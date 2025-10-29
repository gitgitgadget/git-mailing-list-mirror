Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657CF2F3C3D
	for <git@vger.kernel.org>; Wed, 29 Oct 2025 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732996; cv=none; b=E6at6chEfphFq5swAVLslQXt5rX5R7/eX37YrdsxA2BvZBZUoob4ZPRNj3M+iVOX24bIVSLQVs2FlwVFscbkHyQ7StEm0b5+LZtiv89XjnY/bndI8C2svAaFgSsHgEAcUT5F8BfM7RzAduXwaSjgkVGaPnoUvf4zxaozH/If25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732996; c=relaxed/simple;
	bh=JwOyftPl2T0BsbbayJmEA9KGYPFEp20KwBldhNTyR1A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sWEgHUGQr+RE87XeP6AogwVaXKwic9Jqs6dPpuvPOFpiX4+yeH8qGmSoF88QaCp9jor4SEORnI1sB98AP4Ipea9ry7RbT6egEdaZ45eD1ATbpXinkc+g9yNwtKpDTo12fEFuYofe5Q2XqS4LO1Y4wy25MtN1wWC5vSXai8WdQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IKdVaJ0V; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKdVaJ0V"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso6302675f8f.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2025 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761732991; x=1762337791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mCXehaLH9MdKB8OTr3h14P0a27v1nu/ATvf1I0vDjos=;
        b=IKdVaJ0V+owpngojXGS2N7HK85imUBvsATRMET9IOC0ulzwWnPz9M4Cnb8bMCD23AX
         eqx8IhTTa862+cBUJj6D9OcU2OXYQhvjRq4qvKLZxj8i1YKGa9jF+624xWBh7DjPsrnF
         jMkdLFZGobFVOFJ7Fnx3Ln55/9yQ2zIsSG0smhSY8klBE245JZtV3/6h7dYymPpbc9JK
         hBw/ofd61TdpIm47l6jaV6gJUr4LnD8EydyaVcwLuLgXk3k9jCXQxUsZgMkov5gOr8gX
         2SbuuYfrQJ0kgBaMUVr94DRw3DqfmC+ctMUdWga/k6t08RkGtY8onUtdhOczHNf3not7
         6l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761732992; x=1762337792;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCXehaLH9MdKB8OTr3h14P0a27v1nu/ATvf1I0vDjos=;
        b=KAO3Bw+RphYYgdxwMPm+Up54ULAApTstsHLwHJU56bUP5iDEIqpeKkb4HEzlHVIPDm
         WCbiNy3aFt73g8Ge2pWdVziJApCklnlz9zAgoEdS6CjUu8bUyCftLhihJ279Tgf5hlPn
         oYo5W1qNkwugJhGKJD1Aps+pj5GMhxuCE/HAGvNdDwF19Z1JejeR/FDV5Wu3+oInmDn0
         z82OoytfnGNZJC6xO483WoFL9UD5FhnJW3JAbNbf5mgzoULjSaswB9WuzDiDWePqwKDb
         5IsRcgd+/NDmJ+8xkCMDuzzWWlUjf6w+lVZTYtY79vBVoYKCqkYJBJMjuBuvdsE+GSwg
         ERUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgRuS3mHmD0FMoIrR+dAhIYdnSrTiJQ9UE+eguI/0D3HUa5/zQXyl+Y3rVr9lnX7nEFuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2k584ysOmldhEwx/c41Y5kcouSrVc1ZqIWAwsjA8An2s6YOSW
	+9ls3+o8g4a1ie3GbEdFTPn1jhlMevulgbKD7IO4LVREqnrPQFzZDsOj
X-Gm-Gg: ASbGnctMFkQqrl6XQlQfm414ElS+0FSdPsFNf6t4hWaq0rhzEZ213D0AXd1KgCeTYML
	VsY8zCRzSt+DlgedQcz1oxfzEMsQhPgsZ3eDwuUAjqUn7TtSn09x8YsFURiq82beidxVYF3JPM2
	kEZ5pn1W+fI0FeGkhDpccwJO/zWMzIxKMl2Zt+DnxdcqYgNuLPKJNZWOmk49elHCa710X8eEmE9
	U12o5FJegsjUODcLXfr14uXnq8mYh/ge7CoR7I/avRCZVOXOn3eJotKz5sTIlm5M8oJkFT3xy9S
	qe8gbawHLsgOmCLZvleBcFd9gaIMDbZaS3XBUZte9UKcdnxlpC/14BGJ7xRa1DBrB8qaumS5kQU
	qlk0v93DqBW7tPyDBcxnc+1Qsdm49quL/03tEDEMLXuPNIM5h9+I6ToTSbe/aESeSMZwHnALS3+
	rm1N3Oah1Ud/JkQOCM7mdTQnL8kEJJbueX24JiFymTR5hiCxQsbhou
X-Google-Smtp-Source: AGHT+IFPiMu6R02rWAHgJHyS8H89E4Gtm86WBQGNMNVVx1dc8p/XHNJVYUx2D/pWbyru7YRqI58Y/w==
X-Received: by 2002:a5d:5888:0:b0:425:742e:7823 with SMTP id ffacd0b85a97d-429aef71db8mr1920294f8f.12.1761732991273;
        Wed, 29 Oct 2025 03:16:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df6b9sm26424044f8f.44.2025.10.29.03.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 03:16:30 -0700 (PDT)
Message-ID: <fde3dae1-bb11-45e8-9211-50ae003ca497@gmail.com>
Date: Wed, 29 Oct 2025 10:16:27 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] blame: make diff algorithm configurable
To: Antonin Delpeuch via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Antonin Delpeuch <antonin@delpeuch.eu>
References: <pull.2075.v2.git.git.1761658643278.gitgitgadget@gmail.com>
 <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2075.v3.git.git.1761686060477.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonin

On 28/10/2025 21:14, Antonin Delpeuch via GitGitGadget wrote:
> From: Antonin Delpeuch <antonin@delpeuch.eu>
> 
> The diff algorithm used in 'git-blame(1)' is set to 'myers',
> without the possibility to change it aside from the `--minimal` option.
> 
> There has been long-standing interest in changing the default diff
> algorithm to "histogram", and Git 3.0 was floated as a possible occasion
> for taking some steps towards that:
> 
> https://lore.kernel.org/git/xmqqed873vgn.fsf@gitster.g/
> 
> As a preparation for this move, it is worth making sure that the diff
> algorithm is configurable where useful.
> 
> Make it configurable in the `git-blame(1)` command by introducing the
> `--diff-algorithm` option and make honor the `diff.algorithm` config
> variable. Keep Myers diff as the default.
> 
> Signed-off-by: Antonin Delpeuch <antonin@delpeuch.eu>
> ---

Apart from a problem with clearing XDF_NEED_MINIMAL (which is really the 
fault of a terrible api) this is looking good.

> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -779,6 +779,19 @@ static int git_blame_config(const char *var, const char *value,
>   		}
>   	}
>   
> +	if (!strcmp(var, "diff.algorithm")) {
> +		long diff_algorithm;
> +		if (!value)
> +			return config_error_nonbool(var);
> +		diff_algorithm = parse_algorithm_value(value);
> +		if (diff_algorithm < 0)
> +			return error(_("unknown value for config '%s': %s"),
> +				     var, value);
> +		xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;

Unfortunately XDF_DIFF_ALGORITHM_MASK does not include XDF_NEED_MINIMAL 
so if the user has a config file that looks like
	
	[diff]
		algorithm = minimal
		algorithm = myers

We'll parse it as "minimal" rather than "myers"

As we need to reset the diff algorithm in a number of places I think it 
would be best to define a macro

     	#define CLEAR_DIFF_ALGORITHM(flags) \
		flags &= ~(XDF_DIFF_ALGORITHM_MASK | XDF_NEED_MINIMAL)

and use that where we want to reset the algorithm.
> +		xdl_opts |= diff_algorithm;
> +		return 0;
> +	}
> +
>   	if (git_diff_heuristic_config(var, value, cb) < 0)
>   		return -1;
>   	if (userdiff_config(var, value) < 0)
> @@ -824,6 +837,38 @@ static int blame_move_callback(const struct option *option, const char *arg, int
>   	return 0;
>   }
>   
> +static int blame_diff_algorithm_minimal(const struct option *option,
> +					const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +
> +	BUG_ON_OPT_NEG(unset);

This is a change in behavior as we currently accept "--no-minimal" which 
clears XDF_NEED_MINIMAL
> +	BUG_ON_OPT_ARG(arg);
> +
> +	*opt &= ~XDF_DIFF_ALGORITHM_MASK;

This is correct becase we're about to set XDF_NEED_MINIMAL so it does 
not matter that we leave it set here, but would still be clearer if it 
used the new macro I suggested above.

> +	*opt |= XDF_NEED_MINIMAL;> +	return 0;
> +}
> +
> +static int blame_diff_algorithm_callback(const struct option *option,
> +					 const char *arg, int unset)
> +{
> +	int *opt = option->value;
> +	long value = parse_algorithm_value(arg);
> +
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (value < 0)
> +		return error(_("option diff-algorithm accepts \"myers\", "
> +			       "\"minimal\", \"patience\" and \"histogram\""));
> +
> +	*opt &= ~(XDF_NEED_MINIMAL | XDF_DIFF_ALGORITHM_MASK);

This is correct

> +	*opt |= value;
> +
> +	return 0;
> +}
> +

> -		OPT_BIT(0, "minimal", &xdl_opts, N_("spend extra cycles to find better match"), XDF_NEED_MINIMAL),
> +		OPT_CALLBACK_F(0, "minimal", &xdl_opts, NULL,
> +			       N_("spend extra cycles to find better match"),

This is just copying the existing text so it is not a new problem but I 
think it would be better if we said "find a better" rather than "find 
better". We should prehaps think about hiding this option now that we 
support --diff-algorithm.

> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,

As I said above using PARSE_OPT_NONEG here is a regression

> +			       blame_diff_algorithm_minimal),
> diff --git a/t/t8015-blame-diff-algorithm.sh b/t/t8015-blame-diff-algorithm.sh
> new file mode 100755
> index 0000000000..efc4b47ce1
> --- /dev/null
> +++ b/t/t8015-blame-diff-algorithm.sh
> [...]
> +test_expect_success 'blame uses Myers diff algorithm by default for now' '

I'm not sure we need to say "for now" here.

> +	cat >expected <<-\EOF &&
> +	Commit_2 int g(size_t u)
> +	Commit_1 {
> +	Commit_2   while (u < 30)
> +	Commit_1   {
> +	Commit_2     u++;
> +	Commit_1   }
> +	Commit_2   return u;
> +	Commit_1 }
> +	Commit_1
> +	Commit_2 int h(int x, int y, int z)
> +	Commit_1 {
> +	Commit_2   if (z == 0)
> +	Commit_1   {
> +	Commit_2     return x;
> +	Commit_1   }
> +	Commit_2   return y;
> +	Commit_1 }
> +	EOF
> +
> +

There's an extra blank line here

> +	git blame file.c | \

We don't pipe the output git commands as it hides unexpected failures. 
Instead you should redirect the output of git to a file and then process 
that file with sed.

> +		sed -e "s/^[^ ]* (\([^ ]*\) [^)]*)/\1/g" | \
> +		sed -e "s/ *$//g" > actual &&

This can be a single process by passing -e twice. It does not really 
matter but neither pattern needs a trailing "g" as they only match once 
within the line.

> +test_expect_success 'blame gives priority to --diff-algorithm over diff.algorithm' '
> +	cat >expected <<-\EOF &&
> +	Commit_1 int g(size_t u)
> +	Commit_1 {
> +	Commit_1   while (u < 30)
> +	Commit_1   {
> +	Commit_1     u++;
> +	Commit_1   }
> +	Commit_1   return u;
> +	Commit_1 }
> +	Commit_2
> +	Commit_2 int h(int x, int y, int z)
> +	Commit_2 {
> +	Commit_2   if (z == 0)
> +	Commit_2   {
> +	Commit_2     return x;
> +	Commit_2   }
> +	Commit_2   return y;
> +	Commit_2 }
> +	EOF
> +
> +	git config diff.algorithm myers &&

You can use test_config() here which will clear the config setting at 
the end of the test. Alternatively you can save a couple of processes by 
using "git -c diff.algorithm=myers blame ...". This is setting the 
config to the default value, I wonder if it would be better to do

	git -c diff.algorithm=histogram blame --diff-algorithm=myers

instead.

The coverage looks good

Thanks

Phillip

