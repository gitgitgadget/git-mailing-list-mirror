Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274993EBF19
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770353358; cv=none; b=cjZK/1ZVLYTWRIaKDNwWh8l0zWIU00v8lDfYgBCUM1igxhzrzPOCduoTInRq5du1eE+ZW5TG5dTRkWYqVNK5xElaSylD5Z7/14wNi81MrbREvOvhTT2tkrhCJt9sHZSFlatUd73zo/ruJ+u6h2W+uZ8TSTYBJAzLKSOyxcfzXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770353358; c=relaxed/simple;
	bh=PEQSH/dwe25D7qZTRnkB5SCToo51ByjGHKILneCrx0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohccDKADE1x+gxXe2AQAz9DrLmfL/P3TGjEoZAtGam63ttKcmoEmSE3e/p0p1XitB7vuosfpLK6wVbVNotE7IV+nxVy6BoThfU0quDnpFlrX5BRWjQdynRi9z6fWfqo+fd6C/B9vj1xEd6oHib1xSnL4bzWJQO7B3M+dV3M45aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=l2XaJgzx; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="l2XaJgzx"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id E23E0B00535;
	Fri,  6 Feb 2026 05:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770353356;
	bh=PEQSH/dwe25D7qZTRnkB5SCToo51ByjGHKILneCrx0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l2XaJgzx84DwkpdzQKOnQlHB5JVyQ4sO6LCnIxlFLofemtT78pXVeBbH/NvXz+Cbv
	 Po8tB0CdCodAFUeHri7EDlunDL5uohe3pvxdfocEqafrCsV0QT0PUIH3giohoFlrk4
	 W+QHVDFcocFGxTlNUGd5VsbQwr2NKVsuCz0qo+krPNERm0iNLl8ESkw1JW9Tx0pIwL
	 gJBxL4RDnKQ/5j9QXq7Jp03A8nEK5ENaJAa0IjEoJIOdGa39PzyIjbPSYio8b4CRNY
	 CUtkDrRkUCF04lI5gKJ3NF+fvE3V2nRLzKlOpANK+TLPLwKd71Gmc79QrYOzsNtmZy
	 h/V1qNYghDEfQ==
Message-ID: <a023e4a2-e58f-49c7-83ee-a84554b83bc6@free.fr>
Date: Fri, 6 Feb 2026 05:49:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] config-batch: create 'help' command
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <d5e0c32497581e6ac4890c6e71c5c33b92d67d51.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <d5e0c32497581e6ac4890c6e71c5c33b92d67d51.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> Tools that use the 'git config-batch' tool will want to know which commands
> are available in the current Git version. Having a 'help' command assists
> greatly to give a clear set of available commands and their versions.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc | 17 +++++++++++++++
>  builtin/config-batch.c              | 32 +++++++++++++++++++++++++++++
>  t/t1312-config-batch.sh             | 13 ++++++++++++
>  3 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> index 31dd42f481..1fff68a13c 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -38,6 +38,23 @@ unknown_command LF
>  
>  These are the commands that are currently understood:
>  
> +`help` version 1::
> +	The `help` command lists the currently-available commands in

The boilerplat text "The `help` command" is not very useful to the
reader. The new usage is to directly state the command in imperative mood:

List the currently...

> +	this version of Git. The output is multi-line, but the first
> +	line provides the count of possible commands via `help count <N>`.
> +	The next `<N>` lines are of the form `help <command> <version>`
> +	to state that this Git version supports that `<command>` at
> +	version `<version>`. Note that the same command may have multiple
> +	available versions.

Placeholder punning to keep a consistency between the command and its
description. Good!

> ++
> +Here is the currentl output of the help text at the latest version:

current

It may not be wise to talk about the "latest version". If the manpages
and the git command are out of sync (the user compiles her own git
version, but does not update the man pages), this may be confusing.

Is this specification of version critical to the understanding?


> ++
> +------------
> +help 1 count 2
> +help 1 help 1
> +help 1 get 1
> +------------
> +
>  `get` version 1::
>  	The `get` command searches the config key-value pairs within a
>  	given `<scope>` for values that match the fixed `<key>` and
