Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E13C38
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866114; cv=none; b=b9gPm9DRMZA8cGzPk9OG8bShE0W4DrVdUreKds5OqpchIreg9O7EcYHY4y+INHaek0+YvmukpzVhZjSg7uLSaizGoMKM8JjvMBhIiiqSyws/yWvEl24Wlgl9DZYzjEfSTjO3HCCz9spOXkh3oQEShJi3UGxcQpZwaFRUY6zOYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866114; c=relaxed/simple;
	bh=eYN6jaUyTqNqOZvaHxmKNZ68b3wbvK9agU/WWMm/FTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuYfpGjNAgZ7dXcmodmpf3sNk25xQJcu4p7zpDYDTPb+v2I42DmXaYTE3VMLTZN9Xi0nXV6qkUDYTGtNckaAFTt1y5db7DSPsgTr1MgxrObHMVS6yaLnodJx30sb2nhlyVwwwhGlHTBZZtIB7Lyf2ecHFvDQ3o6dbY64JdQTxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzp0oSF6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzp0oSF6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00283a5so37339055e9.0
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 02:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753866111; x=1754470911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MMHwZfe20yL6+qACE7hXQp7EW9HI8HyuRDK2Vo+aA/0=;
        b=Jzp0oSF6c4fiGXZ+fQZ93fZy2JZsLDW1sPFJpSPTdfackGowb0Ckc8Dz+d1pp8ROEx
         o+YpLSC4h3oa17KwudjonPrw/nSrvpLL/sHI5hRh7nQr6sgCpXIBGbcQYSnPfPDP/iMO
         La3uklMbGwFok1Piplx827ldfUMYEzfDEjVyYqA5vovbhWk+/nzYFEgI19BX8ghoSTaQ
         MF9mn3FT+pgCsou8+JD3woUEBAAymwUXQD6R2JSVxp1ByNzGiB1KIK5U0966JN8/Nz2p
         cC7sAI9AvypljUqO8P56/DEEJVQuMpU8B7tbKjmlqhIbazOj2VjCLdOKw92N9jQsl3ap
         SrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753866111; x=1754470911;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMHwZfe20yL6+qACE7hXQp7EW9HI8HyuRDK2Vo+aA/0=;
        b=jFM5baMnToHAirCiiI7Ih6Rf8OPQ14FkiOQfgxkCnKKRtPUTGXDTxz5nusF6BSatBe
         CBWf4Ee8ddbQfFcvfIP7dcHkdKNJqgQY0C7x0wBARU3tJ/TyyXeNQbLfyrKm8FXHaY/f
         uv+WPLsyGocWHAEU1VknH3erF3wT0IBwcV6RT8hllthSHs1fNaYvAp82inWwZQ0XOh0k
         RqcD8bE9QZKtxCXA7Q5UlS268nigLww8wH0AHGO57n4Owhlp3avzv7w0CSPLF5i9+QEC
         DkNRjOWLkc2NnN2TBkvVp9IDkSMSDqJBJH01g8uGeWgnPusQET+eZBtMMrxyLsmLhIXg
         290Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7AkRWofugP2QyFCW88Ns5eMA83of7AgQpgrVL/KlmX222ZpHZrOUjoaZG0Qce3uTRApQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnTSPVdyxCA1x8EBE22dUyeNtPKLiqyzI/37hkXf5M5p6mG9+
	iA1PeFAoujKZ2NmnMcLwpINMX06ZrxIhFCZeYfnHDZsL+hPiXv5xcUXc
X-Gm-Gg: ASbGncvIGxnbkyZ2yTnJhMJPXMv/EezEnRSiE58VXE1dXsadVDCoSH2H6us1EVcGYXV
	e9jSAxBV/lLJPwpj0cPOH0CYAS45TaPwEsgiuOtqkCioWCglcFo6T6QHmn/hr+oXL6GzDep8xu9
	w3Uu7TBQ43wgsn2cZEL8sQ9sVpi8s0IG5V243gokpLMU2DCcglN0Ie2IsTfIYYfLJcQLVlSEyGX
	JDi6FTGkaPjYc6Aj5zR3M2OZTd3T9r3nluSAeie6jPP4MBwUyvkVXHRs+dsDi3C2zNGYVfkhHIY
	cAA4xDJFOisM447c3IKeUvvJKBux5cNc1HRuPHEQn9ParQi/5IuolRg49rW6XUNVi4emOt4HO36
	tycKr8lSEhQ0CIAYiyS9mYQAmkCTqCGYArbRFSphbcNLByb2k1FwKaJx8f1QNK0BGxhs7Sgv5h5
	r+
X-Google-Smtp-Source: AGHT+IE9jiVYNsJix139ctBb+y+z/22rc669zXtS99WY/EulpoKZyB0eOwj0LulNXXTr+fsGZ8XIYw==
X-Received: by 2002:adf:a455:0:b0:3b7:9564:29be with SMTP id ffacd0b85a97d-3b795642a6fmr1077332f8f.49.1753866110634;
        Wed, 30 Jul 2025 02:01:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953751a2sm17712905e9.10.2025.07.30.02.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 02:01:50 -0700 (PDT)
Message-ID: <c4658ae9-007d-4645-9561-febe03dc612d@gmail.com>
Date: Wed, 30 Jul 2025 10:01:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] status: add --json output format to git status
To: Tach via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Tach <tacherasasi@gmail.com>
References: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2025 07:27, Tach via GitGitGadget wrote:
> From: tacherasasi <tacherasasi@gmail.com>
> 
> Add a new --json flag to 'git status' that outputs repository state
> in a structured JSON format. This enables reliable machine parsing
> of status information for tools and automation.
> 
> The JSON output includes:
> - Branch information (name, detached state, ahead/behind counts)
> - Staged files array
> - Unstaged files array
> - Untracked files array
> - Ignored files array (with --ignored flag)
> 
> Implementation details:
> - Add STATUS_FORMAT_JSON to wt_status_format enum
> - Add JSON output option to git status and git commit
> - Implement JSON formatting helpers for arrays and branch info
> - Structure output for easy parsing and future extensibility
> 
> Example:
>    $ git status --json
>    {
>      "branch": {
>        "current": "main",
>        "detached": false
>      },
>      "staged": ["file1.txt"],
>      "unstaged": ["file2.txt"],
>      "untracked": ["file3.txt"]
>    }
> 
> This provides a robust alternative to parsing traditional output
> formats, making it easier to build reliable tools and automation
> around Git status information.

What problem are you having paring the current output? You say this 
patch provides a robust alternative but I'm afraid it does not seem to 
handle filenames containing newlines or double quotes and it assumes 
they are utf-8 encoded. It also seems to print a trailing comma if an 
array has more than one item which is not allowed by the json spec. We 
already have support for generating json output as documented 
json-writer.h which will help with most of that but not the filename 
encoding problem. New features should also be accompanied by tests to 
prevent future regressions. I'm not opposed to adding json output if it 
is robust and handles non utf-8 filenames but it would be helpful to 
understand what problems you are having parsing the output of "git 
status --porcelain[=v2]".

Thanks

Phillip

> Signed-off-by: Tachera Sasi <tachera@ekilie.com>
> Signed-off-by: tacherasasi <tacherasasi@gmail.com>
> ---
>      status: add --json output format to git status
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1937%2FtacheraSasi%2Ffeature%2Fjson-status-output-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1937/tacheraSasi/feature/json-status-output-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1937
> 
>   builtin/commit.c |  9 ++++-
>   wt-status.c      | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>   wt-status.h      |  1 +
>   3 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index fba0dded64a..f1db4fdfd9a 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1540,6 +1540,9 @@ struct repository *repo UNUSED)
>   		OPT_SET_INT(0, "long", &status_format,
>   			    N_("show status in long format (default)"),
>   			    STATUS_FORMAT_LONG),
> +		OPT_SET_INT(0, "json", &status_format,
> +		    N_("show status in JSON format"),
> +		    STATUS_FORMAT_JSON),
>   		OPT_BOOL('z', "null", &s.null_termination,
>   			 N_("terminate entries with NUL")),
>   		{
> @@ -1603,7 +1606,8 @@ struct repository *repo UNUSED)
>   		       prefix, argv);
>   
>   	if (status_format != STATUS_FORMAT_PORCELAIN &&
> -	    status_format != STATUS_FORMAT_PORCELAIN_V2)
> +	    status_format != STATUS_FORMAT_PORCELAIN_V2 &&
> +	    status_format != STATUS_FORMAT_JSON)
>   		progress_flag = REFRESH_PROGRESS;
>   	repo_read_index(the_repository);
>   	refresh_index(the_repository->index,
> @@ -1735,6 +1739,9 @@ int cmd_commit(int argc,
>   		OPT_SET_INT(0, "long", &status_format,
>   			    N_("show status in long format (default)"),
>   			    STATUS_FORMAT_LONG),
> +		OPT_SET_INT(0, "json", &status_format,
> +		    N_("show status in JSON format"),
> +		    STATUS_FORMAT_JSON),
>   		OPT_BOOL('z', "null", &s.null_termination,
>   			 N_("terminate entries with NUL")),
>   		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
> diff --git a/wt-status.c b/wt-status.c
> index 454601afa15..7192fb4d057 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -2564,6 +2564,101 @@ static void wt_porcelain_v2_print(struct wt_status *s)
>   	}
>   }
>   
> +
> +static void wt_json_print_string_array(struct wt_status *s, const char *name, struct string_list *list)
> +{
> +	int i;
> +	fprintf(s->fp, "  \"%s\": [", name);
> +	for (i = 0; i < list->nr; i++) {
> +		if (i > 0)
> +			fprintf(s->fp, ", ");
> +		fprintf(s->fp, "\"%s\"", list->items[i].string);
> +	}
> +	fprintf(s->fp, "]");
> +}
> +
> +static void wt_json_print_change_array(struct wt_status *s, const char *name, int change_type)
> +{
> +	int i;
> +	struct string_list files = STRING_LIST_INIT_DUP;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		struct string_list_item *it;
> +		it = &(s->change.items[i]);
> +		d = it->util;
> +
> +		if ((change_type == WT_STATUS_UPDATED && d->index_status &&
> +		     d->index_status != DIFF_STATUS_UNMERGED) ||
> +		    (change_type == WT_STATUS_CHANGED && d->worktree_status &&
> +		     d->worktree_status != DIFF_STATUS_UNMERGED)) {
> +			string_list_append(&files, it->string);
> +		}
> +	}
> +
> +	wt_json_print_string_array(s, name, &files);
> +	string_list_clear(&files, 0);
> +}
> +
> +static void wt_json_print_branch_info(struct wt_status *s)
> +{
> +	struct branch *branch;
> +	const char *branch_name;
> +	int ahead = 0, behind = 0;
> +
> +	fprintf(s->fp, "  \"branch\": {\n");
> +
> +	if (s->branch && !s->is_initial) {
> +		if (!strcmp(s->branch, "HEAD")) {
> +			fprintf(s->fp, "    \"current\": \"HEAD\",\n");
> +			fprintf(s->fp, "    \"detached\": true");
> +		} else {
> +			if (skip_prefix(s->branch, "refs/heads/", &branch_name)) {
> +				fprintf(s->fp, "    \"current\": \"%s\",\n", branch_name);
> +				fprintf(s->fp, "    \"detached\": false");
> +
> +				branch = branch_get(branch_name);
> +				if (branch && branch->merge && branch->merge[0] && branch->merge[0]->dst) {
> +					if (!stat_tracking_info(branch, &ahead, &behind, NULL, 0, 0)) {
> +						fprintf(s->fp, ",\n    \"ahead\": %d,\n    \"behind\": %d", ahead, behind);
> +					}
> +				}
> +			} else {
> +				fprintf(s->fp, "    \"current\": \"%s\",\n", s->branch);
> +				fprintf(s->fp, "    \"detached\": false");
> +			}
> +		}
> +	} else {
> +		fprintf(s->fp, "    \"current\": null,\n");
> +		fprintf(s->fp, "    \"detached\": false");
> +	}
> +
> +	fprintf(s->fp, "\n  }");
> +}
> +
> +static void wt_json_status_print(struct wt_status *s)
> +{
> +	fprintf(s->fp, "{\n");
> +
> +	wt_json_print_branch_info(s);
> +	fprintf(s->fp, ",\n");
> +
> +	wt_json_print_change_array(s, "staged", WT_STATUS_UPDATED);
> +	fprintf(s->fp, ",\n");
> +
> +	wt_json_print_change_array(s, "unstaged", WT_STATUS_CHANGED);
> +	fprintf(s->fp, ",\n");
> +
> +	wt_json_print_string_array(s, "untracked", &s->untracked);
> +
> +	if (s->ignored.nr > 0) {
> +		fprintf(s->fp, ",\n");
> +		wt_json_print_string_array(s, "ignored", &s->ignored);
> +	}
> +
> +	fprintf(s->fp, "\n}\n");
> +}
> +
>   void wt_status_print(struct wt_status *s)
>   {
>   	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
> @@ -2583,6 +2678,9 @@ void wt_status_print(struct wt_status *s)
>   	case STATUS_FORMAT_PORCELAIN_V2:
>   		wt_porcelain_v2_print(s);
>   		break;
> +	case STATUS_FORMAT_JSON:
> +		wt_json_status_print(s);
> +		break;
>   	case STATUS_FORMAT_UNSPECIFIED:
>   		BUG("finalize_deferred_config() should have been called");
>   		break;
> diff --git a/wt-status.h b/wt-status.h
> index 4e377ce62b8..e929af832b2 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -74,6 +74,7 @@ enum wt_status_format {
>   	STATUS_FORMAT_SHORT,
>   	STATUS_FORMAT_PORCELAIN,
>   	STATUS_FORMAT_PORCELAIN_V2,
> +	STATUS_FORMAT_JSON,
>   
>   	STATUS_FORMAT_UNSPECIFIED
>   };
> 
> base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6

