Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69AC433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA9E2224A
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 01:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry6Itmbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgJIBnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbgJIBnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 21:43:23 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C264C0613D2
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 18:43:23 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w21so914808plq.3
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 18:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B2OEI2HiEeQRsmS7yrYzSwzBHl0iggdL7+6EAyBGvc8=;
        b=Ry6Itmbh/m49Oub4AB0dkHq07QTdGBL5fbQowQvtmfiPoSHjPSrwgeBPVoYWqf9cgg
         oKsPnXgu5ZiaJlLwNjgwF2xItNjCLZTCupWUXnUifBlGwReee5VL4fbkZL/dqubKlng9
         mYaBBgd2YBUKGoA56cEC/7aZk/mqDzRBqgyOAWMNU+y/YZhW8EcPllqYzpXO1WpglCui
         61rUW3IDVnvKA8NENYIqSe2HDfOjY0DZzInJhg4v62xMMWnt3NvDMjTUmXKzR1W8gPv/
         KPR3Id4mghxp8QCjIJ5P20G2Cin9HYJSC+6O1v1iyLzkMED6BGBko5wmIrBHjXwJrF6z
         U4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B2OEI2HiEeQRsmS7yrYzSwzBHl0iggdL7+6EAyBGvc8=;
        b=qauPT5qqDmbRyiKJ1DPDBpB7c4H28N7QSMolfoYMDSfHwJGaZuw5wk0BAL7ERiFUJD
         JjqYxrjvnbQHA/r3TIt+SwrDj0/tczYabDtOrdjJ1VsMD50u3Sk3QCUWgWLTeNNJ9CCL
         Ut0m4PwKKwPdUHB58+gxTyIX6i0Pe90NLILA4gr3jNXOlFzD15DeAjqdq+Ovce07apqg
         VV/StFOInuVcvIoZnbVqR0htMbRIUrb3SJ39Pmu7EcNHa0JAT3WNRwN+0UybUKgg9jCg
         Gsq7J9eXoW5F+wIgYslT1LMegmi7Un69HZ0LxVwATrWtzFUdQ+biOdA8kA8FrMUfIZbX
         /2XA==
X-Gm-Message-State: AOAM530ieprQr3LyJYmbX5oE5/niyvHb+TLvLxO+LZePFU9IkDTclg86
        mp/iyRWmG/dAg4y1TBQgjxc=
X-Google-Smtp-Source: ABdhPJyvmvi4VucOF47ewAnx6IQCeouTS1OMbP1GTgvfw3AhofiSTAXPsmnARu9lziTFyfr7ZPNDtA==
X-Received: by 2002:a17:902:6b45:b029:d3:df34:3222 with SMTP id g5-20020a1709026b45b02900d3df343222mr10170277plt.68.1602207802609;
        Thu, 08 Oct 2020 18:43:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id m3sm8815047pjv.52.2020.10.08.18.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 18:43:22 -0700 (PDT)
Date:   Thu, 8 Oct 2020 18:43:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Amanda Shafack <shafack.likhene@gmail.com>
Cc:     git@vger.kernel.org, wireshark-dev@wireshark.org
Subject: Re: Introduction - An Outreachy 2020 Applicant
Message-ID: <20201009014319.GA2429084@google.com>
References: <CAGxm6oXSaKoTR3btKRV4bMYUsc3-oKeWSfzrWKkCXgrRorAEAQ@mail.gmail.com>
 <20201009002541.GB2415320@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009002541.GB2415320@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> +wireshark-dev@wireshark.org
> Hi Amanda,
>
> Amanda Shafack wrote:
>
>> I am Amanda Shafack, an Outreachy 2020 applicant who wishes to
>> contribute to the "Add Git protocol support to Wireshark" project.
>>
>> In addition, I have some experience coding in C and I hope to enhance
>> my skill set by contributing to this project.
>>
>> I am currently going through the project description and contribution
>> guidelines.
>
> Welcome!
>
> Since this project would involve Git (for Git protocol) and Wireshark
> (where the dissector goes), we're comfortable working with you on
> contributions to both Git and Wireshark during the application[1]
> period.
>
> https://gitlab.com/wireshark/wireshark/-/wikis/Development/ has some
> pointers on getting started with Wireshark development.  I'm cc-ing
> the wireshark developers list in case they have suggestions for an
> approachable "first patch" idea to get used to that project's
> contribution flow.

Ahem, actually cc-ing that list this time.  Sorry for the noise.

> It's also a good idea to build and run wireshark and see if anything
> strikes your eye as something you'd be interested in seeing work
> differently.
>
> For Git we have some suggestions for microprojects at
> https://git.github.io/Outreachy-21-Microprojects/
>
> Thanks for writing, and I look forward to working with you.  These are
> two open source projects that I love and I hope you enjoy working with
> them, too. :)

Sincerely,
Jonathan

> [1] https://www.outreachy.org/apply/
