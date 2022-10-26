Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B96FA3744
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiJZTJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbiJZTIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:08:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07C40026
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:06:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w189so14915039pfw.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayCVtwpoBl0EY94YMead/iWhL48grQRI37oJw1Dzhh8=;
        b=ZO4n6Sh4dn4i+ea2fAFhqp8hVs7Mh9lPSHhXSGWqxI8Z2HRoMUDA6URmw303Pwxy2M
         OeKMZq5tDV/2Zb/RDJMTlWfWv4uDtYbrSFWF5xSSy4egVRnJMMWG3CdbRexL/H+QOL9E
         WPIxpN3UyzRs+XqVoyCkgrYOkmm4Y/vQk1cz7wbt+QwMAwkkn3h7s4BiFaCAoHxF+/A+
         aVnjRLdAvSMitHfbf3+b1ZENDWp51KvykcFSJGflZFHpnvLpoGgzyCtMTCoTXcH+WP6G
         Ev9ztlaC/cpworIgMjul17jSjuRS27YB/cVKmCb5QoQ/e/eiOiKSF5t6cqV4iY0QtZYr
         sRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ayCVtwpoBl0EY94YMead/iWhL48grQRI37oJw1Dzhh8=;
        b=Sq7TTlhlCB9iZg/fM/ptSt7sKleDz+6lYG8D9LXb5NWxJGgsEag8feRBvA+7J/ncjn
         m1Nbq58NPFiVy7QnRBT8pnZ7X/Ugh0RAHyvTJu6TizAvAbhHJtF+jh6m7LDqVJ24FOjz
         5L8RPRuAeRRhkSPgsxp1W+r66bGdOm7y2bDwX26Gx6D/uDoJh1bKRfztRG1Bace9rY5K
         N760aZk1qBdIzU/El/3XEFBqHvh+8NvdvKm87QZ0/WAd06rGHubSgs9nEadk1/ke2Hrd
         VWnzv6bC60aty20uRa3l4nEsAXoZZtUpvmSD93hPJ559tYy2BICHSvZVv3wsOdtoYvln
         vhdw==
X-Gm-Message-State: ACrzQf0ZEyrncy2nDV5tf5iQF8of2Am2GozO+ShnoFcnSDtYl3k2pmYa
        MXjVbWCEYYP3GtGkZQ+8Zmg=
X-Google-Smtp-Source: AMsMyM5XxZTv2igcTiluU7hzEOGR/MdPwaE/lMPbpsvpLs7xh6xwL8Af3Nf87AUqRvYhYwhcoeMYqg==
X-Received: by 2002:aa7:8f35:0:b0:56b:c2dd:a9ae with SMTP id y21-20020aa78f35000000b0056bc2dda9aemr18647476pfr.0.1666811174984;
        Wed, 26 Oct 2022 12:06:14 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id cp2-20020a170902e78200b00186dcc37e17sm1639581plb.210.2022.10.26.12.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:06:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v5 09/12] bundle-uri: fetch a list of bundles
References: <pull.1333.v4.git.1665417859.gitgitgadget@gmail.com>
        <pull.1333.v5.git.1665579160.gitgitgadget@gmail.com>
        <51e9b8474fb040c4277b96d4b13a8da58bdb3682.1665579160.git.gitgitgadget@gmail.com>
Date:   Wed, 26 Oct 2022 12:06:13 -0700
In-Reply-To: <51e9b8474fb040c4277b96d4b13a8da58bdb3682.1665579160.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Oct 2022
        12:52:36 +0000")
Message-ID: <xmqqilk6h0be.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static int fetch_bundle_list_in_config_format(struct repository *r,
> +					      struct bundle_list *global_list,
> +					      struct remote_bundle_info *bundle,
> +					      int depth)
> +{
> +	int result;
> +	struct bundle_list list_from_bundle;
> +
> +	init_bundle_list(&list_from_bundle);
> +
> +	if ((result = bundle_uri_parse_config_format(bundle->uri,
> +						     bundle->file,
> +						     &list_from_bundle)))
> +		goto cleanup;

It makes us a bit nervous to apply the config parser directly on
data controlled by a third-party.  bundle_uri_parse_config_format()
hopefully is careful enough to avoid including other local files and
call generic callbacks to affect the actual configuration used by
the process.

It seems bundle_list_update() discards everything it does not (care
to) understand, and safe to call from config_to_bundle_list(), which
in turn is called from here.

OK.
