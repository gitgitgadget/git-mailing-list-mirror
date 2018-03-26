Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDA31F404
	for <e@80x24.org>; Mon, 26 Mar 2018 02:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeCZCF0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 22:05:26 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:42860 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbeCZCFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 22:05:25 -0400
Received: by mail-wr0-f171.google.com with SMTP id s18so17245126wrg.9
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zNsb3tnVIu+ZjGUwGfAToAQzj8weYLtcDNHcSvatlco=;
        b=QrvP2zmN6UgeV78AG5xyvTVdJTNg43a6ie1cNIlrWNfmCXx8o8aBLPlII5mFXaB/BR
         XgGXNzYCBSxurVgaHLevojF958BMNWHqM9Ikzur/knmLh5TYaVjCw8SCb73uGMxnyuvi
         Deb5q1TaxZxs2qstM0v9Chihw3otYYloAi2G0df68JFNGCUbdADZkY2od9wiOJw4THjR
         ZTa7g7vvys1UNmVB2/lfTcVR1a/NA7u2jpRxLKFu+Kt0cRG6kjeqRRtuIkpHlLA5tkD3
         bNSr34BsP/WvX1jKClRCOAtI5FXONaCcf1OV4250FEYaXq3OrVhM8spIJeK22JO2yp+R
         E8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zNsb3tnVIu+ZjGUwGfAToAQzj8weYLtcDNHcSvatlco=;
        b=mO6oZE3y54Fox6EjN1KhKmC0jA8DAG4IC0jYZINFOdZfrHaj6D1JCe1Zj6Oj6qaiwH
         eZY7BRUsX1NOFEbnopVdrK2b0Ti0FtVkUvEeAGIASy49jDZk8obLFdzSLWFo+OZaIrwW
         /l+5OhVCu5dgk0JMiBodFRPjJZQgpzXYk6gcrmCNkjVbsMF9r/3NBtQRGKVVx+OIyPwT
         PpXjd2G4tbAnnGFEdCoMJzbydPhX0i/zcnez6m06dl5ss40+jT39Pf+7UhoPKiDoejOy
         6WXJ3UMEv+YWIdUjjtjXOVOGxdRLlcTkMS9yXTZyUMJmL6VV+MZ5shX5G0EJ9fizWlx3
         F26w==
X-Gm-Message-State: AElRT7GmnPH2jAk5esDa0RVjnmAgZ+Umcvz4VpkR3570j//aW55fVOV2
        n2ZMsyEMn357DDRI+wKnoqc=
X-Google-Smtp-Source: AG47ELvsk3ZnDcnu4O3DAQc/AxGgDZoM3hwyJejdGSsVw01g6axuFsJM2Ky2OlO9FCjdNtJhwT58PA==
X-Received: by 10.223.150.161 with SMTP id u30mr28395616wrb.151.1522029923538;
        Sun, 25 Mar 2018 19:05:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q90sm19600173wrb.6.2018.03.25.19.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 19:05:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v4 3/7] gc: add --keep-largest-pack option
References: <20180317075421.22032-1-pclouds@gmail.com>
        <20180324074308.18934-1-pclouds@gmail.com>
        <20180324074308.18934-6-pclouds@gmail.com>
        <87fu4pyfvr.fsf@evledraar.gmail.com>
        <CACsJy8CvgAHcB6uKgN=aULST0CkmPeCXLZcM_LZcXv9S9rEWPg@mail.gmail.com>
Date:   Sun, 25 Mar 2018 19:05:21 -0700
In-Reply-To: <CACsJy8CvgAHcB6uKgN=aULST0CkmPeCXLZcM_LZcXv9S9rEWPg@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 24 Mar 2018 13:13:41 +0100")
Message-ID: <xmqqh8p3egm6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> This conflicts with master because of your own 7e1eeaa431 ("completion:
>> use __gitcomp_builtin in _git_gc", 2018-02-09). I pushed out a
>> avar-pclouds/gc-auto-keep-base-pack branch to github.com/avar/git which
>> resolves it as:
>>
>>     @@ -365,6 +393,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>>                     OPT_BOOL_F(0, "force", &force,
>>                                N_("force running gc even if there may be another gc running"),
>>                                PARSE_OPT_NOCOMPLETE),
>>     +               OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
>>     +                        N_("repack all other packs except the largest pack")),
>>                     OPT_END()
>>             };
>>
>> I assume that's the intention here.
>
> Yeah, I want  to keep the same base for easy interdiff. There are
> worse conflicts are with the other series I'm helping Stefan.

Right now there are a couple of topics that wants to touch options
array and also the builtins command table, which are both good
examples of "central registry" that everybody needs to touch and are
bound to become a source of conflict.  Until I scream (and I try
hard not to have to), contributors should not have to worry too much
about causing conflicts---being traffic cop and directing orderly
integration of these topics is what the maintainer(s) do.

Thanks.
