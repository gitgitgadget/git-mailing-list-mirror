Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC2C47082
	for <git@archiver.kernel.org>; Mon, 24 May 2021 02:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8C9D61003
	for <git@archiver.kernel.org>; Mon, 24 May 2021 02:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhEXCmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 22:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbhEXCml (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 22:42:41 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D0C061574
        for <git@vger.kernel.org>; Sun, 23 May 2021 19:41:13 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso23856095otn.3
        for <git@vger.kernel.org>; Sun, 23 May 2021 19:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=i4sAwdiWLO/UqfqDaB1AfTXkaeoa9WByWHKVdXcviws=;
        b=iMHm0VCIjmFFza7Dc7ZHqHGH5LmlsX+XejINQgbyWqFDzOBJQ2iNS7Pwx0Gogu6/PX
         xlELi8PuuKE32gtjoc6K74uCrI63ypVNBsmyqxqXikXt9qu5/R8eG7cgagslRECm0vjq
         hIWOEOIM2QtI8ky6UezR2sM72O41v0oGwdEMennlREgcA7aBz61e6viEx47AZlr2sCbz
         JMC1fw2M/SPB9rcQNWTpkN2+9ekVF/KJFcPII6CC7k3yrjNhDvdzLzJuuJi2lfJVwgLr
         a8Fjc0yY1lbLy/533a5jZ5lE4W8z7P00Tr7muIWvbj7tlgYJwntVtdezjgWW+MtAsQAW
         FIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=i4sAwdiWLO/UqfqDaB1AfTXkaeoa9WByWHKVdXcviws=;
        b=pwSBMlPbdi4Hc7JBpPGkZVYN53jZblXK+GDi0+gL/AHGO1T0TyY9/IEg5xafbAdvkl
         TAT+J6Rv1P42x/wkaCCXHPXvG4QcEIn2TZ6ZL/PQ2GQk95zgCx0FRldRS5p1kwmvTX17
         sSWcA+BJ5KSiXUzYIteoIQUsV2OGIYGo+GcMpQYCiWsQFlRAB0WgybwF1pvAKW9VSd5x
         RxY6uB5YtQ3vCxlbG/QSBknLZyDYo1hH1ui6dn7TRoOm7xep/3vTVJT1LrY49gmh4DHz
         O5dwNApLlknED1jjVkreNl7gC28YNB2Ih//aW10i7Na+3diX4NgTNbdF2PJhibQ+pgRK
         /nXg==
X-Gm-Message-State: AOAM530onaNj7d/txdnJERBvCG/vI3+k44LOV5zfue73ycoBmyEM6NAP
        IXPGDysMR77qKxMV4ZFZ6M0=
X-Google-Smtp-Source: ABdhPJwuTPFIvRXeNywrBzcceg0LtvfqcbEliygiNsW5AOHbxrFt4jdA7XRXqb5c1S9K1nxssri97w==
X-Received: by 2002:a9d:491:: with SMTP id 17mr17020634otm.184.1621824072644;
        Sun, 23 May 2021 19:41:12 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r7sm2628447oom.46.2021.05.23.19.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 19:41:12 -0700 (PDT)
Date:   Sun, 23 May 2021 21:41:10 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Message-ID: <60ab1246d2d14_1691c2083b@natae.notmuch>
In-Reply-To: <xmqq1r9xndjf.fsf@gitster.g>
References: <pull.959.git.1621763612.gitgitgadget@gmail.com>
 <xmqq1r9xndjf.fsf@gitster.g>
Subject: Re: [PATCH 0/3] [GSOC][RFC] ref-filter: add contents:raw atom
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Is there another word to refer to the entire payload unadulterated?

Another word better than "raw"? I don't think so: basic, crude, green,
rough.

-- 
Felipe Contreras
