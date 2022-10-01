Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DC0C433FE
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJAQbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJAQbN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 12:31:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C1D2E69A
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 09:31:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bq9so11128660wrb.4
        for <git@vger.kernel.org>; Sat, 01 Oct 2022 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=bZF62pkAFiBq1mB6tq/5aYQ2LEK5CoIjHW7uFba7VjQ=;
        b=FyliModkficTr+JpOzjDs/PCqsFDO6WQMjLa9w3vc6ajn1bOGOSBDMn11slG+kPMMG
         Il0bntcWhvTmpx/wF6fXAU/+vvvMvC37kwg9T8ILAgRCXiAea8JbAEQK2nhVNDVGDNKW
         xXHuzMpr8hbSxZhmTgbgecDFnG6cK9xTuNrSmXy4OBHKoPEu278RcjlNO1o48j49C4uI
         VtlDzbey5SP+d5S0pKB51IhFbUelX7DxRPsynfm49zXUOLPsLy+ABwAwLDMfEwrkGDSR
         VJLGo62/QQsciLl0HEACc/E9yatOpMfSWOXGrHwxZOFm/YwppAyIqqq4SF5LHn9pICIa
         e5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bZF62pkAFiBq1mB6tq/5aYQ2LEK5CoIjHW7uFba7VjQ=;
        b=WJZynK18z4rRA+zUrvWnPBIVLuSQclPv+2fGzFuEcs8V2UImZmIRrc2Kp1W4Zw/r3k
         HsHe4HGuvax8Qk8946AYJBfzoeh7v1932Gmm3AVLP3yGT2vH0vrJLzDE+kzyuLXcgR5r
         Y6k1dWlwSGOG/0vUP2lL+ibNwEHT+KCzdNhCfSvYZOWjJ9OP/P0qTAQQFejYI9XsTPVo
         EH+3hD4cG4MWF8biEgmGOiyalws/GVsCXK8TW1foquMO7YPKkXeweAy+UxE+p4oI6I4o
         IHfqb25jF7KnEs4Vq3IFrCqiRVMHr752lkjr9ACJvu/J48Umg6g+6At36rM2nbHSgpQL
         b63Q==
X-Gm-Message-State: ACrzQf3lHV4sphnmuo3+zt8Rc3MCimVFyAovRvv0D0VARAkynBoDf/nO
        cZDGMUBCSx/XOW0CZCekjVY=
X-Google-Smtp-Source: AMsMyM7k48d/eJ7MiVewTHVhvLGCU+wMhe2zTqOA/tkl3EC2/c7uX0vzZ8ZYXe03z0K1C+hGfaESJA==
X-Received: by 2002:a5d:64c4:0:b0:228:e143:ddb8 with SMTP id f4-20020a5d64c4000000b00228e143ddb8mr8660573wri.148.1664641867646;
        Sat, 01 Oct 2022 09:31:07 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id c6-20020a5d4146000000b0022a403954c3sm5581746wrq.42.2022.10.01.09.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 09:31:07 -0700 (PDT)
Date:   Sat, 1 Oct 2022 18:31:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] rebase --update-refs: smooth out some rough edges
Message-ID: <20221001163105.GA7659@szeder.dev>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
 <05c5076b-eb78-5381-4eba-863a84190755@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c5076b-eb78-5381-4eba-863a84190755@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2022 at 01:29:58PM -0400, Derrick Stolee wrote:
> On 9/30/2022 10:09 AM, SZEDER Gábor wrote:
> > A couple of cleanups and fixes to a new 'git rebase --update-refs' feature
> > introduced in the current release cycle.

> Junio: I don't think any of this needs to rush into v2.38.0, since
> they are mostly cosmetic changes and helping users get out of bad
> situations.

I do think that we shouldn't have a release where an 'update-ref'
instruction can update anything outside the refs/ hierarchy, so we
don't have to worry about potential backwards incompatibility when we
restrict it later or add DWIMery.


