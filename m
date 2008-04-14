From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/{stable,safe,experimental} updated
Date: Mon, 14 Apr 2008 10:11:39 +0200
Message-ID: <20080414081139.GB9135@diana.vm.bytemark.co.uk>
References: <20080413191140.GA1912@diana.vm.bytemark.co.uk> <2008-04-14-08-44-30+trackit+sam@rfc1149.net> <20080414070348.GA9135@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:12:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJnz-0001Oh-Ad
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760101AbYDNIMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2008 04:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760032AbYDNIL7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:11:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4972 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbYDNIL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:11:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JlJmt-0002n7-00; Mon, 14 Apr 2008 09:11:39 +0100
Content-Disposition: inline
In-Reply-To: <20080414070348.GA9135@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79489>

On 2008-04-14 09:03:48 +0200, Karl Hasselstr=F6m wrote:

> Though I was under the impression that I'd tested it with a fully
> applied stack ... I guess the test suite needs an addition or two.

The real proble turned out to be a certain developer who remembers
running the test suite before pushing out his branches, even though no
such thing occurred. Ahem.

This fixes the bug for me; I'll be squashing it into one of the other
patches tonight. Sorry for the breakage.

diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index 083a546..1830cbd 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -84,7 +84,7 @@ class Log(object):
         def pl(name):
             patches =3D [x.split() for x in
                        self.commit.data.tree.data.entries[name][1]
-                       .data.str.strip().split('\n')]
+                       .data.str.strip().split('\n') if x]
             # TODO: handle case where we don't have the commit object.
             return ([pn for sha1, pn in patches],
                     dict((pn, repo.get_commit(sha1)) for sha1, pn in p=
atches))

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
