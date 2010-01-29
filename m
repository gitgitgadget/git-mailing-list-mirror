From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: build warnings
Date: Fri, 29 Jan 2010 12:23:57 +0100
Message-ID: <40aa078e1001290323u5ab98747p5adc9f703c30fae7@mail.gmail.com>
References: <d2e97e801001290103r5b9cfc2aq8daec90c8c88f2ff@mail.gmail.com>
	 <20100129110201.GB6165@coredump.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Wookey <michaelwookey@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 29 12:31:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nap4N-0006c7-52
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 12:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab0A2LbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 06:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756349Ab0A2LbR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 06:31:17 -0500
Received: from [74.125.82.46] ([74.125.82.46]:62245 "EHLO
	mail-ww0-f46.google.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1756203Ab0A2LbR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 06:31:17 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 06:31:16 EST
Received: by wwi18 with SMTP id 18so133411wwi.19
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 03:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wpfW+KVC7/qMnw5lQwASz2136lmMk+rMN498zPi33Wc=;
        b=QgVN5rJpvb0Af5TsbrevoxxyOxk3Poi6SsrflMHSWt+/udEsk9gm+vDu76UWzJgGEC
         oAfI+V77mIge95BrSPqY1HnakC0y8fzvci5+FR+ToXu/fUEpv4l++5D+6Dd/I7cs9fOv
         Uq+G3okNrOlNC7slzGJtHbZ1EMcFlh14974O0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=svu/05KkWD46QwhhfhxrxdCSQupiIndMxhYRHpSvJTuI2shtw6urGsWAz8wXHsN8JF
         CJue3Sp8WPV6IW/u4oTyA9v2V9YBvmvTf2JUn3F7z2MzfRRSRUFqPEyanmN6dXXaSwA6
         0HD6Rx79nJnJA/czeBf80CJ0yJiGZ9IA+KSCo=
Received: by 10.216.170.198 with SMTP id p48mr393477wel.133.1264764237320; 
	Fri, 29 Jan 2010 03:23:57 -0800 (PST)
In-Reply-To: <20100129110201.GB6165@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138313>

On Fri, Jan 29, 2010 at 12:02 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 29, 2010 at 08:03:37PM +1100, Michael Wookey wrote:
>
>> With current master (dace5dd1), the following build warnings appear =
on
>> Ubuntu 9.10 (x86):
>>
>> =A0 run-command.c: In function =91notify_parent=92:
>> =A0 run-command.c:70: warning: ignoring return value of =91write=92,
>> declared with attribute warn_unused_result
>> =A0 run-command.c: In function =91die_child=92:
>> =A0 run-command.c:80: warning: ignoring return value of =91write=92,
>> declared with attribute warn_unused_result
>> =A0 run-command.c:81: warning: ignoring return value of =91write=92,
>> declared with attribute warn_unused_result
>> =A0 run-command.c:82: warning: ignoring return value of =91write=92,
>> declared with attribute warn_unused_result
>
> There is no point in looking at the return value of any of those call=
s.
> The first one is about notifying the parent process of a child's fail=
ure
> to exec while it is dying (the surrounding function is even an atexit
> handler!). If we can't do that, there is really no alternative behavi=
or.
> The latter three are printing fatal error messages. If we fail at tha=
t,
> there is not much to do (unless we should print an error...).
>
>> =A0 ~$ gcc --version
>> =A0 gcc (Ubuntu 4.4.1-4ubuntu9) 4.4.1
>
> I have heard that Ubuntu recently switched on unused result warnings =
by
> default, and I have seen complaints that it is generating a lot of
> uninteresting warnings like these.
>
> Does anybody know if this behavior is here to stay? Can it be worked
> around with -Wno-warn-unused-result or something? There are few enoug=
h
> callsites here that I am not entirely opposed to annotating them with
> "(void)write" (does that actually work?), but I worry that this is a
> slippery slope. There are a lot of other calls whose return values ar=
e
> also uninteresting (just looking in the vicinity of this code, I see =
an
> fflush and a close, neither of whose failure would be interesting). I=
'm
> not excited at the prospect of annotating all of them.
>

In my experience, quieting warn-unused-result globally isn't ideal;
this warning has helped me track down some serious issues many times
in the past. IIRC, gcc requires a specific attribute on a function
prototype in order to generate warnings when the return-value isn't
used. I guess the issue we're seeing here is that the glibc that
Ubuntu ships has recently added this attribute for some CRT-functions.

Personally I think that quieting them ("(void)func(...)" does work
AFAIK) can make sense as long as there's only a few call-sites.
However, if it's so many that it'll generate substantial noise in the
git-sources or Ubuntu-users will get annoyed beyond sense,
"-Wno-warn-unused-result" might be the only choice. But perhaps this
is something Ubuntu-users would put in their config.mak?

--=20
Erik "kusma" Faye-Lund
