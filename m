From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 16:25:18 -0800
Message-ID: <CAGZ79kbLHNtxcwhZz=tHpJB2XnxMeuEJBG=PmoAbcVF4Wzno2g@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
	<CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
	<xmqqio40hbam.fsf@gitster.mtv.corp.google.com>
	<20151214235736.GA26133@sigill.intra.peff.net>
	<CAGZ79kZGjCy-o=2hO22=4=n2JqUsEG+dqOZFP4Hhf5E72B-_JA@mail.gmail.com>
	<20151215001642.GA26409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:25:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8dQn-0008CI-0F
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 01:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933030AbbLOAZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 19:25:22 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:38636 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932664AbbLOAZT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 19:25:19 -0500
Received: by mail-ig0-f182.google.com with SMTP id xm8so1651599igb.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ekC23iZ81aQybMddv3VNbzyisUwwaD/1XYK3rS9OhNM=;
        b=lzo1wJIQPZG4zNiPRoKQBGThnqsv1vgIoSvKcex0h1hTTVD1RouLw9pTb82kmTZphn
         Uxnrr6g7tRyd6eIgvFHx59VAWtYvgKd27ZaHychYH5MDqdWXoADs2pRFgWseUXqSvJ6I
         kdBckj1sn+6yHu0Qo59QQpbp+ye3MXLRg2NYRU6RU93AFAHBeA76HSlc1euSl4kWeOvy
         VwAdfxRpdUYLbwf5M2hqGBGc7DspYSVnOvk8SpCcP32QcxrjdksD/om6UNmffpMaY0SQ
         JWtg+72Q7BNrGanafTvCI7UkQ0rHgb4z4Z3z1SPGM8vT87YpYfxqGrIKCD+RkCnUDkZY
         Z8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ekC23iZ81aQybMddv3VNbzyisUwwaD/1XYK3rS9OhNM=;
        b=Gm4HgtNTnkYGYwsDzIPfcS7Gjh9/RDLjNiuNTttN3H9/i7r/1h5L7djGTjzlQJnC48
         NT2mmm1vU1ulX8Fi449IYXvFN9jgJeTwY6AefQoSXusGftF7LL6qzSQfdZ0mlN7JBN/Q
         UxXwqYSkDxwzDnu49LXZHYWd1sodG4a7yaZ2+GyO7chUSOXg7BFkvmsu+Ec0dTwduwGu
         C+MAHBSuWV1CwzUafJ8Z+rwbOmYjb50uQ7fEc9UcOxxbAD20mwj7k4XoJ/DAj6puPoHH
         fHn+jrQaTm+etREndJpSH0EoCpxrJMAPx8VvGw5JvI1XUuyThEAWJNoomRb1nft72NaV
         uZTQ==
X-Gm-Message-State: ALoCoQlhIggxLb/ZFJSgLdJE0R2AHEPff4BHr2jmHiCgZylfuUjwtycVU8d5RA2KCHaxOJsvHczZYBO3vvGLCef7ladrHWsiqIBtHa0sqe22C56Vck2eRWY=
X-Received: by 10.50.78.231 with SMTP id e7mr1033632igx.93.1450139118471; Mon,
 14 Dec 2015 16:25:18 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 16:25:18 -0800 (PST)
In-Reply-To: <20151215001642.GA26409@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282457>

On Mon, Dec 14, 2015 at 4:16 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 14, 2015 at 04:09:01PM -0800, Stefan Beller wrote:
>
>> > Are we trying to protect ourselves against somebody _else_ giving us a
>> > non-blocking descriptor? In that case we'll quietly spin and waste CPU.
>> > Which isn't great, but perhaps better than returning an error.
>>
>> Yes.
>> This sounds like a good reasoning for 2/8 (add in the poll, so we are
>> more polite), though.
>>
>> This patch is a prerequisite for 4/8, which explicitly doesn't want to loop
>> but a quick return. Maybe we could even drop this patch and just use
>> `read` as is in 4/8. Looking from a higher level perspective, we don't care
>> about strbuf_read_nonblocking to return after a signal without retry.
>
> I was actually thinking about simply teaching xread() not to worry about
> EAGAIN, but that would probably be a regression in the "whoops, somebody
> gave us a non-blocking stdin!" case.
>
> But yeah, I think simply using xread() as-is in strbuf_read_once (or
> whatever it ends up being called) is OK.

I was actually thinking about using {without-x}read, just the plain system call.
Do we have any issues with that for wrapping purposes for Windows?
There is no technical reason to prefer xread over read in strbuf_read_once as
* we are not nonblocking (so the EAGAIN|| EWOULDBLOCK doesn't apply)
* we don't care about EINTR and retrying upon that signal
* we would not care about MAX_IO_SIZE most likely (that's actually one
of the reasons I could technically think of to prefer xread)


> I think all of the
> _intentionally_ non-blocking descriptors are gone in this iteration,
> right?

I think we don't even have unintentional non blocking fds here now as we
create all the fds ourselves and never set the NOBLOCK flag.

> So the caller of strbuf_read_once expects to have to call poll()
> or to block. And that's what xread() does.

ok, I'll drop this patch and use xread there.

>
> -Peff
