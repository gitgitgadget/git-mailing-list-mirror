Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FED81F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbfAVXxR (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:53:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42124 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfAVXxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:53:16 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so159035pga.9
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3bYLDA1A50stGzomTojRUULibtFhE9b3THX6KD91awo=;
        b=YVvVO0uQ/UagkdFZUuTm8Ruk4XppALCbqLU45TflL7g/8n1u04/In2ssRbEpJozBla
         vZrNA3C4+gYpLthMwy5ml1LooUOJXbpoAK5X9Q4tOJIc4ICTzlqLKiW93vywi35UGOqG
         uvv/+6XKSlODZU0Fd4Ge2A4I4FPRjTeQepJcpTzltuierJDjrdML1z1mF9Gw86nUxGWZ
         ISehgFyEdEEyA7VQYaI8HDWzB9Sd7SIgPfXg9ywDLHkccBC+Q23/07DmrHp1+6l/Drsw
         z9uHDAKhQ7sDdvJFRPPhiVJupk7bEGgr1mG6up1ODBIwl26MpkIzh/LiVAbUAJsXm8ym
         +mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3bYLDA1A50stGzomTojRUULibtFhE9b3THX6KD91awo=;
        b=VrkLguh9k5Gem1Ww615YVwQlm8RzsnhJcFhBeJlCsFYwu9D6fdB8a08LkVehxx5pxV
         hFxpiPNg0jnENUQK5M35SP9r2jlyUmf+ucD3PllBsjVRWYUfbBd9fW8yxcxMYDXq0XL5
         vMZG3teUm14COYmNNHgeBp77+PYmU31+DaR92AeWCOh/nP6uAXOwYgU9CO5GDXI9v682
         8+UgXQTqD5cNFYvxLE94Xa0RjNRANYBww7UaIF3sM/dY3QKJb/98AnlqLCPIAFhBSvOH
         wTdlesIB6BtdU9K9GBpA8SAqg4yVTL78wW+1fd86pJlandcjV0YzJboWhOtrV/Ilvtuf
         +FLQ==
X-Gm-Message-State: AJcUukei68NfJuIlKXe1QBiwBcaZsrYn1xxkuaJpLe2cGYbF8j9QkNu+
        hkPLdw/nwEhh89CAmsSjxpI=
X-Google-Smtp-Source: ALg8bN6Su1aIZiz6tGQldPUK1c1mAlv+c9KOiRYeZFrP5Sd9KgVSAMQTlG1EnvRh81ArXOof3EJc6Q==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr34550914pgc.25.1548201195651;
        Tue, 22 Jan 2019 15:53:15 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id g190sm30876574pgc.28.2019.01.22.15.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:53:15 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:53:13 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 7/8] checkout: introduce --{,no-}overlay option
Message-ID: <20190122235313.GA199923@google.com>
References: <20181220134820.21810-1-t.gummerer@gmail.com>
 <20190108215225.3077-1-t.gummerer@gmail.com>
 <20190108215225.3077-8-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108215225.3077-8-t.gummerer@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thomas Gummerer wrote:

> Currently 'git checkout' is defined as an overlay operation, which
> means that if in 'git checkout <tree-ish> -- [<pathspec>]' we have an
> entry in the index that matches <pathspec>, but that doesn't exist in
> <tree-ish>, that entry will not be removed from the index or the
> working tree.
>
> Introduce a new --{,no-}overlay option, which allows using 'git
> checkout' in non-overlay mode, thus removing files from the working
> tree if they do not exist in <tree-ish> but match <pathspec>.

This patch just hit my workstation.  Some initial thoughts:

I had no idea what --overlay would mean and am still not clear on it.
Is this analogous to "git add --ignore-removal"?  If so, can we just
call it --ignore-removal?

Thank you thank you thank you for working on this.  I run into this
all the time and am super excited about the "default to
--no-ignore-removal" future.

I'm nervous about the config with no associated warning or plan for
phasing it out.  It means that scripts using "git checkout" don't
get a consistent behavior unless they explicitly pass this option,
which didn't exist in older versions of Git --- in other words,
scripts have no real good option.  Can we plan a transition to
making --no-ignore-removal the default, in multiple steps?  For
example:

 1. First introduce the commandline option, as in this series

 2. Next, change the default to warn whenever the difference would
    matter, printing a hint about how to configure to explicitly
    request the old or new behavior.

 3. After a release or two has passed so people get a chance
    to update their scripts, flip the default.

 4. Finally, remove the warning.

 5. Warn whenver the difference would matter when a user has
    requested the old behavior through config, in preparation
    for removing the config.

 6. Remove the config.

Steps 5 and 6 are optional but might be nice.

What do you think?

Thanks,
Jonathan
