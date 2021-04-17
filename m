Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904AC433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 04:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F21E61006
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 04:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhDQEJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 00:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhDQEJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 00:09:50 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0836EC061574
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 21:09:22 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id l131so24905037oih.0
        for <git@vger.kernel.org>; Fri, 16 Apr 2021 21:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q52vVpclpu1O1nCVCeIpvyC+1QU7CCbSJpADkQr+t9Q=;
        b=pNPPU3xsiPzKhhB0W7VdcxI6/cB3B9CcQXaJomUHX/SyD5+OUNhzy2QSoORaVwC29M
         9IKdqxT0nJqYA9ObPFTyExSfzsWTU3roUOWN+CN1GvCPmucHczUbGE9ilQQ1nW+5SRlP
         8wtzadtyvU5MGahrplSdVV5yznaufJF67EeoyosHV93Jy3N6qFP8XWsG4X1u/SOO8sE6
         yJGaRYUqVxH/vFS4ZPgUJ4/xjlqbriVaku8e+eh6Lb2EUHTCDlM1rcUaUjKF1JO27De1
         MMPHFWLMFEq9LGfoD8kR6yFC4l9VqvYdDfHa7obZpDNoAqQS/32MPNXeXhGyFkwfZMxA
         8nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q52vVpclpu1O1nCVCeIpvyC+1QU7CCbSJpADkQr+t9Q=;
        b=k4QqUw4hFSFp0P8uIKGsxLAEj+OpFgD3pTzGCCqk3MtP39OOgtZqROiNW8dAqw0wCn
         UxkMwDYlj1kVUuAflKhKsKErhOsy6Fmq6/Ctu4h9xez/PdsmSKEuMVDTxQNFCh5sPPmm
         fCkUnTiOi0hCX4plcpPv6wQ832Bd0eQ+dmBmVvJ0bmicxpeMlrZlCVC8anl268PotTez
         hlPnahi1vDpbbuXp3XDl5pqPMLFDBADZ7D/8Bxrl4oFJhhn1L9Y92DJvGVmdwJhalQKN
         DQgNRM78lJSAcYYIhHRKA883m19BRNumzPlQj1FOSQGCnYmEL0k9IYH6CON+e/VuPeyo
         CzRg==
X-Gm-Message-State: AOAM530hBQuvG9tfsvgdhN2uoO+2WkGt7VoOJCpnynC4A0oQ/H9u1x1P
        0ZW5I8fz3nRV0RULR6itgGo=
X-Google-Smtp-Source: ABdhPJw3MNNKSLKpaBtv63gDlHkGlg/r+2CApRgxD4MjxGqCi0DNXu+VHfPbzZfwQ5njuhc1QDjvFA==
X-Received: by 2002:aca:a990:: with SMTP id s138mr9116308oie.80.1618632562400;
        Fri, 16 Apr 2021 21:09:22 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:bfd0:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id 128sm1574166oog.37.2021.04.16.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 21:09:21 -0700 (PDT)
Date:   Fri, 16 Apr 2021 23:09:20 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jerry Zhang <jerry@skydio.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ross Yeager <ross@skydio.com>,
        Abraham Bachrach <abe@skydio.com>,
        Brian Kubisiak <brian.kubisiak@skydio.com>
Message-ID: <607a5f701977c_18dc520893@natae.notmuch>
In-Reply-To: <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com>
References: <20210417001525.19960-1-jerry@skydio.com>
 <xmqqzgxxivrb.fsf@gitster.g>
 <CAMKO5Cutas2BM_CTHTJs_O9NSp2Vyn-bK0jV0K758eq5M6-Oag@mail.gmail.com>
Subject: Re: [PATCH] git-rev-list: add --exclude-path-first-parent flag
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang wrote:
> My motivation is to find the point at which a release branch forked off from
> a main branch, even though the release branch could have been merged
> into the main branch multiple times since it was forked off.

As far as I'm aware this is precisely the only advantage of Mercurial
over Git.

Last time I checked the only way to actually find out the fork point
considering multiple corner cases was to directly store it.

Perhaps --exclude-path-first-parent would be a good approximation.

-- 
Felipe Contreras
