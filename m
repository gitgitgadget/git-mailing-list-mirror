Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A39214A9B
	for <git@vger.kernel.org>; Fri,  1 May 2026 18:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659548; cv=none; b=jRHSWZrfpCnWMctnUpMHnFyrL+r5oVSd89Ml2cXh0Mr2rR/4eiKS1+xeY+yvsCdueOEo52Na8svgd4KBvR0Ka7HYmmzRkoIlWrCF5y7VdVvaIFwWMI85Jj3+iWBjXqG8wsJed9RJQ6h9dp7jd3nbeIuAOSYzvtqGA4t2bkp1SCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659548; c=relaxed/simple;
	bh=RP2aQE5c/BdhvVQ/dzUqubCUKTn/oYD2IVMehyVyFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4OrkrprrwlKEe3o/7hDD0IoWW59DQ4jHMKUK657oYJ7yA2kCPUEPxj/cnpgOMhvzbm9LxoV1vi75w0rQsaUkJDgwv6OXWiz/s7XvwUfOPxPsXrNbehnPSFsM/Jy4zUuVEf/gz+RxL4/uo4e1mum5+wdRK099vDGXwefZYLTVwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puWwWtCx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puWwWtCx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d77f6092eso1342999f8f.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777659545; x=1778264345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tm0yLi9KjgzDDAifUNGZoLpV25aqSobgldQH1/zR3/A=;
        b=puWwWtCxzbmYYlqYecG8xsTHqlNDqnwTfLje+oZUqB6BL6PqNUV3oB5tSWUZ6gCj0E
         FzFtmga+PfuseIY1Fhn/SR3ZdmsE+Y3JFZ3H2ontQA2Hi0sI6L93AnBarroGnRGS98/T
         GBNzuMq8mxDEbDVGoyA3UTVG69J0WLIjlMFm0Xde+ICeIwIHnJhL53udPQI6jOD8c/sd
         FSdp1azn/NjMgjfwlg7ntSSYCt20xEJUrstwiyGNGgtvAvhVZ9fS5YOCVIOPsDRtMXV/
         JBq54kvOn9nxNISFatUQn83+E1IK56ofGZvRt+chJ3JEwyC1mzAcwx1KqABYxbMkWiDT
         FuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659545; x=1778264345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm0yLi9KjgzDDAifUNGZoLpV25aqSobgldQH1/zR3/A=;
        b=AvChu+77o35L2EfhUY1tUtbP0g17aLhMZgMj+kscIh2i37m1oq70OEz5Eb4REGSKp2
         G8Zm3lsPKPMJ+zYBKXtrpxmhM8gbEViI/byHaB4xXZ7p6CSkoGDaOGOUOJR49S1BiMy7
         jvPXaFCRl9o0Zyi84Hxg+CWbrxmcS+15fzBA8nXaLZZkhjDw8K32/P5+r0OS1cnFMn7v
         v6eq+wjLUKken+Ykjlvjj8Me0kxNaR5iVZOeatimGAb00e87f6yVXAGMVEwCDE9nkQ6E
         FereQh3vjnfk48GZv+YgRE5+/nmVDNq9dGiiYPSoCl03dQ4d8NnOXLXWr9n7X5w4PCAv
         lfqw==
X-Forwarded-Encrypted: i=1; AFNElJ/kJaGAxa7w5j+/FRN1OcoE1DWVINn848qaCAxzs169jGostghBm58EBSmGrNwKPag30H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqICVB65W23qZ98Vt68/VuNxqa0f0IXEAJiEFglFVaWJ8M9pG
	JVTMZpNPLJr+BaUNndZPcB25c7Qf4mqWBrtNk1wJC9Hi53wwehFOGBhm
X-Gm-Gg: AeBDievErmBcbn756lWXSGGxOiGJGxPwEm9roNDmSZE7vJCug5XCdGRfX8ZU5P0XdZa
	catehp7e+Ik6gO5kcb4fqmOQX8szWlQvfbe+0OXxI9eklTPcmjFrQXViwb9vFXmCyyGxkVRuYEE
	u+oZwlNDgmNLbxxUdfxKClBYiFI8/pEWWJiDaxzQXXQblGUTdwu+8X1iQRb2dFRz1BVHsecOMFI
	IdOk1NS1HAzS2pJSl9YE8YSlsYRXundWVpTB6e3q52Q7G8tg5zWeSCQW33ZG9elnOQnFGzePUS9
	OOUGfic9hLjhrXhpECD1GVdUd7SZJYXpDz93R0EpkMUwidaknT0qJi+o6flQDb9s1rqA9KpKwlt
	8Fg1TQa1eG+GXxdAhlzlWgGuOA/9IaN9wbmEM4koPVMCtPTb9HYX2B3dRXnLcchJM4zLeOhD6Xc
	ZGgJDdbFX2/5Yenb2qulSWTXGhJi0531rZ31Wj2brApLBoaZfyQzmVXq5GkO4pfE6/mfYYEo/2A
	CErVHP1GiCSPQXlpe15TAF0
X-Received: by 2002:a05:6000:1841:b0:43d:7dc2:b655 with SMTP id ffacd0b85a97d-44bb3aa9a9fmr811432f8f.15.1777659544712;
        Fri, 01 May 2026 11:19:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1706:1a01:ea91:f304:7cad:8467? ([2a0a:ef40:1706:1a01:ea91:f304:7cad:8467])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981defb3sm8695246f8f.20.2026.05.01.11.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 11:19:04 -0700 (PDT)
Message-ID: <5256b235-b173-4804-aef0-752eac81d618@gmail.com>
Date: Fri, 1 May 2026 19:19:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] status: improve rebase todo list parsing
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Tian Yuchen <cat@malon.dev>
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <cover.1777648598.git.phillip.wood@dunelm.org.uk>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cover.1777648598.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/05/2026 16:16, Phillip Wood wrote:
> When there is rebase in progress "git status" displays the last couple
> of completed and the next couple of pending commands from the todo
> list. When it does this is tries to abbreviate the object ids of
> the commits to be picked. Unfortunately it does not abbreviate the
> object ids when the line starts with "fixup -C" or "merge -C". It
> also mistakenly replaces the refname in "reset main" and "update-ref
> refs/heads/main" with the object id that the ref points to.
> 
> This series fixes that. The first patch factors out the sequencer
> code that parses the command names in the todo list. The second patch
> uses that function in "git status" to parse the command names so that
> it knows whether the line may contain "-C" and whether there is an
> object id that should be abbreviated.
> 
> Thanks to Elijah and Patrick for their comments in V1.

Sorry Tian, I'd forgotten that you'd commented on these patches as well 
- thanks for your comments too.

Phillip

> 
> Changes since V1:
> 
> Patch 1 - Expanded commit message and added a code comment.
> 
> Patch 2 - Fixed some typos, added a code comment and clarified that -Wswitch
>            is included by -Wall.
> 
> Base-Commit: 8c9303b1ffae5b745d1b0a1f98330cf7944d8db0
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fimprove-status-todo-list-parsing%2Fv2
> View-Changes-At: https://github.com/phillipwood/git/compare/8c9303b1f...b80bc1e0a
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/improve-status-todo-list-parsing/v2
> 
> 
> Phillip Wood (2):
>    sequencer: factor out parsing of todo commands
>    status: improve rebase todo list parsing
> 
>   sequencer.c            |  45 +++++++++-----
>   sequencer.h            |   8 +++
>   t/t7512-status-help.sh |  74 +++++++++++++++--------
>   wt-status.c            | 131 +++++++++++++++++++++++++++++++++--------
>   4 files changed, 191 insertions(+), 67 deletions(-)
> 
> Range-diff against v1:
> 1:  3d5135a719 ! 1:  d27dddff93 sequencer: factor out parsing of todo commands
>      @@ Metadata
>        ## Commit message ##
>           sequencer: factor out parsing of todo commands
>       
>      -    Move the code that parses todo commands into a separate function so that
>      -    it can be shared with "git status" in the next commit.
>      +    Move the code that parses todo commands into a separate function so
>      +    that it can be shared with "git status" in the next commit. As we
>      +    know the input is NUL terminated we do not pass a pointer to the end
>      +    of the line and instead test for a blank line by looking for NUL, CR
>      +    LF, or LF. We use starts_with() instead of starts_with_mem() for the
>      +    same reason. This results in slightly different behavior when there
>      +    a CR at the start of the line that is not followed by LF. Previously
>      +    such a line was treated as a comment rather than an invalid line.
>       
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>      @@ sequencer.h: int read_author_script(const char *path, char **name, char **email,
>        int write_basic_state(struct replay_opts *opts, const char *head_name,
>        		      struct commit *onto, const struct object_id *orig_head);
>        void sequencer_post_commit_cleanup(struct repository *r, int verbose);
>      ++
>      ++/*
>      ++ * Try to parse the todo command pointed to by *p. On success sets cmd,
>      ++ * advances p and returns true. On failure returns false, leaves p and
>      ++ * cmd unchanged.
>      ++ */
>       +bool sequencer_parse_todo_command(const char **p, enum todo_command *cmd);
>      ++
>        int sequencer_get_last_command(struct repository* r,
>        			       enum replay_action *action);
>        int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
> 2:  d20dc1f655 ! 2:  b80bc1e0a2 status: improve rebase todo list parsing
>      @@ Commit message
>       
>           When there is rebase in progress "git status" displays the last couple
>           of completed and the next couple of pending commands from the todo
>      -    list. When it does this is tries to abbreviate the object ids of
>      +    list. When it does this it tries to abbreviate the object ids of
>           the commits to be picked. Unfortunately it does not abbreviate the
>           object ids when the line starts with "fixup -C" or "merge -C". It
>           also mistakenly replaces the refname in "reset main" and "update-ref
>      @@ Commit message
>           wider variety of commands. Only the pending commands in the tests
>           are changed to avoid removing existing coverage.
>       
>      +    Helped-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>       
>        ## t/t7512-status-help.sh ##
>      @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
>        	return split_in_progress;
>       +}
>       +
>      ++/*
>      ++ * If the whitespace-delimited token starting at or just after *pp *
>      ++ * is a hex object id that is longer than its default abbreviation, *
>      ++ * abbreviate it in-place, shrinking `line` accordingly. On return
>      ++ * *pp points one past the (possibly abbreviated) token. Leaves both
>      ++ * `line` and *pp-advanced-past-the-token unchanged in all other cases
>      ++ * (non-hex token, unresolvable, or a refname that happens to consist
>      ++ * only of hex digits).
>      ++ */
>       +static void abbrev_oid_in_line(struct repository *r,
>       +			       struct strbuf *line, char **pp)
>       +{
>      @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
>       +	p += strspn(p, " \t");
>       +	end_of_object_name = p + strcspn(p, " \t");
>       +	/*
>      -+	 * The for "merge" and "reset" the object name may be a label or
>      ++	 * For "merge" and "reset" the object name may be a label or
>       +	 * ref rather than a hex object id. Only abbreviate the object
>       +	 * name if it is a hex object id.
>       +	 */
>      @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
>       +	*pp = end_of_object_name;
>       +}
>       +
>      -+static void skip_dash_c(char **pp) {
>      ++static void skip_dash_c(char **pp)
>      ++{
>       +	char *p = *pp;
>       +
>       +	p += strspn(p, " \t");
>      -+	/* The (void) cast is required to silence -Wunused_value */
>      ++	/* The (void) cast is required to silence -Wunused-value */
>       +	(void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
>       +	*pp = p;
>        }
>      @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
>       +
>       +	/*
>       +	 * Avoid "default" and instead list all the other commands so
>      -+	 * that -Wswitch warns if a new command is added without handling
>      -+	 * it in this function.
>      ++	 * that -Wswitch (which is included in -Wall) warns if a new
>      ++	 * command is added without handling it in this function.
>       +	 */
>       +	case TODO_BREAK:
>       +	case TODO_EXEC:

