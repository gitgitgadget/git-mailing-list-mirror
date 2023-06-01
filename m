Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E64BC77B7A
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 23:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjFAXsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjFAXse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 19:48:34 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A1136
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 16:48:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a66a5d84so22241017b3.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2023 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685663312; x=1688255312;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wGYUFVr3R9WKRQdVNAmnx94YgEbl02oCwlpoUOcfLok=;
        b=BEgVOq4s3/YPMtJg5QRqykfQmBJ43ovrMypWfGYzOXaBAhzwo3dvT4RgLvFcUTSp4u
         S1b9egNw+5tt3hdFLY8jN4XWjSzIwqRuY/ef6Br1o9l1FR1acj4vaCKCdxtm6N5YtFem
         sUwr5K3h3l05JJfHM6Srh+8avpXSFzYX7yRYlJcJFCOTMeeCKfmMYcedPSmMeFSdlQaM
         8jse/x4z7/y1WWAeYBMsZGu1W42DNXV+pM9ZW1+3eOSrvYE9GrZHF7lghPpEXjedffUF
         6iquC7Qk4Nuk5aaRax8pfPygxkRX5XMBmlQ7mooU3rSnGEOossuMbr2IN1wucfdc6qBX
         Cfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685663312; x=1688255312;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGYUFVr3R9WKRQdVNAmnx94YgEbl02oCwlpoUOcfLok=;
        b=OYgAjgUTZNF8daiTafUXXYH9NmCwqw4OXQqvmWFK4LIZ85acrOBo8e4M1qxLeq6B/V
         6yai7B5ev36hIto3nPCDHiQxODywP3nPRljcxD2nwi44UTrOeBq6k2CYbSFqm3Zekw3l
         oZqjLhnt++EqNSBXjlIyScD83vS3aAoI9yfGMSC8PrhYrfAHETZMUb+m+FszndC4+dtP
         YWSHlHDN5JSIPB3iijbis0cfUaWYOYOYQrr45g21WYsZVER8epGdpfKVT/Lk820oJplJ
         716igzIbtNYgKDGaQMPdZLZmgrh8ZB9qSbD+zM7iIrWL5D19GerAshde5MimU0iEJ4eF
         QA0g==
X-Gm-Message-State: AC+VfDz2tCaMcN3RJmmUWJBEC71pFKd0k5kPn7GwXWpP9+LY8GKKNjUT
        oZRO0eGrw6WFIKQyheq2NCq7fc/J1+v0JnUToDdc
X-Google-Smtp-Source: ACHHUZ5Bkw2UPsfJzuiEXaYkQ2wae8EktQbHn6ddsh+eMeJWaHsEVRMGctLKO29laroIFO1M9Vokkffs8zBdnI2dWJ8Y
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:9bd:7d22:5bbe:5b1c])
 (user=jonathantanmy job=sendgmr) by 2002:a81:b64e:0:b0:565:ba21:8123 with
 SMTP id h14-20020a81b64e000000b00565ba218123mr6651645ywk.1.1685663312171;
 Thu, 01 Jun 2023 16:48:32 -0700 (PDT)
Date:   Thu,  1 Jun 2023 16:48:29 -0700
In-Reply-To: <504eb206b5a1ac12676752d68b2e2569dc6737ef.1685472134.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601234829.432150-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 11/14] config: pass kvi to die_bad_number()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> Outside of config.c, config callbacks now need to pass "kvi" to any of
> the git_config_<type>() functions that parse a config string into a
> number type. Included is a .cocci patch to make that refactor. In cases
> where "kvi" would never be used, pass NULL, e.g.:
> 
> - In config.c, when we are parsing a boolean instead of a number
> - In builtin/config.c, when calling normalize_value() before setting
>   config to something the user gave us.

In these cases, could we synthesize a kvi instead of using NULL? I
believe there are already code paths that use an UNKNOWN scope - these
seem similar to that.

Otherwise looks good - a straightforward, mostly mechanical, change.
 
