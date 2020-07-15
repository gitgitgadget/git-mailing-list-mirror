Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BBC433E1
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3312065F
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YjxN/HhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGORBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:01:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60742 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGORBp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 13:01:45 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52EFD6EDED;
        Wed, 15 Jul 2020 13:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lc7ijDSPWxCVe40OgtiReWu5TxI=; b=YjxN/H
        hZUMC/nO0V6I3afHLRF5kw5tRxqPTbxwMjkjp9Xpg1l1+1+xr3d2UBeOp2PdCzNc
        T76sGOk+TV9kCHW2iE1qKN6omarFXA1UVeUckXP185c33u5fsnZe8smemz0XPVjD
        3ony37SYShjSgiJdP8blT+NW1V2l5WmKk1CuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NHiCwSk1hYdCDjkS3fNwJPVctQ+QUFkq
        TywBuQNR/kd10wnrbYaiCDByVt0A9HsvlDvCTjd0zqFHVwNPfHKfo5aPsf6Ajw2p
        YAw9TynNwTwUdeVv6ADuoPQIFon/p28TaNzorri+/PftEyXozxuM2Ev8iHtG0Myc
        dn2f9JisFgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49DA56EDEC;
        Wed, 15 Jul 2020 13:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD38C6EDEB;
        Wed, 15 Jul 2020 13:01:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
Date:   Wed, 15 Jul 2020 10:01:40 -0700
In-Reply-To: <xmqqpn8wkben.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Jul 2020 09:09:36 -0700")
Message-ID: <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA5D10AC-C6BC-11EA-9762-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The current one on the table is NOT
> <20200714040616.GA2208896@google.com> but the two patches
>
> <1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
> <e11e973c6fff6a523da090f7294234902e65a9d0.1594690017.git.gitgitgadget@gmail.com>
>
> For example it special cases only the worktreeconfig and nothing
> else, even though I suspect that other configuration variables were
> also honored by mistake.

The attached may be a less ambitious and less risky update for the
upcoming release.  It is to be applied on top of the two-patch
series from Derrick, and just marks the other "known and honored
back then by mistake" extensions as OK to be there for upgrading.

Thoughts?  If people are happy with that, then we could apply and
cut an -rc1 with it.  Or if we are OK with the "just special case
worktreeconfig; other extensions may have the same issue but we
haven't heard actual complaints so we will leave them untouched",
then -rc1 can be done with just those two patches.

Now I do need to shift my attention to other topics in flight.

Thanks.


 setup.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index 65270440a9..a072c76d05 100644
--- a/setup.c
+++ b/setup.c
@@ -456,27 +456,32 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
 		/*
-		 * record any known extensions here; otherwise,
-		 * we fall through to recording it as unknown, and
-		 * check_repository_format will complain
+		 * Grandfather extensions that were known in 2.27 and
+		 * were honored by mistake even in v0 repositories; it
+		 * shoudn't be an error to upgrade v0 to v1 with them
+		 * in the repository, as they couldn't have been used
+		 * for incompatible purposes by the end user.
 		 */
-		int is_unallowed_extension = 1;
+		int unallowed_in_v0 = 1;
 
-		if (!strcmp(ext, "noop"))
-			;
-		else if (!strcmp(ext, "preciousobjects"))
+		if (!strcmp(ext, "noop")) {
+			unallowed_in_v0 = 0;
+		} else if (!strcmp(ext, "preciousobjects")) {
 			data->precious_objects = git_config_bool(var, value);
-		else if (!strcmp(ext, "partialclone")) {
+			unallowed_in_v0 = 0;
+		} else if (!strcmp(ext, "partialclone")) {
 			if (!value)
 				return config_error_nonbool(var);
 			data->partial_clone = xstrdup(value);
+			unallowed_in_v0 = 0;
 		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-			is_unallowed_extension = 0;
-		} else
+			unallowed_in_v0 = 0;
+		} else {
 			string_list_append(&data->unknown_extensions, ext);
+		}
 
-		data->has_unallowed_extensions |= is_unallowed_extension;
+		data->has_unallowed_extensions |= unallowed_in_v0;
 	}
 
 	return read_worktree_config(var, value, vdata);
