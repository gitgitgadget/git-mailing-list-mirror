Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F370C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 05:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiGYF5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiGYF5O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 01:57:14 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A62BE09
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 22:57:13 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x91so12544635ede.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 22:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+1anDGe6hU1/GSTRIzil+yD685OIKYqh/tbnwPTHrx8=;
        b=Kd8SbYLjBChly6hWVH35FSbhjXKkG7NNM9rhiF/UvzNvhnJgYxqaFppG44mJlfhT/+
         crlBdJ+huj7y0oV69Jlfq4aHDud7Xek9NP0VgzT1yC7FYxM/AK4s9pmrZl5FJmzu2lwf
         4tCRgbzo99V1LArM+k4My23nDpryiYKdtJuKWE+lJ2fEot9rh+srjSmRLvfScJJ+11Xe
         K4sWvHm+MF3OiimncYwh1beoCIDQVblVW5UsBHgx1zfkQUKKCClx2f3irixUiDySfyJs
         tJu9yo97CgTyh9kxr95T6UUwZCTwDpcjJ0HV0C66geFVLA5TJ90jU/Vqq8ke6/xE2ibI
         XLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+1anDGe6hU1/GSTRIzil+yD685OIKYqh/tbnwPTHrx8=;
        b=BiizixIqmF0+CjrKgE1s3UX8XLtgqq93LyKltZ2MyYFx3rupJBVpydTte9/+65jtZ9
         wpW+eoR79eUs33uUbbQQ3HEdoq88eyl0Ko7/HqcckmBpInFcADalC0Tv5lTpSp+7ENyi
         CRcmrCG0mtxW6DbnGMFP2DwvSTcrBTp/M0G71z8qw7bTsKf5IbVBZpWdtrmepeN50n/r
         ntpGQGbe7XUZsVdCwe5Nc88JHWHxpvvC3xh+snp+s8blO6N/k9VVb2fVf/bIgiPi+vV9
         Xw68N7uGGIuZ6ZYiUEtqcNiSD5znyJf55aJjJ6jv9j6CgJYD4ODRCUHeI2GDGRbOzfCU
         mR9w==
X-Gm-Message-State: AJIora93xwX5BBOUkmhoWOkFHcEpUtk1oS/0DA25qjhZR8YjIxfzyhK1
        wQyR2c4SmSGw80PGXSqOJqw=
X-Google-Smtp-Source: AGRyM1u2dWWgA2e2LoQgiKpO5/yUgzQ5655F3zRRKT82KavwM4DwGtrWoOElZavQ4JwbzZDCQsMEAw==
X-Received: by 2002:a05:6402:344:b0:43b:e42b:fdf with SMTP id r4-20020a056402034400b0043be42b0fdfmr7895751edw.416.1658728631601;
        Sun, 24 Jul 2022 22:57:11 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906768d00b0072f9e7ce354sm4447693ejm.139.2022.07.24.22.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 22:57:10 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFr5Z-005a7B-9r;
        Mon, 25 Jul 2022 07:57:09 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Julien Rouhaud <rjuju123@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] gitweb: improve title shortening heuristics
Date:   Mon, 25 Jul 2022 07:54:34 +0200
References: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
 <xmqqfsiq6ksb.fsf@gitster.g> <20220725020534.x33hso22ab2dwyo7@jrouhaud>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220725020534.x33hso22ab2dwyo7@jrouhaud>
Message-ID: <220725.86czdtrayy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 25 2022, Julien Rouhaud wrote:

> On Sun, Jul 24, 2022 at 06:30:44PM -0700, Junio C Hamano wrote:
>> Julien Rouhaud <rjuju123@gmail.com> writes:
>>
>> > Otherwise, would it be acceptable to disable the whole block (the "remove
>> > leading stuff of merges to make the interesting part visible") with some new
>> > configuration option?
>>
>> I personally find that "shortening" logic way too specific to the
>> kernel project hosted at kernel.org and would be inappropriate to
>> use it anywhere else.
>>
>> 	if (length($title) > 50) {
>> 		$title =~ s/^Automatic //;
>> 		$title =~ s/^merge (of|with) /Merge ... /i;
>> 		if (length($title) > 50) {
>> 			$title =~ s/(http|rsync):\/\///;
>> 		}
>> 		if (length($title) > 50) {
>> 			$title =~ s/(master|www|rsync)\.//;
>> 		}
>> 		if (length($title) > 50) {
>> 			$title =~ s/kernel.org:?//;
>> 		}
>> 		if (length($title) > 50) {
>> 			$title =~ s/\/pub\/scm//;
>> 		}
>> 	}
>> 	$co{'title_short'} = chop_str($title, 50, 5);
>
> That's probably true, although some parts (like the protocol) seemed general
> enough to me to be worth considering for general use case, and some of the
> really specific parts seems so specific that they shouldn't really matter if
> used outside kernel.org.
>>
>> Of course, http:// and rsync:// are way outdated (https://, ssh://
>> and git:// are probably reasonable).  Equally outdated is to merge
>> branches from master.kernel.org, www.kernel.org, or rsync.kernel.org
>> (many merges are recorded as pulling from git://git.kernel.org/ or
>> https://git.kernel.org/ these days).
>>
>> Even worse, I somehow thought that kernel.org no longer uses gitweb
>> but uses something else.  So I suspect that nobody sheds tears if we
>> remove the whole block unconditionally.  In fact, it would make the
>> world a better place.
>
> Well, I'm obviously totally fine with getting rid of it.  FWIW, even the
> protocol part wouldn't change anything for the instance hosted by postgres.
>
> I'm attaching an updated v2 patch that removes all that logic and just keeps
> the title_short chopped at 50 chars.

Please "inline" your patches, see "Sending your patches" in
Documentation/SubmittingPatches (I.e. send it with git-send-email, or
similar). I see this as:

> [2. text/plain; v2-0001-gitweb-Remove-title_short-shortening-heuristics.patch]...

In my MUA. But manually extracting it and quoting it:

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1835487ab2..e66eb3d9ba 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3560,23 +3560,6 @@ sub parse_commit_text {
>  		$title =~ s/^    //;
>  		if ($title ne "") {
>  			$co{'title'} = chop_str($title, 80, 5);
> -			# remove leading stuff of merges to make the interesting part visible
> -			if (length($title) > 50) {
> -				$title =~ s/^Automatic //;
> -				$title =~ s/^merge (of|with) /Merge ... /i;
> -				if (length($title) > 50) {
> -					$title =~ s/(http|rsync):\/\///;
> -				}
> -				if (length($title) > 50) {
> -					$title =~ s/(master|www|rsync)\.//;
> -				}
> -				if (length($title) > 50) {
> -					$title =~ s/kernel.org:?//;
> -				}
> -				if (length($title) > 50) {
> -					$title =~ s/\/pub\/scm//;
> -				}
> -			}
>  			$co{'title_short'} = chop_str($title, 50, 5);
>  			last;

This looks good to me, The one thing I'd add is that we're just running:

	 git rev-list --parents --header  --max-count=1 HEAD

And parsing that, but if we're truncating things perhaps we should just
run "git log" or "git show" with the "%<(<N>[,trunc|ltrunc|mtrunc])"
syntax or similar.

That's obviously a follow-up, but if anyone's interested in deleting
even more code here...
