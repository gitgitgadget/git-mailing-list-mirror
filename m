Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4CB1A3160
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771015005; cv=none; b=EMPl5hL3UHEk3k/XNkcbYkq/yHegfrpxwkFEAbivx5OBW/ygr3yCP78t9Q4utxxj37d93M5dthWxvxnJ0Cjh3SwnnQp1FDCqZqhadEu2ovAc4Ib/KulO+vl7TbexLvqBpa/jF9mIh1ZY/akw/KiBx532nVbd9Uux4nVx2LUBtwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771015005; c=relaxed/simple;
	bh=XEODd3+QzSGx2iKgEPOV+FI1QlZU4SMfrP7PtOoBlc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sKGMj4PboHmk/iLnwoS/ekHBk5lv65okSdpix76CfM7ciCru0Ytrz32MKFRN9y4hv1j3kD823yBz98iFt/bsCkZsrOkitlv0MNl8YJTlA4KRwLm5M62HmfyiPe6n/p0ABTmLibfYvewah//e4DSinHLcsm99w75WmKh4JdrU0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c7LuBpur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OYJ8QOjg; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c7LuBpur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OYJ8QOjg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CAB71D00091;
	Fri, 13 Feb 2026 15:36:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 13 Feb 2026 15:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771015003; x=1771101403; bh=G5sTMMybvX
	ne21xdSZEqRX+W2Jo3cFwxQQCo8Vew6no=; b=c7LuBpureQbHu4sWRw1XwuYPkg
	/Vj7ys/rpyA9ubPDaw3JYhKIT2RZOWSV+7XXa2ohEEYDC+KhxHrv+8aXypjC1ouh
	/pO1DkZvoU/WKCTfX/NMu/1u2d6fyVi69GGGNZzGajE1l7wvn0wb23fQji50MJ7f
	M89+2EHrEOjYenNMI5+ECwbCCisbON9IHX5nOGnWUCz/GagqBD8F5UGuQZ99+7TF
	2KiuwACRNdZ8DoeXdatyME73BMMtGAq0nsiCjObA/eaXhBQ1qW5Ck0foDd1A56zO
	rhQurMlyn23Yt7X8gBjxIFAVQlX7EXIcry+KXhKJS7o3eTQq5goFjqTSPWTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771015003; x=1771101403; bh=G5sTMMybvXne21xdSZEqRX+W2Jo3cFwxQQC
	o8Vew6no=; b=OYJ8QOjgW5aLY3eX+yKwKxxLhzJZXQbUEUKdtS6DBbIa+0dydph
	agmyELJqOs1jxfajHArkam67vFMfCFt1IgLpvAGAvvCYDyhHrC815mFOf0ikVwmN
	07l9I1DZ8y/AIBIGFbsUCHVza9wfcronEaUvPhJiYv8z+8tiMWcbFU0iG8JsABsQ
	VbPyrCAnI6ec3XixNUxYnfUBBcg53FU/UQaMkKrIjawpMzGQnyzOJ4qx2pYvLQ3a
	SC0hTQoEBkYD0FTWASk1jb6bBQHO55AJiA3Y9vcKyVzqTta4pFHbodNCTN25Pd/W
	07cYTo61CRQd+wTjjLQ/REQnPSzKF6pvOww==
X-ME-Sender: <xms:WouPaYD5NaC8_Hl84SMRS9EOpxYLTet3fTakRxrLUmKXSCjapvKbmA>
    <xme:WouPacw_8rWrW8CtcmJlFRFRYAtmFYLY1C7G7ENJ63XH18ibtC-houLgkcr_fR8P8
    HgSR5XAahBOb776ueSpaxCl8pOnraUNDuHRdsCwwEF8WltOXvNfuw>
X-ME-Received: <xmr:WouPad1NysCCyYNt2be7h7GcPS3SM_gfhLkREsJjuU_qVYrtLueOszC9vqv87gmdrnbWIY6WaYsBYvXfPwjmxRtWZW_0sVCixA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmjhgthhgvvg
    hthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:WouPaUwjg9T2hY_e7PwV0WHRFg5yzlpBp9tg0Qfna2runoB59SXKZQ>
    <xmx:WouPacEjUQdYvmSo5aX2TQY4lyCiX2_r_gIeEhrtl1C82VC4EmtzfA>
    <xmx:WouPafb-5KlsJXKD0m4BRytKkPJWRXRRS1nUITYGrG-vyYXsKwZo3Q>
    <xmx:WouPaWDuM-aNaQUEV2LjWxD9e4AjzuwwSdzIcjfUQYBe4S8j6pDC5Q>
    <xmx:W4uPaZblSrM9vihu0VLpcWJ-FgJUNojNx5vrZOqt230oUmMmTE8mPC12>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 15:36:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  johannes.schindelin@gmx.de,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Matthew John
 Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v2 3/6] trace2: refactor Windows process ancestry trace2
 event
In-Reply-To: <2b02f62f0df7ad2ca5356813780577facf02a58d.1771012500.git.gitgitgadget@gmail.com>
	(Matthew John Cheetham via GitGitGadget's message of "Fri, 13 Feb 2026
	19:54:57 +0000")
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
	<2b02f62f0df7ad2ca5356813780577facf02a58d.1771012500.git.gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 12:36:41 -0800
Message-ID: <xmqqtsvkl6sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> In 353d3d77f4 (trace2: collect Windows-specific process information,
> 2019-02-22) we added process ancestry information for Windows to TRACE2
> via a data_json event. It was only later in 2f732bf15e (tr2: log parent
> process name, 2021-07-21) that the specific cmd_ancestry event was
> added to TRACE2.
>
> In a future commit we will emit the ancestry information with the newer
> cmd_ancestry TRACE2 event. Right now, we rework this implementation of
> trace2_collect_process_info to separate the calculation of ancestors
> from building and emiting the JSON array via a data_json event.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  compat/win32/trace2_win32_process_info.c | 50 ++++++++++++------------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Looks quite straight-forward refactoring that even I (without Win32
specific knowledge) can follow with ease.  Nicely done.

>
> diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
> index f147da706a..aceea05430 100644
> --- a/compat/win32/trace2_win32_process_info.c
> +++ b/compat/win32/trace2_win32_process_info.c
> @@ -3,6 +3,7 @@
>  #include "../../git-compat-util.h"
>  #include "../../json-writer.h"
>  #include "../../repository.h"
> +#include "../../strvec.h"
>  #include "../../trace2.h"
>  #include "lazyload.h"
>  #include <psapi.h>
> @@ -32,12 +33,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
>  }
>  
>  /*
> - * Accumulate JSON array of our parent processes:
> - *     [
> - *         exe-name-parent,
> - *         exe-name-grand-parent,
> - *         ...
> - *     ]
> + * Accumulate array of our parent process names.
>   *
>   * Note: we only report the filename of the process executable; the
>   *       only way to get its full pathname is to use OpenProcess()
> @@ -73,7 +69,7 @@ static int find_pid(DWORD pid, HANDLE hSnapshot, PROCESSENTRY32 *pe32)
>   * simple and avoid the alloc/realloc overhead.  It is OK if we
>   * truncate the search and return a partial answer.
>   */
> -static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
> +static void get_processes(struct strvec *names, HANDLE hSnapshot)
>  {
>  	PROCESSENTRY32 pe32;
>  	DWORD pid;
> @@ -82,19 +78,19 @@ static void get_processes(struct json_writer *jw, HANDLE hSnapshot)
>  
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
>  
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
>  	}
>  }
> @@ -176,13 +162,27 @@ static void get_peak_memory_info(void)
>  
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
> +		}
> +
> +		strvec_clear(&names);
>  		return;
>  
>  	case TRACE2_PROCESS_INFO_EXIT:
