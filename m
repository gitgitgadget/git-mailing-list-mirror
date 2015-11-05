From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 02/11] run-command: report failure for degraded output
 just once
Date: Thu, 5 Nov 2015 09:37:14 -0800
Message-ID: <CAGZ79kaoWkJR+dg1fiKTiWHWi7N2Ni3ANi4n06_7OU=qt=X_KA@mail.gmail.com>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
	<1446597434-1740-3-git-send-email-sbeller@google.com>
	<xmqqd1vpbpik.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaiRKHd2RS9eNeZt_VZqqBF0HS0D=x1HbOTPXYOphu8pg@mail.gmail.com>
	<563A6C3D.2050805@kdbg.org>
	<xmqq4mh1a37i.fsf@gitster.mtv.corp.google.com>
	<20151104225618.GA18805@sigill.intra.peff.net>
	<xmqqvb9h8ale.fsf@gitster.mtv.corp.google.com>
	<20151105065111.GA4725@sigill.intra.peff.net>
	<xmqq4mh09a0q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 18:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuOTS-0002HT-TP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 18:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932741AbbKERhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 12:37:17 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34348 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905AbbKERhP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 12:37:15 -0500
Received: by ykdr3 with SMTP id r3so143609944ykd.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 09:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PI/QbYnXZST+Ab4QoYkKO9qeNcr++G4OzYSagJl+hYc=;
        b=alkpJvQH1S61AwMBYa1OGqCBJn5TqnRjszG5JY+fVF3v0OoX4Ho71whhqEoUJxlu3X
         SS+n2vLLzdTffJ7IlD/5/yts8Pts5wyWuA5PtxQ1m4iCU4u8ZKmVkHd1ekw9F9WdcZoc
         5myyyCSLhuoGz+9VBKGgc5PvRx3MAm4BeWJ077LzwvXBTcLBLZjhwrXlpPGeKv4n5CKw
         zmons2zf2vIUcoqWb/kwwzdUpKQlG7F0oznacSDHO/LDjAmXWzruJxH9qlpnq5NRfHKR
         vF3fHQbW4LUdeRNojWTB8EYo9KkX2PLmFpwPIrxweXXZS6vkZ7ISzHmlZ2wAEm0cN8ui
         lWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PI/QbYnXZST+Ab4QoYkKO9qeNcr++G4OzYSagJl+hYc=;
        b=ObkG/nyg+9Zf5Fq6CzoOhjLsTks7nSrFrV8FLLbmIvvwZRD3ObcTyUXfVRN6ei4W2m
         q6TCavE3xGgj/Znnns1KIgyUlDd3Xn2FDIFnZKnPOnp1z0qn6Py0KDXdlvFoMOA1QdcS
         xCIBedOgCg9jUfQx61GQCfgVEVzfK6QJot8oB+snvBG8uhPDzBZtFkD2cUWRvJtbrSnj
         rYP6YsrnYRQXDABKoKFOgxn5V6n5joGlQotB5yDyIoKcnOzspaDxXTciVpXoZwg9uq8K
         QyxZGu4Fbb8XXxWoRQaZbqwQMeHHTYyBkKpe3TjlzxS/k1NpkvzJZypiXMP1s6Bi4D3c
         x+sw==
X-Gm-Message-State: ALoCoQmawxh4MsIUwBkXoqIWbRPXkfxQGLJ4yt1tHyY5oGoIsclpJd7uyfoZNJFecx4ocgW1cdBk
X-Received: by 10.13.251.2 with SMTP id l2mr7544083ywf.44.1446745034879; Thu,
 05 Nov 2015 09:37:14 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Thu, 5 Nov 2015 09:37:14 -0800 (PST)
In-Reply-To: <xmqq4mh09a0q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280926>

On Wed, Nov 4, 2015 at 11:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> POSIX implies it is the case in the definition of read[2] in two ways:
>>
>>   1. The O_NONBLOCK behavior for pipes is mentioned only when dealing
>>      with empty pipes.
>>
>>   2. Later, it says:
>>
>>        The value returned may be less than nbyte if the number of bytes
>>        left in the file is less than nbyte, if the read() request was
>>        interrupted by a signal, or if the file is a pipe or FIFO or
>>        special file and has fewer than nbyte bytes immediately available
>>        for reading.
>>
>>      That is not explicit, but the "immediately" there seems to imply
>>      it.
>
> We were reading the same book, but I was more worried about that
> "may" there; it merely tells the caller of read(2) not to be alarmed
> when the call returned without filling the entire buffer, without
> mandating the implementation of read(2) never to block.
>
> Having said that,...
>
>>> So perhaps the original reasoning of doing nonblock was faulty, you
>>> are saying?

I agree that the original reasoning was faulty. It happened in the first place,
because of how I approached the problem. (strbuf_read should return immediately
after reading and to communicate that we had non blocking read and checked for
EAGAIN).

Having read the man pages again, I agree with you that the non blocking is
bogus to begin with.

>>
>> Exactly. And therefore a convenient way to deal with the portability
>> issue is to get rid of it. :)
>
> ... I do like the simplification you alluded to in the other
> message.  Not having to worry about the nonblock (at least until it
> is found problematic in the real world) is a very good first step,
> especially because the approach allows us to collectively make
> progress by letting all of us in various platforms build and
> experiment with "something that works".

I'll send a patch to just remove set_nonblocking which should fix the compile
problems on Windows and make it work regardless on all platforms.

After that I continue with the update series.
