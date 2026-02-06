Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74517AE11
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351072; cv=none; b=QC5qOERCORMd00q2I2kC6a604v7QBud+m3HB04mA1qB5LPeFbEURtsh6h8HeMUiyUQNOk2VonlO1EEMZYhXHJ5z+MpsF3yDNbn6V5RAu2pe6Tt5Oiri/MccBfpxJb0o9INtMnfhZnOn/m1jN98hEnrAWJW59/cK9RmEichPFDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351072; c=relaxed/simple;
	bh=JBZvLIh0HYCA1XXC3cOr55tjYUSYpOtSOXLUVOg4Zog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbF1jnf0MWR40/OrbISPik47g8JxuE1yk3dknwWm+4bGftBA0U0gfu1HAU3ewJNzW8YR9PdatyDZIQ4Ywab/838u0xKWBYAYPuEyvTUuq7hcvwzBmKXzoXgfiBDrOI9h9R/JzrwYuQNIPUHaGX785PGjI57XBgRREPk4ucmw/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=TMygb3/s; arc=none smtp.client-ip=212.27.42.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="TMygb3/s"
Received: from [192.168.43.16] (unknown [37.168.1.79])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id E56BFB0053E;
	Fri,  6 Feb 2026 05:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1770351069;
	bh=JBZvLIh0HYCA1XXC3cOr55tjYUSYpOtSOXLUVOg4Zog=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TMygb3/sYLhFjzF5Nwm97X2MV7tWyJkYEWIAK1kMCegUjxaupm1MpdZf2p8LQzDlh
	 X0JsYHA9pcSO0ck/l7sSd6kP3xKl3ieF3EPjsaiKC3Zv0v8y9Ca3l+A+8vcYtUfbde
	 HhjZx8JKFvm8pqySJ1o4id000viiSpKHx5g/EWGjllKNMywPdfUn3ghOeVawBtB5Ev
	 EiNNqySQbS3/zjfRzWziuRjxifjpwnd+Hz1uzKNiW3LaINtds4CAr7Y+FehXYC0rIC
	 c+XhO3Mm58AEfsy4NWjoCAKiu42DWkEvF5P8rzbLBdr5BkwCzr5Pq0ZBQH+yhZUZZb
	 UJrGBWzAwppiA==
Message-ID: <f1f65415-7a50-451e-9826-05e9d4e38b62@free.fr>
Date: Fri, 6 Feb 2026 05:11:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] config-batch: basic boilerplate of new builtin
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, Derrick Stolee <stolee@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
From: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Language: fr
In-Reply-To: <c4dab0609613bc5d43bce705dca2f057674a5d5b.1770214803.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/02/2026 à 15:19, Derrick Stolee via GitGitGadget a écrit :
> From: Derrick Stolee <stolee@gmail.com>
> 
> Later changes will document, implement, and test this new builtin. For now,
> this serves as the latest example of the minimum boilerplate to introduce a
> new builtin.
> 
> Recently, we updated the comment in builtin.h about how to create a new
> builtin, but failed to mention the required change to meson.build files for
> some CI builds to pass. Fix that oversight.
> 
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  .gitignore                          |  1 +
>  Documentation/git-config-batch.adoc | 24 +++++++++++++++++++++++
>  Documentation/meson.build           |  1 +
>  Makefile                            |  1 +
>  builtin.h                           |  7 +++++++
>  builtin/config-batch.c              | 30 +++++++++++++++++++++++++++++
>  command-list.txt                    |  1 +
>  git.c                               |  1 +
>  meson.build                         |  1 +
>  t/meson.build                       |  1 +
>  t/t1312-config-batch.sh             | 12 ++++++++++++
>  11 files changed, 80 insertions(+)
>  create mode 100644 Documentation/git-config-batch.adoc
>  create mode 100644 builtin/config-batch.c
>  create mode 100755 t/t1312-config-batch.sh
> 
> diff --git a/.gitignore b/.gitignore
> index 78a45cb5be..42640b5e24 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -44,6 +44,7 @@
>  /git-commit-graph
>  /git-commit-tree
>  /git-config
> +/git-config-batch
>  /git-count-objects
>  /git-credential
>  /git-credential-cache
> diff --git a/Documentation/git-config-batch.adoc b/Documentation/git-config-batch.adoc
> new file mode 100644
> index 0000000000..dfa0bd83e2
> --- /dev/null
> +++ b/Documentation/git-config-batch.adoc
> @@ -0,0 +1,24 @@
> +git-config-batch(1)
> +===================
> +
> +NAME
> +----
> +git-config-batch - Get and set options using machine-parseable interface
> +
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git config-batch' <options>

For this new manual page, please use the synopsis style:

[synopsis]
git config-batch <options>

Thanks
