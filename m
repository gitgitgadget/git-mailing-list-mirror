From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/17] fetch: allow "git fetch $there v1.0" to fetch a tag
Date: Tue,  8 Nov 2011 17:01:50 -0800
Message-ID: <1320800523-5407-5-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:03:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZN-0004Cq-6A
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab1KIBCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36360 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab1KIBCR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 003B05B65
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CLTq
	RjmWNG3g9cack/VabfeCI90=; b=xfMc7Il2W6AYLaDMvoevTBOl7PWG68yKi70s
	J8rpcXWcwCFg8vgS1fM4JC7aHZ4g5A5orsbTpFPWdq372rQUc0kGYeRFXBXmdtHD
	k39B5Bz/ezjcxlliohy3hSNgBdDu1qcYrQv9TIDsS39MGIYphf9zP/l53r+ZlTgo
	qjWqRsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ZqZdtH
	LnLVLz6d2u6ToaEgedhrvF1f2CywcA7OwDJLYIqZFi3Ak76bJRj9yi1Ub9cfzTlv
	XFao+p5ljdLv7/AtJGXEmraaTRJQu64Td6A0LwR9GYe1O5OwuSgflgvkYMGaGjOj
	MBgL3BHCLmUXGvr8vw+Jl6AZuPKONrRST4vZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB7E45B64
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60CCD5B62 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:16 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 776BBC82-0A6E-11E1-887D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185141>

You can already do so with "git fetch $there tags/v1.0" but if it is not
ambiguous there is no reason to force users to type more.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index cab4394..ff20eeb 100644
--- a/refs.c
+++ b/refs.c
@@ -998,6 +998,7 @@ const char *ref_rev_parse_rules[] = {
 const char *ref_fetch_rules[] = {
 	"%.*s",
 	"refs/%.*s",
+	"refs/tags/%.*s",
 	"refs/heads/%.*s",
 	NULL
 };
-- 
1.7.8.rc1.82.g90e080
