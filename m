From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git-svn performance
Date: Sat, 25 Oct 2014 06:47:49 +0100
Message-ID: <1414216069.95531.BPMail_high_carrier@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Sat Oct 25 23:02:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi8TY-00071U-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 23:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbaJYVCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 17:02:12 -0400
Received: from nm40-vm4.bullet.mail.ir2.yahoo.com ([212.82.97.172]:56182 "EHLO
	nm40-vm4.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019AbaJYVCL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 17:02:11 -0400
Received: from [212.82.98.126] by nm40.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:47:49 -0000
Received: from [212.82.98.73] by tm19.bullet.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:47:49 -0000
Received: from [127.0.0.1] by omp1010.mail.ir2.yahoo.com with NNFMP; 25 Oct 2014 05:47:49 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 945931.97943.bm@omp1010.mail.ir2.yahoo.com
Received: (qmail 75300 invoked by uid 60001); 25 Oct 2014 05:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414216069; bh=Ivyy8tbRLAoDpSOMYxgf3dIH63JQl5RUH+6Ie79Ur8s=; h=Message-ID:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=qKZzGpH6/3o8ebKC8dSC9dlPY/YZ4A5KKZNaZH2YSF5Ep3LMbhAw/q9wZ95raiVjn9SAroilBiFVkQb9LvIuUcCH2ydIH987fqKAspkL4KY5NcWZlYEIFu7t2M10xRyLCI6vcY+fFvPrTYsdex0TgiQNOArZe6z2/x9se+kOFMU=
X-YMail-OSG: 9P2oSHgVM1mFl7d4NBL649412PE0J0K.xgT9bn3_b1hyp0Z
 hvWiVEJmpa8K7RTs_euCZV9Y4flxHZnuzW0mqxNqeBuYIeq9Usl3WzbYb3GW
 4ThEZso.ft6UJ_87IUNKTCdfayOy73bI0lB6LwqSqc6S860Wk.kRjB6OqQ3L
 eFRzmXObJvlKTDwz7ACDdh1h8AcjF9upiAqQkBkKME7xsrI_.sFSUbpLbNef
 2qhPx6KTgDAmqN3OZwDv4EmoOECbLiPbFapgyj8IB4AOJqC4C2gnNX.Thl74
 NDu.nnjligrsHFSVmypnPIe0qoTcqwItGBhgSx2yr9q7ugvP4xKH5e6CeHmH
 dz790O3WRcAdfiHVi79F92LbvpeRL_iCnb30X.uVpR2OF6JCN6dT_pV627qy
 SOQ_JZSIgbOQ9o85mHZ_9lmm86wzRQOf3ceih499oXjX7I.fvpjGa2DBdN0C
 9Vj9nQIeq3BYcuswqTpWu8Zi1hjlgKyYpOy._UiX994k8F9gbYGBACM9XSDR
 yAkuHn9vx.wphOzR6D._TMCPK3c_pUhf1CFbrii.NLPrMtbyiL_yfi.UvmzH
 qAwC.vcSOAxqPIps-
Received: from [86.30.137.134] by web172304.mail.ir2.yahoo.com via HTTP; Sat, 25 Oct 2014 06:47:49 BST
X-Rocket-MIMEInfo: 002.001,Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpPbiBTYXQsIE9jdCAyNSwgMjAxNCAwNjozMiBCU1QgRXJpYyBXb25nIHdyb3RlOg0KDQo.SGluLVRhayBMZXVuZyA8aHRsMTBAdXNlcnMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToNCj4.IHRoZSBvbGQgZGlkbid0IG1pc3NpbmcgYSByZXZpc2lvbiAtIGp1c3QgYSByZXZpc2lvbiAnbWVzc2FnZScgLSBibGFuaw0KPj4gaW5zdGVhZCBvZiAzIHdvcmRzLCBhYm92ZSB0aGUgZ2l0IHN2biBpZC4gSSBzdXBwcHNlIGl0IGlzIHBvc3NpYmxlDQo.PiBzb20BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



------------------------------
On Sat, Oct 25, 2014 06:32 BST Eric Wong wrote:

>Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
>> the old didn't missing a revision - just a revision 'message' - blank
>> instead of 3 words, above the git svn id. I supppse it is possible
>> some power problem or etc caused this. I'll check the other branches
>> as well, and possibly clone again to be sure. ( The new clone did have
>> one break...)
>
>Oh, there's a possibility the commit message in SVN was edited/added
>after-the-fact, but that depends on the SVN admin (most never allow
>or do it).

That's a possibility - the old clone was created by fetching every few days. It is possible that the author edited it after commiting a blank message and i fetched.

btw, git svn seems to disallow single word commit messages (or is it a svn config?). i found that i could not do git svn dcommit, when i had merely did git commit -m 'typos', for example, for an svn repo i have write access to. (I don't have them many such things, so it is difficult to tell whether it is a repo config, or a git svn strangeness). i just do rebase and do 'typo correction' or something before re-dcommit in the past.
