Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34976426438
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792316749; cv=none; b=UvXIzYaMjYxF5ZqpESIyl9Hwe4QfXVuEziSXvHC2qoBxtK71oExfcWMTX1pvk4STvmiBC3zZ6a/uaNuh77ZqZgaRXfzsNu4JojpY3lX7oKICl3qQDutqEzRLBAIkf0GgbYaWV4WAm9WcqatwJtvBB/rmzohRQ2FfGdmsXLvw72g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792316749; c=relaxed/simple;
	bh=lJ/29aacsUpSHVkMTTZVSFxtrsD1f71PW7ZyqKvd3Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT2AQLxzGAGsrdf9wy4Bw8933nFaSxw9IYSTe8iB0sHbfYwKeaUMWhwAjqNqQRmkLZYn2l8XKtTNIIuR/Byy/Xxe+pNKm/2dKq8Du0yCy2r8nstgTGLAwQ/URQ1C0y0IeD+6gaTH3klf3v3d1OUuFljP105YnbyxRhxUdpXFHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+qxWddb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+qxWddb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afbd2c386so485703f8f.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792316743; x=1792921543; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vd4ju+fIkvXfWF2NOU57i+fC9yG4bfN2y+Ii8nGkvI0=;
        b=B+qxWddbQ3UcPTekHy8SNyfyN1Ra8eIS7dquElmA6OIgGs+CshAmDi6vxo4JMuI0K6
         h5AWePvZnIKcPOEepj2Ow2ngds/wdLd9/lpXn2jnfDK2Gvhx5g0wXPyWRwkLwf8JvYzb
         b7vxoBPPn/TWka55JCUrmQ/4/hdpWfsIz8tbyjtEd8jWrxGei5BMEVy1G6J9jfUlo7QA
         dnigYzxI3bK8c8UIm+9lWDm/PwAQOCJ038/fkOTc6ioJN3k4py4eKRiS4E9+xvl7BIdG
         MWAWueMH35HXdIYFnZWAl0Mm1KMBgBQcink8B7pRc6DpnBTnWUyK9WiyyM39PlESc0yN
         P6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792316743; x=1792921543;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vd4ju+fIkvXfWF2NOU57i+fC9yG4bfN2y+Ii8nGkvI0=;
        b=15cMFzb1vUWiHiIi/KWPG5HWLfJ5+FhQz02Ph6bCGxIbC9cODjf7iyKeVxl6XauCyw
         xn4aVAHPfzdjp/Lq89qJ+8IfxptYI/MQcxl/4j9hnybrDfczXd0dUIJO42soCotyIXnc
         qEjU7LdWYgMr1zyfzpy5nG6JuV+milioeIHOmEf8ryalT+1d0X1K0eBDMI8UNseX2JCh
         PgpCer6kxSbt7vMep3utFobj//Bss85gsivXwkHrPVSHeDCYBtAjVzwL8AaV88AQUm+k
         GBurqW6jf7uctBX2/vvtIAoHqrrBe3RYGMDsQRmv8aUiGlQnJzSb0TMqmlohgFTKfRXr
         f6zg==
X-Gm-Message-State: AFq9FYICBnwtOGIlZw8BHsJMmfCulSH00ZDOb0KkOaRuM0IOdEqNctHa
	rDzE5Lhua+0CrqBZ4VoG9aXgtkkNGXdOXJovRwo/4BKCs9hjG9i2YZQl
X-Gm-Gg: AYBFou2FrHvsillgtdNq++BsGjyd+lfjRJWHO31i4S65um2/EK/usGvTHCsRDwN+2gf
	dzOreTgS5WoeuXaqBFbbaKxrJQLv3l+idrXLwD1SOCuSpTU4IO48CuaeGFbPhUomCl80eVC/iod
	dTKwrdT3zdK4jFNHpwy4+f0jPkxabdjT0RI6GuwgJ9EbTKM0UU6cFJzpp34l4qhE6s+vP+Zu9Md
	C75n/Rb2XLD0KteSjzwAGvM3354khua0BGAXrtf40UyAdTyEDjj7Gecaw7yaTx4JlIpzB5oNL4b
	WjGHiAD/Gs1EbCZrXzFfAK/oeV/E5PgslxPktBEVDNbELJL3395YT75Y97XKIfXnMd+RnOusDOb
	tkOlwjRSBtHEz+ZRp8Fb/nAa06R4o3uw2x/dvhtUcHOC8/ZKhh6TkczWMtC63lCnC6jcqhBT3e4
	9B9kZTyBWxoNYv7J9nxgjEaFKYoDBq67b2RKSeyFrsDWow3Revqo8J38vJ0EEYGFYaLj+IayERA
	NGWqdhQdpjxe+9g23t88bUOeLCEixMIhZqZ9DvKBwSdK/Q8w0MM
X-Received: by 2002:a05:6000:15de:b0:48d:faa6:cedf with SMTP id ffacd0b85a97d-48e07fb8463mr6115873f8f.56.1792316742689;
        Sun, 18 Oct 2026 02:45:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd409989sm16726014f8f.0.2026.10.18.02.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 02:45:41 -0700 (PDT)
Message-ID: <d748915d-c50c-4143-8140-ae885a6ba604@gmail.com>
Date: Sun, 18 Oct 2026 10:45:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [Outreachy][PATCH v3] builtin/var: refactor to use parse-options
 API
To: kerylefondji7@gmail.com, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
 siddharthasthana31@gmail.com
References: <20261017131730.642-1-kerylefondji7@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261017131730.642-1-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Beryle

On 17/10/2026 14:17, kerylefondji7@gmail.com wrote:
> From: Keryle Fondji <kerylefondji7@gmail.com>
> 
> Migrate option handling in 'git var' to the parse-options API.
> This update also aligns variable resolution with current Git configuration
> and attribute handling.

This all looks very sensible, but "git var" was recently converted to 
use the parse_options() api in e19f0779c67 (var: add "-z" output mode, 
2026-09-26) which has been merge to master.

Thanks

Phillip

> Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
> ---
>   builtin/var.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/var.c b/builtin/var.c
> index cc3a43cde2..b9234a55eb 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -3,11 +3,9 @@
>    *
>    * Copyright (C) Eric Biederman, 2005
>    */
> -
>   #define USE_THE_REPOSITORY_VARIABLE
>   
>   #include "builtin.h"
> -
>   #include "attr.h"
>   #include "config.h"
>   #include "editor.h"
> @@ -18,8 +16,12 @@
>   #include "path.h"
>   #include "strbuf.h"
>   #include "run-command.h"
> +#include "parse-options.h"
>   
> -static const char var_usage[] = "git var (-l | <variable>)";
> +static const char * const var_usage[] = {
> +	N_("git var (-l | <variable>)"),
> +	NULL
> +};
>   
>   static char *committer(int ident_flag)
>   {
> @@ -120,6 +122,7 @@ struct git_var {
>   	char *(*read)(int);
>   	int multivalued;
>   };
> +
>   static struct git_var git_vars[] = {
>   	{
>   		.name = "GIT_COMMITTER_IDENT",
> @@ -221,21 +224,32 @@ int cmd_var(int argc,
>   {
>   	const struct git_var *git_var;
>   	char *val;
> +	int list = 0;
>   
> -	show_usage_if_asked(argc, argv, var_usage);
> -	if (argc != 2)
> -		usage(var_usage);
> +	struct option builtin_var_options[] = {
> +		OPT_BOOL('l', "list", &list, N_("list builtin variables")),
> +		OPT_END()
> +	};
>   
> -	if (strcmp(argv[1], "-l") == 0) {
> +	argc = parse_options(argc, argv, prefix, builtin_var_options,
> +			     var_usage, 0);
> +
> +	if (list) {
> +		if (argc > 0)
> +			usage(var_usage[0]);
>   		repo_config(the_repository, show_config, NULL);
>   		list_vars();
>   		return 0;
>   	}
> +
> +	if (argc != 1)
> +		usage(var_usage[0]);
> +
>   	repo_config(the_repository, git_default_config, NULL);
>   
> -	git_var = get_git_var(argv[1]);
> +	git_var = get_git_var(argv[0]);
>   	if (!git_var)
> -		usage(var_usage);
> +		usage(var_usage[0]);
>   
>   	val = git_var->read(IDENT_STRICT);
>   	if (!val)

