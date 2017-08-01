Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D94462047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdHASTc (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:19:32 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:37174 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdHASTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:19:30 -0400
Received: by mail-vk0-f48.google.com with SMTP id r199so9395196vke.4
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=myitcv.io; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KKs4ULJuuxyKVtv2gnkGgZcxXut2SxKXOXu6cRYVWdY=;
        b=RgCByzyyTOsOc0oBqqlxAGoetchb6vVPsSw2h4hjieDaJjUOUN3//WOzQXZUq99Q77
         two+cYmcFWCWA6L/jPPgq4z07Vhmr5Y2/Xet1Xl5Gly+HQCmkBx/phFljh515/VjWep9
         vIArVsDJMnnlIWfiLJCmQtNTK056QilDgZ/k+0WCM0nimwVquIVBlSoTQGH5fAOpuivM
         SvYaMH2kNplFx3iwaXJMhM51JV6CBch75pecKJtezyjxoqEj4rX3oa/ZDdNlqor0M3hV
         p0BTx5ktuiy/HG7mTQmpWnq0DA1vYA/B8Bs9FVurqMfnXahBRKo36GUK/ZgM5j3snreW
         by+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KKs4ULJuuxyKVtv2gnkGgZcxXut2SxKXOXu6cRYVWdY=;
        b=t2sJPhSd1o07j22G6G0uvoD2erR6VsANSVJWvENqDWky6HkLSrVIstCNs1M7FWy+Ae
         tpBkV6syjgzGf345ZmCL7eR4mWqaaKvDgeWMtLsCwoAqQafSeyZGPb7+qvW5Wqscx4Pp
         vPPAaLNPD0I6usNYr6PZCyh+m2ETxIMKAP+BC0fKXwoW5xOtmCozE8H8lRpv0LOB61HB
         eB1BQklWPcQHVUVRFplE90/SNOi4XGKOtlcL+SpWZzwMRc0jBH1BWqACkru3Bf6gcaCo
         JrKIoJCFS7MxGDmnsAUoao8bQPNVeqKWzcNM6xOIs0P6P0hPnbO7y63BtSFPXDKHHVxO
         Butg==
X-Gm-Message-State: AIVw112c58fXNHKie/awUouN4XaQCBrLkhYC2dSdiycDG/8a/KSK7AgA
        DEWlliI5aot/5ATYBFB0uHN3YO7zuaLVKjQkxQ==
X-Received: by 10.31.142.85 with SMTP id q82mr6238113vkd.89.1501611569608;
 Tue, 01 Aug 2017 11:19:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.16.234 with HTTP; Tue, 1 Aug 2017 11:19:29 -0700 (PDT)
In-Reply-To: <20170801181820.GA110646@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com> <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com> <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
 <20170512181950.GE98586@google.com> <CACoUkn7i76dEsQa3eoN+7WR8QmsD1pWsRQ0dvhkxzFN0sxTmRQ@mail.gmail.com>
 <20170801181820.GA110646@google.com>
From:   Paul Jolly <paul@myitcv.io>
Date:   Tue, 1 Aug 2017 19:19:29 +0100
Message-ID: <CACoUkn46an6rStWhhJfgP-vbRU_+898S-TgDcefN3zL-jyDFJQ@mail.gmail.com>
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It looks like it was merged to master.  This should be the relevant
> commit: 188dce131 (ls-files: use repository object, 2017-06-22).

I was just typing a response to my response. Apologies, I was testing
locally with the wrong compiled version of git.

Confirmed fixed for me in e2d9c4613 at least.

Thanks again
