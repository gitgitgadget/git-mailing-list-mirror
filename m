Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 544A320281
	for <e@80x24.org>; Thu, 29 Jun 2017 18:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbdF2SUy (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 14:20:54 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34639 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbdF2SUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 14:20:52 -0400
Received: by mail-pg0-f52.google.com with SMTP id t186so51953148pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=owvMcGQ7+l0V6wOu4hAVjERIBhdSCXG4VGfgSIA3kGc=;
        b=EwIZUwKXlLmt7q94TxK4BwMi+C4wXYCyacKPyY04yNyDAuqG24g44o8wQBArTBxz+m
         EY0jEDpV4oWF2kPaHsodEZsgBnpAqYo7xqPcqXOjtwAl0Yj1Xpa9FvWrBXLlAcNt4VIS
         mbiN1ZhPt3fplc/nsMgaePO6+4uW9hxltQUygoPwlFa7NBdDKy9rnZ1JLzo6jyBb6Ekx
         DPXnKfDad1gLzAmkqTdViQxVUTL2GQf605rJTMnXEV+nQYZQ50MIHNcAvbJb0Q9PRXb+
         KEhdlnkPVu9u1SUfm0Facwd5uqe+ygTHRz8L1uid72NUWfx53x6ayIe7kKXjXjcY08Xd
         ob/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=owvMcGQ7+l0V6wOu4hAVjERIBhdSCXG4VGfgSIA3kGc=;
        b=qjQKxJv0aDiryIsR/KyxDRNzyJxrzwSz4n7CSZXC/KF1XMM3/gO4AS6Y4Puv8p+FTA
         rX2MjSLjP2myDPudfa9OKrYkHV+oxiUpjo+P0ItKD08Tcww/CqrmfKyWFzdwzm9cWPt1
         HW9MuIm/GXAdwoM4MsnwkAlsSCiV63yD2VlYmBbUPWSmMk35Qwe/2biNyDXO/UyVB28u
         Amn8qiSEsqUgyax6qVk6tsDnB+LhruZELlYSDMV11dO/8+P7sdvGtCZhBCwB4+LCTL84
         sXD3cjMPV2ywUuF/i4nCeyCcsMpa+1l4ey7lIsU559SU1YIkA97ykDAroe5kW9szTlXj
         wlVQ==
X-Gm-Message-State: AKS2vOxcGRxlyk7QahoRta2kwrcV464kuFe6C/+Pmv2rSddE2Mg0nKBO
        8RKADI+gRdFfq1Ekf1fMKGNrcavoahv3
X-Received: by 10.84.191.131 with SMTP id a3mr19711673pld.279.1498760451951;
 Thu, 29 Jun 2017 11:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 11:20:51 -0700 (PDT)
In-Reply-To: <xmqqr2y2u0jq.fsf@gitster.mtv.corp.google.com>
References: <20170629011334.11173-1-sbeller@google.com> <20170629011334.11173-2-sbeller@google.com>
 <xmqqvaneu0qy.fsf@gitster.mtv.corp.google.com> <xmqqr2y2u0jq.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 11:20:51 -0700
Message-ID: <CAGZ79kaP3rDRNVQRk3_egZrY54Ra3eaOGCPpufp+y936=6kPQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] hashmap.h: compare function has access to a data field
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2017 at 11:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't looked at the use of keydata in patch-ids.c and friends to
>> decide if that "abuse" claim is correct; if it were the case, should
>> we expect that a follow-up patch to clean up the existing mess by
>> using the new mechanism?  Or does fixing the "abuse" take another
>> mechanism that is different from this one?
>
> I see that you corrected patch-ids.c "while at it".  That may make
> it harder to revert only that "while at it", I suspect.
>
> Thanks.

Yes it was a last minute squash before sending it out, as the fix was only
two lines whereas the conversion is a lot. If it were separated I could have
claimed the introduction to be a rather mechanical patch, but I did not
make use of coccinelle or such, so the likelihood for errors is just as high.

So I decided to squash them.

Thanks,
Stefan
