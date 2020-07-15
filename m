Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C01C433DF
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206EF20663
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JtP5nJid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgGOSJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:09:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57245 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSJS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 14:09:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24B5C78635;
        Wed, 15 Jul 2020 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nOODEybbxcziNspaviIf34qNZLM=; b=JtP5nJ
        id8YFLEMqXxLhErQw0lx82Y/9eR9+FpSeAehxxgGOiouzw9RkjHXdANO0AoHqGfE
        IKoJVSxDTwjEYH/ZwxJac3jDOog9T0r+i3vD9+NoZZbIvWy5gxx0K5aeR7SQibcC
        euYDGVWMbXwEsdSl4H9C1HKTKLvAbFgAnRjcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lPCWWgx22MWHkhyyeIZzAbaVvQMLb7a7
        kdyBa+LvgxsfvTICdC9BcdOowQrq5zL+VT2lsHDUio03xbE+kINDXgN8hganOKbg
        TMPyvXfYQYpcY+4bOSiKalP3eIUR8mrTBdgED25g9sDWH81tY0xYCJYxkovD9FB0
        RlbyCO6Iykc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D55B78634;
        Wed, 15 Jul 2020 14:09:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A0A1578631;
        Wed, 15 Jul 2020 14:09:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] setup: warn about un-enabled extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <xmqqlfjkk8zv.fsf@gitster.c.googlers.com>
        <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com>
Date:   Wed, 15 Jul 2020 11:09:13 -0700
In-Reply-To: <31f52913-8745-18b4-63fc-37d2a9aea8d0@gmail.com> (Derrick
        Stolee's message of "Wed, 15 Jul 2020 14:00:42 -0400")
Message-ID: <xmqqh7u8k5va.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AAAC53A-C6C6-11EA-B6E2-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Your previous diff had this comment, which I thought to be
> helpful: 
>
> +		/*
> +		 * Extensions are added by more "} else if (...) {"
> +		 * lines here, but do NOT mark them as allowed in v0
> +		 * by copy-pasting without thinking.
> +		 */

Yeah, but it felt somewhat strange to have it at the end of one
entry, like this:

+			unallowed_in_v0 = 0;
 		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
+			unallowed_in_v0 = 0;
+		/*
+		 * Extensions are added by more "} else if (...) {"
+		 * lines here, but do NOT mark them as allowed in v0
+		 * by copy-pasting without thinking.
+		 */
+		} else {
 			string_list_append(&data->unknown_extensions, ext);


In any case, I updated the comment in front of the if/else if/
cascade to essentially say the same thing, and with test updates
this time.

Thanks.

-- >8 --
Subject: [PATCH] setup: grandfather other extensions that used to be honored by mistake

We special cased worktreeconfig extension to be OK to exist when the
repository gets converted from v0 to v1 in an earlier commit, but
other extenions were also honored by mistake in v0.  Mark them the
same way so that they won't interfere with the upgrading from v0 to
v1.

A test in t0410 used to expect that presence of the
extension.partialclone configuration variable to interfere, but that
no longer is true.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 setup.c                  | 30 +++++++++++++++++++-----------
 t/t0410-partial-clone.sh | 18 ++++++++++++++++--
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/setup.c b/setup.c
index 65270440a9..97292479d6 100644
--- a/setup.c
+++ b/setup.c
@@ -456,27 +456,35 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
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
+		 *
+		 * When adding new extensions support in this if/elseif/...
+		 * cascade, do not mark them as allowed in v0!
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
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..e9674fc257 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+test_expect_success 'convert shallow clone to partial clone is OK with a grandfathered extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -50,7 +50,21 @@ test_expect_success 'convert shallow clone to partial clone must fail with any e
 	git clone --depth=1 "file://$(pwd)/server" client &&
 	test_cmp_config -C client 0 core.repositoryformatversion &&
 	git -C client config extensions.partialclone origin &&
-	test_must_fail git -C client fetch --unshallow --filter="blob:none"
+	git -C client fetch --unshallow --filter="blob:none" &&
+	test_cmp_config -C client 1 core.repositoryformatversion
+'
+
+test_expect_success 'convert shallow clone to partial clone must fail with an unknown extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	test_cmp_config -C client 0 core.repositoryformatversion &&
+	git -C client config extensions.partialclone origin &&
+	git -C client config extensions.unknown true &&
+	test_must_fail git -C client fetch --unshallow --filter="blob:none" &&
+	test_cmp_config -C client 0 core.repositoryformatversion
 '
 
 test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
-- 
2.28.0-rc0



