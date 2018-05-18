Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31C51F51C
	for <e@80x24.org>; Fri, 18 May 2018 02:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbeERCQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 22:16:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40397 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbeERCQL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 22:16:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id j5-v6so12272963wme.5
        for <git@vger.kernel.org>; Thu, 17 May 2018 19:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rjeJ0vEdwvhReUVeC8CUSaiqvwq1XM0e95kb4Bfo1Hw=;
        b=aAzfsXmaL83CPhghn4hkG6aLijkGIzCJFXEBpQaSRrXPQerrrY7BaBv7K2hmTt+DhV
         W/EyJ9n+tSOTeMv+2/kBvDamK76K3MFRERpY4jA+3TeGD0Sci54kuNbUbcOKEeBK1fxB
         a4bfeE/rxs5u+gP8sfQl4t3I83OMLpkRSQWWMX/2oiwspF9JHqtkMc48jmSFPicYiLlS
         ujzEU5O/iAVe0A0JaYABlXo8MzqpmxsaJhEQhpp6S/EBK4jV0DPl0VBF8EoBXwaHploO
         qgWobo1IoFjutjVFstxaosdSvPv5VEZfhTtt0gGmE+rwNBCHrOwsD/G1goiywwWeF/qC
         LBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rjeJ0vEdwvhReUVeC8CUSaiqvwq1XM0e95kb4Bfo1Hw=;
        b=GRcB0vrnbaCtchGDzkLUjtH+83l5nHtHZRB52r+5NyopsceTSSr5z78u96yT4mURNp
         by2oAg/E2ybHDtwnpvfV6quEsjrE4Yquqj1tpvqF++NqKgN7p9a+tMSiK2++nPVNn5gc
         yGESxYy/WhUlkCyjDHRPBaxdP+6FZnXLfpSq3uMWBgv04/cTfv9i5bUOKObarRdfG/5q
         aCDU6cYIeeaVpmPBHYPxjeZQu1wQV2aktZREUBoK8SFeLtR7eYzNs1uM66BDWsmXU8Hm
         Z+W0UvYQlP+CPhZSC+kEZiktGAHnuAawuGGDgtg0jbvS7jzcgTKy99Y4U4ofy3ffLE8b
         Zf+g==
X-Gm-Message-State: ALKqPwcpyo+72sakiHdOvuGWF03NhBXgsb3wkpM9kvoiTKev6AS71C0i
        5OGczrBvZOBYFimMzLaggZg=
X-Google-Smtp-Source: AB8JxZrFI64FjrWFpcDgu90c4ehHkqsid5SFNhFknlIOtIY02F4KFOwJExHQRluJ7kHM2mX3F1AZsA==
X-Received: by 2002:a1c:ee95:: with SMTP id j21-v6mr3218746wmi.16.1526609770593;
        Thu, 17 May 2018 19:16:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 12-v6sm10658926wmn.27.2018.05.17.19.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 19:16:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 13/14] merge: use commit-slab in merge remote desc instead of commit->util
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-14-pclouds@gmail.com>
Date:   Fri, 18 May 2018 11:16:09 +0900
In-Reply-To: <20180513055208.17952-14-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:52:07 +0200")
Message-ID: <xmqqtvr54sk6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/commit.c b/commit.c
> index 57049118a5..8202067cd5 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1574,13 +1574,21 @@ int commit_tree_extended(const char *msg, size_t msg_len,
>  	return result;
>  }
>  
> +define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
> +struct merge_desc_slab merge_desc_slab = COMMIT_SLAB_INIT(1, merge_desc_slab);

s/^/static /; otherwise sparse would complain?

