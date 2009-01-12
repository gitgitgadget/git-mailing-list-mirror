From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] stgit namelength is an integer
Date: Mon, 12 Jan 2009 21:13:09 +0100
Message-ID: <20090112201309.GA32588@diana.vm.bytemark.co.uk>
References: <20090105190354.GA8295@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMTBh-0006Av-UP
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 21:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbZALUN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 15:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbZALUN1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 15:13:27 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1965 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbZALUN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 15:13:27 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LMT9p-0000NT-00; Mon, 12 Jan 2009 20:13:09 +0000
Content-Disposition: inline
In-Reply-To: <20090105190354.GA8295@osc.edu>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105376>

Thanks, but the test suite fails unless I apply this first:

    Return None instead of crashing on undefined integer config items

    Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

diff --git a/stgit/config.py b/stgit/config.py
index 8934445..5b47580 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -65,7 +65,9 @@ class GitConfig:
=20
     def getint(self, name):
         value =3D self.get(name)
-        if value.isdigit():
+        if value =3D=3D None:
+            return None
+        elif value.isdigit():
             return int(value)
         else:
             raise GitConfigException, 'Value for "%s" is not an intege=
r: "%s"' % (name, value)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
