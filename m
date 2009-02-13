From: Bernt Hansen <bernt@norang.ca>
Subject: [PATCH] Meta/Reintegrate: Record all merges to prevent losing topics
Date: Fri, 13 Feb 2009 13:23:14 -0500
Organization: Norang Consulting Inc
Message-ID: <87r622yz59.fsf@gollum.intra.norang.ca>
References: <7vd4ea8mnf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:24:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY2iW-0000hW-Vl
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 19:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbZBMSXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 13:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbZBMSXV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 13:23:21 -0500
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:56023 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbZBMSXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 13:23:20 -0500
Received: from cpe000102d0fe75-cm0012256ecbde.cpe.net.cable.rogers.com ([99.239.148.180] helo=mail.norang.ca)
	by mho-02-bos.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <bernt@norang.ca>)
	id 1LY2h4-0001iA-7h; Fri, 13 Feb 2009 18:23:18 +0000
Received: from gollum.intra.norang.ca (gollum.intra.norang.ca [192.168.1.5])
	by mail.norang.ca (8.13.8/8.13.8/Debian-3) with ESMTP id n1DINFuQ012893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 Feb 2009 13:23:16 -0500
Received: from gollum.intra.norang.ca (localhost [127.0.0.1])
	by gollum.intra.norang.ca (8.14.3/8.14.3/Debian-5) with ESMTP id n1DINF4i012363;
	Fri, 13 Feb 2009 13:23:15 -0500
Received: (from bernt@localhost)
	by gollum.intra.norang.ca (8.14.3/8.14.3/Submit) id n1DINESG012362;
	Fri, 13 Feb 2009 13:23:14 -0500
X-Mail-Handler: MailHop Outbound by DynDNS
X-Originating-IP: 99.239.148.180
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+bgTy5hL+5ditX3DJN84o1
In-Reply-To: <7vd4ea8mnf.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 26 Jan 2009 01\:03\:16 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109771>

Rebuilding an integration branch loses the initial topics when merging
results in fast-forwarding the history.

Force the integration branch to always record merge commits to ensure
we keep all of the topics on future integration branch rebuilds.

Signed-off-by: Bernt Hansen <bernt@norang.ca>
---
Thanks for this script Junio!

I started using this script today to clean up one of my integration
branches by separating the linear history into separate topics.  This
works great except for the minor glitch this patch fixes.

 Reintegrate |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Reintegrate b/Reintegrate
index dfdb73e..5909821 100755
--- a/Reintegrate
+++ b/Reintegrate
@@ -10,7 +10,7 @@ echo '#!/bin/sh
 while read branch eh
 do
 	case "$eh" in
-	"") git merge "$branch" || break ;;
+	"") git merge --no-ff "$branch" || break ;;
 	?*) echo >&2 "Eh? $branch $eh"; break ;;
 	esac
 done <<EOF'
-- 
1.6.2.rc0.55.g30aa4f
