Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A99C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 11:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiLSLRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 06:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiLSLRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 06:17:11 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489E1127
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:17:10 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so20617891ejm.8
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkK3QiAThcvhqVZ+gjZCA62S38jS/rJ2Y0siC+sel8g=;
        b=IwpWLnTyBEOkmeW7ESr618ChstjHfR/XQ5Jw8dW+DwnYWVzkYsag5MQAxuFYxdZh1r
         mUB/fJk6lPut+8Oh1v5rbuvwgvC+AmeyVLgOn+c+ltKhtTXbbmaxywUfKzvGs6wonBcU
         XBHcgUfFNQxqb27NHPRp5kuCii7tQ3oKLO3kM/6d+yUZ7xGSGvXuOwu1VMskmBy+JsS0
         l+FjOOfeP3u4UveKMIGWDTgt4O7vjyCQqiSIwZ08/5lyAYeZBTbpd2eYw+IJe3fAEdzu
         wyPnPSWpGshssu2BQItGf7jy+Nsm5RkaeWPIrx1zxGkqSt4MFFX/n4H8Bpk6IC5gdcsP
         CE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkK3QiAThcvhqVZ+gjZCA62S38jS/rJ2Y0siC+sel8g=;
        b=g2/IkdM+Y0q5LoD0YHBy+QN7d4ZL6vJmPeswee5ldMXrkXO2hEok6JrxCu6iIDgpsV
         eL+1Ex7zQYTu3mWQxAG2bUT/2iraxiWxDJwNrk+YAedjX9qQ7ZvLboEX1iHsRAIeU77R
         wmH+qA3Mzrx9NVSDdhnPFoSm2GO5jFOELN2c3C9kdzywmbMEZFr6E34ZjldzrusYNqmg
         xhobkGsTaxsuD2D0ADWsNGjyotlD3whLT0m66Dso2J3VmQvgFl7E9VjbJj6TtZI3Br5a
         FIdsbS3NR5ZuAPzVdOWpouJp9TV/ULRwRFgNl1xaiFYZkq2ktzC79epdq6OVUiP6/WKU
         GaRA==
X-Gm-Message-State: AFqh2kq6LVPPcn3RMksCOL5xNtURbqo9vU3Do+pCEitcnpbCBKNcnlz5
        K8Sjpa+zPxvZSyyP64zhJxo=
X-Google-Smtp-Source: AMrXdXuWJ3cBacOGp2exha2jQx1VsJVK42LJqrkxAhGOkD7reRJk+0wTcdIRVOzuboIaLPxS9ohlmg==
X-Received: by 2002:a17:907:d68e:b0:7c1:4f7c:947f with SMTP id wf14-20020a170907d68e00b007c14f7c947fmr95821ejc.72.1671448629146;
        Mon, 19 Dec 2022 03:17:09 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b007a9c3831409sm4265952ejj.137.2022.12.19.03.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 03:17:08 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7E8q-006YXU-0a;
        Mon, 19 Dec 2022 12:17:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/3] bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
Date:   Mon, 19 Dec 2022 12:09:14 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <aafee168fbae2a1887f53febc4abd15522b12bc2.1670866407.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <aafee168fbae2a1887f53febc4abd15522b12bc2.1670866407.git.gitgitgadget@gmail.com>
Message-ID: <221219.86len3zlqj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The GIT_TEST_BUNDLE_URI environment variable is used in the t573* suite
> of tests that consume the bundle URIs advertised by the Git server. This
> variable is equivalent to setting transfer.bundleURI=true, so we can do
> that in these tests instead.

I think this is probably OK. I can't remember why I added both the env
variable and the setting in what became 0ef961dda05 (bundle-uri client:
add boolean transfer.bundleURI setting, 2022-12-05).

But I think this commit message really doesn't explain why it's OK to
remove it. In general we do have GIT_TEST_* settings that duplicate
config, e.g. GIT_TEST_PROTOCOL_VERSION.

We do so because we'd like the environment variable to override the
setting, or the other way around (I think depending on the GIT_TEST_*
variable it's either-or, it's a mess).

But in this case we'd never like to combine the two?

> The environment variable has a name that implies it would be useful
> outside of these tests. It is not useful to set across all tests since
> it would do very little without some setup on the server side. Remove
> it.

This part I really don't get, why does its name imply that? We use
GIT_TEST_* variables for this sort of thing, maybe it's not needed here,
but what should it have been named? GIT_TEST_T57XX_* or something?

I named it like that for consistency with existing test variables, ...
