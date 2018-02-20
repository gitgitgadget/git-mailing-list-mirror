Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A4D71F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBTTAP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:00:15 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:43211 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbeBTTAN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:00:13 -0500
Received: by mail-pl0-f52.google.com with SMTP id f20so1014362plr.10
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0xLbpkpOS/W0Jq1qMKwqY95eB7i9H+S4NJZj5YAHWY=;
        b=P97aOfcq7dclsMLGDqX+X1RXXJXBI/dQqnElWDWw7+VcpW4mF16R5PZ9UmPchBzKiR
         9+cPuq/92tpf+4fJTKj2KcNmo9qdWgoSG62y9LMvFYrsV7yLNc3/g5iz3GmqMeBpkHsO
         /4oy871HJqFsaeBnrOqrGFdzygomtAFqkvQSsEXvuwGS5v9a75eTvJrMTQMQB7pqWU1N
         f30vrT6Mcnp0hr5UrpDH0np1Rph0nnKltiRVXKTdZ+NBSPHuqLSmHvCXfzPGBGFQzqBm
         7RfoxhrQo93uF7kYf3y0M0R14XT8kBwlKY8vZuXxFWdVGev5vF7dtcMtngdKVZesmrUB
         Vl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0xLbpkpOS/W0Jq1qMKwqY95eB7i9H+S4NJZj5YAHWY=;
        b=mVMYpbc7xPxgokAT0P+3QqcelaSxgMZxTdUa7btbf7150zCm+vRDdKi6M3EeBpGnYT
         8OpG1dYZEz3yCvmT4LQqi3h1Lal6mZ1r4/eSgb2bwGgCMuWMFH9wbAHl631ShPV6nhDC
         LiVDXzU+l7zI0saYFf1Sg6bRT5F3NqTex5AVyJLX8BEOg1t6WLiO5WNsNqrWRGHAFsv+
         8uIQZOx7fkthnFJvqZpiCRE+lwH/DNiJ64wHkWAjq7DwEXUfIylJfh87JsV0Rpy2shZO
         Kvgvz2zM2WhCOQHpwLK5pcbRyc9dtnh0tokJ0VYijRulf9lNZcikYE0RNSWTpr1C40c8
         ueNw==
X-Gm-Message-State: APf1xPDKNhsPE8VQXbI0PqnQwBfXQu5s+KLaCOjqtlJ/MFCcOzoBioGZ
        A/cNKCfUWZwT18BUg2AsNNIivg==
X-Google-Smtp-Source: AH8x2262hWlFhmQHNOirGS7pMK7Cz25mKcSJlAE65s1bvp1VJhGVM6hDd5F8HpuXIp8vFmWc9RLIkw==
X-Received: by 2002:a17:902:3124:: with SMTP id w33-v6mr561309plb.356.1519153212023;
        Tue, 20 Feb 2018 11:00:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p125sm10603410pfp.43.2018.02.20.11.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:00:11 -0800 (PST)
Date:   Tue, 20 Feb 2018 11:00:09 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
Message-ID: <20180220190009.GA201604@google.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
 <20180216174626.24677-1-sbeller@google.com>
 <20180216223404.GD216564@aiede.svl.corp.google.com>
 <CAGZ79kafB8JZ0hz4ZbjSpkA2j2AOWjFjoxcQ3e9KcovLp1tzxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kafB8JZ0hz4ZbjSpkA2j2AOWjFjoxcQ3e9KcovLp1tzxw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Stefan Beller wrote:
> On Fri, Feb 16, 2018 at 2:34 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> > Hi,
> >
> > Stefan Beller wrote:
> >
> >> v2:
> >> * duplicated the 'ignore_env' bit into the object store as well
> >> * the #define trick no longer works as we do not have a "the_objectstore" global,
> >>   which means there is just one patch per function that is converted.
> >>   As this follows the same structure of the previous series, I am still confident
> >>   there is no hidden dependencies to globals outside the object store in these
> >>   converted functions.
> >> * rebased on top of current master, resolving the merge conflicts.
> >>   I think I used the list.h APIs right, but please double check.
> >
> > For what it's worth, I think I prefer v1.  I put some comments on why
> > on patch 0 of v1 and would be interested in your thoughts on them
> > (e.g. as a reply to that).  I also think that even if we want to
> > switch to a style that passes around object_store separately from
> > repository, it is easier to do the migration in two steps: first get
> > rid of hidden dependencies on the_repository, then do the (simpler)
> > automatic migration from
> >
> >  f(the_repository)
> >
> > to
> >
> >  f(the_repository->object_store)
> >
> > *afterwards*.
> >
> > Thoughts?
> 
> I would prefer to not spend more time on these conversions.
> If Duy and you would come to a conclusion to either pick this
> or the previous version I would be happy.
> 
> I do not see the benefit in splitting up the series even further and
> do this multistep f(repo) -> f(object store), as the cost in potential
> merge conflicts is too high. Note that brian just sent another object
> id conversion series, also touching sha1_file.c, which I am sure will
> produce merge conflicts for Junio.
> 
> For the next part 2 and onwards I'd be happy to take either this
> strategy or Duys strategy as requested.

I think Jonathan is trying to point out that converting to f(repo) maybe
easier than converting to f(repo->object_store) upfront which would make
it easier to write the patches (which most of them are already written)
and to review because you can use the #define trick to make some sort of
guarantees.

After we have successfully completed the migration to f(repo), then we
can revisit the subsystems which want to have a clearer abstraction
layer and make the jump to f(repo->object_store).

-- 
Brandon Williams
