Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEC134C99D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651143; cv=none; b=Og+vs3nCkt8aBVjrEp4Q2OsZ5lTV36hQV5EzJTf+XseSCTmqO+RvJ1HswOenuE2v2d4gT9hLx9xJ5i0dp3JbYEr5VN7j6q6peWulnE1hMH8+VUEGV1PD2Z5ZLdmTcSVepmotGUhV5VBJoGN1iGag8vfuc6jGPb+iULfCzZ4/SqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651143; c=relaxed/simple;
	bh=ck5V6Qq4POl/5ZarajvJT6wYThzyNmJGiXb3NI4EV3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3VLA6aCHXUWcaSsTmaYhMBEaKb/zu0nz/VA3MsvuSb6fINeYPJDFiDPonkX31LbXt4RNY+5tp7Y9tTn8s/VDhiFYFYBY2A/kEch53pwYjS3H2KF8ACvURkaWCbWJv0wkctZDwzyGCC2s91sVEqzNYTRlh/Dw4erZbrBqHraUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwwgYkoc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwwgYkoc"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b2a0c18caso642500f8f.1
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763651137; x=1764255937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lKElglUMxMwCFZ5dJV197RizSgZXDXpj4XQ31aNef5w=;
        b=lwwgYkocKgGDolFdcIhsMHktbh0T0LxlxuBCfdcO8YadXfLbcY2PFubzFSch4jYqz+
         wLQgNu2YAA+ZpRkNh7BKHxUxoBUVt1wrNovMtAgVBYslqOmugHKA+Lfey0F2edd8RXxD
         CbZ2wedZZKmzmLuztnRYP2rvEfnVn+BOMpcX2bPJCAjkqdBSZ01W7gXE7oyaXYb1MOHW
         FhbPHPcQjATsUjV/UDxcwjC37+8uRzNXEog9NLgcU+McaM5jausP80cUcuy/lI03fAhW
         ENjbIT3Ib3+Q/+fwPANgIzJ5zMN01CZOufE+mpB0+4VoXtJ24IHbbdM7rL7KoF4pf4v2
         IBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651137; x=1764255937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKElglUMxMwCFZ5dJV197RizSgZXDXpj4XQ31aNef5w=;
        b=SkGzYNoeovvmXHDc59leOTM/PYKR3gKLPt9jjdR0c4ve8xayQN+O2MxlhXhnPWv9MU
         7sxZ1ovUGMSvkZJTjLwleLfI+jso1HTXfTvpJZ5TqL0qoQBZyP1M7dpHa9sML+CZx3tU
         Ha/xBXM/Y0Qzbir13B/HAeqJutIZP1nu7DI0CAKNBcwoadlFuu2UsfDPeqNyboXE28rK
         3Kei25jueRZqKZFgF5paJhw0NrLPSXa3rAGy+Kp/9zWmGg2LS0kBHw1EUV99Vye3rmSU
         cFfA72QOiplq/xaqzapyL8ytrqFQdROaa3QBeHyh80DM9Ga1I0FTmrZbiF/ppxKnUAXM
         PyhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp4RSE3gl4F52AjKt6SdmZuGQitZmsV4VpPFrbAxm4XWIz+hNA1wl5/wv9f2H32ffTJOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3j0MmPRJ6l3vzAlD2m06weyR4scZ8mywNWbZCV8xSTsQrkrCb
	BerZwAfQTpkQmhVNgtmqZ1ANRqv7e8bdRbKBfkp9PRH7teVGKCca7LY9
X-Gm-Gg: ASbGnctgeDGXB+sMbeRDZtJ8d3e0fTE4VNbipGPfcxUvB8lBP2/xLYl6/qQH2/85eZN
	RTuYJ5ofivOaGSt/vhSSbCZy8CKIXJ7ResHIBKaMzI1fFdQ/vLRPg305Jd1dGj2zvMXDNICygxK
	2Tji4HrdFjBCu37MCJFwqR8+zb24EYiP+D3QA9s1ysma+MJeii6HL3RzIxDNqIlHWJvEIKBPN4+
	nFTEHLu4p+q08Ig0YT0poBnXH/DkBzLaEsQf2MEuN8X3/ZPeWCcr7hqh0Om5NrgSWS2lc39a7uP
	Cq1ae/FthiWVl/ZFbgJCEXUYS3czQUptb2JsVZFl92U5kSrmnKUT6kydvJVOv8DP1+p0ZiaORwh
	EfdiFSHcwnMU1ZznQF2k/bTj+loHFb0bm3dnCFNRZxpPqDZBOz5wekC7PGEDDhwPCmWMza68swV
	hXwldmAzkuWckZH85ogHlthxG6wM2qjrvq5VnsuwX3IZc8Pwb6SldqC8QMn2nMbw8=
X-Google-Smtp-Source: AGHT+IFXUGvgwmRjPWXBpaycJ6vTrqtEQ0EOT9vq7xlqiErWTGgrxLuQaQxc3JW6R9Am9KVllFw/9w==
X-Received: by 2002:a05:6000:1ace:b0:428:5673:11e0 with SMTP id ffacd0b85a97d-42cb9a63e8emr3522569f8f.40.1763651137146;
        Thu, 20 Nov 2025 07:05:37 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fba201sm5894766f8f.32.2025.11.20.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:05:36 -0800 (PST)
Message-ID: <44f8f04f-825a-474c-8c01-35d0cfbd8073@gmail.com>
Date: Thu, 20 Nov 2025 15:05:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 08/11] add-patch: remove dependency on
 "add-interactive" subsystem
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-8-407dd3f57ad3@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-8-407dd3f57ad3@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/10/2025 11:33, Patrick Steinhardt wrote:
> With the preceding commit we have split out interactive configuration
> that is used by both "git add -p" and "git add -i". But we still
> initialize that configuration in the "add -p" subsystem by calling
> `init_add_i_state()`, even though we only do so to initialize the
> interactive configuration as well as a repository pointer.
> 
> Stop doing so and instead store and initialize the interactive
> configuration in `struct add_p_state` directly.

Makes sense

Thanks

Phillip

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   add-patch.c | 70 ++++++++++++++++++++++++++++++++-----------------------------
>   1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 5c6969927a..790c848e79 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -2,7 +2,6 @@
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
>   #include "git-compat-util.h"
> -#include "add-interactive.h"
>   #include "add-patch.h"
>   #include "advice.h"
>   #include "config.h"
> @@ -263,7 +262,8 @@ struct hunk {
>   };
>   
>   struct add_p_state {
> -	struct add_i_state s;
> +	struct repository *r;
> +	struct interactive_config cfg;
>   	struct strbuf answer, buf;
>   
>   	/* parsed diff */
> @@ -408,7 +408,7 @@ static void add_p_state_clear(struct add_p_state *s)
>   	for (i = 0; i < s->file_diff_nr; i++)
>   		free(s->file_diff[i].hunk);
>   	free(s->file_diff);
> -	clear_add_i_state(&s->s);
> +	interactive_config_clear(&s->cfg);
>   }
>   
>   __attribute__((format (printf, 2, 3)))
> @@ -417,9 +417,9 @@ static void err(struct add_p_state *s, const char *fmt, ...)
>   	va_list args;
>   
>   	va_start(args, fmt);
> -	fputs(s->s.cfg.error_color, stdout);
> +	fputs(s->cfg.error_color, stdout);
>   	vprintf(fmt, args);
> -	puts(s->s.cfg.reset_color_interactive);
> +	puts(s->cfg.reset_color_interactive);
>   	va_end(args);
>   }
>   
> @@ -437,7 +437,7 @@ static void setup_child_process(struct add_p_state *s,
>   
>   	cp->git_cmd = 1;
>   	strvec_pushf(&cp->env,
> -		     INDEX_ENVIRONMENT "=%s", s->s.r->index_file);
> +		     INDEX_ENVIRONMENT "=%s", s->r->index_file);
>   }
>   
>   static int parse_range(const char **p,
> @@ -542,12 +542,12 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   	int res;
>   
>   	strvec_pushv(&args, s->mode->diff_cmd);
> -	if (s->s.cfg.context != -1)
> -		strvec_pushf(&args, "--unified=%i", s->s.cfg.context);
> -	if (s->s.cfg.interhunkcontext != -1)
> -		strvec_pushf(&args, "--inter-hunk-context=%i", s->s.cfg.interhunkcontext);
> -	if (s->s.cfg.interactive_diff_algorithm)
> -		strvec_pushf(&args, "--diff-algorithm=%s", s->s.cfg.interactive_diff_algorithm);
> +	if (s->cfg.context != -1)
> +		strvec_pushf(&args, "--unified=%i", s->cfg.context);
> +	if (s->cfg.interhunkcontext != -1)
> +		strvec_pushf(&args, "--inter-hunk-context=%i", s->cfg.interhunkcontext);
> +	if (s->cfg.interactive_diff_algorithm)
> +		strvec_pushf(&args, "--diff-algorithm=%s", s->cfg.interactive_diff_algorithm);
>   	if (s->revision) {
>   		struct object_id oid;
>   		strvec_push(&args,
> @@ -576,9 +576,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   	}
>   	strbuf_complete_line(plain);
>   
> -	if (want_color_fd(1, s->s.cfg.use_color_diff)) {
> +	if (want_color_fd(1, s->cfg.use_color_diff)) {
>   		struct child_process colored_cp = CHILD_PROCESS_INIT;
> -		const char *diff_filter = s->s.cfg.interactive_diff_filter;
> +		const char *diff_filter = s->cfg.interactive_diff_filter;
>   
>   		setup_child_process(s, &colored_cp, NULL);
>   		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
> @@ -811,7 +811,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   				   hunk->colored_end - hunk->colored_start);
>   			return;
>   		} else {
> -			strbuf_addstr(out, s->s.cfg.fraginfo_color);
> +			strbuf_addstr(out, s->cfg.fraginfo_color);
>   			p = s->colored.buf + header->colored_extra_start;
>   			len = header->colored_extra_end
>   				- header->colored_extra_start;
> @@ -833,7 +833,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
>   		if (len)
>   			strbuf_add(out, p, len);
>   		else if (colored)
> -			strbuf_addf(out, "%s\n", s->s.cfg.reset_color_diff);
> +			strbuf_addf(out, "%s\n", s->cfg.reset_color_diff);
>   		else
>   			strbuf_addch(out, '\n');
>   	}
> @@ -1222,12 +1222,12 @@ static void recolor_hunk(struct add_p_state *s, struct hunk *hunk)
>   
>   		strbuf_addstr(&s->colored,
>   			      plain[current] == '-' ?
> -			      s->s.cfg.file_old_color :
> +			      s->cfg.file_old_color :
>   			      plain[current] == '+' ?
> -			      s->s.cfg.file_new_color :
> -			      s->s.cfg.context_color);
> +			      s->cfg.file_new_color :
> +			      s->cfg.context_color);
>   		strbuf_add(&s->colored, plain + current, eol - current);
> -		strbuf_addstr(&s->colored, s->s.cfg.reset_color_diff);
> +		strbuf_addstr(&s->colored, s->cfg.reset_color_diff);
>   		if (next > eol)
>   			strbuf_add(&s->colored, plain + eol, next - eol);
>   		current = next;
> @@ -1356,7 +1356,7 @@ static int run_apply_check(struct add_p_state *s,
>   
>   static int read_single_character(struct add_p_state *s)
>   {
> -	if (s->s.cfg.use_single_key) {
> +	if (s->cfg.use_single_key) {
>   		int res = read_key_without_echo(&s->answer);
>   		printf("%s\n", res == EOF ? "" : s->answer.buf);
>   		return res;
> @@ -1370,7 +1370,7 @@ static int read_single_character(struct add_p_state *s)
>   static int prompt_yesno(struct add_p_state *s, const char *prompt)
>   {
>   	for (;;) {
> -		color_fprintf(stdout, s->s.cfg.prompt_color, "%s", _(prompt));
> +		color_fprintf(stdout, s->cfg.prompt_color, "%s", _(prompt));
>   		fflush(stdout);
>   		if (read_single_character(s) == EOF)
>   			return -1;
> @@ -1678,15 +1678,15 @@ static int patch_update_file(struct add_p_state *s,
>   		else
>   			prompt_mode_type = PROMPT_HUNK;
>   
> -		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->s.cfg.prompt_color,
> +		printf("%s(%"PRIuMAX"/%"PRIuMAX") ", s->cfg.prompt_color,
>   			      (uintmax_t)hunk_index + 1,
>   			      (uintmax_t)(file_diff->hunk_nr
>   						? file_diff->hunk_nr
>   						: 1));
>   		printf(_(s->mode->prompt_mode[prompt_mode_type]),
>   		       s->buf.buf);
> -		if (*s->s.cfg.reset_color_interactive)
> -			fputs(s->s.cfg.reset_color_interactive, stdout);
> +		if (*s->cfg.reset_color_interactive)
> +			fputs(s->cfg.reset_color_interactive, stdout);
>   		fflush(stdout);
>   		if (read_single_character(s) == EOF)
>   			break;
> @@ -1848,7 +1848,7 @@ static int patch_update_file(struct add_p_state *s,
>   				err(s, _("Sorry, cannot split this hunk"));
>   			} else if (!split_hunk(s, file_diff,
>   					     hunk - file_diff->hunk)) {
> -				color_fprintf_ln(stdout, s->s.cfg.header_color,
> +				color_fprintf_ln(stdout, s->cfg.header_color,
>   						 _("Split into %d hunks."),
>   						 (int)splittable_into);
>   				rendered_hunk_index = -1;
> @@ -1866,7 +1866,7 @@ static int patch_update_file(struct add_p_state *s,
>   		} else if (s->answer.buf[0] == '?') {
>   			const char *p = _(help_patch_remainder), *eol = p;
>   
> -			color_fprintf(stdout, s->s.cfg.help_color, "%s",
> +			color_fprintf(stdout, s->cfg.help_color, "%s",
>   				      _(s->mode->help_patch_text));
>   
>   			/*
> @@ -1884,7 +1884,7 @@ static int patch_update_file(struct add_p_state *s,
>   				if (*p != '?' && !strchr(s->buf.buf, *p))
>   					continue;
>   
> -				color_fprintf_ln(stdout, s->s.cfg.help_color,
> +				color_fprintf_ln(stdout, s->cfg.help_color,
>   						 "%.*s", (int)(eol - p), p);
>   			}
>   		} else {
> @@ -1904,7 +1904,7 @@ static int patch_update_file(struct add_p_state *s,
>   		strbuf_reset(&s->buf);
>   		reassemble_patch(s, file_diff, 0, &s->buf);
>   
> -		discard_index(s->s.r->index);
> +		discard_index(s->r->index);
>   		if (s->mode->apply_for_checkout)
>   			apply_for_checkout(s, &s->buf,
>   					   s->mode->is_reverse);
> @@ -1915,8 +1915,8 @@ static int patch_update_file(struct add_p_state *s,
>   					 NULL, 0, NULL, 0))
>   				error(_("'git apply' failed"));
>   		}
> -		if (repo_read_index(s->s.r) >= 0)
> -			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
> +		if (repo_read_index(s->r) >= 0)
> +			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
>   						     1, NULL, NULL, NULL);
>   	}
>   
> @@ -1929,11 +1929,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>   	      const struct pathspec *ps)
>   {
>   	struct add_p_state s = {
> -		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
> +		.r = r,
> +		.answer = STRBUF_INIT,
> +		.buf = STRBUF_INIT,
> +		.plain = STRBUF_INIT,
> +		.colored = STRBUF_INIT,
>   	};
>   	size_t i, binary_count = 0;
>   
> -	init_add_i_state(&s.s, r, opts);
> +	interactive_config_init(&s.cfg, r, opts);
>   
>   	if (mode == ADD_P_STASH)
>   		s.mode = &patch_mode_stash;
> 

