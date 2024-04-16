Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09D39FCF
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307488; cv=none; b=CHBeCYu7whpcumIUhjJ4WHj76MbN7duDX06vaYhb/H02n/G2viVtm7sDPANNaWiUpnKGGhvekJ+4QE34dNlhkU3m0zxwUqYB5h/I3dRchFLYE/gBvd0i7n72chu75GdCofR1gPf/LrfWk4c26Mks5yS4nzT7OUpJkQJa6Z+nIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307488; c=relaxed/simple;
	bh=3xQOPlPAMUe0aW8AZCEwRMTo6cdkmZbYFz0B1lgxoVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVEYnkyw/7J3KxmM+uGEEszPkfkBVsqH3qYsbRd/R+bstufpH/zsVTFnLMRKxvUpQaS4ukw/iu2JpasKoTRGoOqKNDmYYC+Bi3FeaWWacs9EewkagXXjzdZGmSfZ8aLgLELpU0Unjx4nEM/zy0+ZJj4zWrdcqrjJi7AZUZrTJzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SXhLIBUa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SXhLIBUa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2b743d86eso56765705ad.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713307486; x=1713912286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I//DdiLd0BZYVN6EKYaLt9SBqYkaSm2sQwUm3UyQ/B0=;
        b=SXhLIBUa0FkNpq5EEul0PIBtTCdyOWAnWDAW+jcrvSQtALl3gZT12wF/2/iHwr0+7d
         14KJd9CrJO9neE/GNPacnvUFyd66vPJqPqsoKcpSOVXe1Bx18hjjrV3vkH+93oyiWp+t
         dZTSyU+KtfA1zMcEikY9XWsNQFbBOsMMIHsfg7l0mYQsNgwQbvDRA49ImABubJezkEsQ
         pkSX2zlmn4+sO2n4z/emyt69PdfnmtML7DRiAlOTCKQFFPGrmFBjp6lyxKrz+91d0ER9
         LS4+idXJN6YS2k+lJzMG3EXvc2ie2NjJod+XqMpDml2W6ZeHuv8kEtJ+K7oP39js0gBe
         ZdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713307486; x=1713912286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I//DdiLd0BZYVN6EKYaLt9SBqYkaSm2sQwUm3UyQ/B0=;
        b=dTNPvw7S0vhTV7y0PvmdMMiIqGY+fSUUa934YF9ayTzES1roS7aOZJC4z+pAzP5ubY
         +lM62W48ANliTu5kPhncAWjaLAV+o+A4RlZESQCfXQoxSlZ2YxrN2rLzxUUCtxJRSHfU
         EtIHKjsNVjrbR4WggkvBX8HO1VVTc4PG6wIpvoUpvX6ZbaNn0H3OViz60bpcJttZK+m9
         IPZ66lCMlsBrTfzX0j3dG/4Rr+XDzT69RrwyXpPKy9LKF078kb5oRU7FEa0brBQJAkHO
         zdOGYGVLvqY/9425x3jBq6foMPHWqdrRs0G8PXOVDieOYpQcKq4coYgeZiwBAyrARdvf
         CtEQ==
X-Gm-Message-State: AOJu0Yy+Xtfz2grQ7f9Y19isdYscJhjyQMSmvREjkWcoh01NnnpvWVii
	MvANPoUQ+Q4v6cbx9zMk7L37slOwTnyIhZSlSETGl9lMJkNWofY8OQEJWFImuFQRb2RHBvWeY4w
	XUA==
X-Google-Smtp-Source: AGHT+IH6KdAJZFpbPBq4HpMXpElrj7snWsFgUREw8aZ3b4GJYuVX3KZi6YGFhIULBLtC6IlBOhWBJunXUeQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:c40a:b0:1e2:a7fb:3d71 with SMTP id
 k10-20020a170902c40a00b001e2a7fb3d71mr399731plk.3.1713307486572; Tue, 16 Apr
 2024 15:44:46 -0700 (PDT)
Date: Tue, 16 Apr 2024 15:44:44 -0700
In-Reply-To: <xmqqsezqmrtd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g>
Message-ID: <owly34rl53mr.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Jonathan Tan <jonathantanmy@google.com>, Emily Shaffer <nasamuffin@google.com>, 
	Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, Eric Sunshine <sunshine@sunshineco.com>, 
	Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Use a dash ("git-contacts", not "git contacts") because the script
>> is not a core builtin command that is compiled into the `git` binary.
>
> Pedantic, but "git mergetool" is how it is spelled even though it is
> not a core builtin command and is not compiled into the binary.  The
> reason why "git-contacts" is better is because we do not install it
> to be usable by user's "git".
>
>     ... because the script is not installed as part of "git"
>     toolset.

Noted; I will use this wording.

> An obvious alternative of course is to promote "contacts" out of
> "contrib/" and install it as part of the standard toolset.  I gave a
> brief scan of the script and did not find anything (other than "only
> the recent 5 years worth of history matters") that is too specific
> to our project and I suspect it should do a reasonable job when run
> in any repository/working tree of a git-managed project.
>
> But it is outside the scope of this series.  I'd still welcome the
> thought to do that after the dust settles, though.

Ack. Ideally we would translate it to C (or, dare I say, into a C lib +
some other higher level language, Perl or otherwise), but I agree that's
for another series.

>> This also puts the script on one line, which should make it easier to
>> grep for with a loose search query, such as
>>
>>     $ git grep git.contacts Documentation
>>
>> . Also add a footnote to describe where the script could actually be
>
> Let's drop ". "

Will do.

> ; it may leave the previous sentence appear hanging
> unterminated, but the capital A that begins a new sentence is a good
> enough sign that we finished the previous sentence, isn't it?

In hindsight I agree. From a quick Google search [1] it looks like your
style is what's preferred in academia also.

>> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
>> index e734a3f0f17..8b6e4bf0300 100644
>> --- a/Documentation/SubmittingPatches
>> +++ b/Documentation/SubmittingPatches
>> @@ -493,9 +493,16 @@ security relevant should not be submitted to the public mailing list
>>  mentioned below, but should instead be sent privately to the Git
>>  Security mailing list{security-ml-ref}.
>>  
>> +:contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
>> +part of the core `git` binary and must be called separately. Consult your +
>> +package manager to determine where it is located. For example&#44; on Ubuntu-based +
>> +systems it could be installed under +
>> +`/usr/share/doc/git/contrib/contacts/git-contacts` and may need to be called +
>> +with `perl ...` if it does not have the executable bit set.]
>
> I wouldn't call anything in /usr/share/doc/ "installed", though.
>
> In the context of _this_ document where the user is working on _git_
> project towards submitting patches to _us_, it is far simpler to
> drop the above paragraph and tell them how to run the script in
> contrib/, e.g.
>
>     $ perl contrib/contacts/git-contacts <args>...
>
> without hinting there is anything platform/distro specific, and
> instead to have them all work from our sources.

Indeed. One small change is that the script already has the execute bit
set so I can drop `perl` as $0 (the execute bit is removed when it is
copied into /usr/share/... on my system).

> I am assuming that any user who are reading this part of the
> document would have a reasonably recent version of our sources
> checked out (after all, they already have a patch or two to send but
> they are learning the way to find whom to send them to).

Agreed.

[1] https://camosun.libguides.com/Chicago-17thEd/quotations
