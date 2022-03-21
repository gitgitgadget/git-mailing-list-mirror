Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B762C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 14:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349582AbiCUOfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349428AbiCUOfA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 10:35:00 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41F1DF4F
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:33:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b15so18083372edn.4
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KZHwMIRqQpp2PSoua9bnJqm38Kx2yMgY2UgeI7o/opU=;
        b=NgHLJ2ZzQM+Zn2xQJuinfTPim+zbtSf1YLQ3ZycPudNUE2GkYFaOVX2iAeFsFYaCIa
         DnOcuRu+sHoUxk9tHL8HIzORG5xwew1s77GKPs4p1jHXLaKxlFP7qmfjLkYlngV9bepJ
         9/zpYyPAJWSmt8dOeFjKUX7zMHsqvr0MEHBjSNK8mNELOUYaXBcePlsC2oqMoxu6vGTv
         uwzyfS2Mlv9wc32rIDYKvSwBU9BzlIgNlTdDyVxqgIXB+07wqjYIWltv65PL1Trg3rDY
         vWVuV8WGJZOqEgR4yQyP0ElTFvzZiRK/scUguwqZ13V0GH91JFP18WOIRpFsptQbB1Qn
         mcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KZHwMIRqQpp2PSoua9bnJqm38Kx2yMgY2UgeI7o/opU=;
        b=Y5TpY9Lv5n37hz0I1p4i01hBolmw+OMlZSqLZ96fvVtpPvURw0gEkcrBqcWlpINa30
         YFpE68dKA54IduMyGqzZRPGp9N0TxuCYlxDvHP7Fx92lR9t78+/6cWlHv0TKZj4TjX0M
         z4u3h2i8L85m41bwjX1sDtBGPbsHAYoXKTbr/RE+d3PYZJZuJw6r6aOD9spAOv/NrhYI
         kVAmA+Thsgt6jdXnmdLt8gK4KcZnYlxNqnuAWK75gsJVC2/D2EOzhAVFzKRSdGma0++g
         vCK9BseDekk/yX3p501rIJy/35thEcz7cxyxN2yVDj69PJu9J4m1EmHUzG9U0AH0m5mb
         pzVA==
X-Gm-Message-State: AOAM532wgsDbbh1i2GLeygbvZJ2tsAFN2FX9Mr2XudBxokDRtRAFGEMT
        r84S1+UJ82BiVaoISS1rHewuO0S3VmY=
X-Google-Smtp-Source: ABdhPJxuOLiVJEKsBQxpZ9CYnXFp3l+EGErBExYShzojbpCEWhlg7H8hmXma3t+6Usc6XHN142VCoQ==
X-Received: by 2002:aa7:c3d6:0:b0:419:2370:4856 with SMTP id l22-20020aa7c3d6000000b0041923704856mr11480152edr.180.1647873207047;
        Mon, 21 Mar 2022 07:33:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i10-20020aa7dd0a000000b00419286d4824sm2779356edv.40.2022.03.21.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 07:33:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWJ66-000Y1C-5T;
        Mon, 21 Mar 2022 15:33:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] tracking branches: add advice to ambiguous refspec error
Date:   Mon, 21 Mar 2022 15:11:46 +0100
References: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <pull.1183.git.1647858238144.gitgitgadget@gmail.com>
Message-ID: <220321.86ee2v9xzd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Tao Klerks via GitGitGadget wrote:

Re $subject (and you've got another outstanding patch on list that's the
same), please add "RFC PATCH" to the subject for RFC patches, doesn't
GGG have some way to do that?

>      1. In this proposed patch the advice is emitted before the existing
>         die(), in order to avoid changing the exact error behavior and only
>         add extra/new hint lines, but in other advise() calls I see the
>         error being emitted before the advise() hint. Given that error() and
>         die() display different message prefixes, I'm not sure whether it's
>         possible to follow the existing pattern and avoid changing the error
>         itself. Should I just accept that with the new advice, the error
>         message can and should change?

You can and should use die_message() in this case, it's exactly what
it's intended for:

    int code = die_message(...);
    /* maybe advice */
    return code;

>      2. In order to include the names of the conflicting remotes I am
>         calling advise() multiple times - this is not a pattern I see
>         elsewhere - should I be building a single message and calling
>         advise() only once?

That would make me very happy, yes :)

I have some not-yet-sent patches to make a lot of this advice API less
sucky, mainly to ensure that we always have a 1=1=1 mapping between
config=docs=code, and to have the API itself emit the "and you can turn
this off with XYZ config".

I recently fixed the only in-tree message where we incrementally
constructed advice() because of that, so not having another one sneak in
would be good :)

> diff --git a/advice.c b/advice.c
> index 1dfc91d1767..686612590ec 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -39,6 +39,7 @@ static struct {
>  	[ADVICE_ADD_EMPTY_PATHSPEC]			= { "addEmptyPathspec", 1 },
>  	[ADVICE_ADD_IGNORED_FILE]			= { "addIgnoredFile", 1 },
>  	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir", 1 },
> +	[ADVICE_AMBIGUOUS_FETCH_REFSPEC]		= { "ambiguousFetchRefspec", 1 },
>  	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
>  	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
>  	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },

This is missing the relevant Documentation/config/advice.txt update

> diff --git a/advice.h b/advice.h
> index 601265fd107..3d68c1a6cb4 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -17,6 +17,7 @@ struct string_list;
>  	ADVICE_ADD_EMPTY_PATHSPEC,
>  	ADVICE_ADD_IGNORED_FILE,
>  	ADVICE_AM_WORK_DIR,
> +	ADVICE_AMBIGUOUS_FETCH_REFSPEC,
>  	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
>  	ADVICE_COMMIT_BEFORE_MERGE,
>  	ADVICE_DETACHED_HEAD,
> diff --git a/branch.c b/branch.c
> index 5d20a2e8484..243f6d8b362 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -12,6 +12,7 @@
>  struct tracking {
>  	struct refspec_item spec;
>  	struct string_list *srcs;
> +	struct string_list *remotes;
>
> +"There are multiple remotes with fetch refspecs mapping to\n"
> +"the tracking ref %s:\n";)

"with" and "mapping to" is a bit confusing, should this say:

    There are multiple remotes whole fetch refspecs map to the remote
    tracking ref '%s'?

(Should also have '' quotes for that in any case)

>  /*
>   * This is called when new_ref is branched off of orig_ref, and tries
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> @@ -227,11 +241,14 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  {
>  	struct tracking tracking;
>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
> +	struct string_list tracking_remotes = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	struct string_list_item *item;
>  
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	tracking.srcs = &tracking_srcs;
> +	tracking.remotes = &tracking_remotes;
>  	if (track != BRANCH_TRACK_INHERIT)
>  		for_each_remote(find_tracked_branch, &tracking);
>  	else if (inherit_tracking(&tracking, orig_ref))

FWIW I find the flow with something like this a lot clearer, i.e. not
adding the new thing to a widely-used struct, just have a CB struct for
the one thing that needs it:

	diff --git a/branch.c b/branch.c
	index 7958a2cb08f..55520eec6bd 100644
	--- a/branch.c
	+++ b/branch.c
	@@ -14,14 +14,19 @@
	 struct tracking {
	 	struct refspec_item spec;
	 	struct string_list *srcs;
	-	struct string_list *remotes;
	 	const char *remote;
	 	int matches;
	 };
	 
	+struct find_tracked_branch_cb {
	+	struct tracking *tracking;
	+	struct string_list remotes;
	+};
	+
	 static int find_tracked_branch(struct remote *remote, void *priv)
	 {
	-	struct tracking *tracking = priv;
	+	struct find_tracked_branch_cb *ftb = priv;
	+	struct tracking *tracking = ftb->tracking;
	 
	 	if (!remote_find_tracking(remote, &tracking->spec)) {
	 		if (++tracking->matches == 1) {
	@@ -31,7 +36,7 @@ static int find_tracked_branch(struct remote *remote, void *priv)
	 			free(tracking->spec.src);
	 			string_list_clear(tracking->srcs, 0);
	 		}
	-		string_list_append(tracking->remotes, remote->name);
	+		string_list_append(&ftb->remotes, remote->name);
	 		tracking->spec.src = NULL;
	 	}
	 
	@@ -245,16 +250,18 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
	 {
	 	struct tracking tracking;
	 	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
	-	struct string_list tracking_remotes = STRING_LIST_INIT_DUP;
	 	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
	 	struct string_list_item *item;
	+	struct find_tracked_branch_cb ftb_cb = {
	+		.tracking = &tracking,
	+		.remotes = STRING_LIST_INIT_DUP,
	+	};
	 
	 	memset(&tracking, 0, sizeof(tracking));
	 	tracking.spec.dst = (char *)orig_ref;
	 	tracking.srcs = &tracking_srcs;
	-	tracking.remotes = &tracking_remotes;
	 	if (track != BRANCH_TRACK_INHERIT)
	-		for_each_remote(find_tracked_branch, &tracking);
	+		for_each_remote(find_tracked_branch, &ftb_cb);
	 	else if (inherit_tracking(&tracking, orig_ref))
	 		goto cleanup;
	 
	@@ -272,7 +279,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
	 	if (tracking.matches > 1) {
	 		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
	 			advise(_(ambiguous_refspec_advice_pre), orig_ref);
	-			for_each_string_list_item(item, &tracking_remotes) {
	+			for_each_string_list_item(item, &ftb_cb.remotes) {
	 				advise("  %s", item->string);
	 			}
	 			advise(_(ambiguous_refspec_advice_post));

Also missing a string_list_clear() before/after this...

> @@ -248,9 +265,17 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			return;
>  		}
>  
> -	if (tracking.matches > 1)
> +	if (tracking.matches > 1) {
> +		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
> +			advise(_(ambiguous_refspec_advice_pre), orig_ref);
> +			for_each_string_list_item(item, &tracking_remotes) {
> +				advise("  %s", item->string);
> +			}

See:

     git show --first-parent 268e6b8d4d9

For how you can avoid incrementally constructing the message. I.e. we
could just add a strbuf to the callback struct, have the callback add to
it.

Then on second thought we get rid of the string_list entirely don't we?
Since we just need the \n-delimited list of remotes te inject into the
message.

> +			advise(_(ambiguous_refspec_advice_post));
> +		}
>  		die(_("not tracking: ambiguous information for ref %s"),
>  		    orig_ref);
> +	}
>  
>  	if (tracking.srcs->nr < 1)
>  		string_list_append(tracking.srcs, orig_ref);
>
> base-commit: 4c53a8c20f8984adb226293a3ffd7b88c3f4ac1a

