Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298E7C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhLPV2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbhLPV2G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:28:06 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AAC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:28:05 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id p8-20020a17090a748800b001a6cceee8afso224649pjk.4
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=suOhX7M6S8YAJmBbqHdXQKVz0xiSAxWGYxeNvJF27pM=;
        b=kpJpk8QRSfYDglaoNvTGy1SPMiV2sNimyvbsBz/JD5MIiT4se7CFLP0f9FpLGsETJ6
         PEEulOiRWi4Ek5zgd5rpK+CEtIg6p6jw2h5sVab+Dzrkp9ZM2P2qKr2G1lusPPZqYi1A
         XkmnhDqjf8cpQCroFrIlCt37djDvW43RVMIn6nECH2IAvfE+pB0u8QryN2qWcQds2CsN
         qn57zH2UzKopS0tbwHY6Cnmh5ueGSdqfv9EdzoyhizXjzTyQ2VxAUeb2plVaeR/DQbUS
         a83qtZ15urhA1Hpqr2DtX2OVta41ZdCzW/FjSoCJJB5b5OpNywUxhQFbNQntSzNnh/BD
         OOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=suOhX7M6S8YAJmBbqHdXQKVz0xiSAxWGYxeNvJF27pM=;
        b=tYObUgEgOGhPS/1eeboUgo6FQiQW+F+nhbWKG7cKvMraznVzyXOXCinpLBQTlYUdVI
         6Hh52NYMoXwx12xFsJ7V5jboqsuy11uh2I0UVP3wB15kDo4EQMJN199y/WVa3YmaEG3S
         iZedpW1ep0kZ0suHj9MIvxZa5MTOusv6BBYA0vfrLHqmLu4AK65dkELEO31URw4Zg6dq
         Znvz8K6gl3NsnFnJy87bG4gwaDzi/OJSMfuBVpdwCaDG8ou0R+ChIQQlhp2zx1Ye3L2p
         1KXtLfo+6ZAbZreMnNhgT6DzTHeJF2YdIWIccRazCRljMqw1JqVoiMxq96cGEdu8IKAn
         8j7w==
X-Gm-Message-State: AOAM532CtCqg8dbaCGZynVqXAbMU6KeOwTysC7Yw7nNGkqUPLy1ATL/+
        zjQeMlngk2WMGaVDHAuRQPQHIZpBGcWgDA==
X-Google-Smtp-Source: ABdhPJw6fgHAERTjglp4lt0MX20d61WX3R7N3YTI423gFo6kTBQSe9/c7ZXolxHT3fEf5n1JkN/Yu5SIubODDw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7883:b0:144:ccb8:674b with SMTP
 id q3-20020a170902788300b00144ccb8674bmr18133002pll.63.1639690085380; Thu, 16
 Dec 2021 13:28:05 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:27:56 -0800
In-Reply-To: <57e57e6e6a0735341a86f7b5dc52d477d8789578.1639524556.git.steadmon@google.com>
Message-Id: <kl6llf0k8ckj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1639524556.git.steadmon@google.com> <57e57e6e6a0735341a86f7b5dc52d477d8789578.1639524556.git.steadmon@google.com>
Subject: Re: [PATCH v6 2/3] branch: add flags and config to inherit tracking
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> @@ -192,11 +220,15 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  			   enum branch_track track, int quiet)
>  {
>  	struct tracking tracking;
> +	struct string_list tracking_srcs = STRING_LIST_INIT_DUP;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
>  
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
> -	if (for_each_remote(find_tracked_branch, &tracking))
> +	tracking.srcs = &tracking_srcs;
> +	if (track != BRANCH_TRACK_INHERIT)
> +		for_each_remote(find_tracked_branch, &tracking);
> +	else if (inherit_tracking(&tracking, orig_ref))
>  		return;
>  
>  	if (!tracking.matches)
> @@ -204,6 +236,7 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		case BRANCH_TRACK_ALWAYS:
>  		case BRANCH_TRACK_EXPLICIT:
>  		case BRANCH_TRACK_OVERRIDE:
> +		case BRANCH_TRACK_INHERIT:
>  			break;
>  		default:
>  			return;
> @@ -213,11 +246,13 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
>  		die(_("Not tracking: ambiguous information for ref %s"),
>  		    orig_ref);
>  
> -	if (install_branch_config(config_flags, new_ref, tracking.remote,
> -			      tracking.src ? tracking.src : orig_ref) < 0)
> +	if (tracking.srcs->nr < 1 && track != BRANCH_TRACK_INHERIT)
> +		string_list_append(tracking.srcs, orig_ref);

So, in the BRANCH_TRACK_{ALWAYS,EXPLICIT,OVERRIDE} cases, we append
orig_ref because we expect orig_ref to be a local ref that the caller
wants to track. This is not the case with BRANCH_TRACK_INHERIT, where we
want to inherit the configuration and we no longer care about orig_ref.

This is correct, though it's more unobvious than what I originally
envisioned when I commented on [1]. As a small nit, it might benefit
from a clarifying comment, but this is fine as it is :)

> diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
> index 4453741b96..49c7def21c 100755
> --- a/t/t2027-checkout-track.sh
> +++ b/t/t2027-checkout-track.sh
> @@ -24,4 +24,27 @@ test_expect_success 'checkout --track -b rejects an extra path argument' '
>  	test_i18ngrep "cannot be used with updating paths" err
>  '
>  
> +test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
> +	# Set up tracking config on main
> +	test_config branch.main.remote origin &&
> +	test_config branch.main.merge refs/heads/main &&
> +	test_config branch.autoSetupMerge inherit &&
> +	# With --track=inherit, we copy the tracking config from main
> +	git checkout --track=inherit -b b1 main &&
> +	test_cmp_config origin branch.b1.remote &&
> +	test_cmp_config refs/heads/main branch.b1.merge &&
> +	# With branch.autoSetupMerge=inherit, we do the same
> +	git checkout -b b2 main &&
> +	test_cmp_config origin branch.b2.remote &&
> +	test_cmp_config refs/heads/main branch.b2.merge &&
> +	# But --track overrides this
> +	git checkout --track -b b3 main &&
> +	test_cmp_config . branch.b3.remote &&
> +	test_cmp_config refs/heads/main branch.b3.merge &&
> +	# And --track=direct does as well
> +	git checkout --track=direct -b b4 main &&
> +	test_cmp_config . branch.b4.remote &&
> +	test_cmp_config refs/heads/main branch.b4.merge

Nit: in both cases, the expected result is that branch.b*.merge is
"refs/heads/main". so the difference between --track=direct and
--track=inherit would be more obvious if main tracked something other
than origin/main.

As an side, the comments in the tests make it really readable :)

Overall this patch looks good.

[1] https://lore.kernel.org/git/kl6lfsr3c3j7.fsf@chooglen-macbookpro.roam.corp.google.com
