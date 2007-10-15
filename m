From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 09:07:21 +0200
Message-ID: <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-69--623523175"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 15 09:08:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhK3c-0005gq-Uc
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 09:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXJOHH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 03:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXJOHH7
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 03:07:59 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:46557 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXJOHH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 03:07:58 -0400
Received: from quanta.tsunanet.net ([82.229.223.213])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IhK3P-0002Uo-Qo; Mon, 15 Oct 2007 09:07:55 +0200
In-Reply-To: <Pine.LNX.4.64.0710142359020.25221@racer.site>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60954>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-69--623523175
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Oct 15, 2007, at 12:59 AM, Johannes Schindelin wrote:

> Hi,
>
> On Sun, 14 Oct 2007, Eric Wong wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>
>>> While I have your attention: last weekend, I spoke to a guy from the
>>> ffmpeg project, and he said that the only thing preventing them from
>>> switching to git was the lack of svn:external support...
>>>
>>> (Of course I know that it is more difficult than that: ffmpeg itself
>>> is an svn:external of MPlayer, but maybe we can get both of them to
>>> switch ;-)
>>>
>>> Do you have any idea when/if you're coming around to add that to
>>> git-svn?
>>
>> Soonish, possibly within a next week, even.  I have actually have
>> started a project (using git) that wants to use SVN-hosted  
>> repositories
>> directly submodules; so the fact that I'll actually need something  
>> like
>> it bodes well for getting it implemented :)
>
> Hehe.  Thanks!
>

Thanks for making this another thread because I didn't read the  
answers to that patch and I was going to try and implement this  
(svn:externals via submodules) sooner or later.  Hadn't I seen this,  
we'd probably end up duplicating effort.  Maybe I can help with the  
implementation?

This week I'm probably going to start to dive in git-svn by  
implementing simpler things first:
   - git svn create-ignore (to create one .gitignore per directory  
from the svn:ignore properties.  This has the disadvantage of  
committing the .gitignore during the next dcommit, but when you  
import a repo with tons of ignores (>1000), using git svn show-ignore  
to build .git/info/exclude is *not* a good idea, because things like  
git-status will end up doing >1000 fnmatch *per file* in the repo,  
which leads to git-status taking more than 4s on my Core2Duo 2Ghz 2G  
RAM)
   - git svn propget (to easily retrieve svn properties from withing  
git-svn).  git svn propset would be nice too, but I guess it's harder  
to implement.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-69--623523175
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHExGpwwE67wC8PUkRAq5oAKCsroZ6pUMLb4kGiAGcdBKuh3NhsQCgt8+/
kGFMWBbSN7V+DDkwGAMbsyM=
=gqwa
-----END PGP SIGNATURE-----

--Apple-Mail-69--623523175--
