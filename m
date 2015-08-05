From: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: [PATCH v3 1/1] completion: offer '--edit-todo' during interactive
 rebase
Date: Wed, 5 Aug 2015 15:40:00 +0200 (CEST)
Message-ID: <1331856388.22157.1438782000895.JavaMail.open-xchange@app06.ox.hosteurope.de>
References: <20150801112507.Horde.r5NtLucc5RqP3Wy8gdC7CQ1@webmail.informatik.kit.edu>
Reply-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 15:40:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMyvY-0007dE-CD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 15:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbbHENkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 09:40:06 -0400
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:52855 "EHLO
	wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbbHENkD convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2015 09:40:03 -0400
Received: from app06.ox.hosteurope.de ([92.51.170.13]); authenticated
	by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_ARCFOUR_MD5:16)
	id 1ZMyvI-0000QO-Sy; Wed, 05 Aug 2015 15:40:00 +0200
In-Reply-To: <20150801112507.Horde.r5NtLucc5RqP3Wy8gdC7CQ1@webmail.informatik.kit.edu>
X-Priority: 3
Importance: Medium
X-Originating-Client: open-xchange-appsuite
X-Mailer: Open-Xchange Mailer v7.6.2-Rev25
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1438782003;ff381f69;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275368>

Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Helped-by: John Keeping <john@keeping.me.uk>
Helped-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
Tested by:
- ensuring I'm in a bash shell
- source git-completion.bash
- git rebase -i HEAD~1, choose edit instead of pick in the editor
- on entering "git rebase" you should be offered "--edit-todo"

 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index c97c648..087771b 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1667,7 +1667,10 @@ _git_push ()
 _git_rebase ()
 {
 	local dir=3D"$(__gitdir)"
-	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
+	if [ -f "$dir"/rebase-merge/interactive ]; then
+		__gitcomp "--continue --skip --abort --edit-todo"
+		return
+	elif [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
 		__gitcomp "--continue --skip --abort"
 		return
 	fi
--=20
2.4.3.413.ga5fe668
