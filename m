From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Managing submodules on large multi-user projects
Date: Fri, 29 May 2009 11:41:25 -0700
Message-ID: <20090529184125.GE11222@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 21:29:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA7m3-0002bG-GL
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 21:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbZE2T3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 15:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753224AbZE2T3j
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 15:29:39 -0400
Received: from mx0.slide.com ([208.76.68.7]:57935 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbZE2T3j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 15:29:39 -0400
X-Greylist: delayed 2859 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 15:29:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=Q
	sfyPnx+UuCdcsozfrsHA7KrbqLXDzpW4NpnRSFwTKQ=; b=emuC82g7RqEGbsuFK
	hKI+Zwfuupg6aJAuy5qGJv2KzdgN4i8BQFv9fLpNwnpwoI/RU441dbFI983tDXkN
	aQA1gK0v9CKXSvoar+aok85s56ZXtEVN2Ovp4T19yGr01iF4JlBjs+40CKNFGX7+
	+SZ1nE3TTx0RfRs4WdpZMAwvZ8=
Received: from nat3.slide.com ([208.76.69.126]:51992 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1MA71m-0004T7-9D
	for <git@vger.kernel.org>; Fri, 29 May 2009 11:42:02 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 42D86A6F0003
	for <git@vger.kernel.org>; Fri, 29 May 2009 11:42:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfHbewEaEPrx for <git@vger.kernel.org>;
	Fri, 29 May 2009 11:42:02 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 08EE1A6F0001
	for <git@vger.kernel.org>; Fri, 29 May 2009 11:42:02 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120306>


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As some of you may recall from my last swath of emails to the list
regarding memory usage and repository size, we have quite a large
repository. About a month ago, I added a submodule to the primary repo
in an effort to start to segment where possible, particularly around
third party modules.

I've noticed that keeping submodules updated is an absolute pain,
particularly with a large multiuser setup with *lots* of branches.=20


What will tend to happen is that the submodule reference will be updated
in the master branch (we use a centralized model) and then committed=20
(imagine the commit reference was incremented from A-B).

Other developers with other branches will then periodically merge master=20
into their project/topic branches but will either neglect to run=20
`git submodule update` or our bootstrap script (which also executes the
submodule update command). At this point they'll have outstanding
changes of their own, and the submodule will be marked as "modified" as
well. Usually what will then happen is they'll `git commit -a` without
thinking and the submodule's reference will be changed (typically from
B->A, undoing the previous change).


Are there any saner ways of managing this? I've been trying to get the=20
`git submodule update` command to run with as many hooks as possible
(pre-commit, post-update) to make sure that developers aren't
inadvertantly breaking things, but nothing seems to ensure that
*everybody* is up to date and that *everybody* doesn't inadvertantly
commit changes to the submodule?


Feeling trapped in a box of PEBKAC.

Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkogLFUACgkQFCbH3D9R4W8QpgCfRm6IJzBtX7/MCpTVDfVDiFRV
RtoAn3D+jhT+nUyR7UaP/fWAClnsSd0Y
=Fnch
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
