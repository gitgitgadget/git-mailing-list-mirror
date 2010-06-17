From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCHv5 2/2] bash-completion: Fix __git_ps1 to work with "set -u"
Date: Thu, 17 Jun 2010 22:32:16 +0100
Message-ID: <4C1A9460.6080905@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch> <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 23:32:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPMhK-0006Ov-Ld
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 23:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760024Ab0FQVc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 17:32:26 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:44551 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752803Ab0FQVcZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 17:32:25 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100617213218.CWRN3192.mtaout02-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Thu, 17 Jun 2010 22:32:18 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100617213218.FXKG1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.5]>;
          Thu, 17 Jun 2010 22:32:18 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=W3tOLUehizD4qj6VhtReFuw5MKb8d+XqjIxlDsIazEA= c=1 sm=0 a=zqDl6V-LTjQA:10 a=uEzv4HemXiYA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=OSITfEaOqGQwWcg7xLcA:9 a=7Hq6kL83lbjnnfF1uh_7hcSMDeYA:4 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149330>

Define several variables in __git_ps1 to avoid errors under "set -u" semantics.

__git_ps1 seems to have been missed when the rest of the file was fixed in
25a31f8.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---
 contrib/completion/git-completion.bash |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6e6f458..337e4c9 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -221,8 +221,8 @@ __git_ps1 ()
 {
 	local g="$(__gitdir)"
 	if [ -n "$g" ]; then
-		local r
-		local b
+		local r=""
+		local b=""
 		if [ -f "$g/rebase-merge/interactive" ]; then
 			r="|REBASE-i"
 			b="$(cat "$g/rebase-merge/head-name")"
@@ -264,12 +264,12 @@ __git_ps1 ()
 			}
 		fi
 
-		local w
-		local i
-		local s
-		local u
-		local c
-		local p
+		local w=""
+		local i=""
+		local s=""
+		local u=""
+		local c=""
+		local p=""
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
 			if [ "true" = "$(git rev-parse --is-bare-repository 2>/dev/null)" ]; then
-- 
1.7.0.4
