Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF40BC433E0
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67C420720
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJulbgw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGOQJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:09:48 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58681 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOQJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jul 2020 12:09:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBBC8DD526;
        Wed, 15 Jul 2020 12:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gVbC7ufFj/SFbE1qqIS3W0drM/g=; b=RJulbg
        w84FdupKu6p+TiBiMqksM4UmojPuGbByjfHR8v4zOhY9n3D8YSCxLEtse9FneOds
        t9XnFSM+W3d4IoG2lUZv/Sfnp4XevRfblpP3aPmQjxcxfuhEOs4W6BKvymNwRBE8
        pjK3mH+aimalnp5HHdZfa+dfLLST7ksLUalJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ng8RFxbSdUhaE42CjaGEAVU+PBAVVfmK
        CzC2UHLqbkYrz2AhxXTfTpXrkqxrYoXRJRJAnehyPwPHWx4MBnpYiA+/2qpVp+Vy
        XpgQFMb8zMSdai8oi7S8+HD6aC1arXrZsdhyZKVLuxIE9nHOlg1bwKBowPmmnj18
        AYz+sMQDNuc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4060DD525;
        Wed, 15 Jul 2020 12:09:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED460DD524;
        Wed, 15 Jul 2020 12:09:37 -0400 (EDT)
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
Date:   Wed, 15 Jul 2020 09:09:36 -0700
In-Reply-To: <xmqqzh82ktgm.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 14 Jul 2020 08:27:21 -0700")
Message-ID: <xmqqpn8wkben.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95072C24-C6B5-11EA-A695-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> If you don't mind, I was already going to squash Junio's commit into
>>> mine (almost completely replacing mine) but I could add a small
>>> commit on top that provides the following improvement to the error
>>> message:
>>
>> I don't mind at all. I'd just like to know that v2.28.0 avoids confusing
>> users in the same was as v2.28.0-rc0 confused me.
>
> In a nearby thread, Jonathan Nieder raised an interesting approach
> to avoid confusing users, which I think (if I am reading him
> correctly) makes sense (cf. <20200714040616.GA2208896@google.com>)
>
> What if we accept the extensions the code before the topic in
> question that was merged in -rc0 introduced the "confusion" accepts
> even in v0?  If we see extensions other than those handpicked and
> grandfathered ones (which are presumably the ones we add later and
> support in v1 and later repository versions) in a v0 repository, we
> keep ignoring.  Also we'd loosen the overly strict code that
> prevents upgrading from v0 to v1 in the presence of any extensions
> in -rc0, so that the grandfathered ones will not prevent the
> upgrading.
>
> The original reasoning behind the strict check was because the users
> could have used extensions.frotz for their own use with their own
> meaning, trusting that Git would simply ignore it, and an upgrade to
> later version in which Git uses extensions.frotz for a purpose that
> is unrelated to the reason why these users used would just break the
> repository.  
>
> But the ones that were (accidentally) honored in v0 couldn't have
> been used by the users for the purposes other than how Git would use
> them anyway, so there is no point to make them prevent the upgrade
> of the repository version from v0 to v1.
>
> At least, that is how I understood the world would look like in
> Jonathan's "different endgame".
>
> What do you three (Dscho, Derrick and Jonathan) think?  

It seems that there is no quick concensus to go with your "different
endgame" and worse yet it seems nobody is interested in helping
much.

The current one on the table is NOT
<20200714040616.GA2208896@google.com> but the two patches

<1b26d9710a7ffaca0bad1f4e1c1729f501ed1559.1594690017.git.gitgitgadget@gmail.com>
<e11e973c6fff6a523da090f7294234902e65a9d0.1594690017.git.gitgitgadget@gmail.com>

which we may regret---it is far from a robust and complete solution,
but probably specific to users at Microsoft or something like that.
For example it special cases only the worktreeconfig and nothing
else, even though I suspect that other configuration variables were
also honored by mistake.

So...

Here is my quick attempt to see how far we can go with the
"different endgame" approach, to be applied on top of those two
patches.  It still has two known "breakages" and can use help from
extra eyeballs and real work.

I suspect that an expected test_must_fail not triggering t2404 may
even be a good thing if it is a sign of silent upgrading of the
repository version due to having grandfathered extensions in a v0
repository, but I didn't have time to dig further.

I'll shift my attention to other topics that should be in the
release for the rest of the day, but am pessimistic that I can tag
the -rc1 today, which won't happen until we at least have a
concensus on what to do with the (apparent) regression due to the
"upgrade repository version" topic.

Thanks.

 setup.c                    | 52 +++++++++++++++++++++++++++-------------------
 t/t0410-partial-clone.sh   | 14 ++++++++++++-
 t/t2404-worktree-config.sh |  2 +-
 3 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/setup.c b/setup.c
index 65270440a9..fe4e1ec066 100644
--- a/setup.c
+++ b/setup.c
@@ -455,28 +455,37 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
+		int unallowed_in_v0 = 1;
+
 		/*
-		 * record any known extensions here; otherwise,
-		 * we fall through to recording it as unknown, and
-		 * check_repository_format will complain
+		 * The early ones are grandfathered---they existed in
+		 * 2.27 which mistakenly honored even in repositories
+		 * whose version is before v1 (where extensions are
+		 * officially introduced).
 		 */
-		int is_unallowed_extension = 1;
-
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
+		/*
+		 * Extensions are added by more "} else if (...) {"
+		 * lines here, but do NOT mark them as allowed in v0
+		 * by copy-pasting without thinking.
+		 */
+		} else {
 			string_list_append(&data->unknown_extensions, ext);
+		}
 
-		data->has_unallowed_extensions |= is_unallowed_extension;
+		data->has_unallowed_extensions |= unallowed_in_v0;
 	}
 
 	return read_worktree_config(var, value, vdata);
@@ -511,15 +520,16 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 		die("%s", err.buf);
 	}
 
-	if (candidate->version >= 1) {
-		repository_format_precious_objects = candidate->precious_objects;
-		set_repository_format_partial_clone(candidate->partial_clone);
-		repository_format_worktree_config = candidate->worktree_config;
-	} else {
-		repository_format_precious_objects = 0;
-		set_repository_format_partial_clone(NULL);
-		repository_format_worktree_config = 0;
-	}
+	/*
+	 * Now we know the extensions in "candidate" repository are
+	 * OK, let's copy them to the final place.  Note that this is
+	 * done even in v0 repositories, as long as the extensions are
+	 * the grandfathered ones that used to be honored by mistake.
+	 */
+	repository_format_precious_objects = candidate->precious_objects;
+	set_repository_format_partial_clone(candidate->partial_clone);
+	repository_format_worktree_config = candidate->worktree_config;
+
 	string_list_clear(&candidate->unknown_extensions, 0);
 
 	if (repository_format_worktree_config) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 463dc3a8be..2fc2d0bbfc 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,7 +42,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
 
-test_expect_success 'convert shallow clone to partial clone must fail with any extension' '
+test_expect_success 'convert shallow clone to partial clone succeeds with grandfathered extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
@@ -50,6 +50,18 @@ test_expect_success 'convert shallow clone to partial clone must fail with any e
 	git clone --depth=1 "file://$(pwd)/server" client &&
 	test_cmp_config -C client 0 core.repositoryformatversion &&
 	git -C client config extensions.partialclone origin &&
+	git -C client fetch --unshallow --filter="blob:none"
+'
+
+test_expect_failure 'convert shallow clone to partial clone must fail with unknown extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=1 "file://$(pwd)/server" client &&
+	test_cmp_config -C client 0 core.repositoryformatversion &&
+	git -C client config extensions.unknownExtension true &&
+	git -C client config extensions.partialclone origin &&
 	test_must_fail git -C client fetch --unshallow --filter="blob:none"
 '
 
diff --git a/t/t2404-worktree-config.sh b/t/t2404-worktree-config.sh
index 303a2644bd..b8c12df534 100755
--- a/t/t2404-worktree-config.sh
+++ b/t/t2404-worktree-config.sh
@@ -77,7 +77,7 @@ test_expect_success 'config.worktree no longer read without extension' '
 	test_cmp_config -C wt1 shared this.is &&
 	test_cmp_config -C wt2 shared this.is
 '
-test_expect_success 'show advice when extensions.* are not enabled' '
+test_expect_failure 'show advice when extensions.* are not enabled' '
 	test_config core.repositoryformatversion 1 &&
 	test_config extensions.worktreeConfig true &&
 	git config --worktree test.one true &&
