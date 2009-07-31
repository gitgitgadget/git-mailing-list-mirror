From: demerphq <demerphq@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Fri, 31 Jul 2009 12:04:50 +0200
Message-ID: <9b18b3110907310304w261ee30bw8c06c6a65e936e6e@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
	 <adf1fd3d0907290141v24cf129eue3939bf1afd518d2@mail.gmail.com>
	 <9b18b3110907290221o8afc72s157969ef7d707d4d@mail.gmail.com>
	 <4A720393.6030607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Jul 31 12:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoyx-0000W7-FN
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 12:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZGaKEw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 06:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbZGaKEw
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 06:04:52 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:51642 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbZGaKEv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 06:04:51 -0400
Received: by yxe26 with SMTP id 26so3371296yxe.4
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OR2KE+rCkhP8FHCxLUnCM/VAepjbtiMgdcresBj2syA=;
        b=CxKL2tyejB6nepPrY9a52wniWmjwEYf9LrwdeI1L0tWhAqocmMjzjfNz31g8GwDRlF
         oXBAZRVlE/IDlN4mHmk35tmmOrrrKkgyN6DMA4mJ6Kade5OflebqRT/q4Ft6WxOhltI2
         PUW0l/Ame/2oxqupMvvq4DgnxGdilFeUV3gEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lniiJaSsWOd10iTB+1XjSLP8rtJGLcrjLwZOsbPaRc/vzr4RUiMhARzQKPsWE6gQyJ
         a2/GqjEgQEtjoANTQbk2+YiZIOQeG4etaSjMsdDVZJbSFD3FUwaB9uMIv80Wd7U3xVY2
         np8HB3PF07fWW+mln1xPDHK2t6m141lZKl4Y4=
Received: by 10.231.16.193 with SMTP id p1mr627325iba.19.1249034690963; Fri, 
	31 Jul 2009 03:04:50 -0700 (PDT)
In-Reply-To: <4A720393.6030607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124533>

2009/7/30 Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx>:
> demerphq schrieb:
>> So then git also would benefit from support in git-archive for addin=
g
>> arbitrary files to the archive during generation?
>
> Yes, and this has come up before.
>
> How about the following? =A0It's missing documentation and a test cas=
e,
> but you could try
>
> =A0 =A0 =A0 =A0$ git archive --add-file extra HEAD >HEAD+extra.tar
>
> or
>
> =A0 =A0 =A0 =A0$ git archive --prefix=3Da/ --add-file extra --prefix=3D=
b/ HEAD >ba.tar
>
> Only the file name part (after the last slash) of the extra file is u=
sed,
> together with the prefix, to form the path of the archive entry.
>
> Opening the extra files when parsing the command line arguments and c=
losing
> them after they have been written into the archive is a bit iffy, but=
 it's
> impractical to report open errors after parts of the archive have alr=
eady
> been created.

I havent managed to try it out yet but this is pretty much exactly
what I was looking for. Only thought I had was that it might be nice
to be able to specify what name the file should be added as so that
you can add files to subpaths deeper than the root/root prefix of the
tar. However for /my/ particular purposes that is unnecessary, it only
occurs to me as a nice to have. But if you were inclined to think
about extending it I was thinking an argument notation like --add-file
foo:bar/baz/bop might be useful.

Anyway, thanks a lot, assuming it works ok, which I'm sure it does,
even if it doesn't get accepted to git it is likely we will build a
git that does use it for the perl gitweb site. Much appreciated.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
