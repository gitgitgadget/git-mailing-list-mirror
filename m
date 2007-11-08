From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 15:51:00 +0100
Message-ID: <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-90--669587561"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 15:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8jf-0007Qa-4x
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 15:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761033AbXKHOvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 09:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761035AbXKHOvM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 09:51:12 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:50322 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbXKHOvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 09:51:10 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1Iq8ip-0006hj-IA; Thu, 08 Nov 2007 15:51:07 +0100
In-Reply-To: <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64031>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-90--669587561
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 8, 2007, at 1:54 PM, Steffen Prohaska wrote:

> Do you use rebase like this in real life?
>
> I thought of the text as background information that might
> be helpful for users who want do decide wether to merge or
> to rebase. The problem described may be valuable information
> supporting a decision about a recommended workflow for a group
> of users.

You're missing the point.  Johannes suggested that you rebase *only*  
for bisecting purpose.  Once you find the culprit commit, throw away  
your rebased stuff.  I've never thought about doing this myself, but  
it's a very clever way of tackling this problem.  It's slightly less  
convenient if you need to bisect a large portion of the history (that  
involves many branches and merges) because in this case we'd like to  
have a magic git-linearize-history <start-treeish> <end-treeish>.   
Unless this is already easily doable with git-rebase?

So to summarize (untested):
   git merge topic
   make check
   <omg something's broken>
   git reset --hard HEAD~1 # undo the merge
   git checkout -b wtf
   git rebase topic master
   git bisect ...
   <OK I found the culprit>
   git checkout master
   git branch -D wtf
   git merge --no-commit topic
   <fix the problem>
   git commit # merge done, semantic glitch fixed

Correct me if I'm wrong.

This has *nothing* to do with the fact that you use merge or rebase  
to do whatever you were doing.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-90--669587561
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHMyJUwwE67wC8PUkRAqX/AKDCJzGRoBsVnxEYQzagAtgdOIHjFwCff+ui
7siK2hgwTHTzaCeO4xTT8pw=
=aboN
-----END PGP SIGNATURE-----

--Apple-Mail-90--669587561--
