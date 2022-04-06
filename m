Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6195CC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiDFRev (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiDFRek (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:34:40 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1994915A18
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:41:00 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id p8so2522714qvv.5
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P+NxNY8Zv3DfkSNvkddOKBJ4hqetR8NuJvzorqT6QGQ=;
        b=1ttcJJ/L7BU1Cu73Po3+lUYGqbSTxuvbjmXx5dAktByAHCU/MPuy/OLUUrilwCxQZK
         FQhVabn3J61xNyezB3CbbB2RVI9vCxO7MMk0kzRd3iQezBTb+37Cf5aunRBA3/RbCkmt
         qQW1QVSJlC/8gBgKA7n8ZRq+UK3UAijH9NMsvymclidvHS9sRiYspJsGsBXn+HJR03U7
         OEO92t70vHWUDS67CvC8iSSn0O7DgomLoY6w9d0lkuF10wHWOYJ2pWXlltfiAlRb+eWs
         ykLv2BCfMefHYCfjKPxL5qM2qm2u54RMYgjaiMZ6ZLbCLWwbmgfhAhDbHXjr8/ClhfQ3
         PnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P+NxNY8Zv3DfkSNvkddOKBJ4hqetR8NuJvzorqT6QGQ=;
        b=Ms6eUFyGMdfuUGX+kh+54F0rjH/KV13OuFwKY7phcyKOfPK5sS9enwIxpcaKh0ZCoZ
         T92sYlN1dUuvlbN4Z6179wKa9y7ASA4tJGWGTbbCHyOztmW7cyw2TZUHgVolFZQlLaU/
         C0spLm6airg5oCUPcvP7HbcDRdslkkjIG3yF0rIAO/FhU069SjXHyxjeu5u346RPf/wU
         8MGl8aGwCMcvg1IGYOB3EqwD575Ekj4WmqvfOYyBtM87OtPdh3ixl3tGWl1MD3fVW4yg
         /uRNbYco+tyIriEirWRXVlpwGNQDOjrzG1ow4GBdSlntyrZkzLSTNrtmLdQcEcWSa0K2
         3UwA==
X-Gm-Message-State: AOAM5333e+Rajig9jiRrJ6L2NzPXvFMqn/IgbtHNxUlf4esAo0tjmqtb
        KuxaltE+Cice2CaipYSJwX5r0Q==
X-Google-Smtp-Source: ABdhPJwl4mPb3EK+iucr5h8UeIT3tQtfPlMJqO3iBo/+9BDfZ6NV3cB6HrZJgJCNkHt/Rdrij/MJRQ==
X-Received: by 2002:a05:6214:21e4:b0:441:248a:9823 with SMTP id p4-20020a05621421e400b00441248a9823mr7895368qvj.35.1649259659132;
        Wed, 06 Apr 2022 08:40:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 64-20020a370343000000b0067b31f32693sm10304125qkd.109.2022.04.06.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:40:58 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:40:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Plato Kiorpelidis <kioplato@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC] Contributor candidate introduction
Message-ID: <Yk20iKECF5vDtWQL@nand.local>
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <Yky7xb7nQRR8Vqtj@nand.local>
 <CAP8UFD1Y+4XDARoK_T_c2eMUou4senhQLnjJE4zyz2KHuZGsFw@mail.gmail.com>
 <CAC316V6mDowYpptox3KxYycpwpiQhW+LSmNOx8_F_8LKBG2gUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC316V6mDowYpptox3KxYycpwpiQhW+LSmNOx8_F_8LKBG2gUw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 06, 2022 at 07:41:35PM +0530, Shubham Mishra wrote:
> Hi,
>
> As the topic begans, I think I should also give my updates. Last week
> I spend time around "Croaring" library and right now, I start working
> on the initial version of proposal which I am planning to share by end
> of this week. I think if it's possible to split it into two, We can
> look forward to it with I am okay with picking other project involving
> bitmap too but only issue, I have to start again from scratch :)

Sounds great; I think that having a proposal of how/if we should use
Roaring+Run bitmaps in Git will be useful in its own right.

I expect that it will generate some useful discussion, and provide a
good roadmap for any contributor to get started working on it. Let's see
how the proposal develops and adjust, split or not split the GSoC
project as necessary.

Thanks,
Taylor
