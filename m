Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE711B275
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094088; cv=none; b=VeIlb31YTwGG7DyxKFkgVYc1tSXQ37KUZN5QqWx5HhaRW9etVct4YkdYpXV/foI7oy0LvmppcOwmV6ucrDUSmIP7UCHCeZINOm0XGbWycT/NtOxW+ePJS+wMT1dTo+nCyac8tQr8EdOWXcDmVee07ZDgoQwz9vEJHJdexdgDEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094088; c=relaxed/simple;
	bh=rnj1qRuylxJWmD8SkQEj7FiRUy72xwISNZEduUWNCY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMa4YdPXrQhwDT4XLF5rhmfdiw3sw1BOa6Oq1T8p9Nt2pwp4TzLJuQ4u7jO+Wq3AIRshlngM41pnuGq7RQepJZ49ZR9DOTO5N2PGPBfbhQJLF67FbpnG8FtjnshNI8ZVEec6Wx2SBOmvi/BmNpGvEUvzawefGHcaMrk6WEfPxzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxoaU77t; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxoaU77t"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337b8da1f49so4729909f8f.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2024 03:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706094085; x=1706698885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EJzqs/CoDq5WfYLMGCJRzMtukGeCI3P0SWvTd0OgoVo=;
        b=KxoaU77t+pFxsTzHgPO170HQSbK9nUUygl/dftv3ys5JMCjtBT1xUAGpO1KKnQLz4m
         wd/8bjP+RBG6j2zNk62hZ43nL4VgSeJG0TXfA0TZJrRapveMteieVI+rWPTYzPvaS2QX
         wZGWW5VGJ7WXVEBpQZ7Vef0yMABZYcQ7L/82kheOKtes3YNDVRQUGD5+XmsQM1ZWFbQw
         rH0ZP45Rw5q2ZjxXuse50wFsnIlH6nWjSlOQajluVlnFiMAH5HqDmvVSMDGsQyj4zZPM
         BCLu8UFkQWs6XR6v4MDDHVbIgjYUC6ePHXTSgwWoyZxtggYHwKvpvDHslDerRnlhHtB0
         uPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706094085; x=1706698885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJzqs/CoDq5WfYLMGCJRzMtukGeCI3P0SWvTd0OgoVo=;
        b=YBIYAmKqRcFJloS9sip+663ryU6Jr34dDovs+X80+zec+HrQVpf5m+L+WIu8v8dCoj
         HW/Ev4fJwkmVGEzopTOQZ0MUotV1JIdTxArFW6GyOyTq29Gkz0gkhbYXFWJ56BAocWfJ
         DVNhLBlkcqseu2uiPsQ0hO6IZ4EYqWXuIcRhVxrpdJtXcNJiuzW5ilUy7jInaOkt6ivp
         QQfoxPynoZFjxfDnaP9TzMe8QCDD53RFi48ekE0h88HLp2r7YMyrtpbQHjzkywQHac2z
         2XE0UciDUxT2ngfio3CN36/yaipALvFuTiwg3gps1wgnDF9O7l2o/sTZGpWTwOOx6eJE
         iugg==
X-Gm-Message-State: AOJu0YzBrQZ0LRucPuIQbT5HkOLrmsLRu9QpqZwGYEOb7lUHXbWvrIJg
	k46pp7MZw+4dVhc75z+oeUnASA2TRBBlGrmSR6Mff5KnjmS2TknK
X-Google-Smtp-Source: AGHT+IF5uUBvUtto5YKdWYnPzBmIeekq1vbtTwQFI9noG6ymM8ZGGvFnWKl9duF5KraRYz9aT3pIDw==
X-Received: by 2002:a5d:5310:0:b0:337:c6d7:32d9 with SMTP id e16-20020a5d5310000000b00337c6d732d9mr334718wrv.206.1706094084699;
        Wed, 24 Jan 2024 03:01:24 -0800 (PST)
Received: from [192.168.1.101] ([84.64.64.237])
        by smtp.googlemail.com with ESMTPSA id e11-20020a5d594b000000b003392bbeeed3sm10076232wri.47.2024.01.24.03.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 03:01:24 -0800 (PST)
Message-ID: <7229fe62-cf9b-4829-80ec-c6b44c52163e@gmail.com>
Date: Wed, 24 Jan 2024 11:01:23 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
 commit options
Content-Language: en-US
To: brianmlyles@gmail.com, git@vger.kernel.org
Cc: me@ttaylorr.com, newren@gmail.com
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Brian

Here are some code comments now I've realized why we need to change it

On 19/01/2024 05:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
 >   Documentation/git-cherry-pick.txt | 10 +++++++---
 >   builtin/revert.c                  |  4 ----
 >   sequencer.c                       | 18 ++++++++++--------
 >   t/t3505-cherry-pick-empty.sh      |  5 +++++
 >   4 files changed, 22 insertions(+), 15 deletions(-)
 >
 > diff --git a/Documentation/git-cherry-pick.txt 
b/Documentation/git-cherry-pick.txt
 > index fdcad3d200..806295a730 100644
 > --- a/Documentation/git-cherry-pick.txt
 > +++ b/Documentation/git-cherry-pick.txt
 > @@ -131,8 +131,8 @@ effect to your index in a row.
 >       even without this option.  Note also, that use of this option only
 >       keeps commits that were initially empty (i.e. the commit 
recorded the
 >       same tree as its parent).  Commits which are made empty due to a
 > -    previous commit are dropped.  To force the inclusion of those 
commits
 > -    use `--keep-redundant-commits`.
 > +    previous commit will cause the cherry-pick to fail.  To force the
 > +    inclusion of those commits use `--keep-redundant-commits`.
 >
 >   --allow-empty-message::
 >       By default, cherry-picking a commit with an empty message will 
fail.
 > @@ -144,7 +144,11 @@ effect to your index in a row.
 >       current history, it will become empty.  By default these
 >       redundant commits cause `cherry-pick` to stop so the user can
 >       examine the commit. This option overrides that behavior and
 > -    creates an empty commit object.  Implies `--allow-empty`.
 > +    creates an empty commit object. Note that use of this option only
 > +    results in an empty commit when the commit was not initially empty,
 > +    but rather became empty due to a previous commit. Commits that were
 > +    initially empty will cause the cherry-pick to fail. To force the
 > +    inclusion of those commits use `--allow-empty`.
 >
 >   --strategy=<strategy>::
 >       Use the given merge strategy.  Should only be used once.
 > diff --git a/builtin/revert.c b/builtin/revert.c
 > index e6f9a1ad26..b2cfde7a87 100644
 > --- a/builtin/revert.c
 > +++ b/builtin/revert.c
 > @@ -136,10 +136,6 @@ static int run_sequencer(int argc, const char 
**argv, const char *prefix,
 >       prepare_repo_settings(the_repository);
 >       the_repository->settings.command_requires_full_index = 0;
 >
 > -    /* implies allow_empty */
 > -    if (opts->keep_redundant_commits)
 > -        opts->allow_empty = 1;

I'm wary of this, especially after Juino's comments in 
https://lore.kernel.org/git/xmqqy1cfnca7.fsf@gitster.g/

The documentation changes look if we do decide to change the default.

 >       if (cleanup_arg) {
 >           opts->default_msg_cleanup = get_cleanup_mode(cleanup_arg, 1);
 >           opts->explicit_cleanup = 1;
 > diff --git a/sequencer.c b/sequencer.c
 > index d584cac8ed..582bde8d46 100644
 > --- a/sequencer.c
 > +++ b/sequencer.c
 > @@ -1739,22 +1739,24 @@ static int allow_empty(struct repository *r,
 >        *
 >        * (4) we allow both.
 >        */

The comment above should be updated if we change the behavior of this 
function.

 > -    if (!opts->allow_empty)
 > -        return 0; /* let "git commit" barf as necessary */
 > -

Here we stop returning early if allow_empty is not set - this allows us 
to apply allow_empty only to commits that start empty below.

 >       index_unchanged = is_index_unchanged(r);
 > -    if (index_unchanged < 0)
 > +    if (index_unchanged < 0) {
 > +        if (!opts->allow_empty)
 > +            return 0;
 >           return index_unchanged;
 > +    }

I don't think we want to hide the error here or below from 
originally_empty()

 >       if (!index_unchanged)
 >           return 0; /* we do not have to say --allow-empty */
 >
 > -    if (opts->keep_redundant_commits)
 > -        return 1;
 > -

We move this check so that we do not unconditionally keep commits that 
are initially empty when opts->keep_redundant_commits is set.

 >       originally_empty = is_original_commit_empty(commit);
 > -    if (originally_empty < 0)
 > +    if (originally_empty < 0) {
 > +        if (!opts->allow_empty)
 > +            return 0;
 >           return originally_empty;
 > +    }
 >       if (originally_empty)
 > +        return opts->allow_empty;

Now opts->allow_empty only applies to commits that were originally empty

 > +    else if (opts->keep_redundant_commits)
 >           return 1;

This ensures we keep commits that become empty when 
opts->redundant_commits is set.

The changes to allow_empty() all looks good apart from hiding errors 
from index_unchanged() and originally_empty()

Best Wishes

Phillip
