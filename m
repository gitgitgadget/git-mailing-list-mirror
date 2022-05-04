Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16848C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 19:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbiEDTNL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiEDTNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 15:13:09 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D987B40A1E
        for <git@vger.kernel.org>; Wed,  4 May 2022 12:09:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A64CB11DE46;
        Wed,  4 May 2022 15:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fpafl3yGoJ5qtsQqFHP8jp5cbbbiByscLie+wb
        flR9w=; b=RtzP4lyHf73eQp+QnTCdhjUWd6M+YMl9Cl0OGVpkntYZikPOGlmBw4
        9ks/zpDal6EyCalSTx74HAGLcKWxkSivJQp1l2z6ejOEWpcY92h+vEQ4RiThb26Y
        5EAiwvDMDZxE1PCScF0xZ4dEuedP+7r90jUL3TK2MouLAPMBp1/LM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D8AF11DE45;
        Wed,  4 May 2022 15:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09E5311DE42;
        Wed,  4 May 2022 15:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] object-store: add function to free object_info
 contents
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-4-calvinwan@google.com>
        <xmqqzgjztt7s.fsf@gitster.g>
Date:   Wed, 04 May 2022 12:09:29 -0700
In-Reply-To: <xmqqzgjztt7s.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        02 May 2022 16:23:03 -0700")
Message-ID: <xmqq8rrhm7x2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA03064A-CBDD-11EC-BBF7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +}
>> \ No newline at end of file
>
> Let's avoid such incomplete lines.

As this breaks my build cycle ("make sparse" is part of my
post-integration check), I have added this workaround on the tip of
the topic, but please make sure I do not have to redo that when you
reroll.

Thanks.

Subject: [PATCH] SQUASH??? compilation fix

"make sparse" rightfully complains that this file ends in an
incomplete line.
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 34a6e34adf..c6addb6969 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2674,4 +2674,4 @@ void free_object_info_contents(struct object_info *object_info)
 		free(object_info->delta_base_oid);
 	if (object_info->type_name)
 		free(object_info->type_name);
-}
\ No newline at end of file
+}
-- 
2.36.0-244-ge81c54a17b

