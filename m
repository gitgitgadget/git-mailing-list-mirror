Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D293C433EF
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 13:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244577AbiC3N3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiC3N3d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 09:29:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCD27AD77
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:27:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p15so41502225ejc.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=M1soMvKLxQKcRdo3La0xUFWRtxxOZ1FVsk8gzWppa6o=;
        b=i9/nnVducNJoB+YyAaNpW/N6AV/4Y5bb9J+LlY02tDjny5gaxvAOdaorQpSLkkYtEG
         5qOUF1Li7Ys5QK219KQqtXovw3F77vuXJWeLQMHpNueLvgN4Ts9YvnIs2ctcgm2wnTAd
         HtXGfs4NyzrvgN3bVueGqC24+lmrJiLsq5bmd6RYSdGH1TsVeFKyPYsvDdeKWkJdmm49
         RHuMYd2UQaL9N4KeRuBRVH0bN7I+o/9ZffEUEbA04dxAl7wTO2d6OHeF6G6vFUmECkRR
         U1JM05ZrjqFgA/TwhxlmnigkOo+wZU3FCKeybdvYrbBjPiPdjLJ5fYvSoRCzkqWIFUg1
         +7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=M1soMvKLxQKcRdo3La0xUFWRtxxOZ1FVsk8gzWppa6o=;
        b=WynD54HNzUSWenRB3ByuuJZnXawXrmEjruFQR9bj6wHAqQ6krgiLILP+UF4whY9OU/
         mRfcEdl0eqUtnWrUyHh7/Wflok2Zw5aOoUKQTAADPx2QSbdffhFouWqAnd7z+m0uqPw3
         qHdj3KhawpIT1wOJov0dMG4GC88eo1LgQTMkSFOwm9n9wXx+LJw9S04xXZfQKpaFLqEk
         N71uSXy/8k8OIpiIWAjkGj+oNliJeT0F3hPMYsPi0VPTm3dgB5WlxfwleviUreAvDIsA
         mGrv9ntHYWdD6Y8VOV1vQQBE8YLGK7gnLpeWb72QfFew0tG5oK9Xc431YSdfrQS3pc+i
         yqAg==
X-Gm-Message-State: AOAM531Ljtf0cl9spFNG31GoYhb6hIzExWnu5jtaTb1bSSd7/Nq8HK/3
        4cR6TM+7RjywcBFpse92Kkw=
X-Google-Smtp-Source: ABdhPJxHPo96BhIIZlv9eIMQdq1bcj/KYrlDF+zkcB3/pPXz1BV/arbAAL5jW2uQEN4iIRGYa99v4g==
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id i3-20020a1709064fc300b006e066a5d59cmr39054783ejw.131.1648646866584;
        Wed, 30 Mar 2022 06:27:46 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nd31-20020a170907629f00b006dff863d41asm8439752ejc.156.2022.03.30.06.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:27:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZYMT-004HMf-Au;
        Wed, 30 Mar 2022 15:27:45 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v5] tracking branches: add advice to ambiguous refspec
 error
Date:   Wed, 30 Mar 2022 15:19:47 +0200
References: <pull.1183.v4.git.1648553209157.gitgitgadget@gmail.com>
 <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1183.v5.git.1648624810866.gitgitgadget@gmail.com>
Message-ID: <220330.864k3fpo32.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 30 2022, Tao Klerks via GitGitGadget wrote:

> From: Tao Klerks <tao@klerks.biz>

> +		case 2:
> +			// there are at least two remotes; backfill the first one

Nit: I think it's been Junio's preference not to introduce C99 comments,
despite other C99 features now being used (and I think it should work in
practice as far as portability goes, see
https://lore.kernel.org/git/87wnmwpwyf.fsf@evledraar.gmail.com/)

> @@ -219,6 +233,7 @@ static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
>  	return 0;
>  }
>  
> +

Stray whitespace?

>  /*
>   * Used internally to set the branch.<new_ref>.{remote,merge} config
>   * settings so that branch 'new_ref' tracks 'orig_ref'. Unlike
> @@ -232,12 +247,16 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  	struct tracking tracking;
>  	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	struct find_tracked_branch_cb ftb_cb = {
> +		.tracking = &tracking,
> +		.ambiguous_remotes = STRING_LIST_INIT_DUP,
> +	};
>  
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	tracking.srcs = &tracking_srcs;
>  	if (track != BRANCH_TRACK_INHERIT)
> -		for_each_remote(find_tracked_branch, &tracking);
> +		for_each_remote(find_tracked_branch, &ftb_cb);
>  	else if (inherit_tracking(&tracking, orig_ref))
>  		goto cleanup;
>  
> @@ -252,9 +271,38 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			goto cleanup;
>  		}
>  
> -	if (tracking.matches > 1)
> -		die(_("not tracking: ambiguous information for ref %s"),
> -		    orig_ref);
> +	if (tracking.matches > 1) {
> +		int status = die_message(_("not tracking: ambiguous information for ref %s"),
> +					    orig_ref);

This isn't per-se new, but I wonder if while we're at it we shold just
quote '%s' here, which we'd usually do. I.e. this message isn't new, but
referring again to "ref %s" (and not "ref '%s'") below is.

> +		if (advice_enabled(ADVICE_AMBIGUOUS_FETCH_REFSPEC)) {
> +			struct strbuf remotes_advice = STRBUF_INIT;
> +			struct string_list_item *item;
> +
> +			for_each_string_list_item(item, &ftb_cb.ambiguous_remotes) {

Nit: drop braces, not needed.

> +				/*
> +				 * TRANSLATORS: This is a line listing a remote with duplicate
> +				 * refspecs in the advice message below. For RTL languages you'll
> +				 * probably want to swap the "%s" and leading "  " space around.
> +				 */
> +				strbuf_addf(&remotes_advice, _("  %s\n"), item->string);
> +			}
> +

Per the TRANSLATORS comments in get_short_oid(), it's also good to have
one here in front of advice(). E.g.:

	/*
	 * TRANSLATORS: The second argument is a \n-delimited list of
	 * duplicate refspecs, composed above.
	*/

> +			advise(_("There are multiple remotes whose fetch refspecs map to the remote\n"
> +				 "tracking ref %s:\n"
> +				 "%s"
> +				 "\n"
> +				 "This is typically a configuration error.\n"
> +				 "\n"
> +				 "To support setting up tracking branches, ensure that\n"
> +				 "different remotes' fetch refspecs map into different\n"
> +				 "tracking namespaces."),
> +			       orig_ref,
> +			       remotes_advice.buf
> +			       );

Nit: The usual style for multi-line arguments is to "fill" lines until
you're at 79 characters, so these last three lines (including the ");")
can all go on the "tracking namespaces" line (until they're at 79, then
wrap)>

> +			strbuf_release(&remotes_advice);
> +		}
> +		exit(status);
> +	}

Other than the minor nits noted above this version looks good to me, and
I think addresses both the translation concerns I brought up, and the
"let's not do advice() work if we don't need it" concern by Junio et al.

>  	if (tracking.srcs->nr < 1)
>  		string_list_append(tracking.srcs, orig_ref);
> @@ -264,6 +312,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  
>  cleanup:
>  	string_list_clear(&tracking_srcs, 0);
> +	string_list_clear(&ftb_cb.ambiguous_remotes, 0);
>  }
>  
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>
> base-commit: abf474a5dd901f28013c52155411a48fd4c09922

