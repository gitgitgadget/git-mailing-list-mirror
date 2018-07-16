Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABA8E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeGPUHk (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 16:07:40 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39456 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbeGPUHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 16:07:40 -0400
Received: by mail-yw0-f194.google.com with SMTP id r184-v6so9235317ywg.6
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xy2KsKM2lv4tNYeDBMi0fz5EbeqQCmQAv9DRpY66PY=;
        b=HUUOA2CQgxBdXWdPKafVlC+rwa5TGTlgGBEt+jK8+QV8LjCH13ZvygrYv4QlPqONwu
         IaYRCIkBc078nqX6KwnGPZxhH+IGP8YQXsjQ7CXhSh8ylCIfjv54KoUx892oy9QM4O3/
         jdivN2ZMWcefT06jvo6xvHqPd0wLdUIZ8kHmPiVqQ8tKHA22ba2Vjorp3L+YD7sNqUwv
         CdWTCzsGLtou+A4PY+YtcXPS/G7VWnwxuK4BjkUu0V4BUzW3CiZTw3fVwK0DPPohfGAM
         zgoKJpR+ggMUTv5T1/EM95H0UV9CFWkWIFVcTzEuM//+wZ83c2a+8xr8uLLMUlYKHrSu
         YsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xy2KsKM2lv4tNYeDBMi0fz5EbeqQCmQAv9DRpY66PY=;
        b=V3VZ1cPfry2Omr4w5gePZV/vYqRbzMteBTagG43+SHAQ804T13KRiFDEdJoAfAjabE
         NsickcOYYrSFgAvsbpayQzxN69gmij3GFKGnhhn885edKwtWwmNdaj0Omw7PG4MoJcfX
         Q0d82DDSzneHLw5VCN+q/BWvRPL3We6wleJir0TgEo7z5IFmyfOfd3ix5u6qHIj2nWOs
         eBHZRU4Mu//XFN93ZvEUlQnjZtSx7Q6FVCKD65Oqg0MuJ0Bup3Zsfv7+XrOEhaxRMjEU
         rj93YpBS196VvgdfueFk10Ur6d78NZX9DmoAgjLOCeZCOE2vdrmhjsAcpXyp7QgSGdog
         5W8Q==
X-Gm-Message-State: AOUpUlEtNr67/vI9Uw26m8C8RMT+TjhXBgElqHNeDx1APNi6ufaAfSsf
        0daIRvjFlnasK43rFY0q4S7NCC/vnv6hGMCOu8CN2Q==
X-Google-Smtp-Source: AAOMgpfqMQOPOKIWbKJTkHA8oFTKsQn8Rl7NwVSA4y/FYJHdW23xzxet2ryyoVKyrHEQw9Jeie3ACIKYJIakq2xbIJs=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr6824804ywh.238.1531769927092;
 Mon, 16 Jul 2018 12:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <74b7352b580ae920d9d5f206b9389e207aada4fe.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <74b7352b580ae920d9d5f206b9389e207aada4fe.1531746010.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 12:38:36 -0700
Message-ID: <CAGZ79kZVyd1BgWGW85PxF_4Skv4pEB=a5iH_1i=5B6X07cfyoA@mail.gmail.com>
Subject: Re: [PATCH 06/16] upload-pack: generalize commit date cutoff
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The ok_to_give_up() method uses the commit date as a cutoff to avoid
> walking the entire reachble set of commits. Before moving the
> reachable() method to commit-reach.c, pull out the dependence on the
> global constant 'oldest_have' with a 'min_commit_date' parameter.


  'oldest_have' seems to be used in only one method after that
  (function got_oid); but as that function is called many times
  we either have to make it a function-global or pass around as a parameter,
  we'll defer that to later.

Code (of all previous patches and this one) look good!
Thanks,
Stefan
