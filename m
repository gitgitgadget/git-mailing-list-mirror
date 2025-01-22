Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6916BE3A
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737540680; cv=none; b=Z0TQOo+UMId4nDIr7RjD8/TPsNGaWWnqjlBL/J3BTQPXNmW0gJjE/g8qq1SydYXMGaz/pSf8cH8RFH+f5St+EowdbM4ffPe6Qp6tCxCNd2qVbzBrXjLAjVxtFSWbBBAWR78PfjT649fc6iwRD8E7tqxSMREZ6pQkJbZoGXDZU54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737540680; c=relaxed/simple;
	bh=ID1sBY3V8paj5Lec4Jm42V53jCFIc9diuSZsMvvqLgY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aQhGGdzcnf4OzldqbQSUW5V44Qs3u2dGEU5O/udIHBCOuv8exP0SpGEhomvkIsHcJOLTYcZ+XBLK++UO4CgdiSP88fMkTX+/czaIkFjQpMYDzeJ2kNdFCpHQhmi5vKd7XOhFwfp74cysS2ZmkPDQfJrJDzPH1ZRa3GwSzCUqhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AYcFoGV1; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AYcFoGV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737540675; x=1738145475;
	i=johannes.schindelin@gmx.de;
	bh=VSZdhUTTzdmOUiQDGME3Bn9ErvITJjMT3jLfTThAmiM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AYcFoGV1sKBY1KAgTcJfMyNDJA6balOKAR7ZZfNDx7Rp5r9tXHAtixghRs2jo2o3
	 3pfQIQXub4zXUMgbMl5lB8O12CrMOsqC6wb1y6vRPVdZal6dGkM+7XcvkTXF9uu5e
	 ozSH9EtnFnUSXdce8v7P9fo0wqtigiiQ3NLm0gbuRwiImaH4bVzqp/KtyfjoCTqaV
	 5BFF0bXboMS8Zl4GmdDqeM8nAdld0nHK0tfeS4f13ss5mWjOI/evN1TQ9jJD8Vcds
	 rRz/LlhHs0GMGk1T9MB0M8cG6ncm6wg6O4mwE+Et96mO2Pp6lIrYjScfIcV6ELxtT
	 sfmJWNR9ArWwuZ/9UA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1tsttp49Lf-00QSol; Wed, 22
 Jan 2025 11:11:15 +0100
Date: Wed, 22 Jan 2025 11:11:14 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Adam Murray via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Adam Murray <ad@canva.com>, 
    Adam Murray <ad@canva.com>
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where
 no value specified
In-Reply-To: <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
Message-ID: <c1398676-ddd7-c161-e114-2249316b5311@gmx.de>
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com> <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bctwMvbW3olsouoOvGWd8ax043uQicpuq7KAQACJW+Z+b0Zg7t8
 Nguihpj/QK+KD5Jo0XHdFFL1/WoslXFg2k4elerCAZezUUFdyPoNfPug4NZji6slH8CMMta
 bXExEj9XWXel87Qq/mZ58EfA11JEpesS/BMjp8bMRZY4zElAASR4dmDzRRo5QYcHc4hEUbe
 vtG3QaGljV+iJz1Jhr81A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Zj1nSWEQ60k=;onH3UX4O48FVCmOwtyqojmFtScw
 XXYHoYNmklPAukV5aTEwRaXu5ZMTZXIvrcAebbiX8BqFEKN07jAXu/T6Rhz9gPC/fxlFcCcON
 EcuiRY6hmlbKKYsEXvKHBO8n2CWruPuYG8ukCeiIrl9rbSQte3WaWUqJIuUqJ2H6hx+Xhi2N6
 rSJExppmZSSQpw5+qJKgH/A8RN6zql8YYaWoKjKSrJxAacGe9HkXstJNwZrsgmS7aflo7wMrQ
 Y9nQUZGC0pnhiL7joyhc5+7naYEzBpnYsL6C5pn/daCVrFanp6PFV5eSek/+4G7gCRlUXYXTk
 CwH4OBLOo98iWJH7l1jdA7G0kKpIWNcjMDC03q/CMfoCCUd+JeA8GLB1T2vTy13Qh9FV3J/8f
 evh3Bgsl5qQpDIJzPJXTi0ryuDpWQeleXNFKIYdXtkLAoZEwPKsYsw9S4/hP4GfZdJG3rilpA
 XAcAR5QU8Hi7mDZL7w9NIiGIDqdNG5P7XLpSFhFh+saMKf1hlWEO7vlqFrEuyll/Rzku5fI+b
 fdNY+N+ES3fQ4l2ZApRn/p5LXvWa67a1U7YbICxiuaSLnvflwsrrAVyJTRdLDqupuVW/or78O
 47e+utdoTG3H0rhvR0y3H8RxLB2DKuwfbWEqL4X5RKtsyOFOKwxpWFQj4gLYEVYnflYo8yD37
 lPCIafI+r8ZhypKjMYF3OfXAhKeR/t76qweEHAyP9VFuXCF6QzMZ2fkTWqjYDVAZ8LcvA1Ur0
 6p11QtAlg6N/Lah7TsAkDCJIGMpe4fQxFZ6zpy7NFCqpAELhmCN+opTQjNTRzcEymPfYEIgeX
 qB6Il3vByAayp/vHww0voHxYdHe05ZA/HefE3HXOwpm/u0MLHLk7+JM40mBjJuNpjq+GRpld8
 wOHoFfdGD49w5uohiJl3RSp/nxGVjP6U6dFcwHOS+TL3En8c3W3Y68WcQwaGnbRbYPoruBOA4
 1stHpkRWsRuj3zFip/KmT4by9HA61y3z9G8XaOLFXCxcHsHHB8rC8AZDfxxkcmhTtUgmLQLIX
 Lr2EtY+/Dl+BUjRR7ro9IMmZHrMO/o49NDWxtdvaK3D2GSU0ylVOp7xYb6YxLVpLL2ZAAhLMF
 Eazso3d7fGUT4e5tYKifxgO4m3ZT4A/DnVd/8diC1pMylSn/l/di2JHjteyN8wDeI2eN/v+3j
 yzdAUuwVy3gUXvHrLaCZXQU6Lw+vvGzLhUzkEX26cC3Jp8wVox6t1S8xAdO6Q9WpMBfA0m92V
 sIcjqydAIeCx
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Fri, 10 Jan 2025, Adam Murray via GitGitGadget wrote:

> From: Adam Murray <ad@canva.com>
>
> When TRACE2 analytics is enabled, a git config option that has no value
> causes a segfault.
>
> Steps to Reproduce
> GIT_TRACE2=3Dtrue GIT_TRACE2_CONFIG_PARAMS=3Dstatus.*
> git -c status.relativePaths version
> Expected Result
> git version 2.46.0
> Actual Result
> zsh: segmentation fault GIT_TRACE2=3Dtrue
>
> This adds checks to prevent the segfault and instead return
> an empty value.
>
> Signed-off-by: Adam Murray <ad@canva.com>

This patch looks good to me!

Thank you for the fix,
Johannes

> ---
>     trace2: prevent segfault on config collection where no value specifi=
ed
>
>     cc: Jeff King peff@peff.net
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1814%2=
Fad-murray%2Ffix-trace2-segfault-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1814/ad-m=
urray/fix-trace2-segfault-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1814
>
> Range-diff vs v1:
>
>  1:  24ba9db7aa1 ! 1:  fd7bed52dda trace2: prevent segfault on config co=
llection where no value specified
>      @@ Commit message
>           Actual Result
>           zsh: segmentation fault GIT_TRACE2=3Dtrue
>
>      -    This adds a null check to prevent the segfault and instead ret=
urn
>      -    the "empty config value" error.
>      +    This adds checks to prevent the segfault and instead return
>      +    an empty value.
>
>           Signed-off-by: Adam Murray <ad@canva.com>
>
>      @@ t/t0210-trace2-normal.sh: test_expect_success 'bug messages foll=
owed by BUG() ar
>
>        ## trace2.c ##
>       @@ trace2.c: void trace2_def_param_fl(const char *file, int line, =
const char *param,
>      - 	int j;
>      - 	const char *redacted;
>      -
>      --	if (!trace2_enabled)
>      -+	if (!trace2_enabled || !value)
>      + 	if (!trace2_enabled)
>        		return;
>
>      - 	redacted =3D redact_arg(value);
>      +-	redacted =3D redact_arg(value);
>      ++	redacted =3D value ? redact_arg(value): NULL;
>      +
>      + 	for_each_wanted_builtin (j, tgt_j)
>      + 		if (tgt_j->pfn_param_fl)
>      +
>      + ## trace2/tr2_tgt_event.c ##
>      +@@ trace2/tr2_tgt_event.c: static void fn_param_fl(const char *fil=
e, int line, const char *param,
>      + 	event_fmt_prepare(event_name, file, line, NULL, &jw);
>      + 	jw_object_string(&jw, "scope", scope_name);
>      + 	jw_object_string(&jw, "param", param);
>      +-	jw_object_string(&jw, "value", value);
>      ++	if (value)
>      ++		jw_object_string(&jw, "value", value);
>      + 	jw_end(&jw);
>      +
>      + 	tr2_dst_write_line(&tr2dst_event, &jw.json);
>      +
>      + ## trace2/tr2_tgt_normal.c ##
>      +@@ trace2/tr2_tgt_normal.c: static void fn_param_fl(const char *fi=
le, int line, const char *param,
>      + 	enum config_scope scope =3D kvi->scope;
>      + 	const char *scope_name =3D config_scope_name(scope);
>      +
>      +-	strbuf_addf(&buf_payload, "def_param scope:%s %s=3D%s", scope_na=
me, param,
>      +-		    value);
>      ++	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, p=
aram);
>      ++	if (value)
>      ++		strbuf_addf(&buf_payload, "=3D%s", value);
>      + 	normal_io_write_fl(file, line, &buf_payload);
>      + 	strbuf_release(&buf_payload);
>      + }
>      +
>      + ## trace2/tr2_tgt_perf.c ##
>      +@@ trace2/tr2_tgt_perf.c: static void fn_param_fl(const char *file=
, int line, const char *param,
>      + 	struct strbuf scope_payload =3D STRBUF_INIT;
>      + 	enum config_scope scope =3D kvi->scope;
>      + 	const char *scope_name =3D config_scope_name(scope);
>      +-
>      +-	strbuf_addf(&buf_payload, "%s:%s", param, value);
>      ++	strbuf_addstr(&buf_payload, param);
>      ++	if (value)
>      ++		strbuf_addf(&buf_payload, ":%s", value);
>      + 	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>      +
>      + 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
>
>
>  t/t0210-trace2-normal.sh | 8 ++++++++
>  trace2.c                 | 2 +-
>  trace2/tr2_tgt_event.c   | 3 ++-
>  trace2/tr2_tgt_normal.c  | 5 +++--
>  trace2/tr2_tgt_perf.c    | 5 +++--
>  5 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
> index b9adc94aab4..4047ab562a4 100755
> --- a/t/t0210-trace2-normal.sh
> +++ b/t/t0210-trace2-normal.sh
> @@ -244,6 +244,14 @@ test_expect_success 'bug messages followed by BUG()=
 are written to trace2' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'empty configuration values are handled' '
> +  test_when_finished "rm trace2.normal actual expect" &&
> +  echo >expect &&
> +  GIT_TRACE2=3D"$(pwd)/trace2.normal"  GIT_TRACE2_CONFIG_PARAMS=3Dfoo.e=
mpty \
> +	  git -c foo.empty config foo.empty >actual &&
> +	test_cmp expect actual
> +'
> +
>  sane_unset GIT_TRACE2_BRIEF
>
>  # Now test without environment variables and get all Trace2 settings
> diff --git a/trace2.c b/trace2.c
> index f894532d053..49e7d1db88f 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -762,7 +762,7 @@ void trace2_def_param_fl(const char *file, int line,=
 const char *param,
>  	if (!trace2_enabled)
>  		return;
>
> -	redacted =3D redact_arg(value);
> +	redacted =3D value ? redact_arg(value): NULL;
>
>  	for_each_wanted_builtin (j, tgt_j)
>  		if (tgt_j->pfn_param_fl)
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 45b0850a5ec..8e09485c83c 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -491,7 +491,8 @@ static void fn_param_fl(const char *file, int line, =
const char *param,
>  	event_fmt_prepare(event_name, file, line, NULL, &jw);
>  	jw_object_string(&jw, "scope", scope_name);
>  	jw_object_string(&jw, "param", param);
> -	jw_object_string(&jw, "value", value);
> +	if (value)
> +		jw_object_string(&jw, "value", value);
>  	jw_end(&jw);
>
>  	tr2_dst_write_line(&tr2dst_event, &jw.json);
> diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
> index baef48aa698..924736ab360 100644
> --- a/trace2/tr2_tgt_normal.c
> +++ b/trace2/tr2_tgt_normal.c
> @@ -307,8 +307,9 @@ static void fn_param_fl(const char *file, int line, =
const char *param,
>  	enum config_scope scope =3D kvi->scope;
>  	const char *scope_name =3D config_scope_name(scope);
>
> -	strbuf_addf(&buf_payload, "def_param scope:%s %s=3D%s", scope_name, pa=
ram,
> -		    value);
> +	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
> +	if (value)
> +		strbuf_addf(&buf_payload, "=3D%s", value);
>  	normal_io_write_fl(file, line, &buf_payload);
>  	strbuf_release(&buf_payload);
>  }
> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index a6f9a8a193e..19ae7433ef8 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -446,8 +446,9 @@ static void fn_param_fl(const char *file, int line, =
const char *param,
>  	struct strbuf scope_payload =3D STRBUF_INIT;
>  	enum config_scope scope =3D kvi->scope;
>  	const char *scope_name =3D config_scope_name(scope);
> -
> -	strbuf_addf(&buf_payload, "%s:%s", param, value);
> +	strbuf_addstr(&buf_payload, param);
> +	if (value)
> +		strbuf_addf(&buf_payload, ":%s", value);
>  	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
>
>  	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,
>
> base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
> --
> gitgitgadget
>
>
