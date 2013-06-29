From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH v6 2/5] git-remote-mediawiki: new git bin-wrapper for developement
Date: Sat, 29 Jun 2013 13:09:22 +0200
Message-ID: <CAETqRCiJZchP6ydr1F2wPogphyUQuDFxusq+Uczcxk1kmpoD=Q@mail.gmail.com>
References: <1372354652-4147-1-git-send-email-benoit.person@ensimag.fr>
	<1372354652-4147-3-git-send-email-benoit.person@ensimag.fr>
	<7vr4fnsafy.fsf@alter.siamese.dyndns.org>
	<CAETqRCjZdv-_V3jmhjxZj+_XU7AKRvMZ3ojo7=yW3m846F4E1w@mail.gmail.com>
	<vpqhagj9oux.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jun 29 13:09:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ust21-00070l-0u
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 13:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab3F2LJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 07:09:24 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:50806 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab3F2LJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 07:09:23 -0400
Received: by mail-we0-f173.google.com with SMTP id x54so1938426wes.18
        for <git@vger.kernel.org>; Sat, 29 Jun 2013 04:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=A1Dw7EVhub027Sf2nsKGgguHxF7PyKCEpgIACGBnfaM=;
        b=wXMY2u5Arx31qzinxoTaVC1XQyZoqQd0uoN0QjssVtpDSZHBln9fn3wQnXuGk8x6S0
         GHL54p2wzfF02uPOq7QLHKMR/jYN9WyUCb0XDSJOQ3o+wKwnWjA07C1V7BjIx0Tkm4S4
         4XAxNyhOLxkUoyIGS+I2h2AIpiPryNabTjCjxGyJ33bgL8SO8Lxw7sfbz5ZCI3BHr3Ue
         xaXu911vrFPLhRMONtANtQyulTVACPKl2IpJAMOhEbwPy4Yl1T6I5v8qlpn88x7s++vH
         vl7oe8/Hddw1NEs1rrWc/pxc5GWwgxzqN/JoT5bfFBU6XkfJOEx9w0Z6aZHR/0/dw/j1
         x9ZA==
X-Received: by 10.194.243.101 with SMTP id wx5mr13382321wjc.49.1372504162201;
 Sat, 29 Jun 2013 04:09:22 -0700 (PDT)
Received: by 10.216.245.196 with HTTP; Sat, 29 Jun 2013 04:09:22 -0700 (PDT)
In-Reply-To: <vpqhagj9oux.fsf@anie.imag.fr>
X-Google-Sender-Auth: ijR3GQaql9j0DphsWhhtKLhUV-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229251>

> GIT_ROOT_DIR=../../..
> GIT_EXEC_PATH=$(cd "$(dirname "$0")" && cd ${GIT_ROOT_DIR} && pwd)
> GIT_MEDIAWIKI="$GIT_EXEC_PATH"/contrib/mw-to-git
> PATH="$GIT_MEDIAWIKI"/contrib/mw-to-git:"$PATH"
> GPLEXTRA="$GIT_MEDIAWIKI"/contrib/mw-to-git
>
> exec "${GIT_EXEC_PATH}/bin-wrappers/git" "$@"
Should I do that in a reroll ?

>>> Two possible alternatives:
>>>
>>>  - Is there a reason you would not want to "install" whatever Perl
>>>    modules you want to "use" via GITPERLLIB mechanism to
>>>    ../../perl/blib/lib?
>> If we are making modifications to Git/Mediawiki.pm or even git-mw.perl
>> / git-remote-mediawiki.perl, installing them without proper testing
>> beforehand seems wrong.
>
> That's not "installing" (i.e. not "make install"), just a copy within
> the source tree. Same as what's done in Git's toplevel.
Oh right, sorry, read it too quickly :/ Well, I still find it weird to
copy untested files out of contrib/mw-to-git/ though.

Another idea crossed my mind: for now the test suite creates a symlink
of git-remote-mediawiki in the toplevel if it's not installed. It
would be better to use the bin-wrapper in the testsuite I think ?
(plus, with the current solution, it may have problems finding the
latest Git::Mediawiki.pm)
