From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: git fetch overwriting local tags
Date: Wed, 23 Nov 2011 10:08:21 +0100
Message-ID: <20111123090821.GL19986@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 10:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8oh-0001eL-0w
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 10:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755849Ab1KWJIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 04:08:25 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58238 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1KWJIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 04:08:23 -0500
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1RT8oY-0002tU-Kj; Wed, 23 Nov 2011 10:08:22 +0100
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.77)
	(envelope-from <ukl@pengutronix.de>)
	id 1RT8oX-0007kx-Ve; Wed, 23 Nov 2011 10:08:21 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185832>

Hello,

John and I wondered about git fetch overwriting local tags. I was sure
enough to claim that git fetch won't overwrite local tags with remote
tags having the same name. But after John pointed me to

	http://www.pythian.com/news/9067/on-the-perils-of-importing-remote-tag=
s-in-git/

I tested that (using Debian's 1.7.7.3) and really, git does overwrite
local tags.

Here is my test script:

	mkdir a
	cd a
	echo some content > some_file
	git init=20
	git add some_file
	git commit -m 'some commit log'
	git tag some_tag

	cd ..

	mkdir b
	cd b
	echo some different content > another_file
	git init=20
	git add another_file
	git commit -m 'another commit log'
	git tag some_tag

	git fetch --tags ../a

After that I have:

	git log -1 --oneline some_tag
	c4ad89a some commit log

so b's tag was overwritten.

Is this intended?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
