Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB8ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiIWILA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiIWIK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 04:10:59 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E112AEEA
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:10:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 29so16979413edv.2
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Bvu24cnCDO2bPGUYGuLLNoVQbxESO/IKuhmwQO/oWTo=;
        b=pXxWrL+Fewfh4MRxs9KhbVrIyvEr4gQZeMhXsDnnVLJg9pZsCJLo8e7rGNxWjOzjvL
         MglMOsi6/O4phVH+lI47BzuwMBgRneluxHRg8rdzc+Lfnprm3/WWlf6puRkA5iOmACER
         sPB9aSbjyS13TR/qQ56qihN4RuXc1+ZynsLFwr0QPKjCQPj5CSE5HfE/mg6CMkNk4l0e
         OCZbeGdtdHE0tFN/xBAwCQrnP++ofdJwnUlhLGoOWln4AEg+cglduPvnqeVoD+h2/wII
         ec74hP8cR4Cx0D6WZPMoovwMHA6NQdCJ+eVQiGcq0irDhtpGrkfXnbxxWVMxhxQeunpE
         13lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Bvu24cnCDO2bPGUYGuLLNoVQbxESO/IKuhmwQO/oWTo=;
        b=ZoFZ/abae5078mS8lpBPTqWxo47b14kUK5ViEaHlHdatkYlxDNlBhxescruziLnusC
         Qm81DyIhxeTWk0H1i1Mu9eUi5UWwqZV7v6rUXbGXV3oPgcrZ2t5A9pVffeZjDhwa4o0f
         ekk6TFdTyAfP24GGVjCNoFFmtb93dgAZDXyzpLKSHp6AXmHGbYKRbGYw4APvGhXt8DbN
         ACPhdDi+ROnr2uRz0nT6aknzn3yN9ogPqnVwz/9hRyxGt1lhYGaKTiWeaaqTOrd7lrG4
         BQHheDLvCtctO+Xl13SAzHpvyfcuIb/l8nNpO+zcF0WxbAnPjsnTKLt5mIWhBGBVrpSi
         iGzQ==
X-Gm-Message-State: ACrzQf1xHktmzmYERnRR/APGaRJ45lAPpElBqweS9mdn0yWZAZW0V021
        +VNMeVXDrL+7IvHNFOLX4XSBpqur5Xs=
X-Google-Smtp-Source: AMsMyM6IR58+SHU5S9XmJUZMLBcOFeTvICfSZ8tKpWYdE0W6TPrAAS9Oq8MTOutkkfk7T38kFBAVAg==
X-Received: by 2002:a05:6402:3552:b0:451:2037:639e with SMTP id f18-20020a056402355200b004512037639emr7354456edd.136.1663920656395;
        Fri, 23 Sep 2022 01:10:56 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i23-20020a50d757000000b004479cec6496sm5176504edj.75.2022.09.23.01.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 01:10:55 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1obdlv-003G1q-0T;
        Fri, 23 Sep 2022 10:10:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
Date:   Fri, 23 Sep 2022 10:06:56 +0200
References: <20220922232947.631309-1-calvinwan@google.com>
 <20220922232947.631309-5-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220922232947.631309-5-calvinwan@google.com>
Message-ID: <220923.86o7v64ik0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 22 2022, Calvin Wan wrote:

> +status.parallelSubmodules::
> +	When linkgit:git-status[1] is run in a superproject with
> +	submodules, a status subprocess is spawned for every submodule.
> +	This option specifies the number of submodule status subprocesses
> +	to run in parallel. If unset, it defaults to 1.

Why do we default to 1, instead of e.g. grep.threads defaulting to the
"cores available"?

> +struct submodule_status_util {
> +	int changed, ignore_untracked;

nit: we tend not to group by type, which also makes adding API docs
later easier.

Except that we tend to do that if all the things are really boolean flags, which these are, so maybe:

	unsigned int changed:1,
        	     ignore_untracked:1;

?
