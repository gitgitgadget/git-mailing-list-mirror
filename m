Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF437FF77
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655365; cv=none; b=HvMO6t3cyhR++8xbGeOUNjeOSXbxewAQCjvFYWa71Ef/fKCAARezyqrJoW3F+aZTniMd6SEnQUsTg7glVLUSYDC4bCMr2TpuqWEuPbO4+gfexdTjpksKQMS4P4HVOemB8zGtL33hjQbYKYfcf9QFro7/TS+EVwWYM7T48jXdJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655365; c=relaxed/simple;
	bh=qVUfy8mkYM3CYWrY29NFyNm5EaHY2h+2TIcTJA0/ay8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLK3P1Vu+Gac635h5xWsQLIs8CoLQzpzaYe+vK4Ar7Hb0/vw150WMSSd0t5EKHFd+P8gadkaYAiR3bsQkjz9GqR77ctAZ/RdUoAZYxTupNAPUlq79A2z1Mxtoyttie2RAwLKAoi2TLwmjoX6hxhN7chVW1TTRz9YKkyN8IDFe3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj9PJDit; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj9PJDit"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so13449225e9.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770655364; x=1771260164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/EnEbB3GiiUaSVAW/qRMVbCo+uEjcQAkzOQRjvI908=;
        b=Vj9PJDithKnqv/cQvdW2lpwBeh30gHk6DIpr1jkYoqxtqj9H4Huy92OXwx+OhnE0co
         4p9iLntb4K7GHNJkIlYikfIHtsFC6wWxT+BqMjUktMXweZlYSeOhPby9MAktS8V5tR44
         gv+8Nz+5VOyGv89z2WjnT4oMNt8abhoBPVgl5WnMrPCTMw6OQm9CJuLQJ8NK5bNmFrew
         gH4UyNfZGcbopOB9jLLAsTiHX6xc08l3XeNf3Rsq9RJp+h/SRBRZMy4MZH+MIOdwACGx
         MRQ7wAav14IN1QrjVlSYRPgm3+9pPwYT5DzbLOjuC/aHQwXa/fw+Ul/IdRO8tNaDfSLR
         zR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655364; x=1771260164;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/EnEbB3GiiUaSVAW/qRMVbCo+uEjcQAkzOQRjvI908=;
        b=PUBklGO6yqXO/oOW4BxoD18wnsWJSpnSWtR3VGZZwk6Vr+lU16v7F6fI/lUPxRHP7S
         zLvxzRQnvANWSrlZBY+7vh8lzHObO8nGP53MiaXGrF8n78WcFSKPo3RurwBhupGjcJpb
         iyGm/6gBZhSiMUZh/CGmK7IZwsnWBgqX5SINGs0TkV2tf49RcfxGOgYmJuGldhTo8chf
         o3w2F4TuRoFqlgDIFqd7Qx7w1kH1khUTL+TWYUdzcJesEvVbBEIR0TSXGjWzBxZqy2ev
         f+bXklXHxWBrcxr39pLlgSrGLbjEdvtrI9WhvXoKknX3ZxUOY4KGJgfA3uCGsSsEacbW
         YLPA==
X-Forwarded-Encrypted: i=1; AJvYcCWwRFZCW/+Yyx/rD6LxO6c4BoCtAFPzikUOIOMOeUbBI6XbzWiWWzp1lrqsHj8b93TXx2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD6vcESkm3zZryfaUFdn3zaza7GcdMXpvZM30qQUJav8hQmKLM
	DvIC6dBoeyCdJIWPQem/AFZZ3RRV+C8MqMdeyqewyNxwHP5IL5yAf0Rd
X-Gm-Gg: AZuq6aIrF35SWQjaFBgim1RHQ53GherQ2R7qlcA5HU7l8R8yPf+Mf7jeg+9JsRb0/Pm
	2b83P3XX4ASuhM+mZWFiTelXVy4w0lQJcss84WHmLBkiGaP5IBFl4sDbzaZ3KA63lSBr3nOuZDN
	+pZq8GwPbvW6RMpiPyqpnAaOwt8JTsq8Z/UdzljkmXJo1IFOVhhHquQ5DUEDm0z8AWmUb1tH87m
	4OZF1YsGgp7cSgMncomib73eIF6BnrsyzVzDw56kqhozCxnhGk7jSoyRzzF8QrgnLkl6EeWdijO
	lnaPn5Ho94VLqd4IDWkRgC7t1nRFU0rL5FRkYzpph3AgegJXvHxZ9UYhP06nmig2Mh/H18TQVaS
	GTHYbqB0vENv75Gcy1G/iKg6eDGSmJOiiaihbV1uwOsQ6Lf2cdPmQv4gXnQft0GX8xrdf37z9UW
	LxzTfRX7Sb1+Ac5v2daDZADOxBVaI4XMe8XpH88iw32DXpvA5OjHd7eGBrS0midr1/7Sit7H9WB
	SMAEg==
X-Received: by 2002:a05:600c:1912:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48320966cf7mr133571595e9.20.1770655363388;
        Mon, 09 Feb 2026 08:42:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm343565e9.14.2026.02.09.08.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 08:42:42 -0800 (PST)
Message-ID: <bf5d1e84-2a59-4e1b-a524-c8b251dbae70@gmail.com>
Date: Mon, 9 Feb 2026 16:42:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] doc: add caveat about roundtripping format-patch
To: kristofferhaugsbakk@fastmail.com, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Matthias Beyer <mail@beyermatthias.de>,
 Christoph Anton Mitterer <calestyo@scientia.org>,
 Matheus Tavares <matheus.tavb@gmail.com>,
 Chris Packham <judge.packham@gmail.com>, Jakob Haufe <sur5r@sur5r.net>
References: <bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm>
 <format-patch_caveats.281@msgid.xyz>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <format-patch_caveats.281@msgid.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

Thanks for working on this. I've left a few comments below but I think 
what you have here is pretty good already.

On 08/02/2026 00:11, kristofferhaugsbakk@fastmail.com wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> 
> git-format-patch(1), git-send-email(1), and git-am(1) deal with

I found the mention of git-send-email here and in the documentation a 
bit distracting as it doesn't do any formatting itself - it just runs 
"git format-patch"

> † 1: There is also git-commit(1) to consider. However, making that
>       command warn or error out over such delimiters would be disruptive
>       to all Git users who never use email in their workflow.

This reference is formatted differently to the rest.

> [2]: Recently patch(1) caused this issue for a project, but it was noted
>       that git-am(1) has the same behavior[3]
> [3]: https://github.com/i3/i3/pull/6564#issuecomment-3858381425
> [4]: https://lore.kernel.org/git/xmqqldh4b5y2.fsf@gitster.g/

> diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
> new file mode 100644
> index 00000000000..2accf2763fd
> --- /dev/null
> +++ b/Documentation/format-patch-caveats.adoc
> @@ -0,0 +1,39 @@
> +Patches produced by linkgit:git-format-patch[1] or
> +linkgit:git-send-email[1] are inline. This means that the output of
> +these two commands can lead to a different commit message when applied
> +with linkgit:git-am[1]. It can also mean that the patch is not applied
> +correctly.

Is this last sentence referring to diffs in the commit message being 
applied? I don't think there are circumstances where the patch itself is 
not applied correctly.

> +The commit message might contain a three-dash line (`---`) which was
> +perhaps meant to be a thematic break. That means that the commit message
> +will be cut short. The presence of a line starting with "Index: " can
> +cause the patch not to be found, giving an error about an empty patch.
> +
> +Furthermore, the presence of an unindented diff in the commit message
> +will not only cut the message short but cause that very diff to be
> +applied, along with the patch in the patch section. The commit message
> +might for example have a diff in a GitHub MarkDown code fence:
> +
> +----
> +```
> +diff ...
> +```
> +----

I'm not sure the markdown really adds anything here

> +The solution for this is to indent the diff instead:
> +
> +----
> +    diff ...
> +----
> +
> +This loss of fidelity might be simple to notice if you are applying
> +patches directly from a mailbox. However, a commit authored long ago
> +might be applied in a different context, perhaps because many changes
> +are being integrated via patch files and the
> +linkgit:git-format-patch[1] format is trusted to import changes of a
> +Git origin.

This last sentence lost me a bit. Is this talking about commits that 
have been pushed to a forge and then some downloads it as a patch? It 
would certainly be helpful to explain that even if you're not using an 
email based workflow, it is possible to be caught out by these issues.

> +One might want to use a general-purpose utility like patch(1) instead,

"Given these limitations, one might be tempted to ..."?

> +given these limitations. However, patch(1) will not only look for
> +unindented diffs (like linkgit:git-am[1]) but will try to apply indented
> +diffs as well.

This is useful context.

Thanks

Phillip

> diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
> index 0c94776e296..18f5b950825 100644
> --- a/Documentation/git-am.adoc
> +++ b/Documentation/git-am.adoc
> @@ -259,10 +259,13 @@ message.  Any line that is of the form:
>   * a line that begins with "Index: "
>   
>   is taken as the beginning of a patch, and the commit log message
>   is terminated before the first occurrence of such a line.
>   
> +This means that the content of the commit message can inadverently
> +interrupt the processing (see the <<caveats,CAVEATS>> section below).
> +
>   When initially invoking `git am`, you give it the names of the mailboxes
>   to process.  Upon seeing the first patch that does not apply, it
>   aborts in the middle.  You can recover from this in one of two ways:
>   
>   . skip the current patch by re-running the command with the `--skip`
> @@ -281,10 +284,16 @@ Before any patches are applied, ORIG_HEAD is set to the tip of the
>   current branch.  This is useful if you have problems with multiple
>   commits, like running 'git am' on the wrong branch or an error in the
>   commits that is more easily fixed by changing the mailbox (e.g.
>   errors in the "From:" lines).
>   
> +[[caveats]]
> +CAVEATS
> +-------
> +
> +include::format-patch-caveats.adoc[]
> +
>   HOOKS
>   -----
>   This command can run `applypatch-msg`, `pre-applypatch`,
>   and `post-applypatch` hooks.  See linkgit:githooks[5] for more
>   information.
> diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
> index 9a7807ca71a..36851aaf5e1 100644
> --- a/Documentation/git-format-patch.adoc
> +++ b/Documentation/git-format-patch.adoc
> @@ -796,10 +796,14 @@ CAVEATS
>   Note that `format-patch` will omit merge commits from the output, even
>   if they are part of the requested range. A simple "patch" does not
>   include enough information for the receiving end to reproduce the same
>   merge commit.
>   
> +'''
> +
> +include::format-patch-caveats.adoc[]
> +
>   SEE ALSO
>   --------
>   linkgit:git-am[1], linkgit:git-send-email[1]
>   
>   GIT
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index ebe8853e9f5..0b118df6498 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -690,10 +690,15 @@ Links of a few such community maintained helpers are:
>   	  (cross platform client that can send emails using the ProtonMail API)
>   
>   	- https://github.com/AdityaGarg8/git-credential-email[git-msgraph]
>   	  (cross platform client that can send emails using the Microsoft Graph API)
>   
> +CAVEATS
> +-------
> +
> +include::format-patch-caveats.adoc[]
> +
>   SEE ALSO
>   --------
>   linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
>   
>   GIT
> 
> base-commit: 3e0db84c88c57e70ac8be8c196dfa92c5d656fbc

