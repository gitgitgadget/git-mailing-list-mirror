Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1401C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332042098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qJc4X1y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgIHQH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:07:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63596 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgIHQFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 12:05:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89B4C88EEB;
        Tue,  8 Sep 2020 12:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YpeAT5psFYKKrT7Vi4esbp0rpTI=; b=qJc4X1
        y7zpNK7s/DM8urBp5AkT7Mbw/v8XgbC5Jk5FogPtrA0pprBIVNsWPZ8NaaXw/VQ9
        v4D8yrppKNEBu2Gwv1yc0JBMldl0jGCWR4uH/vHJ7oA14HG4/QYTrwHx0CELNSfF
        l5g1RiLWloFmdHwu+hB+e1rJzRLkzK0PnX5dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J3zKqINP/0Fml6ZQ6HSwc6fkHrbDWQJd
        92WWAiUH3GhP7BCBly2XvNGQPrVbsgnm3BKSgIjkwA6vmoMHRYhbmlm1rmlNynbv
        1GBlV7Quql60efB7NzYOr5mMKqUYZ3AdeqBd2VNXZf24VdWAV4awTWTNUHMBStYf
        4dZbwwZ3BU0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8112388EEA;
        Tue,  8 Sep 2020 12:05:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E44C888EE9;
        Tue,  8 Sep 2020 12:05:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
Subject: Re: git add intent-to-add then git add patch no longer allows edit
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
        <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
        <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
        <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
        <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com>
Date:   Tue, 08 Sep 2020 09:05:14 -0700
In-Reply-To: <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com> (Phillip Wood's
        message of "Mon, 7 Sep 2020 19:00:13 +0100")
Message-ID: <xmqqsgbsz22t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14F7EAF6-F1ED-11EA-BE5A-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>  If we do not flip the
>> "use the built-in variant" for those with feature.experimental we
>> really should do so to widen the canarying population immediately.
>
> That's a good idea

Like this?  If the more specific one is specifically set, we do not
look at experimental bit, but otherwise we use the built-in version.

 builtin/add.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b36a99eb7c..26b6ced09e 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -192,9 +192,15 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	int use_builtin_add_i =
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
 
-	if (use_builtin_add_i < 0)
-		git_config_get_bool("add.interactive.usebuiltin",
-				    &use_builtin_add_i);
+	if (use_builtin_add_i < 0) {
+		int experimental;
+		if (!git_config_get_bool("add.interactive.usebuiltin",
+					 &use_builtin_add_i))
+			; /* ok */
+		else if (!git_config_get_bool("feature.experimental", &experimental) &&
+			 experimental)
+			use_builtin_add_i = 1;
+	}
 
 	if (use_builtin_add_i == 1) {
 		enum add_p_mode mode;
