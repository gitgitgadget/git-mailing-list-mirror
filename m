Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6EC4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiLNXPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 18:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLNXP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 18:15:27 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B624BCA
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:15:26 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x2so3704265plb.13
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7j7JoIie3CRvyAMCZnnkyi/HFAuHT6tIdXojhYFW1w=;
        b=T4CXkwe5EL0WheVDw67bNuZjPY8USXa4lkZVvY0mHgAua/oLDCz4CgorCKyhW9jDIv
         HXTyWjjQKHLCujMpk60Sg753r5jlyC0FsY6VeSzP3IwlRbu+JwKwppvJvirC4/Cy2N7q
         HyeuWwHKKCfg/Gdt/ha9jsvjcTEUZ+tqp58IDycjJvV75gz/++4u+IJIPHn6TQFCngVs
         0euLSBSJ2jeFCdpWRfO4e7c8XIHl2Ff9qDawq99f2UppnypL82a28gJRIcbekBOm0oRS
         fN/V11swHjCN1Q1iZHkqFonB2RZvrvxSEVhRF51JbadFtr1zAMs9YlmW/T3g9BUri15T
         GI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7j7JoIie3CRvyAMCZnnkyi/HFAuHT6tIdXojhYFW1w=;
        b=Coc8Q6iP+8P2IAJfoCDS83zQ6ZmDwveizfHXJh56kE6Sw3QXcXV8tBcc6zQX2aFloE
         Tw9NkCvu5yGuOpfomh0YItYgIm+sFtvUEPKS09J9QwcP6knjRMbqHA3SPKHBgY9CEtWm
         +yylvfVaYYR95TdCS5i0WClAUjK4qMHSYRjFi3Ww024FtEFQNyct838ZsUW5/OR+4+ky
         3H6B29nkdfQCUrlyVbTpRrEH2Nvj49vZycigj5IdsG5kseYU5JGHIq73a9lQEcPekTXu
         cxx5hePgJDUIVFFJdzYfc1I6JAJ5pW1PhVHLqyBnTUZ5s3N7N7bDFqh7g4H0kg+snR3G
         rDig==
X-Gm-Message-State: ANoB5pmFeTd7cMghwkXSf9DVJ65Mqpmk8+mxOV/AgkU6TMmILJfm6opQ
        WI55p3Bcs2YfCLa9tDjrFrRL
X-Google-Smtp-Source: AA0mqf50x5OAoauttMZj+KEiTLn+KHeBMzkWKZLmK1sOZLswocCTT98RWkGNu7yXcEdZ7pjTZgC6Kg==
X-Received: by 2002:a05:6a21:9212:b0:9f:2dd1:c2bc with SMTP id tl18-20020a056a21921200b0009f2dd1c2bcmr31579219pzb.49.1671059725493;
        Wed, 14 Dec 2022 15:15:25 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902c38100b00187197c499asm2367050plg.164.2022.12.14.15.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:15:25 -0800 (PST)
Message-ID: <35352a10-3fc0-365f-11af-b821d114c409@github.com>
Date:   Wed, 14 Dec 2022 15:15:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/8] credential: add WWW-Authenticate header to cred
 requests
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <d02875dda7c0939a0de59a47fa9eb3a73ebd29a4.1670880984.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <d02875dda7c0939a0de59a47fa9eb3a73ebd29a4.1670880984.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Add the value of the WWW-Authenticate response header to credential
> requests. Credential helpers that understand and support HTTP
> authentication and authorization can use this standard header (RFC 2616
> Section 14.47 [1]) to generate valid credentials.
> 
> WWW-Authenticate headers can contain information pertaining to the
> authority, authentication mechanism, or extra parameters/scopes that are
> required.
> 
> The current I/O format for credential helpers only allows for unique
> names for properties/attributes, so in order to transmit multiple header
> values (with a specific order) we introduce a new convention whereby a
> C-style array syntax is used in the property name to denote multiple
> ordered values for the same property.
> 
> In this case we send multiple `wwwauth[]` properties where the order
> that the repeated attributes appear in the conversation reflects the
> order that the WWW-Authenticate headers appeared in the HTTP response.
> 
> [1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47

...

> +Attributes with keys that end with C-style array brackets `[]` can have
> +multiple values. Each instance of a multi-valued attribute forms an
> +ordered list of values - the order of the repeated attributes defines
> +the order of the values. An empty multi-valued attribute (`key[]=\n`)
> +acts to clear any previous entries and reset the list.
> +

The commit message & documentation changes (here and the 'www-auth[]'
definition below) are concise, easy-to-understand explanations of what
you're doing here with the 'www-authenticate' header values.

>  
> @@ -160,6 +166,16 @@ empty string.
>  Components which are missing from the URL (e.g., there is no
>  username in the example above) will be left unset.
>  
> +`wwwauth[]`::
> +
> +	When an HTTP response is received by Git that includes one or more
> +	'WWW-Authenticate' authentication headers, these will be passed by Git
> +	to credential helpers.
> +	Each 'WWW-Authenticate' header value is passed as a multi-valued
> +	attribute 'wwwauth[]', where the order of the attributes is the same as
> +	they appear in the HTTP response. This attribute is 'one-way' from Git
> +	to pass additional information to credential helpers.

nit: if you're trying to get a paragraph break between "...to credential
helpers." and "Each 'WWW-Authenticate' header value", you need to add an
explicit break:

-------- 8< --------

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index bf0de0e940..50759153ef 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -171,10 +171,11 @@ username in the example above) will be left unset.
 	When an HTTP response is received by Git that includes one or more
 	'WWW-Authenticate' authentication headers, these will be passed by Git
 	to credential helpers.
-	Each 'WWW-Authenticate' header value is passed as a multi-valued
-	attribute 'wwwauth[]', where the order of the attributes is the same as
-	they appear in the HTTP response. This attribute is 'one-way' from Git
-	to pass additional information to credential helpers.
++
+Each 'WWW-Authenticate' header value is passed as a multi-valued
+attribute 'wwwauth[]', where the order of the attributes is the same as
+they appear in the HTTP response. This attribute is 'one-way' from Git
+to pass additional information to credential helpers.
 
 Unrecognised attributes are silently discarded.
 
-------- >8 --------

You can test to see how the docs look by running 'make doc' from the
repository root and looking at the generated 'git-credential.html' (note
that, if you've installed Git dependencies with Homebrew, you might need to
specify 'XML_CATALOG_FILES=$(brew --prefix)/etc/xml/catalog' to get it to
work).

> +
>  Unrecognised attributes are silently discarded.
>  
>  GIT
> diff --git a/credential.c b/credential.c
> index 897b4679333..8a3ad6c0ae2 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -263,6 +263,17 @@ static void credential_write_item(FILE *fp, const char *key, const char *value,
>  	fprintf(fp, "%s=%s\n", key, value);
>  }
>  
> +static void credential_write_strvec(FILE *fp, const char *key,
> +				    const struct strvec *vec)
> +{
> +	int i = 0;
> +	const char *full_key = xstrfmt("%s[]", key);
> +	for (; i < vec->nr; i++) {
> +		credential_write_item(fp, full_key, vec->v[i], 0);
> +	}
> +	free((void*)full_key);
> +}
> +
>  void credential_write(const struct credential *c, FILE *fp)
>  {
>  	credential_write_item(fp, "protocol", c->protocol, 1);
> @@ -270,6 +281,7 @@ void credential_write(const struct credential *c, FILE *fp)
>  	credential_write_item(fp, "path", c->path, 0);
>  	credential_write_item(fp, "username", c->username, 0);
>  	credential_write_item(fp, "password", c->password, 0);
> +	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);

This implementation looks good to me.

>  }
>  
>  static int run_credential_helper(struct credential *c,

