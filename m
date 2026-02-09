Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B637998B
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648090; cv=none; b=U60vSWEBTcSAvkfEHtfllf8UxbyQ6fpi1pbd/XJJK9OmmjPCNVp6TEp1cnjMwaI4G8d+1DReADKSPYDO6ZhqaaTD+kzy9owxYObURqfcWdepRwvaSlswk/MU+3YOPYlR/e2Nuz3yF7Hc3lfr5s3Cpu3u40m9RDDeodm4cJB+Mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648090; c=relaxed/simple;
	bh=YiasL5ASGT3jHOh5IGu83OYIja0FgWK7zVlwaFopXTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/leGdr+QWvME58VoJRT1pPe6XJc6F8zCpNNClg6BxH7KUusBRsvhjc3fdYa/iRjx5EXuaTJdoEkzB8hIE5wenelRyyT2WFuQt+pUjoleGgO6ODQje6LWui1YqL0LoT2dRJODSce9gGkiPYYCZDykhggRbviA02vsaqF/QlDWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joEPgUnj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joEPgUnj"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-895341058b1so44537876d6.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770648089; x=1771252889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36dNQd/w6hxznUl+TtxanriY6DfrSW+9E/uKTh8AtA8=;
        b=joEPgUnjLD/nJ1K77l+HvJmNw2DkKd+hDN0BXFvJGLDVlsVE/F/0YsaFecfnKOEyYA
         vsWSitM+fJ8+CAMfc2+4zAKLjID/2KtMJ4h0RId2GMuIULCnn7Y4jSbBBzR6hcoHHtJU
         xvOboS/X/8sk3p3VpLA9vj/nQO2h4tP59G0Os44W1Ug6Mo0pwgONfapQjHFKrHOgCT2A
         zJEA+FbukB64qTBjLGJDyfPLoaEEHgE55BI6fJyjPX2I4/3s0tInlDEZlYwBnvFBXV/m
         zTOsyp8vCeQgN/iqOoXehRPBdehN5o9M6SaQQvFvD9kYanJ/0SUeQnWxpxa/T7qBHH+G
         w8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648089; x=1771252889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36dNQd/w6hxznUl+TtxanriY6DfrSW+9E/uKTh8AtA8=;
        b=d7HB165oKlP9oN4r3UvOiBWLiR/MLRkhIUyhL0LxGPvTtwOXQ4viZ4Y6O74M9qMdCD
         +H0/dzQvmyXVP03QqtEvfpLlEF5fewVXyYlVhIzdq/23VhQOSK1JSL5SCUz/CalQHntj
         CI9YsnimJFufSm3xwKpUvfsejDgyRZzhXCfr0keVgfAIAkAoF8o/9GXasLS+eUftNYzS
         DsYZXcr+Q29663nja8LSM6YI6nm5hJOCwkwOiCS3nKgVc7rVklzymLojl1iybjP9zVbn
         5YS/AlyLIFtGWvmC/sFct+BwHUV+oFaYfhe/d+rAXFeAqGUgkyLBBUPC9fwq7XkwXwmV
         Uf3w==
X-Forwarded-Encrypted: i=1; AJvYcCVBq20L/2GyfSNVTX45VWk+PO7jnaiTlrjJqe/bGxd87gYk8bp+PSzTLQqB47OPXIyd+oI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1+Gfwz0Ad2XCr4h545eh77ve4jakQg3PT9GNEnAYYVsQjRul
	mrbRYNMO+GLpfW772W14ZjRvoatB7Hdzsla31pMteV1A4X9nWdyLd5MQ
X-Gm-Gg: AZuq6aJ9F2126RaXdRgxxPOMxB34B/gSXcgEybPgQHIxU6dUsi9q46pra7pNOqHv2qy
	RaFx2Rel/g9XScMV2w/eeIxDt51S5CNHNU7MjnYbGKApiN3B+MhHF2WRUzlubyFP7/YiSyks1WQ
	QgJumtaZodze0Kozh5Y2se5nvKCddlG3nhPELrequxChSKskRyEslZ6EaE99NfL7k/Z20eX7Cqs
	CZ0eogNZcEkPEr6r74HGlvPFzItSUb+bRmDAJR2TBKyByhc1+Qq972HpuSPVtj+09v4JY5APT5x
	/7U/135diRu6sGrp4Yns+VqK2B5F6VNP3xWxq3vh2a91v0PbS4b79N/bmxvNp3B+7ZNHm+gCQNn
	+IBNyWUpqJnQTCV1h5WmG7Z+obhZ8la2UHqmGam+Nzq0sWuWyY5oi+iOd2fSZKVXm/R06Yx5kKh
	V80PhTN75ldHp/jdRazlXz6LGJPZ0MW1AfMccsmyGBBV0jqbh0sEk31b2qFQ==
X-Received: by 2002:a05:6214:3012:b0:87c:22f9:dac4 with SMTP id 6a1803df08f44-8953c7dab25mr167411746d6.15.1770648089101;
        Mon, 09 Feb 2026 06:41:29 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aeed8bsm842495885a.20.2026.02.09.06.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:41:28 -0800 (PST)
Message-ID: <1a282a1c-866e-49fc-b396-014921135cc4@gmail.com>
Date: Mon, 9 Feb 2026 09:41:28 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] trace2: refactor Windows process ancestry trace2
 event
To: Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
 Matthew John Cheetham <mjcheetham@outlook.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
 <7ccd0a9a6d89decaa5856494a184c71bc0d678e9.1770307510.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <7ccd0a9a6d89decaa5856494a184c71bc0d678e9.1770307510.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/2026 11:05 AM, Matthew John Cheetham via GitGitGadget wrote:
> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
...
>  #include "../../json-writer.h"

Are we able to delete this after your change?

>  	pid = GetCurrentProcessId();
>  	while (find_pid(pid, hSnapshot, &pe32)) {
> -		/* Only report parents. Omit self from the JSON output. */
> +		/* Only report parents. Omit self from the output. */
>  		if (nr_pids)
> -			jw_array_string(jw, pe32.szExeFile);
> +			strvec_push(names, pe32.szExeFile);
>  
>  		/* Check for cycle in snapshot. (Yes, it happened.) */
>  		for (k = 0; k < nr_pids; k++)
>  			if (pid == pid_list[k]) {
> -				jw_array_string(jw, "(cycle)");
> +				strvec_push(names, "(cycle)");
>  				return;
>  			}
>  
>  		if (nr_pids == NR_PIDS_LIMIT) {
> -			jw_array_string(jw, "(truncated)");
> +			strvec_push(names, "(truncated)");
>  			return;
>  		}

Nice replacement of JSON with strvec logic.

> @@ -105,24 +101,14 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
>  }
>  
>  /*
> - * Emit JSON data for the current and parent processes.  Individual
> - * trace2 targets can decide how to actually print it.
> + * Collect the list of parent process names.
>   */
> -static void get_ancestry(void)
> +static void get_ancestry(struct strvec *names)
>  {
>  	HANDLE hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
>  
>  	if (hSnapshot != INVALID_HANDLE_VALUE) {
> -		struct json_writer jw = JSON_WRITER_INIT;
> -
> -		jw_array_begin(&jw, 0);
> -		get_processes(&jw, hSnapshot);
> -		jw_end(&jw);
> -
> -		trace2_data_json("process", the_repository, "windows/ancestry",
> -				 &jw);
> -
> -		jw_release(&jw);
> +		get_processes(names, hSnapshot);
>  		CloseHandle(hSnapshot);

Nice simplification!

>  void trace2_collect_process_info(enum trace2_process_info_reason reason)
>  {
> +	struct strvec names = STRVEC_INIT;
> +
>  	if (!trace2_is_enabled())
>  		return;
>  
>  	switch (reason) {
>  	case TRACE2_PROCESS_INFO_STARTUP:
>  		get_is_being_debugged();
> -		get_ancestry();
> +		get_ancestry(&names);
> +		if (names.nr) {
> +			struct json_writer jw = JSON_WRITER_INIT;
> +			jw_array_begin(&jw, 0);
> +			for (size_t i = 0; i < names.nr; i++)
> +				jw_array_string(&jw, names.v[i]);
> +			jw_end(&jw);
> +			trace2_data_json("process", the_repository,
> +					 "windows/ancestry", &jw);
> +			jw_release(&jw);

Ah, you still have JSON logic at this point.

I see that in your next patch you export the names vector itself _and_
this older JSON version. We should consider a future where we drop this
JSON altogether, but it's nice to have both for a few versions so tool
makers have time to respond.

Thanks,
-Stolee
