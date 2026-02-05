Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE47B28BA95
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313015; cv=none; b=hdZApws1u79rIs7Mx9QGY4wmZW1XqPRkY8M5RGBn7HEb8THMSau5sHyDc091Wr+8+5zEUAGbVvuMgnigCAYKEMa7J0sE93bI5CiwkwFOp8btsiH0DK5XtSqDNqejXOw0dUicOD3GFneAX+aBUwy7U0lgP8hKfJLJMHGPKi1gRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313015; c=relaxed/simple;
	bh=PahO5t4qAzcgOhBpbAuy1zRjtfbbfAfvmpR6hDsU3pQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=K1gpwGE3SjpyUyE3gcOQoyV8Vgbl6KDHVRoNAdmjIqBnngpx2t4BALyWypOJR61fbza+9Dd9k7TY/doeFrUtPshH7AwA06bU6jV8GKmjZ1nVNbM9WAg5YGMQhZImlwfyrKZohMcrKVkrtrRPpbjnEqoQhuvZEwabJHAPHSZoOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=bJi4t+vP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VzsHRvsw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="bJi4t+vP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VzsHRvsw"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CC96EC000A;
	Thu,  5 Feb 2026 12:36:54 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 05 Feb 2026 12:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770313014;
	 x=1770399414; bh=uVXg09OwkdLW4TinQGZo9UGFWQM9CsKzVVLWko9r0Fw=; b=
	bJi4t+vPk0F+3UyKO2RY2Xd6S6qSgin+a3jjEqM/2s32OxZOmQO43TvMtBIBQnNx
	OsIQOosGmVm0TrlR5dcEkXQeYME/c1FlBuZNuilBy1hauUjASUFs4MYgIXDVjQEN
	eM2bYZLdliXDJgDyff1KwinjK4CiXeNS4Zmwpwa+SJTtHEQpF8wHNMya8iZuKeyK
	JQuEy18W1Kpn+gYDJLTRB2EVq1s1RpQ+RcqeeTHTJyB/jZu/qXe/FMHjAGN+iUBG
	RWX1c/Hb/ouYdTVG+ZAhzDpobECcgshMbaPVyJ7oSCPdYfvNDDr81inh1sybCyKK
	+Py0eDRoeJ+TJp3mz8JZpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770313014; x=
	1770399414; bh=uVXg09OwkdLW4TinQGZo9UGFWQM9CsKzVVLWko9r0Fw=; b=V
	zsHRvswgFf80oHy5eyXKfYV9sqaHee6pwDuNJzBA2VFqIrV6PkxsvGiCqDr7GIqX
	BoKhd2JSJBATJDJO6vNyvut0k+3lXQdhIbcCjcQ1vVlQZMgN29SjYrLd+BHd3K6O
	atp86IgEN5wk4BxCF/dovi5MAf8Fvx5bZTG3qFXB+vfsRl8FKIuFDh5yKYHMnVzw
	TsyHU+SyKoLulXsBr2T5UC1rFkDigqXgzsoKIXb0pANIIcBr3PHjVYECnfZNJ9MO
	+r32ku8rGpafgKkDXZMGRfRSIiOQmbw1ua7+Qa5eYOyxRNXI9Zy/vbALhFBlCxAG
	4U6qYC3yTXnmar1Si8L6Q==
X-ME-Sender: <xms:NtWEaTY-t6MryKGOKOk1gD-MqEqw5XNVK80QzsKyOWKbkc7rbOTBNx8>
    <xme:NtWEadPUQGA1w78dynJ-FjgdN7LVe6rsw1OM4ynIulDS9aYylJgqeRUFADBq-CTso
    30equSiQiZb80aqFLqsbp9rrtjdM-B1TOqsw-_wmqZTGmZt78VvDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgedtjeeiteeg
    hfeutdeutddtiefgvdegteektdeutddugfekleeugfelteffjeffnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:NtWEaYBfrZkh372mon9fGBa-um9PSWZIby8o9l-0ssWxu-VneaFHag>
    <xmx:NtWEaYW3vhWFSc3Sm_YiIYs0eX0E7gjGofiCrNhGGBs6o3WB4ghBnA>
    <xmx:NtWEaWDX8swIIT7VQTETlyKIWPslrvJdgumhXGWoXE1QIZATHHWWMQ>
    <xmx:NtWEab9B_IsSDYiv1MDpZrv5y3W1p6VvfRCymToFh6PAyWey1ztFTg>
    <xmx:NtWEaTGhVbkKMz_B37tGRy4OVE-NU_tIWz_4V2eJwgSZSu-eYvCUJPSX>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0D9341EA006C; Thu,  5 Feb 2026 12:36:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A2XJfbkGeYzJ
Date: Thu, 05 Feb 2026 18:36:33 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>, "Derrick Stolee" <stolee@gmail.com>
Message-Id: <bd2dbd12-e12f-467c-983b-f7e9a31e1d92@app.fastmail.com>
In-Reply-To: 
 <59d19fee5f5bd34c5864bebb8243afdc6bc9ea7a.1770214803.git.gitgitgadget@gmail.com>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <59d19fee5f5bd34c5864bebb8243afdc6bc9ea7a.1770214803.git.gitgitgadget@gmail.com>
Subject: Re: [PATCH 11/11] config-batch: add unset v1 command
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Feb 4, 2026, at 15:20, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <stolee@gmail.com>
>
> Add a new 'unset' command with version 1 that mimics 'git config
> --unset' with optional regex pattern or '--fixed-value' arguments.

`git config --unset` is deprecated in favor of `git config unset`.

>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-config-batch.adoc | 28 ++++++++
>  builtin/config-batch.c              | 99 +++++++++++++++++++++++++++++
>  t/t1312-config-batch.sh             | 61 ++++++++++++++++--
>  3 files changed, 181 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-config-batch.adoc
> b/Documentation/git-config-batch.adoc
> index feec85c4ef..bdfd872d65 100644
> --- a/Documentation/git-config-batch.adoc
> +++ b/Documentation/git-config-batch.adoc
> @@ -135,6 +135,34 @@ set 1 success <scope> <key> <value>
>  set 1 failed <scope> <key> <value>
>  ------------
>
> +`unset` version 1::
> +	The `unset` command removes a single value from a config file.
> +	It specifies which file by a `<scope>` parameter from among
> +	`system`, `global`, `local`, and `worktree`. The `<key>` is the
> +	next positional argument. There could be two additional
> +	arguments used to match specific config values, where the first
> +	is either `arg:regex` or `arg:fixed-value` to specify the type
> +	of match.
> ++
> +------------
> +unset 1 <scope> <key>
> +unset 1 <scope> <key> arg:regex <value-pattern>
> +unset 1 <scope> <key> arg:fixed-value <value>
> +------------
> ++
> +These uses will match the behavior of `git config --unset --<scope> <key>`

Same as above.

> +with the additional arguments of `<value-pattern>` if `arg:regex` is
> +given or `--fixed-value <value>` if `arg:fixed-value` is given.
> ++
> +The response of these commands will include a `success` message
> +if matched values are found and removed as expected or `failed` if an
> +unexpected failure occurs:
> ++
> +------------
> +unset 1 success <scope> <key>
> +unset 1 failed <scope> <key>
> +------------
> +
>  NUL-Terminated Format
>  ~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/config-batch.c b/builtin/config-batch.c
> index 373b0cad47..25a942ba61 100644
> --- a/builtin/config-batch.c
> +++ b/builtin/config-batch.c
> @@ -17,6 +17,7 @@ static int zformat = 0;
>  #define HELP_COMMAND "help"
>  #define GET_COMMAND "get"
>  #define SET_COMMAND "set"
> +#define UNSET_COMMAND "unset"
>  #define COMMAND_PARSE_ERROR "command_parse_error"
>
>  static void print_word(const char *word, int start)
> @@ -445,6 +446,99 @@ cleanup:
>  	return res;
>  }
>
> +/**
> + * 'unset' command, version 1.
> + *
> + * Positional arguments should be of the form:
> + *
> + * [0] scope ("system", "global", "local", or "worktree")
> + * [1] config key
> + * [2] config value
> + * [3*] match ("regex", "fixed-value")
> + * [4*] value regex OR value string
> + *
> + * [N*] indicates optional parameters that are not needed.
> + */
> +static int unset_command_1(struct repository *repo,
> +			 const char *prefix,
> +			 char *data,
> +			 size_t data_len)
> +{
> +	int res = 0, err = 0, flags = 0;
> +	enum config_scope scope = CONFIG_SCOPE_UNKNOWN;
> +	char *token = NULL, *key = NULL, *value_pattern = NULL;
> +	size_t token_len;
> +	struct config_location_options locopts = CONFIG_LOCATION_OPTIONS_INIT;
> +
> +	if (!parse_token(&data, &data_len, &token, &err) || err)
> +		goto parse_error;
> +
> +	if (parse_scope(token, &scope) ||
> +	    scope == CONFIG_SCOPE_UNKNOWN ||
> +	    scope == CONFIG_SCOPE_SUBMODULE ||
> +	    scope == CONFIG_SCOPE_COMMAND)
> +		goto parse_error;

I think this should get braces since it has many lines? Or maybe
multi-line conditionals are excempt.

> +
> +	if (!parse_token(&data, &data_len, &key, &err) || err)
> +		goto parse_error;
>[snip]
