Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA11E2023D
	for <e@80x24.org>; Wed,  2 May 2018 20:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbeEBUgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 16:36:07 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:38510 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbeEBUgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 16:36:07 -0400
Received: by mail-pf0-f171.google.com with SMTP id o76so12768173pfi.5
        for <git@vger.kernel.org>; Wed, 02 May 2018 13:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZUa4HWQ2dPOrGz+wwWhZCRvkSD3vjRIXeTMFGtTTHnE=;
        b=bundnjG9ZWnR401hDbC/VMD9eCi9QmjD5kObUdDloez6QWYtFyJvwJE9glxdTkLrWW
         dzgKRbbZR5dDmQql2qJsu6vne+5ShgQrwegGiDwnUX9R3VKoqjPobnU8zCeGHG0boLyP
         SWEOQqfKKQdIB5kWX5QNAL0gDdELE81lQzI6zXlHu8i1IyS6sbrzk5TfN8MYlWZ9/6p8
         swbVFpeoV5+yHA3YC9VCF1hvczWnODGyrFj7xdPrOWK7w2RhiGrQQhs9YJJWNuqNC5JQ
         EgxCgOojGfgZ//wBUM6liymKlA4WTziRQ2JuRO8zHHi4BecieWeOdkOKsgKZzNmCU+/Q
         ADtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUa4HWQ2dPOrGz+wwWhZCRvkSD3vjRIXeTMFGtTTHnE=;
        b=OrG/svuVg8A0PpNWZS12+A/jZW2tYxrd8sppLv2bKmtr7b+oxm8n/yESDYaIrST4Kp
         CBJI3FR56RfhumFycw3mHx4Kb4yV+7JwQ20wC1YRQlbvp8RfC21pJdiIfgUG4Zm89io3
         Fj8mYXSBSfJ8FqEwA09p0A0l+1Jvpl3w9NocphsN0opiF0dvNJphO0CrdMypYsjW0CtG
         8mq9J/K/WYpRmzQcv4M8k4VcX+0yKsRbawZUX5fa+QG0vY+I5mNsmzyy3O4/3LmldH9L
         hLL0IlRuVaU8WKx8NxRLxNWlV6MDkSytyl3sZRjt+pLF/wCgg8rbfMJL3/U2JK2tWO5g
         oKTQ==
X-Gm-Message-State: ALQs6tCXFWV9GstE8thHcuJegsd6wR1dAHLdNZh1n4JqsMacG2H6mtbv
        kFl9h2HYbcjh5vHT9/pZNOnTVwOZTDo=
X-Google-Smtp-Source: AB8JxZp8+9a/NcHS7AfdVjpjcRXSw32AvdT8sWs4yQ3bYmlkfn3ooEwavLS7leCs5onRPbDCcQRrYw==
X-Received: by 10.98.249.9 with SMTP id o9mr14950193pfh.256.1525293366491;
        Wed, 02 May 2018 13:36:06 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id s17sm29032902pfi.165.2018.05.02.13.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 13:36:05 -0700 (PDT)
Date:   Wed, 2 May 2018 13:36:04 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/13] object: allow create_object to handle arbitrary
 repositories
Message-Id: <20180502133604.bac43123a7082ff6e6c5a1ed@google.com>
In-Reply-To: <20180501213403.14643-13-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180501213403.14643-13-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  1 May 2018 14:34:02 -0700
Stefan Beller <sbeller@google.com> wrote:

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Downloading this patch set and viewing the whole function modified in
this patch shows that globals are no longer referenced, so this is good.
Same comment for patch 11.
