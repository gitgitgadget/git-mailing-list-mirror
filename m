Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED2B20248
	for <e@80x24.org>; Tue, 26 Mar 2019 08:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfCZIvv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 04:51:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbfCZIvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 04:51:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id e24so6906187pfi.12
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YLs4KuilYcNcQ+vzJ03ZeFEbBViMp47g/91mePMJWVE=;
        b=t2m3hsAgYGb2g2mYSP2/ltiA+E4ocwPwDYwTFr5muz+JIVVqmdK0Na3XWS/0+8i5al
         UFDyjd8sODPLHakwpqQoHekhRjx1qEvPXtZm02O0UVxmwkuMs3m3H7w1mJOE+PWqyAwA
         qx4IfSdYPN+aKSfrgmN6v21v7Fq+eQhFq0ieGbreryQxnX7fbbZfhPxp/5rZTHCfQvOZ
         GM7qwsJZNmFdHam4k78eCCHSLTM2mX7aYrXdKih45egnUJTzAEODGVkV4ApvywK4v6EH
         UA68h0N08pLrehwPrqtOLR4eyb46t4OfZu26RGT6pJMPqV0Wpv6B07aDfRoFTqcu0uG8
         qE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YLs4KuilYcNcQ+vzJ03ZeFEbBViMp47g/91mePMJWVE=;
        b=NXZuB0g8iHWJp/b9bN//5D7QZAncH9FkN5qY6IXvlOjz32Nwss2wrlBga6xJLFjLFD
         sjzDtjo50itTVOMioYgCka55hVuOEqu3ncwRmaLqMvxJC2+JkrtytIGbrpJFd8QB5OrI
         396rObmtgqRt/0HMAUL4TrGjji+PJeqAWzm7YNeMaMGQBB8ZmmSGS8v5piw2GWFbp9co
         yZ7oVxIemuTr0oTsGt3ZqTwWqUJGI+vA5z2lMg2H1SxPWgtMze+5A8VHzMFqUp35KuOS
         a6sAE5VKnWGEuelqO9M2P0aV3J2az7ef0monFopp47z7P5ywx8lC8uCv/ld2SGKG3jvH
         MtWA==
X-Gm-Message-State: APjAAAVAp5mLUHDD8klaPCnccjFib5wbxp9uWgmcVB37SKGFu0DEuP5d
        t0jxdSpa7VwItufu8wLgBqpjB94H
X-Google-Smtp-Source: APXvYqxeIS+GFuNQaRMCBYXLKc3zUmtz+H20S1pso/49zB90OjpVKVz8FPjyXqGSevzYnJCmjb3atA==
X-Received: by 2002:a63:e051:: with SMTP id n17mr27466059pgj.19.1553590310349;
        Tue, 26 Mar 2019 01:51:50 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id m3sm20276390pgp.85.2019.03.26.01.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 01:51:49 -0700 (PDT)
Date:   Tue, 26 Mar 2019 01:51:47 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: [PATCH 1/3] tag: prevent recursive tags
Message-ID: <20190326085147.GA3837@archbookpro.localdomain>
References: <20190325233723.GD23728@sigill.intra.peff.net>
 <cover.1553586707.git.liu.denton@gmail.com>
 <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c371a653b4049256f3427e467b144385ee47ef43.1553586707.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 12:53:18AM -0700, Denton Liu wrote:
> Robert Dailey reported confusion on the mailing list about a recursive
> tag which was most likely created by mistake. Jeff King noted that this
> isn't a very common case so, most likely, creating a tag-to-a-tag is a
> user-error.
> 
> Prevent mistakes by erroring and providing advice on recursive tags,
> unless "--allow-recursive-tag" is specified. Fix tests that fail as a
> result of this change.
> 
> Reported-by: Robert Dailey <rcdailey.lists@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  advice.c                       |  2 ++
>  advice.h                       |  1 +
>  builtin/tag.c                  | 30 ++++++++++++++++++++++++++----
>  t/annotate-tests.sh            |  2 +-
>  t/t0410-partial-clone.sh       |  2 +-
>  t/t4205-log-pretty-formats.sh  |  2 +-
>  t/t5305-include-tag.sh         |  2 +-
>  t/t5500-fetch-pack.sh          |  2 +-
>  t/t6302-for-each-ref-filter.sh |  4 ++--
>  t/t7004-tag.sh                 |  4 ++--
>  t/t9350-fast-export.sh         |  4 ++--
>  11 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 567209aa79..f31889e6de 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -26,6 +26,7 @@ int advice_ignored_hook = 1;
>  int advice_waiting_for_editor = 1;
>  int advice_graft_file_deprecated = 1;
>  int advice_checkout_ambiguous_remote_branch_name = 1;
> +int advice_recursive_tag = 1;
>  
>  static int advice_use_color = -1;
>  static char advice_colors[][COLOR_MAXLEN] = {
> @@ -81,6 +82,7 @@ static struct {
>  	{ "waitingForEditor", &advice_waiting_for_editor },
>  	{ "graftFileDeprecated", &advice_graft_file_deprecated },
>  	{ "checkoutAmbiguousRemoteBranchName", &advice_checkout_ambiguous_remote_branch_name },
> +	{ "recursiveTag", &advice_recursive_tag },
>  
>  	/* make this an alias for backward compatibility */
>  	{ "pushNonFastForward", &advice_push_update_rejected }
> diff --git a/advice.h b/advice.h
> index f875f8cd8d..66aa39757c 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -26,6 +26,7 @@ extern int advice_ignored_hook;
>  extern int advice_waiting_for_editor;
>  extern int advice_graft_file_deprecated;
>  extern int advice_checkout_ambiguous_remote_branch_name;
> +extern int advice_recursive_tag;
>  
>  int git_default_advice_config(const char *var, const char *value);
>  __attribute__((format (printf, 1, 2)))
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 02f6bd1279..0b44a3cbc1 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -22,10 +22,11 @@
>  #include "ref-filter.h"
>  
>  static const char * const git_tag_usage[] = {
> -	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
> +	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [--allow-recursive-tag]\n"
> +		"\t\t<tagname> [<head>]"),
>  	N_("git tag -d <tagname>..."),
> -	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]"
> -		"\n\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
> +	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
> +		"\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"),
>  	N_("git tag -v [--format=<format>] <tagname>..."),
>  	NULL
>  };
> @@ -197,6 +198,7 @@ static int build_tag_object(struct strbuf *buf, int sign, struct object_id *resu
>  struct create_tag_options {
>  	unsigned int message_given:1;
>  	unsigned int use_editor:1;
> +	unsigned int allow_recursive_tag;
>  	unsigned int sign;
>  	enum {
>  		CLEANUP_NONE,
> @@ -205,6 +207,17 @@ struct create_tag_options {
>  	} cleanup_mode;
>  };
>  
> +static const char message_advice_recursive_tag[] =
> +	N_("The object '%s' referred to by your new tag is already a tag.\n"
> +	   "\n"
> +	   "If you meant to create a tag of a tag, use:\n"
> +	   "\n"
> +	    "\tgit tag --allow-recursive-tag %s\n"

My bad, left an extra space before the quote.

> +	   "\n"
> +	   "If you meant to tag the object that it points to, use:\n"
> +	   "\n"
> +	   "\tgit tag %s^{}");
> +
>  static void create_tag(const struct object_id *object, const char *tag,
>  		       struct strbuf *buf, struct create_tag_options *opt,
>  		       struct object_id *prev, struct object_id *result)
> @@ -215,7 +228,14 @@ static void create_tag(const struct object_id *object, const char *tag,
>  
>  	type = oid_object_info(the_repository, object, NULL);
>  	if (type <= OBJ_NONE)
> -	    die(_("bad object type."));
> +		die(_("bad object type."));
> +
> +	if (type == OBJ_TAG && !opt->allow_recursive_tag) {
> +		error(_("refusing to make a recursive tag"));
> +		if (advice_recursive_tag)
> +			advise(_(message_advice_recursive_tag), tag, tag, tag);
> +		exit(1);
> +	}
>  
>  	strbuf_addf(&header,
>  		    "object %s\n"
> @@ -403,6 +423,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  					N_("use another key to sign the tag")),
>  		OPT__FORCE(&force, N_("replace the tag if exists"), 0),
>  		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
> +		OPT_BOOL(0, "allow-recursive-tag", &opt.allow_recursive_tag,
> +					N_("allow recursive tags to be made")),
>  
>  		OPT_GROUP(N_("Tag listing options")),
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
> index 6da48a2e0a..841f922e07 100644
> --- a/t/annotate-tests.sh
> +++ b/t/annotate-tests.sh
> @@ -70,7 +70,7 @@ test_expect_success 'blame 1 author' '
>  
>  test_expect_success 'blame by tag objects' '
>  	git tag -m "test tag" testTag &&
> -	git tag -m "test tag #2" testTag2 testTag &&
> +	git tag -m "test tag #2" --allow-recursive-tag testTag2 testTag &&
>  	check_count -h testTag A 2 &&
>  	check_count -h testTag2 A 2
>  '
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index bce02788e6..5f06c2d76f 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -16,7 +16,7 @@ pack_as_from_promisor () {
>  
>  promise_and_delete () {
>  	HASH=$(git -C repo rev-parse "$1") &&
> -	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
> +	git -C repo tag -a -m message my_annotated_tag --allow-recursive-tag "$HASH" &&
>  	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
>  	# tag -d prints a message to stdout, so redirect it
>  	git -C repo tag -d my_annotated_tag >/dev/null &&
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
> index f42a69faa2..018550f3b2 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -511,7 +511,7 @@ test_expect_success 'set up log decoration tests' '
>  
>  test_expect_success 'log decoration properly follows tag chain' '
>  	git tag -a tag1 -m tag1 &&
> -	git tag -a tag2 -m tag2 tag1 &&
> +	git tag -a tag2 -m tag2 --allow-recursive-tag tag1 &&
>  	git tag -d tag1 &&
>  	git commit --amend -m shorter &&
>  	git log --no-walk --tags --pretty="%H %d" --decorate=full >actual &&
> diff --git a/t/t5305-include-tag.sh b/t/t5305-include-tag.sh
> index a5eca210b8..c99850c1c0 100755
> --- a/t/t5305-include-tag.sh
> +++ b/t/t5305-include-tag.sh
> @@ -68,7 +68,7 @@ test_expect_success 'check unpacked result (have commit, have tag)' '
>  test_expect_success 'create hidden inner tag' '
>  	test_commit commit &&
>  	git tag -m inner inner HEAD &&
> -	git tag -m outer outer inner &&
> +	git tag -m outer --allow-recursive-tag outer inner &&
>  	git tag -d inner
>  '
>  
> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 49c540b1e1..c549b37aec 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -562,7 +562,7 @@ test_expect_success 'test --all wrt tag to non-commits' '
>  		hello tag
>  	EOF
>  	) &&
> -	git tag -a -m "tag -> tag" tag-to-tag $tag &&
> +	git tag -a -m "tag -> tag" --allow-recursive-tag tag-to-tag $tag &&
>  
>  	# `fetch-pack --all` should succeed fetching all those objects.
>  	mkdir fetchall &&
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fc067ed672..f7b56ae195 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -12,7 +12,7 @@ test_expect_success 'setup some history and refs' '
>  	git checkout -b side &&
>  	test_commit four &&
>  	git tag -m "An annotated tag" annotated-tag &&
> -	git tag -m "Annonated doubly" doubly-annotated-tag annotated-tag &&
> +	git tag -m "Annonated doubly" --allow-recursive-tag doubly-annotated-tag annotated-tag &&
>  
>  	# Note that these "signed" tags might not actually be signed.
>  	# Tests which care about the distinction should be marked
> @@ -24,7 +24,7 @@ test_expect_success 'setup some history and refs' '
>  		sign=
>  	fi &&
>  	git tag $sign -m "A signed tag" signed-tag &&
> -	git tag $sign -m "Signed doubly" doubly-signed-tag signed-tag &&
> +	git tag $sign -m "Signed doubly" --allow-recursive-tag doubly-signed-tag signed-tag &&
>  
>  	git checkout master &&
>  	git update-ref refs/odd/spot master
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 0b01862c23..7a7c0ccee9 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1265,7 +1265,7 @@ echo "A message for another tag" >>expect
>  echo '-----BEGIN PGP SIGNATURE-----' >>expect
>  test_expect_success GPG \
>  	'creating a signed tag pointing to another tag should succeed' '
> -	git tag -s -m "A message for another tag" tag-signed-tag signed-tag &&
> +	git tag -s -m "A message for another tag" --allow-recursive-tag tag-signed-tag signed-tag &&
>  	get_tag_msg tag-signed-tag >actual &&
>  	test_cmp expect actual
>  '
> @@ -1690,7 +1690,7 @@ test_expect_success '--points-at finds annotated tags of commits' '
>  '
>  
>  test_expect_success '--points-at finds annotated tags of tags' '
> -	git tag -m "describing the v4.0 tag object" \
> +	git tag -m "describing the v4.0 tag object" --allow-recursive-tag \
>  		annotated-again-v4.0 annotated-v4.0 &&
>  	cat >expect <<-\EOF &&
>  	annotated-again-v4.0
> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index 5690fe2810..b5ed7e119a 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -441,8 +441,8 @@ test_expect_success 'set-up a few more tags for tag export tests' '
>  	HEAD_TREE=$(git show -s --pretty=raw HEAD | grep tree | sed "s/tree //") &&
>  	git tag    tree_tag        -m "tagging a tree" $HEAD_TREE &&
>  	git tag -a tree_tag-obj    -m "tagging a tree" $HEAD_TREE &&
> -	git tag    tag-obj_tag     -m "tagging a tag" tree_tag-obj &&
> -	git tag -a tag-obj_tag-obj -m "tagging a tag" tree_tag-obj
> +	git tag    tag-obj_tag     -m "tagging a tag" --allow-recursive-tag tree_tag-obj &&
> +	git tag -a tag-obj_tag-obj -m "tagging a tag" --allow-recursive-tag tree_tag-obj
>  '
>  
>  test_expect_success 'tree_tag'        '
> -- 
> 2.21.0.512.g57bf1b23e1
> 
