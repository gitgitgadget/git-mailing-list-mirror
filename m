Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FFBC71148
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242032AbjALUFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 15:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjALT6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 14:58:25 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080CA1CD
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:58:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n12so20230878pjp.1
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mX6HbSMn29Hq4j0o+dBZ0SbTL0OqDSlhWYWPEzowYt0=;
        b=V27ne3/Zn7Z7kNgUyoW3L0aJmfnHO8fKbFHQntnm6L3SeSZwabavyGWB3EmrYEmGx3
         4ozrjhsuJXahS/B6dshWoDKxnJi2HdgXKb2KBzIjW+8NNOLPZcIPeX42XGhJ03joxO0J
         rodNiOKVSIs3hCSfYC159X5Joe+rAwMSBLApWxsTY+nMexUfbsHI+lTqQpCPBuewYlLG
         InbS3xK+RZHrBSF49I5Ss4llEIdZ8VGMDJT5w/3UOXSM/QMxohjNf8owlv7LljVnS0nK
         jn4qVoZtcnYc5onyT+czIjWiyxdHzOdWz36QG51MwgS+50Q/lSYCT7L2EyA9drFepwyR
         OQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX6HbSMn29Hq4j0o+dBZ0SbTL0OqDSlhWYWPEzowYt0=;
        b=7RZWzoWtkqaDeiohv+ITOCDg+QBkukWL+k6OG3awsgBPMg5Bj5T71Qo4uRCLDixt7W
         i1vbSGKWkg8Zi9Heg+K8vrrnQffnpOWOzaBma24PHw0InOkmI+eqEqQzIFWNpO76mS8z
         BYurkafpI+/jB+ZHnUxPJGY75M53T7e6qekE7oy/cJ1ZnulnD7QaMb3kw9U00rmKPVyQ
         jmBoF5lvGH68fy4zTAIwC/aouYEKB9xdNC5T2IE3daHgBa2Xzokwp2k8LrbEvJUEK6bQ
         Gz2YXEP+w0kwh17q5ITPTsGnMTahBIDx/4MzNzAP8And/+WdqQdwGbPErYot87w2Tol8
         aHJg==
X-Gm-Message-State: AFqh2kp3Kg2TNDCUiBd/w997VrLoW5rMzfaC4yr9d00gQvmvjFfskFR3
        x9U9D1RJnsHSYc3Lk+uhxKkm
X-Google-Smtp-Source: AMrXdXs3IDiNtPYYD2Wgz4oS2ot8buDLx1LhIRYr95Mf/wEVUFo3oHz84L80eC+kvFUGqekBdtXXkA==
X-Received: by 2002:a05:6a20:d006:b0:af:c491:c7d2 with SMTP id hu6-20020a056a20d00600b000afc491c7d2mr73292954pzb.29.1673553479511;
        Thu, 12 Jan 2023 11:57:59 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id q145-20020a632a97000000b004a4f24fbce9sm10379456pgq.5.2023.01.12.11.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:57:59 -0800 (PST)
Message-ID: <b5c0ba73-c1a7-293e-4594-b8ee291152de@github.com>
Date:   Thu, 12 Jan 2023 11:57:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 04/10] test-http-server: add stub HTTP server test
 helper
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <706fb3781bd383380a7b1fd30495eb2da970b5ec.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <706fb3781bd383380a7b1fd30495eb2da970b5ec.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Introduce a mini HTTP server helper that in the future will be enhanced
> to provide a frontend for the git-http-backend, with support for
> arbitrary authentication schemes.
> 
> Right now, test-http-server is a pared-down copy of the git-daemon that
> always returns a 501 Not Implemented response to all callers.

Between your earlier response [1] and this iteration of the patch, all of
the comments from my previous review [2] have been addressed. The changes to
drop the dependency on cURL also look correct to me. Thanks!

[1] https://lore.kernel.org/git/AS2PR03MB98150C33F9704D2CA10A2EF9C0FC9@AS2PR03MB9815.eurprd03.prod.outlook.com/
[2] https://lore.kernel.org/git/752da6b2-9c75-0f68-e507-cca02bf918ca@github.com/

> 
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  Makefile                            |   1 +
>  contrib/buildsystems/CMakeLists.txt |  11 +-
>  t/helper/.gitignore                 |   1 +
>  t/helper/test-http-server.c         | 385 ++++++++++++++++++++++++++++
>  4 files changed, 396 insertions(+), 2 deletions(-)
>  create mode 100644 t/helper/test-http-server.c

