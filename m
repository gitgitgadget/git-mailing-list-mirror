Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919651B960
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733645345; cv=none; b=OQ+kFKhOOQSry6YzH82kZTs7GClXNTGcNF/OrnCaZDiF/Ee22YlzboiSknf6qfjv4o74wDKs1kmY11OlPR7UDtV+pD8kRWtf7B9Ez6WIeOUibJyRVe1xnePepCdd9FJGffA53RfLJw5tk6nj6qKiudkN0lj5/sqaRQ5DRjAQrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733645345; c=relaxed/simple;
	bh=zGMLTdKbVOec4XHyeV5uxcI9i3s6kab2BpimNbYkfOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrbEkA7gQMKtJcfIaKrL6Q3nqxT9oNsouht4VZmXDNQFsuvQigmjWyezw1MKra3LJPb5NenAuV5mvxvZWyAimLepBjk1C3qiYguMISvq92lDBFnR1qgNvNYOSMjmSRL+I66BwzLBFz1vzUztndntWZTcrbrp9cnIOOsI6dlDb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BG1v3wCQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG1v3wCQ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385ddcfc97bso2691562f8f.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2024 00:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733645342; x=1734250142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4QF5+Ry6QKbZWoacWcnq3SPkRCF3xyzNooi609BGaE=;
        b=BG1v3wCQDZutuE7bHkl3egBDfVcmhkM+SfAg9gPfjvpMMR3F7P2ZlVe79zkYsGpMlv
         O+xT8hYray/7GIB2+HVVhE21UclZi8pEH1+tXJ3Blhjls34VA7oYFitwt6fG1ki7j7hW
         6ArNEbKrKwrci8VvrgJsnjzX7XksEqgegIbwC9QliaudnvKRWaPCyfa08Abb+ZGqkGiN
         ZCTD9tj9zYWWSlVsQwZnGi664nE4GJCkP7Q47C/tF2pWfkq0JVrp+hVNc6s3Qhm6fKGo
         o2xTCmJHoSa6t4QtaLNB782saCfXoAKDeZEgNCmx1/mXhcOPt9cWNo5rC6ryE4j7kGSR
         8jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733645342; x=1734250142;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T4QF5+Ry6QKbZWoacWcnq3SPkRCF3xyzNooi609BGaE=;
        b=bbmQzikf/L1w7CzIEJce/bLXAKu+MsHoSwHXfnRMdihLGyf9Kg5jfbBd13lvt0ks6E
         kkiC7GUhRDISE3nZ1yuzLdF4FPKeIpjbabPHIuvO1eei9ITVModkzAokj6K1NCD+Ohws
         JIYrJt1nfV+xJzoIOLKrrzXSpMVOOikckQYxU8rb7dRI+NPq6ALAb5SuEZ9f2splWFC5
         KMCEKziRJYtwJL79QpkAlrf9CGQ0OpPWzh5KqMCoiNbFXdlvGj1uKp+nuvDFc0CwwhHg
         75/S9EbMy2RZtZ36S4E2nH3ruLEPWLrqWilXkMfPYQzxr3ZJavPPiwfLIWF5DVFG1rK/
         iveg==
X-Forwarded-Encrypted: i=1; AJvYcCUzmfAUJaYSJt3+1muCzp5MI8cnhyIY/0h74hBpZIUnhyfjOJF298rrw+pVeI5t0d34ZsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAR6kzW5Q4esJs1cuE3/E+eJZVtygpbGDebd2SdxmkcBMMQZX
	mZ068eKfhZiHbvsDQFo4ynm/TtW1pf7oVcBoTO7deuHg8z3lXZ5C
X-Gm-Gg: ASbGnctSkIYKVgHYF8zzLqUOC57UQqlxuSPq1rB7w7BDfygrDSR1wg2EFUZB/8kY40r
	ONYEb510iLJYDlR2UruZEWzQ00QDSwhq3GJuek/ncl0pQZ1mdZQzbegisbR728yH5cOJKnwgC4l
	1oF9y00iThHOBqn+BrOc1vw98FOgSE768hb0Q0c4X2kP+/0idShTGHxopmTAUWYDt96AcRYkSHE
	8oYqtGH1M9uV5GH2eApMbCqQ690NOJeVyZ82Fim
X-Google-Smtp-Source: AGHT+IHfflY1DdXQFA2PXj+DtKzi0N+bNRvJ1PC/cDuPrtlC9/Txe8CJpyc2SYPHbMAiYF0gxLJzSw==
X-Received: by 2002:a05:6000:71a:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-3862b34e29cmr7121609f8f.16.1733645341472;
        Sun, 08 Dec 2024 00:09:01 -0800 (PST)
Received: from gmail.com ([88.14.46.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a85f2sm9299369f8f.29.2024.12.08.00.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 00:09:00 -0800 (PST)
Message-ID: <0e139151-7162-42b3-afae-248c28bf4c4b@gmail.com>
Date: Sun, 8 Dec 2024 09:08:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] advice: suggest using subcommand "git config set"
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Heba Waly <heba.waly@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <Z1FkrsQ5tkz1pFUz@pks.im>
 <20241205122225.1184215-1-bence@ferdinandy.com>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <20241205122225.1184215-1-bence@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, Dec 05, 2024 at 01:21:58PM +0100, Bence Ferdinandy wrote:

> The advice message currently suggests using "git config advice..." to
> disable advice messages, but since
> 
> 00bbdde141 (builtin/config: introduce "set" subcommand, 2024-05-06)
> 
> we have the "set" subcommand for config. Since using the subcommand is
> more in-line with the modern interface, any advice should be promoting
> its usage. Change the disable advice message to use the subcommand
> instead.

It's very consistent to keep our messages updated with respect to
changes in the user interface.  So this patch is a step in the right
direction.  Thanks for working on this.

> Change all uses of "git config advice" in the tests to use the
> subcommand.

Maybe this should be done in a separate patch.

> 
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
> 
> Notes:
>     For the tests I just indiscriminately ran:
>     sed -i "s/git config advice\./git config set advice./" t[0-9]*.sh
>     
>     v2: - fixed 3 hardcoded "git config advice" type messages
>         - made the motiviation more explicit
> 
>  advice.c                        | 2 +-
>  commit.c                        | 2 +-
>  hook.c                          | 2 +-
>  object-name.c                   | 2 +-
>  t/t0018-advice.sh               | 2 +-
>  t/t3200-branch.sh               | 2 +-
>  t/t3404-rebase-interactive.sh   | 6 +++---
>  t/t3501-revert-cherry-pick.sh   | 2 +-
>  t/t3507-cherry-pick-conflict.sh | 6 +++---
>  t/t3510-cherry-pick-sequence.sh | 2 +-
>  t/t3511-cherry-pick-x.sh        | 2 +-
>  t/t3602-rm-sparse-checkout.sh   | 2 +-
>  t/t3700-add.sh                  | 6 +++---
>  t/t3705-add-sparse-checkout.sh  | 2 +-
>  t/t7002-mv-sparse-checkout.sh   | 4 ++--
>  t/t7004-tag.sh                  | 2 +-
>  t/t7201-co.sh                   | 4 ++--
>  t/t7400-submodule-basic.sh      | 2 +-
>  t/t7508-status.sh               | 2 +-
>  19 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/advice.c b/advice.c
> index 6b879d805c..f7a5130c2c 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -93,7 +93,7 @@ static struct {
>  
>  static const char turn_off_instructions[] =
>  N_("\n"
> -   "Disable this message with \"git config advice.%s false\"");
> +   "Disable this message with \"git config set advice.%s false\"");

The main goal of this patch.  Good.

>  
>  static void vadvise(const char *advice, int display_instructions,
>  		    const char *key, va_list params)
> diff --git a/commit.c b/commit.c
> index cc03a93036..35ab9bead5 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -276,7 +276,7 @@ static int read_graft_file(struct repository *r, const char *graft_file)
>  			 "to convert the grafts into replace refs.\n"
>  			 "\n"
>  			 "Turn this message off by running\n"
> -			 "\"git config advice.graftFileDeprecated false\""));
> +			 "\"git config set advice.graftFileDeprecated false\""));

OK.

However, instead of solidifying this message, perhaps we could take
advantage of `advise_if_enabled()` here.  That way, we simplify the
code a bit while we also automatically get the new help message, which
you are already adjusting in advice.c.

More on this below.

>  	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
>  		struct commit_graft *graft = read_graft_line(&buf);
> diff --git a/hook.c b/hook.c
> index a9320cb0ce..9ddbdee06d 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -39,7 +39,7 @@ const char *find_hook(struct repository *r, const char *name)
>  				advise(_("The '%s' hook was ignored because "
>  					 "it's not set as executable.\n"
>  					 "You can disable this warning with "
> -					 "`git config advice.ignoredHook false`."),
> +					 "`git config set advice.ignoredHook false`."),

This message is more of a warning than advice.  I don't think we want
to use the same approach here as above, because:

    hint: The 'foo' hook was ignored because it's not set as executable.
    hint: Disable this message with [...]

looks weird.

So, your change is enough and right.  OK.

>  				       path.buf);
>  			}
>  		}
> diff --git a/object-name.c b/object-name.c
> index c892fbe80a..0fa9008b76 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -952,7 +952,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  	"\n"
>  	"where \"$br\" is somehow empty and a 40-hex ref is created. Please\n"
>  	"examine these refs and maybe delete them. Turn this message off by\n"
> -	"running \"git config advice.objectNameWarning false\"");
> +	"running \"git config set advice.objectNameWarning false\"");

Here, however, I think we should also switch to `advise_if_enabled()`.

[...]

The rest of the patch looks good.  I think it's desirable to separate
the changes in the advice messages from the uses of "git config set"
in the tests, as I commented at the beginning of this message.  But I
don't have a strong opinion on it.

I'll reply to this message with the changes I've suggested about using
`advise_if_enabled()`.  If you agree with the changes, feel free to
use them as you wish.

Rubén Justo (3):
  advice: enhance `detach_advice()` to `detach_advice_if_enabled()`
  commit: use `advise_if_enabled()` in `read_graft_file()`
  object-name: advice to avoid refs that resemble hashes

 advice.c                            |  8 +++-----
 advice.h                            |  2 +-
 builtin/checkout.c                  |  5 ++---
 builtin/clone.c                     |  3 +--
 commit.c                            | 17 +++++++----------
 object-name.c                       |  9 ++++-----
 t/t1512-rev-parse-disambiguation.sh | 15 ++++++++++++++-
 7 files changed, 32 insertions(+), 27 deletions(-)
