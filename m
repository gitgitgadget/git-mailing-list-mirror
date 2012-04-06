From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 02:30:07 +0300
Message-ID: <CAMP44s3CA9e06QoJ_-QWoEevfY==CgqZrUu1EKn3zeVDdAyvOA@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
	<CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
	<20120406213448.GA5436@sigill.intra.peff.net>
	<CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com>
	<7vk41szdev.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIbm-0000KM-CL
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758355Ab2DFXaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 19:30:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64126 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab2DFXaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 19:30:08 -0400
Received: by wibhj6 with SMTP id hj6so873127wib.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 16:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EOrimHAnjvs2cqgLBpin/aMoaC+1LNwHbjoOGQQRxPg=;
        b=VS0SKXaupx1WkYLdogzN7lxIhY1lJ5GiD0S99rOet1H4DZuHg7dUp9A1eSVlXwuyZA
         K26y0Zl0p5cGQzr3wIXd4gxXY0lwqTWrNNU3DLVuDoKG6jK6K9Xd9TF/BJSQcuzl6zsi
         wwWR8A82kb2OqQyTakeLtLbAot/gYjp9G39lMgr06gmZrFPqWZuyd0mncVasqud8Vja3
         P9Vc+rlitE3a0DPn5L9nQkGAjbZ5CWJmdCQhBAnfH8g6mSiadfj3/fXzWTd0VchXTITP
         5O5bLoq6z3etHmHfcVvBChgOs6Uv0nb45PbKXtHh6wsKecqxqZx2OsaL02QYz+d4y0Gt
         Ob1w==
Received: by 10.216.53.200 with SMTP id g50mr624960wec.2.1333755007559; Fri,
 06 Apr 2012 16:30:07 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 16:30:07 -0700 (PDT)
In-Reply-To: <7vk41szdev.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194923>

On Sat, Apr 7, 2012 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sat, Apr 7, 2012 at 12:34 AM, Jeff King <peff@peff.net> wrote:
>>
>>> But my point still stands that you cannot assume that you are runni=
ng
>>> bash, and you need to either find bash, or gracefully exit the test
>>> script if it is not available. Anything else will cause "make test"=
 to
>>> fail on some systems (and indeed, applying and running your test, i=
t
>>> breaks "make test" on my debian box with dash as /bin/sh).
>>
>> So? 'make test' fails on my Arch Linux box which doesn't have
>> /usr/bin/python, which is presumably why there is NO_PYTHON.
>
> If you "git grep NO_PYTHON", you would notice that t/test-lib.sh does=
 have
> a provision to set PYTHON prerequisite,

Yes, but you have to specify NO_PYTHON, otherwise it would just assume
python is installed.

> so fixing it presumably is just
> the matter of marking appropriate tests with the prerequisite, no?

You would still have to specify NO_PYTHON.

> Which ones are broken for you?

In fact, I do have python, but the program name is python2, but if I do=
 this:

 export PYTHON_PATH=3D/usr/bin/python2

The tests fail on remote-helpers.

> Complaining about it in a thread that does not
> directly related to that "on a box without python some tests are brok=
en"
> issue is a very good way to leave it unfixed.

My point is that the argument "this is worst than nothing because
tests would break on X systems" seems rather weak to me considering
that tests are already broken on Y systems.

>> Instead
>> of doing some nasty hacks such as 'bash <<\END_OF_BASH_SCRIPT', it
>> would be much easier to have a NO_BASH option. And in fact, when zsh
>> completion tests are available, NO_ZSH (probably on by default).
>
> "The box does not have bash" and "The builder does not wish to let th=
e
> scripts run with bash" are two separate things. =C2=A0SHELL_PATH is o=
ften set
> to /bin/dash even on a box that has /bin/bash because it is much fast=
er to
> run scripted Porcelains with, but the end user of the resulting build=
 may
> still want to use bash in her interactive session.

So? SHELL_PATH would not interfere with NO_BASH/NO_ZSH. But in any
case, I've sent a patch that detects bash presence, similarly to
Jeff's patch.

Cheers.

--=20
=46elipe Contreras
