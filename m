From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 0/3] fix git-p4 client root symlink problems
Date: Thu,  7 Mar 2013 18:19:14 -0500
Message-ID: <1362698357-7334-1-git-send-email-pw@padd.com>
References: <20130307091317.GY7738@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mikl=C3=B3s=20Fazekas?= <mfazekas@szemafor.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 00:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDk6J-0003o0-5B
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 00:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759955Ab3CGXTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 18:19:25 -0500
Received: from honk.padd.com ([74.3.171.149]:58032 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660Ab3CGXTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 18:19:25 -0500
Received: from arf.padd.com (unknown [50.55.138.130])
	by honk.padd.com (Postfix) with ESMTPSA id 500445B67;
	Thu,  7 Mar 2013 15:19:20 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F259123D3B; Thu,  7 Mar 2013 18:19:17 -0500 (EST)
X-Mailer: git-send-email 1.8.2.rc2.64.g8335025
In-Reply-To: <20130307091317.GY7738@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217626>

Mikl=C3=B3s pointed out in

    http://thread.gmane.org/gmane.comp.version-control.git/214915

that when the p4 client root included a symlink, bad things
happen.  It is fixable, but inconvenient, to use an absolute path
in one's p4 client.  It's not too hard to be smarter about this
in git-p4.

Thanks to Mikl=C3=B3s for the patch, and to John for the style
suggestions.  I wrote a couple of tests to make sure this part
doesn't break again.

This is maybe a bug introduced by bf1d68f (git-p4: use absolute
directory for PWD env var, 2011-12-09), but that's so long ago
that I don't think this is a candidate for maint.

		-- Pete

Mikl=C3=B3s Fazekas (1):
  git p4: avoid expanding client paths in chdir

Pete Wyckoff (2):
  git p4 test: make sure P4CONFIG relative path works
  git p4 test: should honor symlink in p4 client root

 git-p4.py               | 29 ++++++++++++++++++++++-------
 t/t9808-git-p4-chdir.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 7 deletions(-)

--=20
1.8.2.rc2.64.g8335025
