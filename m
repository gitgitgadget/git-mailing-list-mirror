Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A0B314A62
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536282; cv=none; b=LFc4Tn+aCEekLLpW82f3nNvob2fzX/XbVDl+v/CoEwiHLiN0VQKOJQRmLdgcM6vIjFgLbfy+qXcEarsnO2proUkTTporGwO+lyjtvyREYw7A2oWpsHA+5HA1PlwYRIF6p/DqdDl2hIG5WrNzLIf8GGV7+93b1qJZ705r9BeR1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536282; c=relaxed/simple;
	bh=RljUk2HyMBQSsdPkKSD59Twr+HH/MPEdSXLVH3OUfjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S41BDDKusiL2Q4H6Nddm4e8aGm0bxCR032vGykbI0kWPv+lDltnfcZ9SsJH5pcjkNGiafzQ/cPay5z8IPopYFfZ+1Lu+7YyNJRKQv1hgo5hK6TTqavg4c6xA4jRMbM2SwBzRADdhoFc4YMNxAAF/flqbf+raBj15MhRB8IhpcyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OkGjA3Bj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v+zGYGag; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OkGjA3Bj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v+zGYGag"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E28991D00045;
	Tue, 23 Dec 2025 19:31:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 23 Dec 2025 19:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766536278; x=1766622678; bh=Kq5WRQOcoT
	CgXAoRl/Bqi8YqVs8lKJCMvhA7kJeSu0k=; b=OkGjA3Bj2NHrxpjwxSMEeRLTJw
	04jk4JInogbVxbCyj6mD2cGuAIc55/SgVrglLDNS+hmTzpZPu+9NaJgGcJEofVQ5
	+MSKfCyrQM7dv5FouHWFdD3HFGhQfzKhpSFHBHqVztxkOMEX8R+FXVG4sDfqEJoF
	JJtxVVrWxGwpT/NKbfyO48mGX8jVe3N5aY3LaUcOO9z9cA7ZdMbQTxDvvzsP4s4T
	TdaGHYg+qCXwlwOfZj+0BcDdpYpcw9ku3E0QcRo3H1t+exGmkBAv+uwbWdHWouTB
	KXpGfFyli7QYK8t4450GZT3qW8x1ggvmi8I9Q7wBOhVe+YRAZRFycFCadwjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766536278; x=1766622678; bh=Kq5WRQOcoTCgXAoRl/Bqi8YqVs8lKJCMvhA
	7kJeSu0k=; b=v+zGYGagJXNRQe6o64moQgXDsOLjdK+h9td6FqlxKoho/z17SGD
	cRDHVkZ92HUAop74/TTUHS0OjPEVt61k4NCVIUndSQ5C73GkoCYxv5VjTz838ywu
	jk6NkNbtmtDk7VqIW8DSTMaNXE1HxiEuSsrspGrqwTAk/PVev+0A5Vl0T+S1wcVr
	0zKFMqXqspym16JG2GugZTeBKyvtocpkoYJGIw+cCu2KgQLlM0OaGaj1QG3Oew6y
	UEGm+kpZLzX6b+L/CZyY+f5tV7CKXo8sPwhB9rAy4nEOV3watjUz3BXkykVthmTg
	LE/3HhWDnESZSVCd2vtOAuNdWUruqhoiw5g==
X-ME-Sender: <xms:VjRLaV9zLnGW6L10HtlqMAy8jV6J4k20MDH161AxraGM4XZgO2PMxA>
    <xme:VjRLaQs6MQ2OqSlExywfwSX5phLAC0BNozO8S1Wbg8d3UDeghZVOTFF-gwKK3b7Rb
    A-NkwiMtkSe-mF2-HCBK3EcgXIJHXFYH0uCUrYj3_hxLzkwUMl->
X-ME-Received: <xmr:VjRLaYCmKVKNpPBrEFA-dO3S5K0Gh27CeGzPacasV2D39IiTRrfENEeZ-HDu_3O-dTms8hZD_iUU3k9YknkOSCT5zQSaRcL-SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiuddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffefvdelvddufeejgeduleetgeefgedugeehvedutdevieetvdejueduffej
    keenucffohhmrghinhepphhusghlihgtqdhinhgsohigrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhksh
    drihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:VjRLaYXycr6jvAqb5NpMF4SMG8wm_BvmuWaSiRTrWsebmM5inwhdSg>
    <xmx:VjRLaWD2sfJXejOztTCjxLtYLQTaAMzXNiqFLKtcQhg0xTKVUHLiDQ>
    <xmx:VjRLab90Nuhd6Eg55nL_1bcu3Kpor_l43oJqPAlGj1P5ucRd0cqfzg>
    <xmx:VjRLadFiEpYkJgLEYEXCN1ro6kjhD1ZTUPX_vsJ2XJXxdDVW1ECLSQ>
    <xmx:VjRLaSRAG7wVmR0leaCgJ7GRiHpzbwSyxQkbEUCgJKkYJPsGXxAa1t9I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Dec 2025 19:31:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] ws: add new tab-between-non-ws check
In-Reply-To: <20251223132756.604036-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Tue, 23 Dec 2025 15:27:56 +0200")
References: <20251223132756.604036-1-adrian.ratiu@collabora.com>
Date: Wed, 24 Dec 2025 09:31:16 +0900
Message-ID: <xmqq5x9wpvor.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> This adds a new check to detect HT in the middle of sentences that
> should have been a SP, as suggested by Junio in
> https://public-inbox.org/git/xmqqy0mwsedz.fsf@gitster.g/
>
> The check is a bit complex because we want to detect places where
> a SP was intended and the naive before/after character check can
> issue false positives in cases like "a\tb".

Add something like "where the tab expands to more than one display
column" at the end of the string, probably.  Otherwise what you
meant by "false positive" is unclear.

> +test_expect_success 'check tab between non-whitespace (tab-between-non-ws: off)' '
> +	git config core.whitespace "-tab-between-non-ws" &&
> +	printf "1234567\tb" >x &&
> +	git add x &&
> +	git diff --cached --check
> +'

I think the cases covered by these tests are wide enough.  The
feature covered by the code change in this patch is insufficient, so
when it is improved, the tests for missing features would need to be
added to each of these cases.

> @@ -228,6 +234,32 @@ static unsigned ws_check_emit_1(const char *line, int len, unsigned ws_rule,
>  		written = i;
>  	}
>  
> +	if (ws_rule & WS_TAB_BETWEEN_NON_WS) {
> +		/*
> +		 * A tab surrounded by non-whitespace characters is a typo candidate
> +		 * (a space might have been intended). This checks for a tab that
> +		 * would be expanded to a single space, which is when it appears at
> +		 * a column that is one less than a multiple of the tabwidth.
> +		 */
> +		int col = 0;
> +		int tabwidth = ws_tab_width(ws_rule);
> +
> +		if (!tabwidth)
> +			BUG("a known tabwidth is required by WS_TAB_BETWEEN_NON_WS");
> +
> +		for (i = 0; i < len; i++) {
> +			if (line[i] == '\t') {
> +				if (i > 0 && i < len - 1 &&
> +				    !isspace(line[i - 1]) && !isspace(line[i + 1]) &&
> +				    (col % tabwidth) == (tabwidth - 1))
> +					result |= WS_TAB_BETWEEN_NON_WS;
> +				col += tabwidth - (col % tabwidth);

Checking "i < len -1" is good.  We do not need to check for a tab at
the end of the string here, as it is *not* "between no-ws".  If a
file type does not want a trailing tab, it can be marked with
trailing-whitespace.

> +			} else {
> +				col++;
> +			}
> +		}
> +	}
> +
>  	if (stream) {
>  		/*
>  		 * Now the rest of the line starts at "written".
> diff --git a/ws.h b/ws.h
> index 06d5cb73f8..35475fd320 100644
> --- a/ws.h
> +++ b/ws.h
> @@ -16,6 +16,7 @@ struct strbuf;
>  #define WS_BLANK_AT_EOF         (1<<10)
>  #define WS_TAB_IN_INDENT        (1<<11)
>  #define WS_INCOMPLETE_LINE      (1<<12)
> +#define WS_TAB_BETWEEN_NON_WS   (1<<13)
>  
>  #define WS_TRAILING_SPACE       (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
>  #define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)

The above is sufficient to make "git diff --check" and "git apply
--whitespace=warn" notice, but the code change in this patch is not
sufficient.

 * Colored "git diff" output needs to highlight whitespace errors.
   diff.c:diff_colors[] tells us to use BG_RED to paint them by
   default.  At the end of ws_check_emit_1(), when stream is not
   NULL, we emit the middle segment as-is, but when this new
   whitespace error class is in effect, that part needs to paint the
   tab at 7th column between !isspace() bytes.  Introduce a helper
   function "static emit_middle_section()" to do so, perhaps.

 * "git apply --whitespace=fix" needs to turn such a HT to a SP.
   This is probably done in ws_fix_copy().

Thanks.
