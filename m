Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36311C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 18:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AA08613E9
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 18:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhFQS07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 14:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbhFQS0T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 14:26:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A52C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 11:24:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id h9so7538400oih.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Yp/WV3yU4BW+ipnAznKWt7IrMKdPFITIZmU/Iqnb2tE=;
        b=qdHksbSL/hfgWHmvHeIyKaCpsUzs08uScVoehqfN4Dp8UIh+T+/c2yZ5LtFbBkmjzL
         Jvjyf0qnHSPgfED6PP9Fl6X9huEcYbvxygZDW2Ei9R5Nu9E/a2csN7NKLY3+tHtvw33p
         /OZurlbK99DURerIA3Bb6ogEak78mOme+TmjCt7Gen64WfioezLKfICU2WnmEZW7b/vF
         4GpPQ5Jgd/QjyWXaB2iuBLuwDXVi+RE7uaLKF56FoEtip1XU9EYathR9un3dIUMs3kfQ
         7QdISJ14l3wUnSO+4MSCTXC4nbk8PERUQIc65GXYX8KDLnXHn1KiWSJl0wsqGqj72ztJ
         qq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Yp/WV3yU4BW+ipnAznKWt7IrMKdPFITIZmU/Iqnb2tE=;
        b=EKCCDrqei8zUKLETjPIj2XjoCLvtjw3k/PPgOa9rzki/EhH6oRNfiNpFLOAympUaWl
         7e5/ILpQNjkcLhDs5I6VH0ORb5jefyCA/TbNyiDIEA5CZ6Fa561FFWpLkoGG5GLVbnie
         3QTXimbBtne+52FgdqDqHR8I1eNNGqO9xsU35++2xIDwdEHIfXN1aRkQZfFyxrqDZ5R5
         xjwRKGM+78Nwmo7RPEvYx0QOyJvotzf3gX/zx8FjM8OOgol9Wa9p0O4wo1opRlWeIDQm
         fenXuB9RFAOzQu5zfyTqoGQwp0fM9Js8bonBrhk9y0ZhfYLGd8K1cr51fPC+M9QP9zCY
         B1zA==
X-Gm-Message-State: AOAM530XYlGWlGLBF0W67dvxFw3qQwOCyBKUt3m1GPAudWrwwxFArql0
        EqLSs3tTglzP/kn+belXXLw=
X-Google-Smtp-Source: ABdhPJwoVJqr9ldjvNJb3rk4lO5dk1OHrvAKDTCEEeYtozlBIvZ9JB7oVMpQ8yPYj17WqVN3ylQAgg==
X-Received: by 2002:aca:fc05:: with SMTP id a5mr4348072oii.158.1623954249981;
        Thu, 17 Jun 2021 11:24:09 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p10sm1525037otf.45.2021.06.17.11.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 11:24:09 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:24:07 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60cb9347e9d2e_150282085c@natae.notmuch>
In-Reply-To: <5c27a8ac-f6b1-3551-0af3-4e242437005d@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <5c27a8ac-f6b1-3551-0af3-4e242437005d@gmail.com>
Subject: Re: [PATCH 0/7] Make diff3 the default conflict style
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood wrote:
> Regrettably I shall not be commenting further on these or any future 
> patches from you. I do not feel it would be a productive use of my time 
> as you have not entered into the kind of constructive discussion that is 
> the expected norm on this list.

Please let me know where exactly I have ignored your feedback or engaged
in any kind of unconstructive discussion with you.

Without any actual proof I don't think the above is an accurate
assessment.

Also, in my opinion it's bad manners to say "I don't like you and I'm
going to mute you". Just mute.

Cheers.

-- 
Felipe Contreras
