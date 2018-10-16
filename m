Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D03B1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeJPML4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:11:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35884 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbeJPMLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:11:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so21615603wmf.1
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wF7To5UGyAqydISj6oll4gb++uI3FiIrCRORCrzWe2o=;
        b=UxPw/R3g0adL9QWNzD5ABw02AxduAMhsiJ4Zw3McOyHpRVgdF0SZ3Fbh2lp9iNZTFg
         wh2vj2HHdJDbY6Qh8OCEvN5U+X4cPlD90BYXuVNQVqccVhPgHbTPzHU6b7zKkGE45ttW
         DarvK1IiWrYjwqGv6r2SL3O+jCUfQHjCbdz6N+45+sIVIreM1nc1RGhDkh4RukeGFsEa
         rlNmkl9rIbmPfCCzirXa/BHbAIME3AOM8RmpEB5D6qp43vrlqaoujNA5uBRved/d/l3T
         Fwtz2PzoYb5SSnb4ZMnanZ7k9HJ/FbTn5laBBraCOOv2yLPKxG85m/dEdKJFmdegx/6I
         9srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wF7To5UGyAqydISj6oll4gb++uI3FiIrCRORCrzWe2o=;
        b=Pr5vk4ZG942w9+SuBkk8X2ZtvGCQUckV3kyb0BpVOIB/ExUb+1VsTL1WYZ9O1awZym
         AqjafiFEREvjubJIT1Vzcvea0bwCcFsv4yNIhFkvCxMIua8bLKr4tva49zvsf3e2PcAp
         AHGFf30Ct+Rn5kiWPo+ftfIIMuZtkS0RmgPIWGpSkoHFD/fXv3yl4s3aEUkcfR6+O9Cs
         O/348AR09OmTkwxz/ilvIvonBvsGSr+sdQkNz5AS+Bz3IzIhegUxbdvLxpKJE8qZy4tD
         8XbKcOGjD3VJYPAmFsjd+XJbwgu5outlFB6Ne0ov9vPqX+ECstvCACtC/WvsusAQ7lJO
         j6Fw==
X-Gm-Message-State: ABuFfoiZAIt7XajWlZQEinYiP5m0igls9LAFX+D5+A9AZlHH7xjgqA/C
        JQmeOJ2gHOdmCkF4gZmJDhSAsRQCnkA=
X-Google-Smtp-Source: ACcGV606TbPv4/OOFu+Rl4VGyBXNerjs/hCMCH8MgbnweAHDzo1ztiCn93aPWTLUmDVtJXveU32C/w==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr15830137wmk.49.1539663808483;
        Mon, 15 Oct 2018 21:23:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 67-v6sm8641280wmd.1.2018.10.15.21.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:23:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Brendan Forster via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Brendan Forster <github@brendanforster.com>
Subject: Re: [PATCH 2/3] http: add support for disabling SSL revocation checks in cURL
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
Date:   Tue, 16 Oct 2018 13:23:25 +0900
In-Reply-To: <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        (Brendan Forster via GitGitGadget's message of "Mon, 15 Oct 2018
        03:14:45 -0700 (PDT)")
Message-ID: <xmqq1s8q34g2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Brendan Forster via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Note: an earlier iteration tried to use the config setting
> http.schannel.checkRevoke, but the http.* config settings can be limited
> to specific URLs via http.<url>.* (which would mistake `schannel` for a
> URL).

Yeah, "http.schannel.anything" would not work, but is this note
relevant here?  As far as the git development community as a whole
is concerned, this is the first iteration of the patch we see and
review.

In any case, you can use "http.<url>.$variable" to say "I want the
http.$variable to be in effect but only when I am talking to <url>".
Does it make sense for this new variable, too?  That is, does it
benefit the users to be able to do something like this?

    [http] schannelCheckRevoke = no
    [http "https://microsoft.com/"] schannelCheckRevoke = yes

I am guessing that the answer is yes.

I guess the same comment applies to the previous step, but I suspect
that the code structure may not allow us to switch the SSL backend
so late in the game (e.g. "when talking to microsoft, use schannel,
but when talking to github, use openssl").

> +#if LIBCURL_VERSION_NUM >= 0x072c00
> +		curl_easy_setopt(result, CURLOPT_SSL_OPTIONS, CURLSSLOPT_NO_REVOKE);
> +#else
> +		warning("CURLSSLOPT_NO_REVOKE not applied to curl SSL options because\n"
> +			"your curl version is too old (>= 7.44.0)");
> +#endif

That ">=" is hard to grok.  I think you meant it to be pronounced
"requries at least", but that is not a common reading.  People more
commonly pronounce it "is greater than or equal to".

> +	}
> +
>  	if (http_proactive_auth)
>  		init_curl_http_auth(result);
