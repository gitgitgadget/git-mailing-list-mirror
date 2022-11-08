Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797CCC433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 01:27:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiKHB1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 20:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHB1d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:33 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA36726AFB
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 17:27:32 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 64so12095851pgc.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 17:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWJkw1UX2Zm+sgK4OIc/Ap4OX/+W7WQXlLUB6BMcGWs=;
        b=XUqGzjNjSNQx9vZeSezvJANiMexAvsoJsyVcuANLyL7ihhjj0RGq3usMytwsmqvhHG
         3uQyXcQrRCs1ynvcOx0qJXhPPC0Ing1uDWBbgqRykbn+8Wa5qU2NEZFNnO+0vUOOD16n
         x42xSc+evcTxOsYb/BeBtRzzDND1/ZziTbVB+Ky+wNgvZk3YRGC7paAGnCVDuvcZo6qK
         sBJWyrkPHxDxdEJwfn6/1euNsEIFSLnYkqFSd56Fn3eA8Sqrms3tCWx+bMLfuf+ZGhCN
         GQO0uS6QicWW6GPFyyiowBzx2K6BvpiX+K9hY7cltZ9kfFnWcf9oTweu96pmNDYQQH86
         dOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWJkw1UX2Zm+sgK4OIc/Ap4OX/+W7WQXlLUB6BMcGWs=;
        b=5nqNyHXOcMavylia4wTcGyNpJyB0DTvY8TS2D6pLFrgrVMOquxeBJ8r1gu2DQ2EX3m
         +tXgvBKh2znA9nqJLFhQ2HdBOOMdI9Zt/gO51c3rCdxCcs1kJXq9Khm5eYOUnHgzkGKT
         /AMME6AD5KUOWMySPV6NXljIANNQkMPkN0PBQ/NXjk7gqTSW7v6fUY7KTsIakciqWMip
         Ug92TNyAe+d2d9eGNumbLPD9M6zsKddkYl8VSU85yOm/uvvngSEnvAKIqp1I5bEdD3my
         7WewtiCrlaJTjYzqD4Szxla6I+1wYyjz39gkpsg0ajRTzScK6pwNAmZIjntlv15oWRX9
         lL6Q==
X-Gm-Message-State: ACrzQf0S01op2ViNzlYNDeMxH2K8McUHmHJhIIWOTadQ02oDo6G+Bae2
        qyMmpYysp775NcL6AUZudhMBE8nVpF8=
X-Google-Smtp-Source: AMsMyM4ZpkVmN6lZBrR6ep74rQnKA7159FrgMy74EH1OEcdaf7IxBqRJy7yEW6fnNTlc0mRCkr9Oug==
X-Received: by 2002:a63:e511:0:b0:46f:98cf:13d3 with SMTP id r17-20020a63e511000000b0046f98cf13d3mr41802728pgh.363.1667870852555;
        Mon, 07 Nov 2022 17:27:32 -0800 (PST)
Received: from localhost ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id b143-20020a621b95000000b0056bfebfa6e4sm5112023pfb.190.2022.11.07.17.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:27:32 -0800 (PST)
Date:   Tue, 8 Nov 2022 08:27:29 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 11/13] bisect--helper: remove subcommand state
Message-ID: <Y2mwgeXQh21e4wFf@danh.dev>
References: <cover.1667667058.git.congdanhqx@gmail.com>
 <cover.1667667460.git.congdanhqx@gmail.com>
 <8037667da0f3d9f91c8f2aa477e2e95fb7f0c24b.1667667460.git.congdanhqx@gmail.com>
 <221107.86fseutp3v.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86fseutp3v.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-07 22:45:50+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Sun, Nov 06 2022, Đoàn Trần Công Danh wrote:
> 
> > In previous change, we've made 'state' optional, and replaced all of its
> > usage.
> >
> > Let's remove it, now.
> 
> Let's remove it then? I.e. let's squash this into 10/13. No reason not
> to...

I was following the existing (I think) practice of removing
a subcommand in a separated commit. Sure, I can meld it into 10/13

-- 
Danh
