From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/12] fetch: allow "git fetch $there v1.0" to fetch a tag
Date: Mon,  7 Nov 2011 19:00:37 -0800
Message-ID: <1320721245-13223-5-git-send-email-gitster@pobox.com>
References: <1320472900-6601-1-git-send-email-gitster@pobox.com>
 <1320721245-13223-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 04:01:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNbvv-0001LQ-Tb
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 04:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab1KHDBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 22:01:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab1KHDA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 22:00:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBD4E650C;
	Mon,  7 Nov 2011 22:00:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=y56i
	Dh37KwesUmNlJmLCfWtJ298=; b=mZkqiVWtTn/4ya16AB9JVAu5DeN8Dv0n+OsH
	d0Pm5Rr4Xp1jdA5ZZe6Oh3UmHcOUc3FS+3mmwl9Ox6MQllqBt8Z19Xpp7k3HBSkk
	rOqn/IAXpMhAaLpFA3VtunfdE1ZPw0rt58fSKCcuysw7/ozTseXOvbXip95UGs31
	hZQCzc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	vPlDqDoyH0eBsRasZGaqlwxM8Ht7TLjwJ0rEb2iBLFoAbgvM1Skm31uUhD6XaqR6
	vkjAjT20vcUnnVvnNrz1JSv2eC/u62jUHqaqkHoEJzLJsNc4zLm4z8D1mpjk8OmK
	96Yq2kbSqTv1vrWxOz2vJKE10VsREEy6IVTAVSb1ekY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C31D9650B;
	Mon,  7 Nov 2011 22:00:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56B26650A; Mon,  7 Nov 2011
 22:00:56 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.g90e080
In-Reply-To: <1320721245-13223-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E0D5960C-09B5-11E1-96E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185053>

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
1.7.8.rc0.128.g31aa4
