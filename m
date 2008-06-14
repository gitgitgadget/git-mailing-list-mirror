From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT RFC] Commit behaviour
Date: Sat, 14 Jun 2008 12:23:10 +0200
Message-ID: <200806141223.11134.robin.rosenberg@dewire.com>
References: <1213313997-1520-1-git-send-email-robin.rosenberg@dewire.com> <4852EFBF.6000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 12:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7SzI-0006x6-3o
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 12:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbYFNK0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 06:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbYFNK0e
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 06:26:34 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13656 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753059AbYFNK0d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jun 2008 06:26:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0E9591434DC6;
	Sat, 14 Jun 2008 12:26:32 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dfp+l5Ng3Lj; Sat, 14 Jun 2008 12:26:31 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 1AFFE8026D9;
	Sat, 14 Jun 2008 12:26:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4852EFBF.6000406@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85009>

l=C3=B6rdagen den 14 juni 2008 00.07.59 skrev Marek Zawirski:
> Theses patches don't work for me however :/ When I introduce some cha=
nge=20
> to a resource/file, even add it to index and click commit (toolbar or=
=20
> menu), commit action does nothing. It is - nothing happens. Can you=20
> reproduce this problem, or should I debug it on my instance? Or do I =
use=20
> it in some wrong way?

=46ound it. Obviously this won't work for commits to multiple repositor=
ies which is supposed
to work really, but I think that was broken earlier by yours truly. Thi=
s fix should make it
possible to test the idea though this thread is about, and see if we ha=
ve more selection
problems.=20

-- robin

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actio=
ns/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/inte=
rnal/actions/CommitAction.java
index da32ea5..922649b 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Comm=
itAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Comm=
itAction.java
@@ -124,7 +124,7 @@ public class CommitAction extends RepositoryAction =
{
        }

        private void loadPreviousCommit() {
-               IProject project =3D getSelectedProjects()[0];
+               IProject project =3D getProjectsForSelectedResources()[=
0];

                Repository repo =3D RepositoryMapping.getMapping(projec=
t).getRepository();
                try {
