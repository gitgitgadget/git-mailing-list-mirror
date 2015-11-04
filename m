From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Wed, 4 Nov 2015 12:14:44 -0800
Message-ID: <CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu4SL-0002AI-SA
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 21:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbbKDUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 15:14:47 -0500
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35700 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030659AbbKDUOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 15:14:45 -0500
Received: by ykek133 with SMTP id k133so93400261yke.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nGplfIC73pZvVzUK03xXFnEgd06KTa+q52iwiZPD75Y=;
        b=Xo7zqtWEChyJBJ/sfZkqdI55J9WI4Ghn1dnuVB5+KZl62X+aN7TgbvOJf/1JEct3TQ
         euAnYLuEUv0T/dPpi+ETq6znhGqjXhtrGkHZloTDNSRc5/r5EmTOMffd2z08Cthi+2dq
         vns5MYNTvK+fsSOtAk7ZRYhK2xkC+lz7O/TJzWaDgFfZ5rzW/VhsR86VrtgIR/FzmROb
         m1mTK68lVVqDvMN3YKwDZ7pMxGBDanL6rpS/sNoicC2byTHOn+GDBHT+hSqYnPlPDWOr
         l3M9efU00go50IzsNIdl9zx62OGsbJWkioM9BN+S8EwsAn7hqzXln8dfixQbbUqa2DiH
         zFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=nGplfIC73pZvVzUK03xXFnEgd06KTa+q52iwiZPD75Y=;
        b=MgRY7TkxRAByHurea6ajbEdBGCpTmVv+llzr/pu9NEsMcbqYUWZyejsx/KCESAX4gz
         nzREIIp0ahM88Y+sDos8prAGjSfnJcnLJwURY6HEag5I8kULPzvo2wFeJaT9lG2pY+Rw
         jdqz3cAUwuzY+E0DiogX2X9xabPeHI5BWYnwDdpuTjnGc8TbtiPJwjhv5Ez/TQdzM9ba
         iAJzEpNAHNH81W1HUTIg2vesv+qnbGWupblAnU6+lawgEjq/RblhLv8kx6euums7g06X
         1cvqOTkIqDNb/4rGKEWmQmay2BOWa0dLgPN8ppoTYROZDqHB2ul33oTp2FLHSkDenTie
         E5HA==
X-Gm-Message-State: ALoCoQkz5N0XvCBXOqlK4DyxU3FgMOssypqhj11KFvjJU8U4MzvDnBMzJiKhkCoKtjLjOf2m9PRU
X-Received: by 10.13.251.2 with SMTP id l2mr2976530ywf.44.1446668084601; Wed,
 04 Nov 2015 12:14:44 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Wed, 4 Nov 2015 12:14:44 -0800 (PST)
In-Reply-To: <xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280879>

On Wed, Nov 4, 2015 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The warning message is cluttering the output itself,
>> so just report it once.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  run-command.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 7c00c21..3ae563f 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1012,13 +1012,21 @@ static void pp_cleanup(struct parallel_processes *pp)
>>
>>  static void set_nonblocking(int fd)
>>  {
>> +     static int reported_degrade = 0;
>>       int flags = fcntl(fd, F_GETFL);
>> -     if (flags < 0)
>> -             warning("Could not get file status flags, "
>> -                     "output will be degraded");
>> -     else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
>> -             warning("Could not set file status flags, "
>> -                     "output will be degraded");
>> +     if (flags < 0) {
>> +             if (!reported_degrade) {
>> +                     warning("Could not get file status flags, "
>> +                             "output will be degraded");
>> +                     reported_degrade = 1;
>> +             }
>> +     } else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK)) {
>> +             if (!reported_degrade) {
>> +                     warning("Could not set file status flags, "
>> +                             "output will be degraded");
>> +                     reported_degrade = 1;
>> +             }
>> +     }
>>  }
>
> Imagine that we are running two things A and B at the same time.  We
> ask poll(2) and it says both A and B have some data ready to be
> read, and we try to read from A.  strbuf_read_once() would try to
> read up to 8K, relying on the fact that you earlier set the IO to be
> nonblock.  It will get stuck reading from A without allowing output
> from B to drain.  B's write may get stuck because we are not reading
> from it, and would cause B to stop making progress.
>
> What if the other sides of the connection from A and B are talking
> with each other,

I am not sure if we want to allow this ever. How would that work with
jobs==1? How do we guarantee to have A and B running at the same time?
In a later version of the parallel processing we may have some other ramping
up mechanisms, such as: "First run only one process until it outputted at least
250 bytes", which would also produce such a lock. So instead a time based ramp
up may be better. But my general concern is how much guarantees are we selling
here? Maybe the documentation needs to explicitly state that we cannot talk to
each or at least should assume the blocking of stdout/err.

> and B's non-progress caused the processing for A on
> the other side of the connection to block, causing it not to produce
> more output to allow us to make progress reading from A (so that
> eventually we can give B a chance to drain its output)?  Imagine A
> and B are pushes to the same remote, B may be pushing a change to a
> submodule while A may be pushing a matching change to its
> superproject, and the server may be trying to make sure that the
> submodule update completes and updates the ref before making the
> superproject's tree that binds that updated submodule's commit
> availble, for example?  Can we make any progress from that point?
>
> I am not convinced that the failure to set nonblock IO is merely
> "output will be degraded".  It feels more like a fatal error if we
> are driving more than one task at the same time.
>

Another approach would be to test if we can set to non blocking and if
that is not possible, do not buffer it, but redirect the subcommand
directly to stderr of the calling process.

    if (set_nonblocking(pp->children[i].process.err) < 0) {
        pp->children[i].process.err = 2;
        degraded_parallelism = 1;
    }

and once we observe the degraded_parallelism flag, we can only
schedule a maximum of one job at a time, having direct output?
