Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7B2C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiHBXIw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiHBXIf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 19:08:35 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F09156BAC
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 16:08:25 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id f13-20020a056a001acd00b0052ab9ae76fbso5633249pfv.20
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc;
        bh=RIxaOwykIIgjyI8v6vAvnPI1CEe4NFLVdqeGcd9AEu8=;
        b=bb3oir/ksM9spkn2tgpttfvHMes2yVt5law3u58/A6ErKCLru8RwnrCi25rlQm0Nmb
         ug5ZFm2TR8TeSlvtbxr7UwgkYnamZ2DXAs+QUkAzIXcFEByeVMPjvb2fiRnUR6JWYTZr
         a8zWSfMJq4n/OcPKvLfOV+0EiUf7yzz5p7YjhWlVDcj7TO8ePtgHLpEzPdDbmfK0ngyK
         vpL5QKC3d8+MrGiHpsO6lApQr1ZjtrtM3XvrFtpzdOhe64fZxc8STb2U7kUB8Ytvo+sz
         PiLdrabWLOR9qmimGMxqc0u5CPVPPiyDgC5aMLyPhYhSvqnobNGInCzryAB5lXCAbg4y
         lYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc;
        bh=RIxaOwykIIgjyI8v6vAvnPI1CEe4NFLVdqeGcd9AEu8=;
        b=CDjwWhs+qc5C1eZcpXCmymm8pl6JlF3Mk5Ue45UdFEbLUePWAcGdAN4iYH6TuvrcV1
         EYjxeLSaYN48YUyj/leFp72aSXtJpPQtMrl0f0d16+/eLVbbEOsOO1kqVYPTgMr/dpGX
         mY0UxC36V/oXWIEikf5ayJbKGwDVSZHKaVfYHvL8wvdkBXiLEe8flmOWqemlfHghXN+i
         7qKPipVA48IeIyfAW9jPScPQTyWx21SYJ1YyZZhpqZ5MjqmdNwLRPouI/gVhsmm+4d+L
         hIa6mI2CliW2rMHtG4usLayPvDylHuY5OzmwzyCINvpqAjClI3WuljjsS3WHnfho6GrI
         RvKA==
X-Gm-Message-State: ACgBeo3u6WfE4HvOSUAZla/diINp9D1l+ID/tuda5xQBTNaTXRDh6oSn
        4xV6IIhYEukkP/QPGPhohAzkvXfrtYSyyw==
X-Google-Smtp-Source: AA6agR6hLWBiaW7ZGMMKpjCk4wREbnj0zDJbOLYLSHRweJJpKiRYYlaZ5B5nIlXGIHg+gAs3afpNg9aUMUOxnQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:bd08:b0:16e:e00c:dd48 with SMTP
 id p8-20020a170902bd0800b0016ee00cdd48mr14459152pls.93.1659481702994; Tue, 02
 Aug 2022 16:08:22 -0700 (PDT)
Date:   Tue, 02 Aug 2022 16:08:21 -0700
In-Reply-To: <patch-v2-21.28-bce1a014a2f-20220802T154036Z-avarab@gmail.com>
Message-Id: <kl6lo7x2tfa2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
 <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com> <patch-v2-21.28-bce1a014a2f-20220802T154036Z-avarab@gmail.com>
Subject: Re: [PATCH v2 21/28] submodule--helper: don't call
 submodule_strategy_to_string() in BUG()
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Don't call submodule_strategy_to_string() in a BUG() message. These
> calls added in c51f8f94e5b (submodule--helper: run update procedures
> from C, 2021-08-24) don't need the extra information
> submodule_strategy_to_string() gives us, as we'll never reach the
> SM_UPDATE_COMMAND case here.
>
> That case is the only one where we'd get any information beyond the
> straightforward number-to-string mapping.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/submodule--helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 955deb375ee..b49528e1ba9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2155,8 +2155,8 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  		must_die_on_failure =3D 1;
>  		break;
>  	default:
> -		BUG("unexpected update strategy type: %s",
> -		    submodule_strategy_to_string(&ud->update_strategy));
> +		BUG("unexpected update strategy type: %d",
> +		    ud->update_strategy.type);
>  	}

At first I worried that we would be losing readability by printing the
raw int value instead of a string, but then I remembered that we
probably wouldn't print anything sensible for an unknown value anyway :x

What makes this change obviously good is that we're switching on
ud->update_strategy.type, so it makes the most sense to print that value
(instead of ud->update_strategy). Unfortunately we can't see that from
the context lines though.

>  	strvec_push(&cp.args, oid);
> =20
> @@ -2181,8 +2181,8 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  			    ud->update_strategy.command, oid, ud->displaypath);
>  			break;
>  		default:
> -			BUG("unexpected update strategy type: %s",
> -			    submodule_strategy_to_string(&ud->update_strategy));
> +			BUG("unexpected update strategy type: %d",
> +			    ud->update_strategy.type);
>  		}
>  		if (must_die_on_failure)
>  			exit(128);
> @@ -2212,8 +2212,8 @@ static int run_update_command(struct update_data *u=
d, int subforce)
>  		       ud->displaypath, ud->update_strategy.command, oid);
>  		break;
>  	default:
> -		BUG("unexpected update strategy type: %s",
> -		    submodule_strategy_to_string(&ud->update_strategy));
> +		BUG("unexpected update strategy type: %d",
> +		    ud->update_strategy.type);
>  	}
> =20
>  	return 0;
> --=20
> 2.37.1.1233.ge8b09efaedc
