From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v5 4/4] Documentation: Describe 'submodule update --remote' use case
Date: Sun, 26 Jan 2014 12:45:16 -0800
Message-ID: <fff9b46f7d832b74e219075c28db5ebcb0137299.1390768736.git.wking@tremily.us>
References: <20140117023746.GJ7078@odin.tremily.us>
 <cover.1390768736.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 26 21:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7Wb8-0002cz-3s
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 21:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbaAZUqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jan 2014 15:46:20 -0500
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:35282
	"EHLO qmta10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753331AbaAZUqK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jan 2014 15:46:10 -0500
Received: from omta17.westchester.pa.mail.comcast.net ([76.96.62.89])
	by qmta10.westchester.pa.mail.comcast.net with comcast
	id Jk8o1n0041vXlb85Akm9KK; Sun, 26 Jan 2014 20:46:09 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta17.westchester.pa.mail.comcast.net with comcast
	id Jkm81n00C152l3L3dkm8yT; Sun, 26 Jan 2014 20:46:09 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id DF3A8F1C33D;
	Sun, 26 Jan 2014 12:46:07 -0800 (PST)
Received: (nullmailer pid 2845 invoked by uid 1000);
	Sun, 26 Jan 2014 20:45:23 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
In-Reply-To: <cover.1390768736.git.wking@tremily.us>
References: <cover.1390768736.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390769169;
	bh=CxLPoCK6qRDglPphyVzaM/Gnhd830Tmx1+V6HediCXw=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id:MIME-Version:Content-Type;
	b=m7vaqqjKV7UkhXO1fEAqn0mE2l8z2m30Nmbs8jxBZGhry59xBQqrYQhUXaBpt6L/e
	 2LStY+XCG5lXJhL+zFTPc1J7z3Z4DWqsofS8lutH/qI/05tkjCGpR435KN+VldjFHC
	 GfsTcR7pZR63XbfE6GGdmiBtDtD/qsR/76zZz0uoWSqZOk2G4oZlx6dWuOwCojE4dr
	 6dP+fLPbAFRHugCBboov2RdI6qt7oRCv2pttN/daeScSgtGtOFIMi6l82tYaf9V9yt
	 kJg7M8xpsWbl+doIacsdiwQ/LgA5XUO2CZGXP32nqJ9yGHqUifog/rEoaenrLBgli8
	 KbeCZz1OGVacw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241115>

On Thu, Jan 16, 2014 at 12:21:04PM -0800, Junio C Hamano wrote [1]:
> I think copying some motivation from the log message of 06b1abb5
> (submodule update: add --remote for submodule's upstream changes,
> 2012-12-19) would help the readers here.  A na=C3=AFve expectation fr=
om a
> casual reader of the above would be "The superproject's tree ought
> to point at the same commit as the tip of the branch used in the
> submodule (modulo mirroring delays and somesuch), if the repository
> of the superproject and submodules are maintained properly", which
> would lead to "when would any sane person need to use --remote in
> the first place???".

There have been other interpretation issues with the --remote option
as well.  With this commit, I try to make it clear that there is no
implicit floating going on; --remote lets you explicitly integrate the
upstream branch in your current HEAD (just like running 'git pull' in
the submodule).  The only distinction with the current 'git pull' is
the config location/setting used for the upstream branch, which is
hopefully clear now.

With syncing between the out-of-tree submodule config and the in-tree
superproject .gitmodules [2], you wouldn't have to chose between (or
manually sync) "easily distributable .gitmodules settings" and "native
submodule pull", but this patch is my take on the current situation.

[1]: http://article.gmane.org/gmane.comp.version-control.git/240529
[2]: http://article.gmane.org/gmane.comp.version-control.git/240336

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/git-submodule.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index 2e1c7a2..21cb59a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -299,6 +299,16 @@ In order to ensure a current tracking branch state=
, `update --remote`
 fetches the submodule's remote repository before calculating the
 SHA-1.  If you don't want to fetch, you should use `submodule update
 --remote --no-fetch`.
++
+Use this option to integrate changes from the upstream subproject with
+your submodule's current HEAD.  Alternatively, you can run `git pull`
+from the submodule, which is equivalent except for the remote branch
+name: `update --remote` uses the default upstream repository and
+`submodule.<name>.branch`, while `git pull` uses the submodule's
+`branch.<name>.merge`.  Prefer `submodule.<name>.branch` if you want
+to distribute the default upstream branch with the superproject and
+`branch.<name>.merge` if you want a more native feel while working in
+the submodule itself.
=20
 -N::
 --no-fetch::
--=20
1.8.5.2.8.g0f6c0d1
