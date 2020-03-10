Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3333C10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4C0222C3
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 21:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPmW2Ju1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:29:07 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:34876 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJV3H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 17:29:07 -0400
Received: by mail-pj1-f73.google.com with SMTP id o10so90252pjt.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Iq0ZhnCENpGHFvEPDLJuSXVglmCCztzzZUEkHHHcBi0=;
        b=RPmW2Ju1+zrRZYiz/utVjec7Bf33oL9vU3tXxAfHR2SQ1jdF/xLLBJ5plx4manBslc
         q0ynbkG2/Ayb9Wyw6DnDj4abocdS9UcDJJTP14i2ciZZnTqr95wbLZVmGmh0kBRLof+D
         E0x5WIKPff9oB/RvSNWo7nUtJnCN33ZXwv4TdFioH07D791WAKZ8un3rykdPd3RsW7tu
         YXwgyI859RWEtdUnecjrKkhkepBDZzILKvShurlEIg6TO/R7xT8RL55Vd4ORfc4vM/RF
         Dd8yj8Pd9BaF6OeZpsKwT6eBNDjLrHdNRe7rrOaIxGk7NtdaNPlCu/1AbadnONsLPI4m
         hpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Iq0ZhnCENpGHFvEPDLJuSXVglmCCztzzZUEkHHHcBi0=;
        b=M1pHub3xlDulh16g6p0Rg4LRwErSC987jRIRg9Bu0I3B9CgqXgVgblR2HgHfcCSEWc
         lEkvy4x9ZFlI+rbLdzjt2+ECFlqzOH05f2xa33LNH1W7qdqHVSHeOQxiqT4WXYpD0QSB
         3qQlh9IX8DWFNzjgffxqu0haJ/cnsirrR1th/omwqnskBPF6HB5Qjvu3aZH62AV5FNp5
         1OM5InEOpn7lBJoiIKL22ILiF+F8Wk3UPI+lzSZixVjYd/Y+hOKDWMy9s/ddzekOZfs3
         IiQmMnAP9panOYwZLn2ogP7KzsGbq7R3kXyImQt1S5q/EFLOVuP9R+Xy1LIpbypweRWZ
         k77g==
X-Gm-Message-State: ANhLgQ1es73ScHQudTm+jyZnD+klAblK2zvITYMwLXjqQ/VlDDJKI7zn
        N2kvvz8n2mSGUVGTLTjrDDUcVQGpj7RAhYWmdrPZ
X-Google-Smtp-Source: ADFU+vvumrUCphpQBsoxKZbwTBJ1vN8cIIWmsvnmlP39oPHC84IHev+GcK5A6ArpfbjMSYFg8FSaw+QZGmtWbkFyXosQ
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr2418579pjp.33.1583875746012;
 Tue, 10 Mar 2020 14:29:06 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:29:02 -0700
In-Reply-To: <20200228000412.GC12115@google.com>
Message-Id: <20200310212902.77827-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200228000412.GC12115@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH v2 3/7] index-pack: remove redundant parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It looks like compare_ofs_delta_bases() could be similarly cleaned up
> here? This seems to be the only caller.

[snip]

> And same with compare_ref_delta_bases here.

That's true, although I didn't need these cleanups for the rest of my patches,
so I think it's better to defer them to reduce the overall size of the
patch.
