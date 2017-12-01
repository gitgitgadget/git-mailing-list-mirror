Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2E620C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbdLAD0w (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:26:52 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34750 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbdLAD0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:26:51 -0500
Received: by mail-pl0-f65.google.com with SMTP id d21so5508729pll.1
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rF3oAikJQ1EsUN46EOUYL18TECOpMAroPkwW6tx0cJk=;
        b=QWUQAnmDV7aRNVLwEIYFoE46bITDbq6L17eit39U5v2wY5x4WUPzS0gMca16CY3smc
         uZEgvU6DRxcgndizPTqFhNrwDH5N8w32mcXGjg5fMzfqhzsxQ2UuqkjMGi0TO7zkfSf5
         WWQemNJuRZ9T91DkdakjlnhqmoA3E3AuVWnondAiatvAajXew75PMMOU8Lz/mfVsaz8R
         EV02HMV4JgDpuI2wZi8mAy9dIL+j62a2PVFQ5SBUCJIigiRQ4OMoqJv/sx+/Io3QWr2c
         fm3aum45JZcun0UVSxDtutv9HmtlgqiV6avFXzirmsJJpM9JjptpKSqR/fkVIGYGmmwi
         tdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rF3oAikJQ1EsUN46EOUYL18TECOpMAroPkwW6tx0cJk=;
        b=gxyQwrzTN1bt5va+sDSeI0ttB7TKzKHeYRncapN80gX8pn7glyQs1LFg6Bw3/LYC2h
         L57CbJGmWxI0L7OLBBrzCqwn4o4vloyD8QKKlqM5Tbmo4DeSnWqvGmZ3x/miVcOTM9sV
         uoFW3UmEpOf0h/+QxQMVQJiIPDq3/0avEXsaSWE17287j9heeRCEdz3BkYvY8Ra5FiAW
         eFbOJmFbf6S5ABvMzD9cfyFw54pvIz6au5kbQRKSc8Ok6yPr5PixN3M6hdvsTCLPz/RK
         kAmo88t0fKRhO6pRIFtO1tLzIq6f8QyFttgsjgIU8Lg/CYBE1/P8gRatDCI65Tx4KvF6
         ZTCw==
X-Gm-Message-State: AJaThX5qlVyLJGhws61OQ8pzb+1oZFHCmEY0tJY26g8JUZmnvCLjV0Vm
        dNnQRFq+ARW3WFfulbUXW0w=
X-Google-Smtp-Source: AGs4zMZg/kCRq8lEQN0sPMrH3j3gqhVUoLG+7Fto9Y/Vbw2fq9bT0BrugvvfQ4PnyPjyDYRZ61D4oA==
X-Received: by 10.159.214.140 with SMTP id n12mr4634546plp.256.1512098810519;
        Thu, 30 Nov 2017 19:26:50 -0800 (PST)
Received: from [192.168.206.100] ([117.249.175.222])
        by smtp.gmail.com with ESMTPSA id m11sm8706371pfh.35.2017.11.30.19.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Nov 2017 19:26:49 -0800 (PST)
Subject: Re: [PATCH v4 1/2] refactor "dumb" terminal determination
To:     lars.schneider@autodesk.com, git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-2-lars.schneider@autodesk.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <a9786a9f-66c9-9f1e-75c8-b2c5a81b08aa@gmail.com>
Date:   Fri, 1 Dec 2017 08:56:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129143752.60553-2-lars.schneider@autodesk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 29 November 2017 08:07 PM, lars.schneider@autodesk.com wrote:
> +int is_terminal_dumb(void)
> +{
> +	const char *terminal = getenv("TERM");
> +	return !terminal || !strcmp(terminal, "dumb");

So, IIUC, there terminal is considered to be 'dumb' when the TERM 
environment variable is NOT set or when it is set to 'dumb'.

> +}
> +
>   const char *git_editor(void)
>   {
>   	const char *editor = getenv("GIT_EDITOR");
> -	const char *terminal = getenv("TERM");
> -	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
> +	int terminal_is_dumb = is_terminal_dumb();
>   
>   	if (!editor && editor_program)
>   		editor = editor_program;
> diff --git a/sideband.c b/sideband.c
> index 1e4d684d6c..6d7f943e43 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -20,13 +20,12 @@
>   
>   int recv_sideband(const char *me, int in_stream, int out)
>   {
> -	const char *term, *suffix;
> +	const char *suffix;
>   	char buf[LARGE_PACKET_MAX + 1];
>   	struct strbuf outbuf = STRBUF_INIT;
>   	int retval = 0;
>   
> -	term = getenv("TERM");
> -	if (isatty(2) && term && strcmp(term, "dumb"))
> +	if (isatty(2) && !is_terminal_dumb())
>   		suffix = ANSI_SUFFIX;
>   	else
>   		suffix = DUMB_SUFFIX;
> 

This one looks good to me if my observation above is correct.

---
Kaartic
