Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 547AE2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752448AbcIOU6O (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:58:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751570AbcIOU6M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:58:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D5FE3D673;
        Thu, 15 Sep 2016 16:58:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=astU2GEik0mNa5D6kAmWG/j2bKw=; b=MId1qH
        DcDLgVqvfJsYmEJFWVX75jZszY+Y4Oa7SDXb4Ow655hBiLjkVb0EC81UGTZGUJve
        jGvfHpWtIma/zUnLL8HkQzHsvPitSLeQE2NZgyHW7VLJIHTNqcbFoctYVOU93zdC
        lmUiL+HFH5yOMD/UgS4S9sp5SEjcEP/erg7Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MQj8KQoYrHxTMLNZ4VYR7CzEgX9vRZue
        37tHxU7Rk/BtAo81VlCcywwptXVHXa2qKRxlfwDLi6bgYwZE5z1fHXt6StXdxK3T
        FZ/5C3PaW2s/5bVieCmWxjrOseeryqOs6KLS3fePce+Ag23ZoDQ3a1qVwAp/A6Y5
        6+50ppGeHsc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 858A33D671;
        Thu, 15 Sep 2016 16:58:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11FE53D670;
        Thu, 15 Sep 2016 16:58:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <1473726835-143289-1-git-send-email-bmwill@google.com>
        <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 13:58:09 -0700
In-Reply-To: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 13 Sep 2016 09:31:18 -0700")
Message-ID: <xmqqa8f8nan2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C88C050-7B87-11E6-B665-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is an absolute mininum fix ;-)

 builtin/ls-files.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0bce00..6e78c71 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -78,7 +78,7 @@ static void write_name(const char *name)
 	 * churn.
 	 */
 	static struct strbuf full_name = STRBUF_INIT;
-	if (output_path_prefix != '\0') {
+	if (*output_path_prefix) {
 		strbuf_reset(&full_name);
 		strbuf_addstr(&full_name, output_path_prefix);
 		strbuf_addstr(&full_name, name);
-- 
2.10.0-458-g97b4043

