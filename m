From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 14/21] remote.c: read $GIT_DIR/remotes/* with strbuf_getline()
Date: Thu, 14 Jan 2016 15:58:29 -0800
Message-ID: <1452815916-6447-15-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnL-0003PK-1B
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbcANX7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932128AbcANX7C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:59:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C75323CD8C;
	Thu, 14 Jan 2016 18:59:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Lspx
	VvWWKch0Yo4U9Qp3pn2R7Yo=; b=G0Smnq+m906AU/5kH5ks5KoswwU3dcNPCtnW
	F4JwflShjyRtkwyJ24Efic2RTkv3wMh2Fn3Ku1k7CyF5R6D5O3P3R/FlWnlGG7XM
	ZqZHlvA36j14l4wByAFdI/kZ77W2VM8U4G3Kh/3eb/3yCboYioafxFsjBSVrYVw/
	ANYfUFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	K6VSZ4Ga8m0evaF61C4jJhCWYUsFRZuMNAgmrhcJZp8Aah4ZLoxvB6aCQv82PWhb
	6h/0tCaL2fpIHQEUaaNlrij7Fp5tbCiukq4WSLDxfhJRut6oZiC+KV8pxhCCsgSi
	mUrD0Gifa1D1q4xqaldLZjiV4kKhEtSSH5zDgXtenv4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC6853CD8B;
	Thu, 14 Jan 2016 18:59:01 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DA64D3CD8A;
	Thu, 14 Jan 2016 18:59:00 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C852D9EE-BB1A-11E5-8480-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284112>

These files can be edited with a DOS editor, leaving CR at the end
of the line if read with strbuf_getline().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f195693..7d61dab 100644
--- a/remote.c
+++ b/remote.c
@@ -256,7 +256,7 @@ static void read_remotes_file(struct remote *remote)
 	if (!f)
 		return;
 	remote->origin = REMOTE_REMOTES;
-	while (strbuf_getline_lf(&buf, f) != EOF) {
+	while (strbuf_getline(&buf, f) != EOF) {
 		const char *v;
 
 		strbuf_rtrim(&buf);
-- 
2.7.0-250-ge1b5ba3
