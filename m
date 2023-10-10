Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31119CD691F
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJJJ7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 05:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjJJJ7o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 05:59:44 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F138399
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 02:59:41 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32799639a2aso5334522f8f.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696931980; x=1697536780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FWbSgc0ZUlMzyn7LuoRa6qxJ33d/SNGyD8BHk23f6Y8=;
        b=nVkAwux0lfZ+1+D6jcS3oz1JvIssE44PGpPi+0TuOhrkcWe73vte5oHACya9K1qJR0
         Uuy3omD9qAIpqUdCGLOJnZbziidKQp5xpYKuAnaGNbgX8VKnNy15qA4/q61simS1fg8+
         1MNTqwMolldiS5L7qBbc2kQvb9pJ9C+1dxyN1OtWmoIITVaviBCDhMOIJu5Zq7gOBpFG
         H8zNx6uBulRWV6m758D9vxM9zPPLO4336YHHgDMaS48N2o1KyW65h4qBc/xYWwm0BL0y
         rX0NfQlES32Q62BA9LKukhnDrsFYnvkic3s0HP2h+Bo9eo/UbwdTcxpe+gbPBI7mANCy
         O0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696931980; x=1697536780;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWbSgc0ZUlMzyn7LuoRa6qxJ33d/SNGyD8BHk23f6Y8=;
        b=HVi3/tXwLKM5lCBko+kmrFD6FNMMGoS+yD7/b47uvMZqs/MslvP6DP+lAdfNj0S3ob
         TwIwRT59wAsE+9SxqJoFQN38f6e5OVpn4eZaDfo08HbjyBFN1Q7Vd+Q64rQUHB+bxOG7
         QFQoGDgMwXziU3qb7vSa5eCpLHSH9UBWhjx2FTBf3I0PBYtZ2uLPRXMt6ci0cXHzN6Ri
         YJBmBMhCqMEnuYJQMlqu7aQUsNDieACE9CE+JSp6Tw0B6iOwo7QUYtGY5auXG4VUZeBZ
         d7m6o9dJgFy252wYRdUkNWxi90z1MOo+rg/hqayOeM2PShr2YV0sopGgNSb65xNluqiJ
         3vcg==
X-Gm-Message-State: AOJu0YwYT17P+fDnLoQB++yDrc7TUxaZXHqpiXAtsQ1+1lPr7nanmtfe
        Gvjotdi/LbCh7/GopaNSh4s=
X-Google-Smtp-Source: AGHT+IE6QvzNSEQQu+fxLBwYMY1+L8f9tT2cshMirulLg6fJL7YRbFvYBxTU1B1AqmrZyjeCtvbyfQ==
X-Received: by 2002:adf:ec82:0:b0:322:db93:41ab with SMTP id z2-20020adfec82000000b00322db9341abmr15786726wrn.0.1696931980222;
        Tue, 10 Oct 2023 02:59:40 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d4802000000b0031fe0576460sm12205991wrq.11.2023.10.10.02.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 02:59:39 -0700 (PDT)
Message-ID: <066b3162-6a81-45d7-b164-17b74e6c92dc@gmail.com>
Date:   Tue, 10 Oct 2023 10:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/4] wrapper: reduce scope of remove_or_warn()
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230627195251.1973421-1-calvinwan@google.com>
 <cover.1696021277.git.jonathantanmy@google.com>
 <c9e7cd78576527571fd70b953e340b5bdd196221.1696021277.git.jonathantanmy@google.com>
In-Reply-To: <c9e7cd78576527571fd70b953e340b5bdd196221.1696021277.git.jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan

On 29/09/2023 22:20, Jonathan Tan wrote:
> From: Calvin Wan <calvinwan@google.com>
> 
> remove_or_warn() is only used by entry.c and apply.c, but it is
> currently declared and defined in wrapper.{h,c}, so it has a scope much
> greater than it needs. This needlessly large scope also causes wrapper.c
> to need to include object.h, when this file is largely unconcerned with
> Git objects.
> 
> Move remove_or_warn() to entry.{h,c}. The file apply.c still has access
> to it, since it already includes entry.h for another reason.

This looks good. On a related note wrapper.c includes repository.h but 
does use anything declared in that header.

Best Wishes

Phillip
