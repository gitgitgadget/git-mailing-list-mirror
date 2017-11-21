Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD242036D
	for <e@80x24.org>; Tue, 21 Nov 2017 22:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbdKUWex (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 17:34:53 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38062 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdKUWex (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 17:34:53 -0500
Received: by mail-it0-f45.google.com with SMTP id n134so3994778itg.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sHrDsprJds6cxi1Elby+IOsOWvxeptJM+gDsUTq3BxE=;
        b=WysZyWjnoX+0AgSdfIRkiMg2F34f8ZD0NJANTRF4VX7eYpA1G+oM8SiDQ4w7J+1X8P
         CEULRcFP9/roohOlUKsTWSLYxIRoICgwEaSg6D1TBGwuFKb6c0NzD/3qyWZQX4INf7D6
         tgXPOJAEJalF/3a1/Dqx/Nla7HAe5thRDMGv2RFUgNraRd2Shb8kowVsIZZiVUJyUURz
         IIgUIU6OYpbOGXV/OtBUmmZ265Briuk4il+axVsmdPlusT7uw7Jue/WeBvTKvfVt0psy
         BFzA6BQafR8dFGvugXB0UNXnOKtIiL5r2B/SRv6Wct0jjoJ08bAH6l/ULo8h97hyG5WB
         7oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sHrDsprJds6cxi1Elby+IOsOWvxeptJM+gDsUTq3BxE=;
        b=l0ButbbocmmIqT65moHglqay/ieJ1fwaNHPVi5+hPPaf8NOgOmJQVRWK48vv+9By6X
         YFhjdq+Z92v78g0FLgEzebcerWEIRrkXhQpJBvfFysiwYtY/v2MuNHHyPmnAR+elSXp/
         J1hIriYOEGnSK9/PdTGy2vf3abPbYQbXlE6XYzY5eINWo8nOjBtKsBOSy+3456UwukH9
         VZAWPSz5SIzKHYER2PlwfmDuOA+oted0+wqlyvu3SqLoBDCxWidHonrrVAOTSL0ztCZr
         wP5fyS/HC1rLBnkvZzFNtq9cWgLShzaq7MTFRoY9Fu9Gw7tMIQNiu6fefxx4zLxRIE0S
         b00w==
X-Gm-Message-State: AJaThX4PjeN9ik+7b6S8V45MdVSL4uaJVhi4OoSC8JqLHvLVLI3AcZd6
        uuogJhdr0GlOa9wKr3ZE68A=
X-Google-Smtp-Source: AGs4zMYf22F34K58MXlHT1ZyRYBBjEzgc9HMECrQIIqjpUrxiPL2hz2KAQeLrBYH5rn271FIZPB0HQ==
X-Received: by 10.36.120.11 with SMTP id p11mr4120667itc.10.1511303692373;
        Tue, 21 Nov 2017 14:34:52 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y198sm6123665iod.50.2017.11.21.14.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 14:34:51 -0800 (PST)
Date:   Tue, 21 Nov 2017 14:34:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
Message-ID: <20171121223449.GI3429@aiede.mtv.corp.google.com>
References: <20170724173601.19921-1-sbeller@google.com>
 <20170724180312.GE13924@aiede.mtv.corp.google.com>
 <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
 <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
>> Junio C Hamano <gitster@pobox.com> writes:

>>> Also, while I do agree with you that the problem exists, it is
>>> unclear why this patch is a solution and not a hack that sweeps a
>>> problem under the rug.
>>>
>>> It is unclear why this "silently detach HEAD without telling the
>>> user" is a better solution than erroring out, for example [*1*].
[...]
> So I took a step back and wrote about different proposals where
> we want to go long term. See below. This will help us
> figuring out how to approach this bug correctly.

Stefan, do you know what thread I should look at to find the current
state of this patch?  I've had it applied locally for a long time.

The thread I am replying to appears to be where the patch comes from
but I have some memories of more recent discussion that I'm not
finding.

More context:
https://public-inbox.org/git/xmqqshd8i3ze.fsf@gitster.mtv.corp.google.com/
says

 * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
  - Documentation/checkout: clarify submodule HEADs to be detached
  - recursive submodules: detach HEAD from new state

  "git checkout --recursive" may overwrite and rewind the history of
  the branch that happens to be checked out in submodule
  repositories, which might not be desirable.  Detach the HEAD but
  still allow the recursive checkout to succeed in such a case.

  Expecting a reroll.

Thanks,
Jonathan
