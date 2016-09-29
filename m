Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF04620987
	for <e@80x24.org>; Thu, 29 Sep 2016 14:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934199AbcI2OiT (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 10:38:19 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36620 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbcI2Ogd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 10:36:33 -0400
Received: by mail-pa0-f65.google.com with SMTP id cd13so1701447pac.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=gnlMg+7Dn9RpVB8kYYMIMTM50lU+DDvIQ1Vue53w48Y=;
        b=rGYjwd+XysduM2wWeQLdCWTn6wckSPnhXrrftU+dt/+oT/OfQ+z/2JDGw/BWYwmhvt
         kQyrMZLO666yBao8tVKqvDhmAn1jHxNrVZNFxqHqPHp+UVoILJfIP2N/djOFPit9Pn2R
         d3KdnzfMnhm89p4cMq9xc3E1rFjZ37SqNoQcjscFTtOf56trXmw2KGRrmXDbBEh45cX1
         HxC8cgJFRv3VRBdJ29Bak9mmXqk2k7vWZg2MX7tmFIAXB4uY/ESzutsF6JJTP8bzqzlb
         YiKfvWnoaGOjaZflXanmfInYoxNRwuLl19TLZWokY8O3wHs8uTZmpJry20L9K3noOa1z
         1C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=gnlMg+7Dn9RpVB8kYYMIMTM50lU+DDvIQ1Vue53w48Y=;
        b=XX0kxP/QfTMeA50vItz+7guq0VqZkP/Mqxca3K5h9jNe3PlsLDYXvduQy81YSnDgdV
         a2MxC2Y9J3HB6f9A+R/duDX6h3jL0OOEOyZbbJeacF7ggP4d3YgrLC89MgV2SxSaFfzA
         B8jNwRwh4fx4rAdq2rBM05qOjlPHNGlb5TEDTpr6AsP0YjmA1GtX32Jv7EOBRf+nBjZ4
         vfj2/I160eM+4DQfmuCLi7TaLcasHBiAISLQ/lFAHnW2KoNcgW1qrYGq5jUz87mJHNW5
         KRKvbeH0QkMjHxqZqSH/bsvgTSiuj+A+Cdkk42ZP2jiDbYK0abz6KvAhyAAJ+fmY4E8M
         7xPA==
X-Gm-Message-State: AA6/9RnPTyU5rLJcDpWgu6hJ7NM/duUdyGqC1h8jZ//GpRYZGMDfXXogQ82k1w4oENE8FA==
X-Received: by 10.66.199.38 with SMTP id jh6mr2961071pac.160.1475159790619;
        Thu, 29 Sep 2016 07:36:30 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::223:12ff:fe05:eebd? ([2002:46b5:ad14:0:223:12ff:fe05:eebd])
        by smtp.gmail.com with ESMTPSA id t16sm20885108pfj.76.2016.09.29.07.36.29
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 07:36:30 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Jeff King <peff@peff.net>
In-Reply-To: <20160929132425.of7m5t4tsqcb6bbk@sigill.intra.peff.net>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net> <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net> <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com> <841D4FC2-9673-486A-8D94-8967188CCC60@gmail.com> <20160929132425.of7m5t4tsqcb6bbk@sigill.intra.peff.net>
Message-Id: <2FECD796-7B92-41BB-A0AF-57650FF7E78D@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Thu, 29 Sep 2016 07:36:27 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 29, 2016, at 06:24, Jeff King wrote:

>> If you are doing "git show 235234" it should pick the tag (if it  
>> peels to a
>> committish) because Git has already set a precedent of preferring  
>> tags over
>> commits when it disambiguates ref names and otherwise pick the  
>> commit.
>
> I'm not convinced that picking the tag is actually helpful in this  
> case;
> I agree with Linus that feeding something to "git show" almost always
> wants to choose the commit.

Since "git show" peels tags you end up seeing the commit it refers to  
(assuming it's a committish tag).

> I also don't think tag ambiguity in short sha1s is all that  
> interesting.

The Linux repository has this:

    901069c:
       901069c71415a76d commit iwlagn: change Copyright to 2011
       901069c5c5b15532 tag    (v2.6.38-rc4) Linux 2.6.38-rc4

Since that tag peels to a commit, it seems like it would be incorrect  
to pick the commit over the tag when you're looking for a committish.

Either 901069c should resolve to the tag (which gets peeled to the  
commit) or it should error out with the hint messages.

The Git repository has this:

    c512b03:
       c512b035556eff4d commit Merge branch 'rc/maint-reflog-msg-for- 
forced
       c512b0344196931a tag    (v0.99.9a) GIT 0.99.9a

So perhaps it's a little bit more interesting than it first appears.  :)

--Kyle
