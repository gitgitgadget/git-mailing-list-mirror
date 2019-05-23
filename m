Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A6B1F462
	for <e@80x24.org>; Thu, 23 May 2019 20:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfEWUzA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:55:00 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39044 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387529AbfEWUzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:55:00 -0400
Received: by mail-pl1-f182.google.com with SMTP id g9so3218011plm.6
        for <git@vger.kernel.org>; Thu, 23 May 2019 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sXxo9auSqvY4gK+o3RrQtLtyD43p9Wkn8zIalMwg+AM=;
        b=OFEvyreWaiDbBCdEYYxfOLmFU5/hi549n96/G3vghsZnqBexSAiIJJXO+gPB/G5pWK
         RggNZFa+2/iq7Ou0wm5hEyrqzaKieBMVw93X5e+5O9/IDr9fd+4obOD0ewmo1ZJF2g31
         ZGgC2Avo5foQA1CqsEqNAIllXFfu7AfiKo97jbwGl8ePcd6tRWPeru8s/AixFCXlzJd8
         XZV7VUwuu2FX7hAXvvWq/nOf4wf/KB0v6i7RMTfRMR6rIN2xNzvKV34fzaH9id9Rw7Tp
         EESq2+fJz5feWsN4EBJh1IJ14uTj4v4dBuAbNx1H4RV+HRW/Yi6bEYDe7y7JQvNSXDRP
         QQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sXxo9auSqvY4gK+o3RrQtLtyD43p9Wkn8zIalMwg+AM=;
        b=lFapS2Lka1iW3oQ6urm7YgQpOHOBl4BCs+mAVyv+60MlOlRbfR8qjxDynfC2Y0wmY8
         GK/TMJF30Ovw4m2YdGclTvXc6pnfdeWwuSuM3PAm7Mu04FrvU0cAthHfNC3HTXAD3SgU
         3q6ASA88aNc6nGDuY8F4RKR/500NeEFPRVdYJOyb3B3O7YQNt38L+oPQDyE20Rdb8yQN
         35YWuSgt+Q7enLLWh9hppHwhz1jN/podwO0NkL4PMdzHtLIaz/yDcyGofsAckPts/G5E
         moe9Z8GRbtjeXPpEG5gti5oh9FVrmq2qCzoIm8KYsCJyEJ2v9N00/3NHw7MhyLvBL3YS
         G3Ew==
X-Gm-Message-State: APjAAAXgK9akXJ5sukQtwZqQYmC3prSWO+IK6HoLu3kA9X+QsT+WALxA
        eVUPUy/yr2oyNtpprNSQpJQ=
X-Google-Smtp-Source: APXvYqwnqrqKX3fJhys74MnwcFihfUl0q6DKIR02nr69Ac+J4t70FsRljVjA/wkdY1AVxgPLH4/+3Q==
X-Received: by 2002:a17:902:f085:: with SMTP id go5mr91377984plb.53.1558644899306;
        Thu, 23 May 2019 13:54:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c129sm306785pfg.178.2019.05.23.13.54.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 13:54:58 -0700 (PDT)
Date:   Thu, 23 May 2019 13:54:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190523205457.GC70860@google.com>
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <86h89lq96v.fsf@gmail.com>
 <20190523205009.GA69096@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523205009.GA69096@thyrsus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric S. Raymond wrote:
> Jakub Narebski <jnareb@gmail.com>:

>> Currently Git makes use of the fact that SHA-1 and SHA-256 identifiers
>> are of different lengths to distinguish them (see section "Meaning of
>> signatures") in Documentation/technical/hash-function-transition.txt
>
> That's the obvious hack.  As a future-proofing issue, though, I think
> it would be unwise to count on all future hashes being of distinguishable
> lengths.

We're not counting on that.  As discussed in that section, future
hashes can change the format.

[...]
>> All right.  Looks sensible on first glance.
>
> I am very relieved to hear that. My view of git is outside-in; I was quite
> worried I might have missed some crucial issue.

Honestly, I do think you have missed some fundamental issues.
https://public-inbox.org/git/ab3222ab-9121-9534-1472-fac790bf08a4@gmail.com/
discusses this further.

Regards,
Jonathan
