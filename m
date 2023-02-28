Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A9C64EC4
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 23:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjB1Xk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Feb 2023 18:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjB1Xkz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2023 18:40:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D75E36443
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:40:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q189so6697058pga.9
        for <git@vger.kernel.org>; Tue, 28 Feb 2023 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eedUPYZNuu15PVEa8yEoZU2uJmbmZVCIqta2cOfzMIY=;
        b=PeRCHnJqywQ+3Yu/uL/wvOAUmeky1iN+s1FEIN+Rh4KFfYCSHew5tLJSJNOPzNAZgF
         8ZSyxjCKBZMqyO5fq86mdNEmQyBlq/ZvR8tg1Z+dE7UWTulGw3orpeW9tvTGucfjCXbl
         7EjfhVuCsAC8PZLLM6QOCnXpB2xEAVDjZ2KwUDoYiHKBQViixII/3T5NZ2JqUg+Y+EVP
         3UM+Gi2Ncgj+xHQCxNwvvsclBK7OVzHzAd+BYlfuBZoobdtDdWfedUgKkuodNQyQVbYD
         H36kZmwWnJyJMrwGVRY83+6YE76Xdo2rPLZZmav/IG0KM3odTJXpb2vgMSvzcDgqhojJ
         q20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eedUPYZNuu15PVEa8yEoZU2uJmbmZVCIqta2cOfzMIY=;
        b=n46J2rlZQWZ8sB1Uc9iAhHzu67m0cap2lRYZJPb6LiEn24LQkQ4CopZgp4wuPe25/G
         hxDJpNk1bvwLnwFNMFiOGbVcjD1ZMBkLiej8mWA7J4kPmsWDbooUQTnJxyniPMTjMN5t
         Q1S619i1a3vqgwqgkAQQ00cJUuu1ucqPL5T1sRpsezhjDoSnHpCPe66Y6JzoE3+geh/U
         DRiuozpFPTQEbdMDYEXBmFuO1TnE4QDxszUP7YOn6dyP9XlDn0uZlhG4H1Mv7Zd/Sl4a
         M9TuJn60D15RAQaufAd6Eex3eRm6YsfHKwC6e+Ru/zV6tJZ9phhJ/eqlM95hHI5wHw9r
         Cl6g==
X-Gm-Message-State: AO0yUKUCH6l0yfksF9XRk3W2T4CU3oMxHsv0gDmsWzXT6gfMBvQKCSdb
        NuEWYpW4Y8+RACLV0WftaWBqSVBxsPk=
X-Google-Smtp-Source: AK7set8+BsEI09GzS8oYn0gSio76bTTpzfEAppXpxcszAXLwJfBtBZKY4lQH/POH2rif2/UIaXCgBA==
X-Received: by 2002:a05:6a00:b51:b0:5a8:ac15:534d with SMTP id p17-20020a056a000b5100b005a8ac15534dmr15817223pfo.13.1677627653685;
        Tue, 28 Feb 2023 15:40:53 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x42-20020a056a000bea00b005df065ebd5esm6537646pfu.209.2023.02.28.15.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 15:40:53 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/20] t5541: run "used receive-pack service" test earlier
References: <20230228233913.684853-1-gitster@pobox.com>
Date:   Tue, 28 Feb 2023 15:40:53 -0800
In-Reply-To: <20230228233913.684853-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Tue, 28 Feb 2023 15:38:54 -0800")
Message-ID: <xmqqlekhpddm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> From: Jeff King <peff@peff.net>

Sorry for these patches that were sent out by accident.  Please
disregard.
