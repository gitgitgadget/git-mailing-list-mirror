Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AF1B042D
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368823; cv=none; b=rgRsC5Qf5t0EMX4fdDOIStTxNZpJCp5TRf47MBZA4AmLA6wf2176yfmyddoLllZY3UakddqgCfPYPRvJUjOz4xKuRXI3ooZmmiBKmw7Yq7ttkF8B6Sx3NzVKKxAGdSx/YqpyZD01gVH5gXZoydPzZJw5/kAcyJASgVqkmsdsH9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368823; c=relaxed/simple;
	bh=xXFN0tfhRVnJpfc4LYu3R4JmEcIqgp58BQD5hv+DYTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg4cvlIYCKWE31dbwk6JmyJdVcbNsnWCJiopLRbIccPgNc7c1X204Jnn2kTZVqOFmo3bnnIsB0lxYsF5/0qKgTCmIalwYrlf78aWs6HC5zBNNqKL74HCWGya3+PQSjuu51507xHniqnFFzp7Opo9i5mVC/v1qHSAE28B0PljHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=283tnZEh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="283tnZEh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467abce2ef9so49141cf.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 12:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736368821; x=1736973621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWjV6nulo3iUqPy6ngOty53IXPP4bPf4rNKeEIYDamI=;
        b=283tnZEhzBcYDL5WRI9huZgj3vJczSryS8W0wfJHl26q+GHnFtO2aWdzR6daE299+M
         3pWJrjX48/phoZsDnemKsd3Wd8p/WuwrAn7fUQLvLZIrrEX55mwTYR3FSgrEYSynJzk9
         MWHfKzlVmJJoOfko08kkjseNt0zJV4apVX9MdrOx0ygcLB9dHlsuzgg/QNVQbKe/jJtb
         kWYJr6JDhVAzTsavAvKlD4+mgAuwESL/r0aRK1gfkIhF2VLmTrDv8E9aLFrReziV3tcu
         PbnxvEazSgM2l4dwx6v4SYgH5TaSbWmHAPJd9mC/BO4dCjZvrZQxrmG9QFnD5v59HKr+
         xe3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736368821; x=1736973621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWjV6nulo3iUqPy6ngOty53IXPP4bPf4rNKeEIYDamI=;
        b=EIrm1YV2SgcCxf3Xe1BqRvB8DkqD1TFaqEle8Kmaj9cEu88l8TOxNK2hPUjhPVNIWZ
         b8hbhR0PpB84vzmNMxYfvIc/MJiIFVpQGdoG8V+SuKIKepTuwYotlDpkWq/jupL7Vqji
         9at9pMx+mifAKQ5fbJ9egVBMsqlqt9dbN7cZZc2ye1/vaFoJD8xOqCbLdE0AUSJA2muk
         YraioDeHMfa3yY0koBB6CRGJdVpN4AI4BC33SFktmoGTD4mj/x+BcKRZvdrAqE+i4W9a
         pgLDwunQeOWQImxLgprQ6Ao4WDdEUMvVh7jpOKbkeN07Z+coSHk+qSBRyMaLR+yfG19t
         N47w==
X-Gm-Message-State: AOJu0YywKbQJ797o/6yY6paESzGJg/InLqDTX3zRJ8clvhfBI8VNu7sk
	gGMG1TPudNCrWAXBxqzRT0TxnS4eMMyoBIO/tGQUUgg2YrG4B90qiMBX0lIohzjgnTyQ5JAfqFJ
	bM5y0DOWE3VanH35RW9WCsqDDHJt61l7GiNgo
X-Gm-Gg: ASbGnctDwBsLQfrl7HX4PWtZBA0MzK6NvKzUpnCqbODEeNS+Ctykmx9hs3ftVZJBg4I
	9oizAlBd4wmpF5mYnSTcjgrQ9xRdDmkjdbCLdKU3PrshDslC3/k7BlUWTn+2vSX7VRXmx
X-Google-Smtp-Source: AGHT+IHDgkdVLg1kiGWFQa5KnT7aTv/tZp4oR2kwxRHgol7aXKQLeIPBSChDNjRDNug6e8cms3sQryr1z5qsf5ooVuY=
X-Received: by 2002:a05:622a:13c6:b0:466:861a:f633 with SMTP id
 d75a77b69052e-46c7bf64e55mr456421cf.5.1736368820809; Wed, 08 Jan 2025
 12:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.git.git.1736080517950.gitgitgadget@gmail.com>
From: Emily Shaffer <nasamuffin@google.com>
Date: Wed, 8 Jan 2025 12:40:09 -0800
X-Gm-Features: AbW1kvbY9n6Cb3gUrAyly4Q_fhl4eTUXz2wdrZ2vkcrHzJTSQdJwMWujtN-f12s
Message-ID: <CAJoAoZmzLOMNCNP-X-=QTSb=ed0GOkhx7w0PhVc2FmcbVL6jWQ@mail.gmail.com>
Subject: Re: [PATCH] docs: update contributing guide to refer current bugs and
 feature requests
To: Rhythm Narula via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Rhythm Narula <rhythm.narula26@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 4:35=E2=80=AFAM Rhythm Narula via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Rhythm-26 <rhythm.narula26@gmail.com>
>
> The contributing guide is updated to include references to the current
> open bugs and feature requests. This update aims to improve visibility
> for contributors on where to find open issues and features that need
> attention.
>
> CC: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Rhythm-26 <rhythm.narula26@gmail.com>
> ---
>     docs: updates MyFirstContribution guide to refer current bugs and
>     feature requests
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-186=
7%2FRhythm-26%2FupdateContirbutingDocumentation-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1867/R=
hythm-26/updateContirbutingDocumentation-v1
> Pull-Request: https://github.com/git/git/pull/1867
>
>  Documentation/MyFirstContribution.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirs=
tContribution.txt
> index e41654c00a6..3b26a5265b2 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -109,6 +109,14 @@ of invocation during users' typical daily workflow.
>  (We've seen some other effort in this space with the implementation of p=
opular
>  commands such as `sl`.)
>
> +:mailinglist: git+subscribe@vger.kernel.org

What's the purpose of adding this attribute? Did you mean to use it to
linkify "mailing list" in the first bullet below? Note that the
mailing list and how to subscribe to it is also described above under
"Getting Help", maybe it makes more sense to refer back to that
header...? Not sure.

> +
> +Here's where you can find bugs and feature requests existing in the syst=
em:

I like the placement. The patch context doesn't make it super clear,
but this is sitting at the end of the "Identify a Problem to Solve"
step, so it's handy if folks are still following along in this guide
on their first couple of real patches until they build muscle memory
:) Initially I had thought this might make more sense to sit at the
end of the tutorial, as a sort of "what do I do next?", but I think
this placement is very good too.

> +
> + - Git uses a mailing list for discussion on bugs, features and patches.=
 Search for relevant topics or tagged issues
> +   like #leftoverbits in the archives: https://lore.kernel.org/git/
> + - Unofficial bug trackers - https://github.com/gitgitgadget/git/issues,=
 https://git.issues.gerritcodereview.com/
> +



It could be nice to say something like "For next time, here's where
you can find..." but I don't think it's necessary - my personal taste
just thinks it could flow better.

Nice idea, though. With a couple tweaks I'd like to see it land.
Thanks for sending the patch.
 - Emily
