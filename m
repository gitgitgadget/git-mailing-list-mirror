Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480058124
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852451; cv=none; b=YKKLxDt4T8bBf9i/LGxTxK3jBvroFJOAP95qx9toPazwgvDX6W74vbGVe6oOBOtmFmPNGeJBOntv2rN5Nn4IiIdgliDCoY2+HdZVIorY2QOPO0hWBUp9NJ9IJCa2eSqaY1xmHVhE9X1Z/m6f8azjdM2GZOtnj2ZTDskihySKWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852451; c=relaxed/simple;
	bh=SjE8dADpDIIn+1pYTsdRYfKqRHBFOf7WDbXbTTHyPvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTFecuTv0WfFbdhnRNJWuS6P1h8cLsVHE92gs3dEGHSRt7XZEyaceEeKyqZW6qWRquPstvbcAE8cBICTRsZXymKPUirSR4mkoW0MWmC8CyS3jAHodTgkz1gJo060NQpkVVCjo21va8yRA0YOR+j/L7weH4Ejl+H6uo36DHBfahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJr4Q51U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJr4Q51U"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso383305e9.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707852448; x=1708457248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+k7URZRJx0fbUDCmuFksueNeHuEfJCzhvmLBirmYeds=;
        b=DJr4Q51UhMJG5onpWXwbDayf+hPxYwsDNZeuLuwtfwqK0SZDfM0QwAsym9liCpaPQD
         qiCx6rUOWaWBQtX8ASLT0Gm9dpaWwl7zLnlirPJl1PAI6KLH25A15gkCyOPf7w5mRgsp
         9NTK4XfhigkN9TxzA1I9Ar0CRKIO6sj2bh6gQ8Z5x4yYpCDXw/6deIp6+6GQiWleJSPi
         vSDkRx9LqZSkKRC6n0bF9+/K0Pc+tIUxfbjk/ccmAZ18mjQBrzXzTkhkgqlQWeRc83A9
         2saoHbjlYIwXBIe3HIi+EKADmfVrLYT4CvXa56HgSyySTMg+Dk9bygcnN2hEFpPaeqQu
         zc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852448; x=1708457248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k7URZRJx0fbUDCmuFksueNeHuEfJCzhvmLBirmYeds=;
        b=Jh6Fs6GRQqClDT/1/T033GKiWadhUnas7ttCV0dQsoaErv4gLdRkgz3CpCVpHlxKTo
         LBZq1l02N10PcY2My+HiGkiPTVck3fyzCPqF3TT7J43Vgm/zP+kLp44cAu31WvkZFpvd
         fMy4Epo8XATOlGIa1YDJnJEPfopZKfwo1wkpxdcQdk67fDGGeo6+JeWLIS54PuF8og7k
         J/tBz4oPhnHueL1BYTqjUyZC/R4Q7J1c2ZtyeXMD5haNvPMYtIOWWELteBB/8A7mha3x
         eUDmDGUZIsjLreEJu4V2JNSX+CAVMATVBVO0ctloZPCj/u9I/gFU4y6zGqr7ZkWGiBEa
         IgRA==
X-Forwarded-Encrypted: i=1; AJvYcCWAepIOWE68Tba8wLOlaSLJz4hPbdkXBSiPb5R3w9C3nst/vuZKtcFkCINC696zwP6kkvrTayeuQlhvAmEtVbj3IqI0
X-Gm-Message-State: AOJu0Yz1j2vfh77k6s84EcMZjXpHDz70iYCAkbNcSzj+jvsdYmsAeZrw
	KCbQ6wVxsAjHkC7qE+Ljd9s/CWP27RCr/IKm803c9wvlgW7diw/N
X-Google-Smtp-Source: AGHT+IF+hyhTNgC/8Ogl/aRpQ2VnKdcYtyq2EGd2Dh4NL3vBd7DWq3myLgB2iH/RwEnBLiHnAS/FsA==
X-Received: by 2002:a05:600c:4708:b0:411:dd82:a23c with SMTP id v8-20020a05600c470800b00411dd82a23cmr236794wmo.0.1707852447746;
        Tue, 13 Feb 2024 11:27:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs2al67IySzF2vHq5RbpySOUrga13m4BBP8t4na9ejw9ibvsP93BxM1Z/o0xxMgN2KMiQZ2nPwK8F4pGZhMjJqFOzk2H/7C4vz1kd9OwoYUotJ4WmeXndEQrvoxaJwfbTOLd5/AnVIhRAU98I6
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b0033b74a3dcf9sm9230273wry.27.2024.02.13.11.27.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 11:27:27 -0800 (PST)
Message-ID: <48b96426-9231-4e80-b55d-628dd8847337@gmail.com>
Date: Tue, 13 Feb 2024 20:27:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] column: disallow negative padding
Content-Language: en-US
To: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
Cc: Tiago Pascoal <tiago@pascoal.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <cover.1707839454.git.code@khaugsbakk.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13-feb-2024 17:01:19, Kristoffer Haugsbakk wrote:

> The series gets split into two patches.

Very good.

> 
> Cc: Tiago Pascoal <tiago@pascoal.net>
> Cc: Chris Torek <chris.torek@gmail.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Cc: Rubén Justo <rjusto@gmail.com>
> 
> Kristoffer Haugsbakk (2):
>   column: disallow negative padding
>   column: guard against negative padding
> 
>  builtin/column.c  |  2 ++
>  column.c          |  4 ++++
>  t/t9002-column.sh | 11 +++++++++++
>  3 files changed, 17 insertions(+)
> 
> Range-diff against v2:
> 1:  1c959378cf4 ! 1:  4cac42ca6f8 column: disallow negative padding
>     @@ Commit message
>          A negative padding does not make sense and can cause errors in the
>          memory allocator since it’s interpreted as an unsigned integer.
>      
>     -    Disallow negative padding. Also guard against negative padding in
>     -    `column.c` where it is conditionally used.
>     -
>          Reported-by: Tiago Pascoal <tiago@pascoal.net>
>     -    Helped-by: Junio C Hamano <gitster@pobox.com>
>          Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
>      
>     -
>     - ## Notes (series) ##
>     -    v2:
>     -    • Incorporate Junio’s changes (guard against negative padding in
>     -      `column.c`)
>     -    • Tweak commit message based on Junio’s analysis
>     -    • Use gettext for error message
>     -      • However I noticed that the “translation string” from `fast-import`
>     -        isn’t a translation string. So let’s invent a new one and use a
>     -        parameter so that it can be used elsewhere.
>     -    • Make a test
>     -
>       ## builtin/column.c ##
>      @@ builtin/column.c: int cmd_column(int argc, const char **argv, const char *prefix)
>       	memset(&copts, 0, sizeof(copts));
>     @@ builtin/column.c: int cmd_column(int argc, const char **argv, const char *prefix
>       		usage_with_options(builtin_column_usage, options);
>       	if (real_command || command) {
>      
>     - ## column.c ##
>     -@@ column.c: void print_columns(const struct string_list *list, unsigned int colopts,
>     - 	memset(&nopts, 0, sizeof(nopts));
>     - 	nopts.indent = opts && opts->indent ? opts->indent : "";
>     - 	nopts.nl = opts && opts->nl ? opts->nl : "\n";
>     --	nopts.padding = opts ? opts->padding : 1;
>     -+	nopts.padding = (opts && 0 <= opts->padding) ? opts->padding : 1;
>     - 	nopts.width = opts && opts->width ? opts->width : term_columns() - 1;
>     - 	if (!column_active(colopts)) {
>     - 		display_plain(list, "", "\n");
>     -@@ column.c: int run_column_filter(int colopts, const struct column_options *opts)
>     - 		strvec_pushf(argv, "--width=%d", opts->width);
>     - 	if (opts && opts->indent)
>     - 		strvec_pushf(argv, "--indent=%s", opts->indent);
>     --	if (opts && opts->padding)
>     -+	if (opts && 0 <= opts->padding)
>     - 		strvec_pushf(argv, "--padding=%d", opts->padding);
>     - 
>     - 	fflush(stdout);
>     -
>       ## t/t9002-column.sh ##
>      @@ t/t9002-column.sh: EOF
>       	test_cmp expected actual
> -:  ----------- > 2:  9355fc98e3d column: guard against negative padding
> -- 
> 2.43.0
> 

The BUG() in run_column_filter() may be questionable, but overall this
v3 LGTM.

Thanks Kristoffer for your work.  And also thanks to Tiago for
reporting.


    * P.D. *
    
    Thinking about this in a more general way, I've found that this kind
    of error has hit us several times:
    
      - 953aa54e1a (pack-objects: clamp negative window size to 0, 2021-05-01)
      - 6d52b6a5df (pack-objects: clamp negative depth to 0, 2021-05-01)
    
    Maybe the source of this error is how easy is to forget that
    OPT_INTEGER can accept negative values (after all, that's what an
    integer is).
    
    There are not many users of OPT_INTEGER, and a quick check gives me
    the impression (maybe wrong...) that many of them do not expect
    negative values.
    
    Maybe we should consider having an OPT_INTEGER that fails if the
    value supplied is negative.  Ideally, some kind of opt-in machinery
    could be desirable, I think, for example to include/exclude:

    	- negative values
    	- "0"  ( may not be a desired value )
    	- "-1" ( may have some special meaning )
    	- ...
    
    I'll leave the idea here, just in case it inspires someone.  Thank
    you.
