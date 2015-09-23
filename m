From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 17:14:42 -0700
Message-ID: <CAGZ79kYKxNAXhbmXEtMeBYeGqu8i4bcUW_hpjLaPSF4p5O=uBg@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
	<xmqq37y78gzt.fsf@gitster.mtv.corp.google.com>
	<5600DF2D.9010202@web.de>
	<CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
	<xmqqy4fy2q6o.fsf@gitster.mtv.corp.google.com>
	<20150922194927.GA622@sigill.intra.peff.net>
	<xmqqlhby2pj0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 02:14:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeXhw-0004GS-Dl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 02:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935093AbbIWAOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 20:14:44 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34443 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934802AbbIWAOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 20:14:43 -0400
Received: by ykdg206 with SMTP id g206so26802957ykd.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HX/hmHSZ9KkjYXtXkM4+DwaEubkwUPqdGMn4pSm/Uos=;
        b=jJMe/iw5SfKHXvkIuKtyWPhUfXbSGRb4IJ7ik9U4Pqlxq/bXNCF52+VbsDA4pqsyF+
         VzyEiJHrZpiE+ea7B16UF7D6ZFiOeK2Z8EAf6xTSPv+KIWXGacU1+ZKH6z5n+Pe0ByWr
         cOHHU3LgKiBfSKC10Ylq1y7XwowOaeJ11ot2DgSG0ta19xb7fNXoijZOuoAa9jrRPgaf
         QObF4hZIvnWK9n2Z1vUUOOh5v8Vkfeav53sKdmemEQZX2SpN2EBhgXFqB7hrTSlfiN9U
         WkGIPWXqEq21n7RQl8HDUUtSpDDkYhbrzdakv81Xh7GkRRkCC7iuxna1ZYDQ3kjjNgns
         aZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HX/hmHSZ9KkjYXtXkM4+DwaEubkwUPqdGMn4pSm/Uos=;
        b=YGVWbN/ft+86S/cWZfqe8XPKs9t/JfxylLHn0B154LbUVtmEpsW9AydIaN4UsJSsZf
         WJaowMUe4/4QZblnLa6ivHHE5n+eaN/qvpQ0QIHhSh0PgOJbBA3beyj444qECaBw1fpe
         NGo/vrK1NgaHm4VyoAtaf+TKb62G8y5hYTTcl8FUsmANmXEef8Y3KzcaXRtxssEEz6u7
         dGrPOTbU+sZ/+96TfHx/5hSWJoMwS/hPQl97/J2CahZeTnvRcLw6N/MbNR63z7eJMiXo
         eCS977GGVxsy2CyKovVF4AXAgn9BsV1ET0cR7n+3XkR//Vv9HwOk6Cj+mmrufu+2LO/+
         XP9A==
X-Gm-Message-State: ALoCoQl2wxXa6ux1Q8TJwpc6irsho1/d1RgtIB1/e9tzrBJIznsKIY64dwbeTuSmp6OR/ufQ8fSX
X-Received: by 10.129.116.84 with SMTP id p81mr24165180ywc.1.1442967282791;
 Tue, 22 Sep 2015 17:14:42 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 22 Sep 2015 17:14:42 -0700 (PDT)
In-Reply-To: <xmqqlhby2pj0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278449>

On Tue, Sep 22, 2015 at 1:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Tue, Sep 22, 2015 at 12:45:51PM -0700, Junio C Hamano wrote:
>>
>>> One caveat is that the caller may not know in the first place.
>>>
>>> The last time I checked the existing callers of xread(), there were
>>> a few that read from a file descriptor they did not open themselves
>>> (e.g. unpack-objects that read from standard input).  The invoker of
>>> these processes is free to do O_NONBLOCK their input stream for
>>> whatever reason.
>>
>> Yeah. I do not think this is a bug at all; the user might have their
>> reasons for handing off an O_NONBLOCK pipe. If we take xread() to mean
>> "try to read from fd until we get a real error, some data, or an EOF",
>> then it is perfectly reasonable to replace spinning on read() (which we
>> do now) with a poll() for efficiency. The caller (and the user) does not
>> have to care, and should not notice; the outcome will be the same.
>
> I think we are in agreement, and that answers the question/guidance
> Stefan asked earlier in $gmane/278414, which was:
>
>> So rather a combination of both, with the warning only spewing every
>> 5 seconds or such?
>
> and the answer obviously is "No warning, do a poll() without timeout
> to block".

Ok. Expect that in a reroll.

To answer the first question upthread:

> I can sort of see EINTR but why is ENOMEM any special than other errors?

So we have 4 kinds of additional errors, when adding the poll. When we want to
keep the behavior as close to the original as possible, we should not error out
for things we had under control previously.

       EFAULT The array given as argument was not contained in the
calling program's address space.

       EINTR  A signal occurred before any requested event; see signal(7).

       EINVAL The nfds value exceeds the RLIMIT_NOFILE value.

       ENOMEM There was no space to allocate file descriptor tables.

I don't see a way EFAULT can be returned as we have the array hard
coded on the stack.
(No tricks with the heap or anything, we'll have it on the stack)

EINTR is possible while waiting. Actually it doesn't matter if we
retry the poll or read first
and then poll again, so we can easily just continue and do the read.

EINVAL is highly unlikely (as nfds == 1 in the case here), but can happen.
ENOMEM is similar to EINVAL.

We should not care if the call to poll failed, as we're in an infinite loop and
can only get out with the correct read(..). So maybe an implementation like this
would already suffice:

ssize_t xread(int fd, void *buf, size_t len)
{
    ssize_t nr;
    if (len > MAX_IO_SIZE)
        len = MAX_IO_SIZE;
    while (1) {
        nr = read(fd, buf, len);
        if (nr < 0) {
            if (errno == EINTR)
                continue;
            if (errno == EAGAIN || errno == EWOULDBLOCK) {
                struct pollfd pfd;
                pfd.events = POLLIN;
                pfd.fd = fd;
                /* We deliberately ignore the return value of poll. */
                poll(&pfd, 1, -1);
                continue;
            }
        }
        return nr;
    }
}

In the resend I'll only check for EINTR and in other cases of early poll
failure, we just die(..).
