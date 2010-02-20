From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make a 
	new one
Date: Fri, 19 Feb 2010 21:42:00 -0600
Message-ID: <ee63ef31002191942h7fbbb6bt627cd36ea343e606@mail.gmail.com>
References: <20100219065010.GA22258@progeny.tock>
	 <20100219072331.GG29916@progeny.tock>
	 <20100219080819.GA13691@coredump.intra.peff.net>
	 <20100219081947.GA12975@progeny.tock>
	 <20100219083440.GC13691@coredump.intra.peff.net>
	 <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
	 <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
	 <20100220003950.GA18550@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 04:42:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NigEN-0008Cd-4b
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 04:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab0BTDmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 22:42:05 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60643 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab0BTDmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Feb 2010 22:42:03 -0500
Received: by pwj8 with SMTP id 8so786991pwj.19
        for <git@vger.kernel.org>; Fri, 19 Feb 2010 19:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i5C1uLq6QDUoapsykd/NigfxYbx3W5ZMOPrch1kN+mo=;
        b=OSa0jJ+ZDAhYY12Ok/T3FSxKw1HM5/5JAQFakl6lzdNUyKuz28JaqXKeDLWkTrLI+F
         mNo48l4e351z0TFaW8jhsjfJ5Q7rx/xdNxYpnnLrLiH2aXu0VGaBX5DPMfs56Qe3aPuk
         l6tBf/RpnKtvCBKDKwcMQDhAzRkWDLTV/DpnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FaKDOHXkTL4zDyA2rRMpTT8Vfzlkk90H0GRai3L4olA6Jpau84fqiUaEFvX7SzUga7
         CRBkT8fm7yPK1zVDLp53F8QMuTPMXgOjcmtCUxX/76hNbtyVGcEfdXwOy7EDpVIBdx7M
         W8eWw7tCM8UacEWPiI7eVQQ5Ywyxbonsvyw4Y=
Received: by 10.114.23.9 with SMTP id 9mr7921103waw.169.1266637320492; Fri, 19 
	Feb 2010 19:42:00 -0800 (PST)
In-Reply-To: <20100220003950.GA18550@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140512>

On Fri, Feb 19, 2010 at 6:39 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Brandon Casey wrote:
>>>> On Fri, Feb 19, 2010 at 02:19:47AM -0600, Jonathan Nieder wrote:
>
>>>>> Hmm, how about /dev/ptmx? =C2=A0(One can check by replacing posix=
_openpt(...)
>>>>> with open("/dev/ptmx", ...) in the test-terminal.c I sent.)
>>
>> Didn't work on Solaris 7. =C2=A0I applied your series on top of mast=
er with the
>> change you described. =C2=A0Here's the diff:
> [...]
>> Here's the result of the terminal test:
>>
>> =C2=A0 # ./test-terminal sh -c "test -t 1"
>> =C2=A0 # echo $?
>> =C2=A0 1
> [...]
>>
>> And here's the output of t7006-pager:
>> *** t7006-pager.sh ***
>> * =C2=A0 ok 1: set up terminal for tests
>> * no usable terminal, so skipping some tests
>
> Thanks for trying it out. =C2=A0That=E2=80=99s an excellent outcome: =
it means that
> test-terminal compiled without trouble with no makefile magic. =C2=A0=
It
> does seem strange to me that there was no error message. =C2=A0Is
> sh -c "test -t 1" false for an ordinary terminal?

No, it is true.  I also substituted /usr/xpg4/bin/sh and got the same r=
esult.

-brandon
