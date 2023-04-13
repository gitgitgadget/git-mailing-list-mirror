Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C8DC77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 09:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDMJhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDMJhD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 05:37:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9006259C6
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 02:36:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v9so19859294pjk.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378619; x=1683970619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8BcY1zUWmjAv4QkcdLReyq8MlmRLobw2QR9a0IahcM=;
        b=Q7yDCfkg1CkGJbrMCy5o4jSNmVctmaIGa4wUWY/8WgxfNT5DdPDMKsYZcjqjJDUM/c
         4DW1CcL1VhP9fvu4c4F6ULmDGrvuLWTOwki+Vn2oOea3kuf1dBQd64pgYHCclDgorb8e
         im2nptTitzxbiCV56Jz7Is4nNEIz8B5INbVeGoqKqWJHDD2Hk8WFVs0tiynMPGCXKlC8
         m5jrzKYKeEHchMvRPHI3B1MzuxBXuGpr+UwYLsWPp+OLgZ79c1BOLPTIn7R3uOBlATYO
         GygOkAxhOAT/Z0+KrH3Oc92GifMZ/2xsvJQ83i5wHuQ+C8AU6sc607myYERm1LaR6gcO
         Ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378619; x=1683970619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8BcY1zUWmjAv4QkcdLReyq8MlmRLobw2QR9a0IahcM=;
        b=SLYbjqeHl4OF4NSL5yKy1LYlexPZSPIrmLFJY/jL7YDOiWSePNKkeX4IG1DmvOK7AQ
         xyejn69PKVk8+oVaQqe9XgZ+vzwMFjWH4W+GtMRQ8TmAw+MJL6I9SynrIw4vhLQesro9
         8OzG3NfWGBEeEzjzJIk5tPpTPgzucBdcUH+DEyouNn68Af5m5oPbwmvZOcXltnNKdFbU
         Nm9oseS/80Kso9yZp6+w9uepeWbtxIDtNc4tM0SftnsSfAAcV42qeDVWOcRT3Klr+wKG
         wBmJo4ZFhmnZNRb9YDqtjSKLvW3eDz/pvE8K3z8zsIobUpvSb0vxk6aT59SxQLxtd1IU
         lVxQ==
X-Gm-Message-State: AAQBX9cDofGYjH+JGQ2K0Tt4Y/MToYtgfNiN8BMH11LuAXmSXNCbrjW+
        xq+1dsOLK42n2e7fDD9RY8Q=
X-Google-Smtp-Source: AKy350YOKGLXFN+XhJA6q2gOUQ1hge6HpKDjjWJ0zO9kwFh57eKzKVqJFDwAeYOwKSVHZR1l3A8jkA==
X-Received: by 2002:a17:902:d505:b0:1a1:ee8c:eeba with SMTP id b5-20020a170902d50500b001a1ee8ceebamr1927207plg.59.1681378618964;
        Thu, 13 Apr 2023 02:36:58 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.54])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001a0428bd8c4sm1030992pln.289.2023.04.13.02.36.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:36:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 3/4] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Thu, 13 Apr 2023 17:36:52 +0800
Message-Id: <20230413093652.75678-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.0.rc2.4.gf6da9915.dirty
In-Reply-To: <xmqqy1nf8c0f.fsf@gitster.g>
References: <xmqqy1nf8c0f.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Just FYI, it seems that it is indeed premature to declare that this
> one to be leak-free.  With this topic merged to 'seen', the leak
> checker CI job seems to choke on t3301 (in addition, it also barfs
> on t3307).

Yes, it contains a leak in function "parse_reuse_arg()", will fix.

Thanks.
