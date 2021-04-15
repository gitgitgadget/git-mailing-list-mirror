Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43AEC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E05361152
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhDOJMa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhDOJM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:12:29 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AEFC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 02:12:05 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id p2so1010816pgh.4
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TrovLvwqALocIUPSZJg+sTGhKEgJ4/3GqB8vq6PCON8=;
        b=u+BGXVur1BdBsVgQqnb/q64aimAJ7LwgWu+hizJ9f55VFS+VVJ68sh3rw8u5MolSlU
         5yL2dHD7BT06bYA+oQJtFm0IWk1lMbP2w12kx4B+P0wTcAvFfEdF1rI8OQNptqAGuCMb
         pj0hGJpQjjA2hDfXapmqHrd0meuJLRvaDLqHQyeSKrChKOlou10Nf3xJXcpa/eco18Rt
         /oe3fiBNqLW4veJLu6/QO2yIpsz3EZaw9Rzob6bgWVuHkiNx633BvV56kvt7eGXhNw04
         aeax/v7yww/rSVp7sJFpIBM4DXodTh9U5EzcOap9kwcJ7x4xrscU5q0j9TN+iLUmWOI7
         u10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TrovLvwqALocIUPSZJg+sTGhKEgJ4/3GqB8vq6PCON8=;
        b=kULyywAHrIMxj4hXx1gSYyYnCaHQqhISt8ZpgMX9MS1ho8yhsE38S4ghVBhz1EwGwI
         rnx47JQ9ixKLR6VplybA5og1cU5F/fdAbfKdj987wK7XSZQuIsei5BCmCZi0ypiOuPXN
         VCyLinlZMG6gtbTTyfozMnwtDg98mEUMDvdpeHr3e3e44iQGBjwPjPAVnN6KHl42FfSq
         RFR5OZRiV7CcqRfoQQCRrE5p4CYsY1CA+vrvbXrPJvQclTQpHHHdXMTt9F07Chd6NeNJ
         QxzxuL/mKh49XlzZiBLPwMchWj6ysOAxzPTeQLDit9K+lHSb/S0Q1pk7l8Uh4Ru+xErj
         IXGg==
X-Gm-Message-State: AOAM533rR7PmEZ5fjRxjSwlTugsOAYRZvcpq1Bv0F+ogKicA/j5y1Cgj
        aw/SwQjQrvKGTw7KAYgoBs3rgqa08i0=
X-Google-Smtp-Source: ABdhPJx2jNppvAvsyJSt+FsRhFoiliqpx1TqJ/wC/3n8874pNntKf9+dp4Esqtg8lXau2oFaMCnklw==
X-Received: by 2002:a63:211c:: with SMTP id h28mr2521257pgh.278.1618477925263;
        Thu, 15 Apr 2021 02:12:05 -0700 (PDT)
Received: from generichostname ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id b7sm1578745pfi.42.2021.04.15.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 02:12:04 -0700 (PDT)
Date:   Thu, 15 Apr 2021 02:12:02 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: Why isn't 'jch' based on 'next'?
Message-ID: <YHgDYl3cMx9+Hqa7@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Out of curiosity, why is 'jch' not based on 'next' but instead, it
recreates the same merge commits on top of 'master'. What is the
advantage of this?

Thanks,
Denton
