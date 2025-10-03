Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAC234BA50
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759499277; cv=none; b=ZVb2EAl0Vs5ayD1SJsVpDu4kdFi8I3WlMKpF0fX1GkjsEwGcLfbfsKQ6gm+aQM/jWXWknNF4tPVjef+AgdR5vFQgGhXhW6mJwaxtOTpfdUcccumoUlXRFysRan94wmBWb0kY2ezZQlu+YCuEblbHXFErru7NR624QBdnDKDaMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759499277; c=relaxed/simple;
	bh=y2MY2JhljzdeeLNlLii4shyPyH2VB/R47E27dfX6Kjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cj2cdXvctji+TWRcQ96Bdqk7gAfzsHZh/h6zuYDtg/j5rJbyU6GTBP0BATrMxndH1Zu1XObVPrPXTBJL7AMDmh2JoTO0S0E94uvk1Biv5i0Beof7aiD7C0usomqG+D7eIcapjqjim3iH4gwq2f7u4icGrVGSRH4+O6frWDuFKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUv6Pvzj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUv6Pvzj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e542196c7so19487355e9.0
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759499273; x=1760104073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dGccFQfZMquzZ2IpFcJrNrYLnHzrcAlMq8TPcJWVsnw=;
        b=HUv6PvzjbdNvBN9Y82fPoRusiG+AUcQKHWD/M4Exism2WqodzFSECkOG8MXiQk1udc
         zcGTtLJ2Mkcw67qyk2RMkavbplEvXnDu9lXecegiG6Do042/PSejArd8uDVE+rky/qtZ
         oqCkjnOvT4PDtGrVuz56Nq8rMpC+JoszELNKLOgQMSHCWRjel76jrAbLPwWKc8EoRje0
         aMJPToTbrMKwgbuhtIK/NJQtlgwaNQVz6xIIOHaiOs7Q8moIKCT5kcTRMgpPmxcGdl8i
         mdtQEaYfDiaNMg/GylhLURiApiSFuC40U4QeININ9kQ8vd0TMcuxa1PM4ZaRPbVkhcee
         n0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759499273; x=1760104073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGccFQfZMquzZ2IpFcJrNrYLnHzrcAlMq8TPcJWVsnw=;
        b=WknFKzXmIU+J8lbMXmbHB/hJIkK6HQJ6mJdQF3+Bh18yVqSQ4omJURG2kIP+DpCL3U
         svbikq6XuOrLmp8jakjrBugxZibo3fq2wtv6tguVL3tVpqgiTTcfAKEcHQMtTZgu1ey3
         RnwAimIVuxdYv6xLPzhOk/rqH9a5spDZHLTUvodLe8OfaprjwWmlHUsDBIcy0Dxn0z4g
         CHGEuk6q3Yovk3kr1CYR71B/3yPHHjbkt9bkwNHJXRMV0Zjuj8M4vdfxpvZjJFFVCIqs
         m+TEwXMSmUeubTjRuoUfZ669IY+MH/4OvXeGp6FsJRUe3xFuQUgR4Yeroh448+axqaNT
         +SsA==
X-Forwarded-Encrypted: i=1; AJvYcCXrTkTdxAaMgXaBroXMHjJiVfDXtOghQ/VEDg5qQEaukgcHV2lYWpAXLLCsMdg+ISTXC5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4oYzz8iOXc+a/5ijpr0soyW3Qjsu92QvEkv5dvCWtOwgbzRP
	D0gc9jYdTSRNJTQgv2MDnWFdfOicmblnwdExYhLKdtuKfPqDyIUAOVVr
X-Gm-Gg: ASbGncv6VD5DXEx28jDd7t+TMO7/c50974xxK2TNlQ63VUaPDtrFE4EWc8cdRhWGYyA
	ddwIo7IDRp4kjz5O+D4KOVEJXvtq6d3jTFDaaD4eCRLulrUir/ZLmGyiF8wedmK+DYBhMuYtAB0
	AUxBzWyZl/M4YO6uIrdL0qLA0QzCJZZcBeE3xMjDuK5Yt6eN/oYpWoMvsxNoXyMpKaG7Bhw3D7i
	gnRRYPVGHD9opcHMXN1T7yedKkvbQc2gcj34VEwq5BjfgQ2sz9hy07D/8Mf8bpDLE5W8OgbwLu2
	ozhIx5Md5u3O7llTAVG6YWMq9vwY8/mZ4hQhb4v1ah9fNDiT/+LFQjNC4ky4gJlOPpjqe79Dv7J
	3R06zSgvCI2CfT00JkF2HBpHjaNiFkUZovXDC50wtREkNWuACvh2A6fxMTGcvUaLxV7DwrNWttv
	11d8nRj08HD9d2VhjeileXLzkQcJb4FuHPxw==
X-Google-Smtp-Source: AGHT+IHKpLDul57m3VLLigpQbGr6cRizlemJzaXeTB7At5d96QsJHLAOHjsM5lVm8f0wWybkYMcGMQ==
X-Received: by 2002:a05:600c:1d05:b0:46e:477a:f3e3 with SMTP id 5b1f17b1804b1-46e70cb75c3mr21563445e9.18.1759499273002;
        Fri, 03 Oct 2025 06:47:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4abcsm8008415f8f.53.2025.10.03.06.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 06:47:52 -0700 (PDT)
Message-ID: <01959215-3cb5-4c12-91eb-1b28e18addf9@gmail.com>
Date: Fri, 3 Oct 2025 14:47:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>,
 Jeff King <peff@peff.net>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com>
 <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2048.v6.git.git.1758926520.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ezekiel

On 26/09/2025 23:41, Ezekiel Newren via GitGitGadget wrote:
> Changes since v5.
> 
>   * Address review feedback on commit messages.
>   * Drop commit "xdiff: delete rchg aliasing"
>   * Use DISCARD/KEEP/INVESTIGATE instead of NONE/SOME/TOO_MANY
>   * Fix the word wrapping in the comments of xprepare.c

Thanks for expanding the commit messages, I think the range diff looks 
good. There's a typo in patch 12 (see below) but its not worth 
re-rolling just for that.

> Range-diff vs v5:
> [...] 
>   12:  08a0fceb72 ! 11:  f08782a977 xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
>       @@ Metadata
>        Author: Ezekiel Newren <ezekielnewren@gmail.com>
>        
>         ## Commit message ##
>       -    xdiff: use enum macros NONE(0), SOME(1), TOO_MANY(2) in xprepare.c
>       +    xdiff: add macros DISCARD(0), KEEP(1), INVESTIGATE(2) in xprepare.c
>        
>       -    Rename dis1, dis2 to matches1, matches2.
>       +    This commit is refactor-only; no behavior is changed. A future commit
>       +    will use bool literals for changed[i].
>        
>       -    Define macros NONE(0), SOME(1), TOO_MANY(2) as the enum values for
>       -    matches1 and matches2. These states will influence whether changed[i]
>       -    is set to 1 or kept as 0.
>       +    The functions xdl_clean_mmatch() and xdl_cleanup_records() will be
>       +    cleaned up more in a future patch series. The changes to
>       +    xdl_cleanup_records(), in this patch, is just to make it clear why

Not worth a re-roll on its own s/is/are/

Thanks for working on this

Phillip

>       +    `char rchg` is refactored to `bool changed`.
>       +
>       +    Rename dis* to action* and replace literal numericals with macros.
>       +    The old names came from when dis* (which I think was short for discard)
>       +    was treated like a boolean, but over time it grew into a ternary state
>       +    machine. The result was confusing because dis* and rchg* both used 0/1
>       +    values with different meanings.
>       +
>       +    The new names and macros make the states explicit. nm is short for
>       +    number of matches, and mlim is a heuristic limit:
>       +
>       +      nm == 0       -> action[i] = DISCARD     -> changed[i] = true
>       +      0 < nm < mlim -> action[i] = KEEP        -> changed[i] = false
>       +      nm >= mlim    -> action[i] = INVESTIGATE -> changed[i] = xdl_clean_mmatch()
>       +
>       +    When need_min is true, only DISCARD and KEEP occur because the limit
>       +    is effectively infinite.
>        
>            Best-viewed-with: --color-words
>            Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>       @@ xdiff/xprepare.c
>         #define XDL_GUESS_NLINES1 256
>         #define XDL_GUESS_NLINES2 20
>         
>       -+#define NONE 0
>       -+#define SOME 1
>       -+#define TOO_MANY 2
>       ++#define DISCARD 0
>       ++#define KEEP 1
>       ++#define INVESTIGATE 2
>         
>         typedef struct s_xdlclass {
>         	struct s_xdlclass *next;
>       @@ xdiff/xprepare.c: void xdl_free_env(xdfenv_t *xe) {
>         
>         
>        -static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>       -+static bool xdl_clean_mmatch(uint8_t const *matches, long i, long s, long e) {
>       ++static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
>         	long r, rdis0, rpdis0, rdis1, rpdis1;
>         
>         	/*
>        -	 * Limits the window the is examined during the similar-lines
>        -	 * scan. The loops below stops when dis[i - r] == 1 (line that
>       +-	 * has no match), but there are corner cases where the loop
>       +-	 * proceed all the way to the extremities by causing huge
>       +-	 * performance penalties in case of big files.
>        +	 * Limits the window that is examined during the similar-lines
>       -+	 * scan. The loops below stops when matches[i - r] == SOME (line that
>       - 	 * has no match), but there are corner cases where the loop
>       - 	 * proceed all the way to the extremities by causing huge
>       - 	 * performance penalties in case of big files.
>       ++	 * scan. The loops below stops when action[i - r] == KEEP
>       ++	 * (line that has no match), but there are corner cases where
>       ++	 * the loop proceed all the way to the extremities by causing
>       ++	 * huge performance penalties in case of big files.
>       + 	 */
>       + 	if (i - s > XDL_SIMSCAN_WINDOW)
>       + 		s = i - XDL_SIMSCAN_WINDOW;
>        @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, long e) {
>         
>         	/*
>         	 * Scans the lines before 'i' to find a run of lines that either
>        -	 * have no match (dis[j] == 0) or have multiple matches (dis[j] > 1).
>        -	 * Note that we always call this function with dis[i] > 1, so the
>       -+	 * have no match (matches[j] == NONE) or have multiple matches (matches[j] == TOO_MANY).
>       -+	 * Note that we always call this function with matches[i] == TOO_MANY, so the
>       - 	 * current line (i) is already a multimatch line.
>       +-	 * current line (i) is already a multimatch line.
>       ++	 * have no match (action[j] == DISCARD) or have multiple matches
>       ++	 * (action[j] == INVESTIGATE). Note that we always call this
>       ++	 * function with action[i] == INVESTIGATE, so the current line
>       ++	 * (i) is already a multimatch line.
>         	 */
>         	for (r = 1, rdis0 = 0, rpdis0 = 1; (i - r) >= s; r++) {
>        -		if (!dis[i - r])
>       -+		if (matches[i - r] == NONE)
>       ++		if (action[i - r] == DISCARD)
>         			rdis0++;
>        -		else if (dis[i - r] == 2)
>       -+		else if (matches[i - r] == TOO_MANY)
>       ++		else if (action[i - r] == INVESTIGATE)
>         			rpdis0++;
>        -		else
>       -+		else if (matches[i - r] == SOME)
>       ++		else if (action[i - r] == KEEP)
>         			break;
>        +		else
>       -+			BUG("Illegal value for matches[i - r]");
>       ++			BUG("Illegal value for action[i - r]");
>         	}
>         	/*
>       - 	 * If the run before the line 'i' found only multimatch lines, we
>       +-	 * If the run before the line 'i' found only multimatch lines, we
>        -	 * return 0 and hence we don't make the current line (i) discarded.
>       -+	 * return false and hence we don't make the current line (i) discarded.
>       - 	 * We want to discard multimatch lines only when they appear in the
>       +-	 * We want to discard multimatch lines only when they appear in the
>        -	 * middle of runs with nomatch lines (dis[j] == 0).
>       -+	 * middle of runs with nomatch lines (matches[j] == NONE).
>       ++	 * If the run before the line 'i' found only multimatch lines,
>       ++	 * we return false and hence we don't make the current line (i)
>       ++	 * discarded. We want to discard multimatch lines only when
>       ++	 * they appear in the middle of runs with nomatch lines
>       ++	 * (action[j] == DISCARD).
>         	 */
>         	if (rdis0 == 0)
>         		return 0;
>         	for (r = 1, rdis1 = 0, rpdis1 = 1; (i + r) <= e; r++) {
>        -		if (!dis[i + r])
>       -+		if (matches[i + r] == NONE)
>       ++		if (action[i + r] == DISCARD)
>         			rdis1++;
>        -		else if (dis[i + r] == 2)
>       -+		else if (matches[i + r] == TOO_MANY)
>       ++		else if (action[i + r] == INVESTIGATE)
>         			rpdis1++;
>        -		else
>       -+		else if (matches[i + r] == SOME)
>       ++		else if (action[i + r] == KEEP)
>         			break;
>        +		else
>       -+			BUG("Illegal value for matches[i + r]");
>       ++			BUG("Illegal value for action[i + r]");
>         	}
>         	/*
>       - 	 * If the run after the line 'i' found only multimatch lines, we
>       +-	 * If the run after the line 'i' found only multimatch lines, we
>        -	 * return 0 and hence we don't make the current line (i) discarded.
>       -+	 * return false and hence we don't make the current line (i) discarded.
>       ++	 * If the run after the line 'i' found only multimatch lines,
>       ++	 * we return false and hence we don't make the current line (i)
>       ++	 * discarded.
>         	 */
>         	if (rdis1 == 0)
>        -		return 0;
>       @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, l
>         	xdlclass_t *rcrec;
>        -	char *dis, *dis1, *dis2;
>        -	int need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>       -+	uint8_t *matches1, *matches2;
>       -+	int status = 0;
>       ++	uint8_t *action1 = NULL, *action2 = NULL;
>        +	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
>       ++	int ret = 0;
>         
>        -	if (!XDL_CALLOC_ARRAY(dis, xdf1->nrec + xdf2->nrec + 2))
>        -		return -1;
>        -	dis1 = dis;
>        -	dis2 = dis1 + xdf1->nrec + 1;
>       -+	matches1 = NULL;
>       -+	matches2 = NULL;
>       -+
>        +	/*
>        +	 * Create temporary arrays that will help us decide if
>        +	 * changed[i] should remain 0 or become 1.
>        +	 */
>       -+	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
>       -+		status = -1;
>       ++	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
>       ++		ret = -1;
>        +		goto cleanup;
>        +	}
>       -+	if (!XDL_CALLOC_ARRAY(matches2, xdf2->nrec + 1)) {
>       -+		status = -1;
>       ++	if (!XDL_CALLOC_ARRAY(action2, xdf2->nrec + 1)) {
>       ++		ret = -1;
>        +		goto cleanup;
>        +	}
>         
>        +	/*
>       -+	 * Initialize temporary arrays with NONE, SOME, or TOO_MANY.
>       ++	 * Initialize temporary arrays with DISCARD, KEEP, or INVESTIGATE.
>        +	 */
>         	if ((mlim = xdl_bogosqrt(xdf1->nrec)) > XDL_MAX_EQLIMIT)
>         		mlim = XDL_MAX_EQLIMIT;
>       @@ xdiff/xprepare.c: static int xdl_clean_mmatch(char const *dis, long i, long s, l
>         		rcrec = cf->rcrecs[recs->ha];
>         		nm = rcrec ? rcrec->len2 : 0;
>        -		dis1[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>       -+		matches1[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
>       ++		action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>         	}
>         
>         	if ((mlim = xdl_bogosqrt(xdf2->nrec)) > XDL_MAX_EQLIMIT)
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>         		rcrec = cf->rcrecs[recs->ha];
>         		nm = rcrec ? rcrec->len1 : 0;
>        -		dis2[i] = (nm == 0) ? 0: (nm >= mlim && !need_min) ? 2: 1;
>       -+		matches2[i] = (nm == 0) ? NONE: (nm >= mlim && !need_min) ? TOO_MANY: SOME;
>       ++		action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && !need_min) ? INVESTIGATE: KEEP;
>         	}
>         
>        +	/*
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>         	     i <= xdf1->dend; i++, recs++) {
>        -		if (dis1[i] == 1 ||
>        -		    (dis1[i] == 2 && !xdl_clean_mmatch(dis1, i, xdf1->dstart, xdf1->dend))) {
>       -+		if (matches1[i] == SOME ||
>       -+		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
>       ++		if (action1[i] == KEEP ||
>       ++		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
>         			xdf1->rindex[nreff++] = i;
>       -+			/* changed[i] remains 0 */
>       ++			/* changed[i] remains 0, i.e. keep */
>         		} else
>         			xdf1->changed[i] = 1;
>       ++			/* i.e. discard */
>         	}
>       -@@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>       + 	xdf1->nreff = nreff;
>         
>         	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
>         	     i <= xdf2->dend; i++, recs++) {
>        -		if (dis2[i] == 1 ||
>        -		    (dis2[i] == 2 && !xdl_clean_mmatch(dis2, i, xdf2->dstart, xdf2->dend))) {
>       -+		if (matches2[i] == SOME ||
>       -+		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
>       ++		if (action2[i] == KEEP ||
>       ++		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
>         			xdf2->rindex[nreff++] = i;
>       -+			/* changed[i] remains 0 */
>       ++			/* changed[i] remains 0, i.e. keep */
>         		} else
>         			xdf2->changed[i] = 1;
>       ++			/* i.e. discard */
>         	}
>         	xdf2->nreff = nreff;
>         
>        -	xdl_free(dis);
>        +cleanup:
>       -+	xdl_free(matches1);
>       -+	xdl_free(matches2);
>       ++	xdl_free(action1);
>       ++	xdl_free(action2);
>         
>        -	return 0;
>       -+	return status;
>       ++	return ret;
>         }
>         
>         
>   13:  975e845bfa ! 12:  83e1ace5bd xdiff: change type of xdfile_t.changed from char to bool
>       @@ Commit message
>            xdiff: change type of xdfile_t.changed from char to bool
>        
>            The only values possible for 'changed' is 1 and 0, which exactly maps
>       -    to a bool type. It might not look like this is the case because
>       -    matches1 and matches2 (which use to be dis1, and dis2) were also char
>       -    and were assigned numerical values within a few lines of 'changed'
>       -    (what used to be rchg).
>       +    to a bool type. It might not look like this because action1 and action2
>       +    (which use to be dis1, and dis2) were also of type char and were
>       +    assigned numerical values within a few lines of 'changed' (what used to
>       +    be rchg).
>        
>       -    Using NONE, SOME, TOO_MANY for matches1[i]/matches2[j], and true/false
>       +    Using DISCARD/KEEP/INVESTIGATE for action1[i]/action2[j], and true/false
>            for changed[k] makes it clear to future readers that these are
>            logically separate concepts.
>        
>       @@ xdiff/xdiffi.c: static int group_slide_up(xdfile_t *xdf, struct xdlgroup *g)
>         
>         		while (xdf->changed[g->start - 1])
>         			g->start--;
>       +@@ xdiff/xdiffi.c: int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>       +
>       + int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
>       + 	xdchange_t *cscr = NULL, *xch;
>       +-	char *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
>       ++	bool *changed1 = xe->xdf1.changed, *changed2 = xe->xdf2.changed;
>       + 	long i1, i2, l1, l2;
>       +
>       + 	/*
>        
>         ## xdiff/xhistogram.c ##
>        @@ xdiff/xhistogram.c: redo:
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>        -	 * changed[i] should remain 0 or become 1.
>        +	 * changed[i] should remain false, or become true.
>         	 */
>       - 	if (!XDL_CALLOC_ARRAY(matches1, xdf1->nrec + 1)) {
>       - 		status = -1;
>       + 	if (!XDL_CALLOC_ARRAY(action1, xdf1->nrec + 1)) {
>       + 		ret = -1;
>        @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>         
>         	/*
>       @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *
>         	 */
>         	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
>         	     i <= xdf1->dend; i++, recs++) {
>       - 		if (matches1[i] == SOME ||
>       - 		    (matches1[i] == TOO_MANY && !xdl_clean_mmatch(matches1, i, xdf1->dstart, xdf1->dend))) {
>       + 		if (action1[i] == KEEP ||
>       + 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
>         			xdf1->rindex[nreff++] = i;
>       --			/* changed[i] remains 0 */
>       -+			/* changed[i] remains false */
>       +-			/* changed[i] remains 0, i.e. keep */
>       ++			/* changed[i] remains false, i.e. keep */
>         		} else
>        -			xdf1->changed[i] = 1;
>        +			xdf1->changed[i] = true;
>       + 			/* i.e. discard */
>         	}
>         	xdf1->nreff = nreff;
>       -
>        @@ xdiff/xprepare.c: static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>       - 		if (matches2[i] == SOME ||
>       - 		    (matches2[i] == TOO_MANY && !xdl_clean_mmatch(matches2, i, xdf2->dstart, xdf2->dend))) {
>       + 		if (action2[i] == KEEP ||
>       + 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
>         			xdf2->rindex[nreff++] = i;
>       --			/* changed[i] remains 0 */
>       -+			/* changed[i] remains false */
>       +-			/* changed[i] remains 0, i.e. keep */
>       ++			/* changed[i] remains false, i.e. keep */
>         		} else
>        -			xdf2->changed[i] = 1;
>        +			xdf2->changed[i] = true;
>       + 			/* i.e. discard */
>         	}
>         	xdf2->nreff = nreff;
>       -
>        
>         ## xdiff/xtypes.h ##
>        @@ xdiff/xtypes.h: typedef struct s_xdfile {
> 

