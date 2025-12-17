Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309B369995
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979483; cv=none; b=gLxoP13wZAHJ6vlx3rnocahejBLmB3v3FCnGr4lQ3GeaLdJWhQ5kOHdDlGKGC7XlMlbH1HltxGbaP59nQS7lcAsk+3ygk1U//2m3MWOJigyaIRjwgbSDl/XGNcfGRVKE9tQy2x+TR7l6LQpNjRG0Ov1WIGABzxSLaWfbxYUpCGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979483; c=relaxed/simple;
	bh=3UfKwy7qiCAplMZ6gglb6rFlS+u4w0qoCdU4r1A/ums=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYnG7/LwTX/8AAUeGcnld1rJEHaWFtaFGYnMDG2HK5Mjmwu/+hCJevhh1lre8Irt+NAkkWMaVGR4crmZfGBojg0UCJYKsLN1si18MHJIQS6eFFJKMc6+cKKOSvyS0d5HEoTKeDEIj0J5ie75/Ff6xZG3gkBw+zo0kgqGHDnKUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dWZvh6Wpbz7QjwB
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:51:12 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dWZvW5J7QzRqq5;
	Wed, 17 Dec 2025 14:51:03 +0100 (CET)
Message-ID: <7bde8cd7-7487-4270-98e5-ab598b0a91d1@kdbg.org>
Date: Wed, 17 Dec 2025 14:51:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] commit: document that $command.signoff will not be
 added
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <xmqqldj48pyl.fsf@gitster.g> <xmqqv7i62r6w.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqv7i62r6w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 16.12.25 um 19:54 schrieb Junio C Hamano:
> Every now and then we see this coming up on the list.  Let's help
> new contributors who are not aware of past discussions by clearly
> documenting our past consensus.
> 
> Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Elijah Newren <newren@gmail.com>
> Helped-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * The text is from Elijah and Johannes this round; I am merely
>    playing a copybot.
> 
>  Documentation/gitfaq.adoc         | 19 +++++++++++++++++++
>  Documentation/signoff-option.adoc |  4 ++++
>  2 files changed, 23 insertions(+)
> 
> diff --git c/Documentation/gitfaq.adoc w/Documentation/gitfaq.adoc
> index f2917d142c..0e40befb77 100644
> --- c/Documentation/gitfaq.adoc
> +++ w/Documentation/gitfaq.adoc
> @@ -83,6 +83,25 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
>  which quotes the filename with spaces and specifies the `--nofork` option to
>  avoid backgrounding the process.
>  
> +[[sign-off]]
> +Why not have `commit.signoff` and other configuration variables?::
> +	Git intentionally does not (and will not) provide a
> +	configuration variable, such as `commit.signoff`, to
> +	automatically add `--signoff` by default.  The reason is to
> +	protect the legal and intentional significance of a sign-off.
> +	If there were more automated and widely publicized ways for
> +	sign-offs to be appended, it would become easier for someone
> +	to argue later that a "Signed-off-by" trailer was just added
> +	out of habit or by automation, without the committer's full
> +	awareness or intent to certify their agreement with the
> +	Developer Certificate of Origin (DCO) or a similar statement.
> +	This could undermine the sign-off’s credibility in legal or
> +	contractual situations.
> ++
> +There exists `format.signoff`, but that is a historical mistake, and
> +it is not an excuse to pile on more mistakes of the same kind on top.

I feel that we should s/pile on/pile/, but I am not a native speaker.

This patch looks good with or without this change.

> +
> +
>  Credentials
>  -----------
>  
> diff --git c/Documentation/signoff-option.adoc w/Documentation/signoff-option.adoc
> index cddfb225d1..9a80d60f1b 100644
> --- c/Documentation/signoff-option.adoc
> +++ w/Documentation/signoff-option.adoc
> @@ -16,3 +16,7 @@ endif::git-commit[]
>  +
>  The `--no-signoff` option can be used to countermand an earlier `--signoff`
>  option on the command line.
> ++
> +Git does not (and will not) have a configuration variable to enable
> +the `--signoff` command line option by default; see the
> +`commit.signoff` entry in the gitfaq for more details.

-- Hannes

