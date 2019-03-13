Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3314A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 04:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfCME2H (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 00:28:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36691 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfCME2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 00:28:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so382912wru.3
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 21:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W3+77qDyXuWNGdOSpNaV8s6aGLOQyazBcfItb0nxJNM=;
        b=o9/3J6EG76xG/2Fd1naLGBqkyTcU6HTTnHPEcLtXalRF9xNjLDWfjdhR29IWsjkVRR
         mnVPdJKCriwQvGsLOE4kDW22yqCtKr+PvI21PP6PbtPZE+OEDh5BYahgKxqAgREen2SP
         2ebSJqiYRBSgWI83XxcJ9+QR2bnKOYX5czLlPiFjkGmcAfonE04+WQzSSh28qJSD08dn
         RQJ5kwrCzEiYbf+Cn5vnUgvtICt4mAKbrJlCFndqgkfbaKRY1gnhxxWvoWf9RD5U9zy3
         qwUOcnEEnQwXIqGEY8+GV7R0KX5ougwTOBwG/VNscDMmv2mrBuak1GDvKno0fQCYR9hw
         +2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W3+77qDyXuWNGdOSpNaV8s6aGLOQyazBcfItb0nxJNM=;
        b=E9GB2MFJ+db0QiTCldBCkLSFGk4tyvh+dmPIiXHXt/0oPm1CHp/mxJeRbkYpqbZeei
         IWrdKJe9z7wvIoDLJsY7c+55hIfX0VOoM3ComBgcS4F36f02C67nTYv+pgtc2BCxsWhE
         selR2qCRfHQ3lmdIDLZAL5JwgPCxc/uXhAwdgC8gSRcStmM0Jhi62n3tGRr0IYDX6ou/
         dz2t+ObLqEs4wy4l6Uv8sYza7jDKkiReWssX8PEInQk/gbmBVvAScwrk+bfH3qOmi/lS
         J1J/imjgXSzAdInpBSCcQt6OzBlyq1KiF6FJJ2x09eMfWNuK1Q3LSD8KjwdN6/YTEsgS
         7pvA==
X-Gm-Message-State: APjAAAVZ8N1DJOfjqZbMjNFy2MAiv3UcKiwQMs8HSkcG+TaxfhpFS8WL
        ErHh0JC5pF576Yyao3+wB6s=
X-Google-Smtp-Source: APXvYqzvCRDHMW8+9qot2tBLWESdZeg0n3Dx3MOLNqIl7ngCtUNZRShsuhT+4XZLtyDEjQEnR+bFqA==
X-Received: by 2002:a5d:4b06:: with SMTP id v6mr20947008wrq.151.1552451284868;
        Tue, 12 Mar 2019 21:28:04 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id i10sm22165815wrx.54.2019.03.12.21.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 21:28:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3 04/11] promisor-remote: add promisor_remote_reinit()
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
        <20190312132959.11764-5-chriscool@tuxfamily.org>
Date:   Wed, 13 Mar 2019 13:28:03 +0900
In-Reply-To: <20190312132959.11764-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 12 Mar 2019 14:29:52 +0100")
Message-ID: <xmqqlg1je6uk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Christian Couder <christian.couder@gmail.com>
>
> We will need to reinitialize the promisor remote configuration
> as we will make some changes to it in a later commit.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

At this point, turning "initialized" into a file-scope static, and 
building reinit as

	void promisor_remote_reinit(void)
	{
		initialized = 0;
		... clear existing "promisor" entries ...
		promisor_remote_init();
	}

may make more sense.

> -static void promisor_remote_init(void)
> +static void promisor_remote_do_init(int force)
>  {
>  	static int initialized;
>  
> -	if (initialized)
> +	if (!force && initialized)
>  		return;
>  	initialized = 1;
>  
>  	git_config(promisor_remote_config, NULL);

The promisors and promisors_tail would need to be reinitiazlied and
existing elements on the list purged.  Otherwise, after removing an
entry from the configuration file, the entry will still stay around.

>  }
>  
> +static inline void promisor_remote_init(void)
> +{
> +	promisor_remote_do_init(0);
> +}
> +
> +void promisor_remote_reinit(void)
> +{
> +	promisor_remote_do_init(1);
> +}
> +
>  struct promisor_remote *promisor_remote_find(const char *remote_name)
>  {
>  	promisor_remote_init();
> diff --git a/promisor-remote.h b/promisor-remote.h
> index f9f5825417..f96722bc66 100644
> --- a/promisor-remote.h
> +++ b/promisor-remote.h
> @@ -10,6 +10,7 @@ struct promisor_remote {
>  	struct promisor_remote *next;
>  };
>  
> +extern void promisor_remote_reinit(void);
>  extern struct promisor_remote *promisor_remote_new(const char *remote_name);
>  extern struct promisor_remote *promisor_remote_find(const char *remote_name);
>  extern int has_promisor_remote(void);
