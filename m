Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45732C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098842087D
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xeG7Ecr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgIHWBM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:01:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59959 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgIHWBL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:01:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF60C8BEF4;
        Tue,  8 Sep 2020 18:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xAaHrj0KDy2o/abJExKYIFcz/yk=; b=xeG7Ec
        r0RUtGLIaP4M3ziJUrDWkyTUKiCLzO8PjqD+biZUVQwI7BZ3jxcvWuXty5tPtes2
        grgy9VIKwGYW4leal9wV3swVGZvo7L/bVr6o8qWvrzzW4IRsA12oNYBujIUCS4Uk
        urNrdykQTZbywRLkUgveOYaGCB3r3FA/TSAQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gpdj3Na/T6gGid0X8Q2mtZyhSISbtWDv
        XmIWLVf21MvazypRYG7kIdzbqKF/oNaWMK6jMGd/r8JQpZF7kF53HNH5RVcZrVfn
        HCl1B1J/U7faTZIZzUtk0wFCxakbT8HpstwiZLxt5Y8a8mFretr1w6+hEMvV/1H4
        8JOXkgco4Bw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B3CE8BEF3;
        Tue,  8 Sep 2020 18:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB4C88BEF2;
        Tue,  8 Sep 2020 18:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, phillip.wood@dunelm.org.uk,
        Thomas Sullivan <tom@msbit.com.au>, git@vger.kernel.org
Subject: Re: git add intent-to-add then git add patch no longer allows edit
References: <C55J4YTSBL48.171K3FSJLUQOA@ziyou.local>
        <1071d841-a030-30c2-e50e-6d97eb494fea@gmail.com>
        <nycvar.QRO.7.76.6.2009040831570.56@tvgsbejvaqbjf.bet>
        <xmqqd02y7rwj.fsf@gitster.c.googlers.com>
        <a8099cb4-97e0-5596-72a1-10402762015b@gmail.com>
        <xmqqsgbsz22t.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009082151520.54@tvgsbejvaqbjf.bet>
Date:   Tue, 08 Sep 2020 15:00:59 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009082151520.54@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 8 Sep 2020 21:52:13 +0200 (CEST)")
Message-ID: <xmqq363sx71g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7986010-F21E-11EA-AF31-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Like this?  If the more specific one is specifically set, we do not
>> look at experimental bit, but otherwise we use the built-in version.
>
> Looks fine to me,
> Dscho

Thanks, with the proposed log message this time...

-- >8 --
Subject: [PATCH] add -i: use the built-in version when feature.experimental is set

We have had parallel implementations of "add -i/-p" since 2.25 and
have been using them from various codepaths since 2.26 days, but
never made the built-in version the default.

We have found and fixed a handful of corner case bugs in the
built-in version, and it may be a good time to start switching over
the user base from the scripted version to the built-in version.
Let's enable the built-in version for those who opt into the
feature.experimental guinea-pig program to give wider exposure.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
-- 
2.28.0-539-g66371d8995

