Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D761201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751992AbdF3R0k (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:26:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35301 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdF3R0j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:26:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so17724002pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hu7cgkqlrgA4ugCZPTLKynggfVs01a+cxo09dDN/vcM=;
        b=b3Ik8E7z9q6MoyJDIdctYvRvifagcaqAj77i+ssc70fBMN9PCmMHt4/lreGP0rh4ah
         etiH/kTklF+2fBHMSLR522hfJVLoNCVWs3qSso2u0q5OOUR31aHa7BBn03slBTiMBbHz
         8YwIfegfjDu+RByCwKpsM+2IRGcE4LfIML/h+0VOlBNxN5Q7E9TN933vdlUOCd2ZUOMf
         D4Vl9Q1HRFw7WeMpPHKQVTJokxVc57rCoq2LTa8NWukTWsXGm8oqce9F6J/DemhOMlMV
         MoY7vx9wLE6plS1n6PDskqNekfd5G7KFBQSYU+mPGVpATs+WV/UH7tWeQJfLcl/9e7OU
         +jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hu7cgkqlrgA4ugCZPTLKynggfVs01a+cxo09dDN/vcM=;
        b=uZywNhB0lJzzc59KTGYl7rSOocDBaS4nwQzoRbgc1zdmwXffmQXtswN0Iwz6m0YBRn
         bYCkOn6sFgwMu4AhE8Y4oMfeTFb0Exu2OM8mbHdBzxM/+zDxWlYauwT14e3zRvFlSr0V
         ftRP4sAeCgTnqQJIvsxRDx2yOULrKq7zTKJaWF6b1OKelrBOwQJ6VEzea+k7FZK7J/80
         U6SdhjU3XUPoIAFWWchxy5Bow/L5QGIX+MQpNUHjoVCIPNWxCVbCV4zAb9P/Ilhzir4a
         xgqTU2DOf9MTBKuApSo94/0bNjW4JNl14p16RnnuCtsDoqTUunWUYujpWnlBK/2WJUdP
         kQLQ==
X-Gm-Message-State: AKS2vOxoEK1LYtch8dlxiYHII6qqMpo/amtipVe31t2Hb/YNapSIOjfr
        t5GtFFoMtSZqhg==
X-Received: by 10.84.218.136 with SMTP id r8mr25518880pli.205.1498843598406;
        Fri, 30 Jun 2017 10:26:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id 5sm16457245pfe.60.2017.06.30.10.26.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:26:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629011334.11173-2-sbeller@google.com>
        <xmqqvaneu0qy.fsf@gitster.mtv.corp.google.com>
        <xmqqr2y2u0jq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaP3rDRNVQRk3_egZrY54Ra3eaOGCPpufp+y936=6kPQw@mail.gmail.com>
Date:   Fri, 30 Jun 2017 10:26:36 -0700
In-Reply-To: <CAGZ79kaP3rDRNVQRk3_egZrY54Ra3eaOGCPpufp+y936=6kPQw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 29 Jun 2017 11:20:51 -0700")
Message-ID: <xmqqshihs7xv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yes it was a last minute squash before sending it out, as the fix was only
> two lines whereas the conversion is a lot. If it were separated I could have
> claimed the introduction to be a rather mechanical patch, but I did not
> make use of coccinelle or such, so the likelihood for errors is just as high.
>
> So I decided to squash them.

I somehow think that logic leads to a suboptimal workflow.  If they
were separated, somebody else could have done an independent
mechanical conversion to verify the result matches yours, which
would give us more confidence.  When such an independent mechanical
conversion does not match, we need one round-trip to ask you if it
was a misconversion or a manual tweak.

In any case, I think I've looked at it long enough to be reasonably
OK with the conversion result myself, so let's move it forward.  Of
course I welcome independent eyeballing by others.

Thanks.
