Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687A9C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4951461159
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 11:17:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFDLTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 07:19:05 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:41545 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhFDLTF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 07:19:05 -0400
Received: by mail-pf1-f178.google.com with SMTP id x73so7215073pfc.8
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Ngq1fWBPAMuEWEiWcO9RTUNqkEDWIWAWGMX+7/zUJI=;
        b=tT0zIgd585HmX/102ed4nDh+wya9jm/y3ubxUZukTLd+Vi8OaI1T2AIL4JzMrHt/Lt
         blsIJK29C2LHnGKqT17ZAJ27MAwl1Z7gB37dvRzP3mbTsacrb/bt96ThoW033tVnc5LA
         V+0M7/YSoSO/5ycgk+TnJCbdBqUsUUX8FWmnGwDLz5VBN46ZuaAvyDEEkN9MqNJP04hb
         k+Ck2BnJIktIBB/WD4UBhsjh5L5weKlbX35bzSSp/WaY+SBQubsJw5Va4w7pAnsYhN5H
         brHNz7Vvn0YSSiSs275Q7XJtVU5t/gB10MXy4Qv8froX07MTnXH2eXOMkB4G0FcyVTZF
         sXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Ngq1fWBPAMuEWEiWcO9RTUNqkEDWIWAWGMX+7/zUJI=;
        b=SbZiZGwFtkGYVgzVtyPdvD4gWiD4IPGO9E8JZH5bU6/zlTZ73dHLvM37Y0zPa6JHlZ
         QEwUbCP+ft8iPFfko6/A/FjSFRlB7rk9AGgpKZfIg2rmeDuKxkn9sCeo5oBLbASN5odT
         koRMB310YOuTi97yjPRPxm2xg5MGUBw/m4GY0CPoe2Uhlz5TyhUZAPDGPqc3eXGhFpxV
         B5gKwBkV3MERI8z18LQPjLK4dRu27gCvZP7l97AGsDwl0wwh6U7/L8HZOFz3McUIBoVj
         HIDEn+rKlM26cEsGer319wkrQSMD3LvoQcC1HtJGBYvvk/Pj5S7V2ZYB+FzJldnnRRu3
         PihQ==
X-Gm-Message-State: AOAM533c46FGem/Qlv4QmoBiFhpHurOuKv5v/PtlyTuJaKcdARXsubNt
        norgs0ICMHNNckm9uyk+EadKjel0lyZV6Oj3
X-Google-Smtp-Source: ABdhPJwyJaFrMdRZFAagl8hFRYleXuGfwbpzUgCEUZ4rrCJV+97g/34sTXkJO9+v+5JNeZLAIIRu2A==
X-Received: by 2002:aa7:80d3:0:b029:28e:f117:4961 with SMTP id a19-20020aa780d30000b029028ef1174961mr3911049pfn.37.1622805370205;
        Fri, 04 Jun 2021 04:16:10 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id k1sm1582633pfa.30.2021.06.04.04.16.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jun 2021 04:16:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3] [GSoC] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <20210604110524.84326-1-raykar.ath@gmail.com>
Date:   Fri, 4 Jun 2021 16:46:06 +0530
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <97DA3479-7E78-4EC8-BBD0-72869803E9D0@gmail.com>
References: <11A04D37-41CB-43D7-B237-3BFA10B1313A@gmail.com>
 <20210604110524.84326-1-raykar.ath@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-Jun-2021, at 16:35, Atharva Raykar <raykar.ath@gmail.com> wrote:
>=20
> Let's add a new "add-clone" subcommand to `git submodule--helper` with
> the goal of converting part of the shell code in git-submodule.sh
> related to `git submodule add` into C code. This new subcommand clones
> the repository that is to be added, and checks out to the appropriate
> branch.
>=20
> This is meant to be a faithful conversion that leaves the behaviour of
> 'submodule add' unchanged. The only minor change is that if a =
submodule name has
> been supplied with a name that clashes with a local submodule, the =
message shown
> to the user ("A git directory for 'foo' is found locally...") is =
prepended with
> "error" for clarity.
>=20
> This is part of a series of changes that will result in all of =
'submodule add'
> being converted to C.
>=20
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>=20
> Changes since v2:
> * Remove printf debug statement that was accidentally inserted into =
the final
>   patch
> * Rename 'struct add_data info' to the more descriptive
>   'struct add_data add_data'
> * Remove unnecessary variables while parsing flags, and insert into =
the struct
>   members directly
> * Eliminate extra heap allocation via 'xstrndup()' in parse_token()
>   (I learnt this trick from Junio's comment on Shourya's v2 review of =
a similar
>   patch :^) )

I forgot to mention, but this patch can be fetched via GitHub from:

=
https://github.com/tfidfwastaken/git/tree/submodule-add-in-c-add-clone-v3=
