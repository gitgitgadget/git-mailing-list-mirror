Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F036605E
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935077; cv=none; b=YRSmH3LlLU4+SD27oWmR4ccdmCC9NJrp14NGDIWltju5UCWQnr27GC7CoeBy/thOLk0EhnBWdpbYvQb3ndmfQFWqhFnw65hIVcs7rc05w10ovK8RqTa79qcFo8msGOMe/quYvpywXQPPKmNwGt62KTa2vEdn2XvyimSBPqWjl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935077; c=relaxed/simple;
	bh=GjFGqSK+R7as94ol48H6MJs3F9DbQw9QFg4gdl+cDaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1gvbKhANvYmKfajEyvOeybq/52zIPMfhR6YrZ1gHykLd0WeoauXvHsg3oGbh1a8j1bHdykE7KzI59/qDjrhWung5nYrYK0LI9BzyJ8ZbL6ddUcNSzDDajHdhpBQnpgDTPyQTEGRTgtlM1+CqQth2yykL49LFuh3x4rhSgpwHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FR4oZrwq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR4oZrwq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-899afcec41eso1340966d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 04:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935075; x=1772539875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfIgfXLjyzyy9IU1UTmKdecgG6GdZ6GpcixhwIc+dWk=;
        b=FR4oZrwqtsP1Cc711XpahSems7J3g54DeuJer1/dpZK598NUcpYuM9nXh/YlZ6Lo/1
         4QLk2S9n2x2JdG9hidn9ZThu249VMe/8GojZlN+Vlfw4V7JaoJ1MS27L3TTSeLM91DdU
         2aDA2iV7Qteh0RrN/znqDDPx1zM8OIi0w3UfdQYyVL3XDnodCRcPjAIUJkmybI3sV6Od
         +pkxRBzIpmQ6PaDS6THsmK+GebmuRHcqmoHkwE4pTcRatwTNo0xIYSIsyQtXWlbfLj+U
         Fb29d/SkjdfFdO/GF88gtSv6nbUpevETlUtcfrzRVvNlXqFFyoswDQvX9NETvp49tw5f
         5S9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935075; x=1772539875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfIgfXLjyzyy9IU1UTmKdecgG6GdZ6GpcixhwIc+dWk=;
        b=IiBqztr9AFU5i6ml8ZJwFj9yYZgecevvDbey4YCP6g1yQfWYpT0YQ+bCSMjKfJSUNa
         /KJwl5GJKpxXf81laEo85HJm2ILm/zUlgFHbPXhIIQui3yTwM7OYHZOUYpYTyo5IegcH
         fU0P//GaS8HBu4+0UfyW9GHBMonTz98RpNa8wl9OqQKTZU74SqGeaRRZ2+jSg+C1nGCk
         zvCUp0WcAeeKaEhkyhZ2VfEuiVq0njUJfaboShp5eC+sNROkL8EZTs03XbNSdwjOXhq0
         +pibjbSZ+UDyxItZ4OY+HSlgyIKFLo6sCwz/L50eCZM2Av7mR2TrJ5l2cLAB/yxGbiy3
         GHJA==
X-Forwarded-Encrypted: i=1; AJvYcCVoSwqnw8PbnCmhbsXoNsluBAyyodv1p+NeX2dgzzMfjK+y0bNQ+skjRoQsIhqrbJcWUZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xCvGr6IAMj6nkXQplxiQ0IUOS+QTmDPCmd2pSe1Vkbvw1R+g
	tg2rRcRPEcf0RSDvq62hJQOe/Ggw6AqpxjRDWE38xEgfMV5eqs0mjm88
X-Gm-Gg: ATEYQzyXlv8gnbX2fMydCCzPH+b4x32mUuLC6QsAzaPQ22bSWd3/YSa7l/pO2y5QObO
	6S2/D3+9PFRU8ymS1xnwoexJLI08yAbvXgTDV7v385+F40DB4nUC8ffNh/8AlfQDcF5Kw1Rnwer
	p8I54VnT8piUyDB2b0OtKhTqPFQuXV28VSj+7ZVtw1MV4glaFqqx6xRsobJ1hS9DSPonedUG7BX
	dOgDz1+31/rqFHHQpo6cXlUrzul3iIpvHsfRvIPvGrn0gYB7HJpKMmjR1caJNElOhb1c9dJNYIH
	Pb4jY/T/JmGhrv+260YylR3Wsb6mBMRKOJ4/geqvQEOmsDbz/8Gymuf/wV0vo0DLqGIE4EclG+t
	CfpJjV8GNIX1wbd/kgKaof0k8YhF+nKCfBhJCeIqJLS3yULCNPzqjgpYVYJmzJlbjSAZLxtkFjI
	pOs7zNzuFXM4DcIu1VSOZt2e665Dxowv1SsjYqHAQLIrjZaeyHiQgkmt/04RpoT9OHmgs+1gK8x
	d1kXxui5kbCoQgIMW3MlpLjXMS9jkz7t4KuyH7BmlXaGD4+
X-Received: by 2002:a05:6214:1d2e:b0:894:707d:d1e9 with SMTP id 6a1803df08f44-89979ecbd90mr186755196d6.44.1771935074838;
        Tue, 24 Feb 2026 04:11:14 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997c6911ebsm89905816d6.7.2026.02.24.04.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:11:14 -0800 (PST)
Message-ID: <fce7662f-d741-41e1-93dd-f82e65e04f41@gmail.com>
Date: Tue, 24 Feb 2026 07:11:13 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] for-each-repo: work correctly in a worktree
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
 <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>
 <20260224091806.GC986367@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260224091806.GC986367@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/24/26 4:18 AM, Jeff King wrote:
> On Mon, Feb 23, 2026 at 10:34:30PM -0500, Eric Sunshine wrote:
> 
>>> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
>>> @@ -60,6 +61,9 @@ int cmd_for_each_repo(int argc,
>>> +       /* Be sure to not pass GIT_DIR to children. */
>>> +       unsetenv(GIT_DIR_ENVIRONMENT);
>>
>> This only unsets GIT_DIR. Is that sufficient in the general case?
>> Elsewhere, we recommend[*] unsetting all of Git's local environment
>> variables.
>>
>> [*]: From the "githooks" man page: "Environment variables, such as
>> GIT_DIR, GIT_WORK_TREE, etc., are exported so that Git commands run by
>> the hook can correctly locate the repository. If your hook needs to
>> invoke Git commands in a foreign repository or in a different working
>> tree of the same repository, then it should clear these environment
>> variables so they do not interfere with Git operations at the foreign
>> location. For example: `unset $(git rev-parse --local-env-vars)`"
> 
> Yeah, agreed. There's another subtle issue, which is that this is
> unsetting GIT_DIR in the parent process. So any other code we call that
> is meant to run in the original repo might get confused. I can well
> believe there isn't any such code for a command like for-each-repo, but
> as a general principle, the change should be made in the sub-process.
> 
> You can stick the elements of local_repo_env into the "env" list of the
> child_process struct. If you grep around, you can find some instances of
> this.
> 
> There's an open question there of how to handle config in the
> environment, though. Depending on the sub-process, you may or may not
> want such config to pass down to it. For for-each-repo, I'd guess that
> you'd want:
> 
>    git -c foo.bar=baz for-each-repo ...
> 
> to pass that foo.bar value. We do have a helper to handle that in
> run-command.h:
> 
>    /**
>     * Convenience function which prepares env for a command to be run in a
>     * new repo. This adds all GIT_* environment variables to env with the
>     * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
>     * corresponding environment variables to be unset in the subprocess) and adds
>     * an environment variable pointing to new_git_dir. See local_repo_env in
>     * environment.h for more information.
>     */
>    void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
> 
> Do be careful using it here, though. It expects to set GIT_DIR itself to
> point to the new repo (which is passed in). But I'm not sure that's 100%
> compatible with how for-each-repo works, which is using "git -C $repo"
> under the hood, and letting the usual discovery happen.
> 
> So for a bare repo, you'd want to pass the repo directory. But for a
> non-bare one, you'd want $repo/.git. And there are even more weird
> corner cases, like the fact that using "/my/repo/but/inside/a/subdir"
> with for-each-repo will find "/my/repo".
> 
> So you might need to refactor prepare_other_repo_env() to split out the
> "everything but the config" logic versus the "set GIT_DIR" logic. Or
> just inline the former in run_command_on_repo(), though it probably is
> better to keep the logic in one place (it's not many lines, but it has
> to know about all of the env variables that affect config).

Thanks for the recommendations. I'll come back with a more sophisticated
v2 that handles these issues.

> Alternatively, for-each-repo could do repo discovery itself on the paths
> it is passed, before calling sub-programs. That's a bigger change, but
> possibly it could or should be flagging an error for some cases? I
> dunno.
I'm surprised that passing '-C <repo>' doesn't already overwrite these
variables but I suppose environment variables override arguments in this
case. (This is the root of the bug.)

Thanks,
-Stolee

