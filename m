Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA601339A8
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743777956; cv=none; b=ViEUmq+0GG7f6wsE+GtRw7sdUu5Oa2iGTplEvzcC4kxQLqdPsAcyQYySamDaMdBCS3O1M2TIRD7YxrICH9i43b5DHH0gYaJ3kqRdRvofQic96jnWVcF6B9527dqm4bGhuFqMcROb40DMtoCuPiTtGJcle4JePiHsyh04IBmpxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743777956; c=relaxed/simple;
	bh=jcE2qks1K6AteEQKHdd85sPG4HF36JwdSjOMgKJ2ZAg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFSvECJZBGc0WgT+MQ3U74Mi0G6TAV5AyEC9ZqujUKaoReG3DX7RkGyCt23rKe9gEbQSJv/YknBiR0QPdrSLJOZj+aP9cI7vFR1jJoRFtqE35V4uFR3LTVO/VR5GoNKeqv/euUl1lqchwcaBc4aTssqVesDPoO5THgtJWChiZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4G8LJWY; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4G8LJWY"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso1196702e0c.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 07:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743777953; x=1744382753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jcE2qks1K6AteEQKHdd85sPG4HF36JwdSjOMgKJ2ZAg=;
        b=c4G8LJWY+P+Zus3PnFzG/UoOsXsScg6sukFqtGoxoM/6Ws8Ho5CLcDzmhLACur+2ej
         n4s71wCShFndsb4VfVFWVu7xISRsY+yqsX0VAdnk7/8nfIVt7Kh1Vl18dtEDHT39ez9y
         bWEVdXxx6nAwql5vJqpVaLK95utMzbO5YudXwFntU1mcd0YT4rJkpIDY4R3jArBgV31e
         1ndV0vQY0U+7Rd/YvSXXvmkop1nOqcRITbgzTDdvjqFhrei86s4IOl1qdZFcK9V/G+WF
         y88n78io67VkinEwcfnJ6RpRu9CxPjXYhKQPiPzcNSW40jCDAMooRQqAB1rPzvSb7RUD
         Jkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743777953; x=1744382753;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcE2qks1K6AteEQKHdd85sPG4HF36JwdSjOMgKJ2ZAg=;
        b=NYz9kO4jAAEd1B3vbqEiErgP02j0A1c/iXsGigd5n1x2+mU/6fZ0dVHxEyRj7Bl5NZ
         7LNLURz+rPZ+QE8qU7EycQ8cKxqe0WVIQT804Caxbxw8dOBsgiJBN5k5xMlnW53B1NDM
         EhVkTVNzdpgNC4eUcwpGihAlghH2n3vN9v2aWrB0VSk1OlC2sh77y6ukIC9FFQeXbviv
         Vk0ebFpt93+FonbO9lKx047IsAE5mnFrhRAb0U5XoLtYI5qT1+T3swmxrVaOCkT1rYM+
         wLAa8Yo39LzKZPTQztuBCPN5BUL0dfByxLvBHlKH8/0UG7TTS58xa94fBGfcPrg3ivJN
         xrFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0JQeYpYVaFRXi4Q1jByZEnM470kTNQVlcqBTDYvyyiLDno1NkSSYnAfTOaFuDhFWpw8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxlFFt7XmwOUXOvhFcZYG+LZotjORsu6enDo6ZSv6NsM7XgZd
	DXnBjy6RlBf8eflb01vwUWY7arXG66uIJ7KjMW3LNheiu7ajAcxiazzCDQGccYuZHUJmPqRt03E
	0WsgNMxcp58gpaGqvHOYT3w4/3L0=
X-Gm-Gg: ASbGncsPHUZojiAuYIgFmNos0zXCHX3J+C/OsQWlzqLzMGx7AmErk6yBQQ49jWV8Q/W
	wayjSRI7QpoHqeAKifevQfXJQqlVKStTFhL0CZny0D4IMuY9Kst8FQ04mkwfyiyg0eV7Uq70ffM
	uIq1QVRta9QsN+YmlM0H4oZgbFabwrpOueacIh2h3H+PMxXCglA6DLCyw8ojPv
X-Google-Smtp-Source: AGHT+IH7ijDBJMqbI8c2vMMQgQU8KrS2i7cc5jq0SbCR9Eq11oCpG7FivxC6hbBMh5jtbKcVTFRnWDGWIu5Y9BFsNYM=
X-Received: by 2002:a05:6122:3291:b0:51f:3eee:89f4 with SMTP id
 71dfb90a1353d-5276455f053mr2783693e0c.9.1743777953645; Fri, 04 Apr 2025
 07:45:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 07:45:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 07:45:52 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250404085133.1098274-1-ayu.chandekar@gmail.com>
References: <20250326052602.265989-1-ayu.chandekar@gmail.com> <20250404085133.1098274-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2025 07:45:52 -0700
X-Gm-Features: ATxdqUEPsBix4GLa5YDM4dNXUIRGkCNgRcy5quWjsgJz7b66SQnX6T1-VP6nFsU
Message-ID: <CAOLa=ZQ8KvAZjsDWerF0E9VUzsbNOj+Vcxo_mFL5Y3Of9iCAHQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BGSOC=5D_=5BPROPOSAL_v2=5D=3A_Refactoring_in_order_to_re?=
	=?UTF-8?Q?duce_Git=E2=80=99s_global_state?=
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, ps@pks.im, 
	shejialuo@gmail.com, shyamthakkar001@gmail.com
Content-Type: multipart/mixed; boundary="0000000000007ea8060631f4f11d"

--0000000000007ea8060631f4f11d
Content-Type: text/plain; charset="UTF-8"

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

[snip]

> Proposed Plan:
> --------------
>
> I have been reviewing global variables across the codebase to understand their
> dependencies and impact. To do this, I examined `config.c` and cross-referenced
> it with `environment.c` to see how these variables are currently managed. The
> goal of this project is to eliminate global variables by moving their
> configurations into their local contexts.
>
> The general approach for handling a global variable begins with understanding
> its purpose. This involves tracing its usage across the codebase and identifying
> the subsystem it should belong to. If the variable is closely tied to
> repository-related functionality, it may belong in struct repository or
> struct repo_settings. Otherwise, it should be placed in a more suitable
> context based on its scope.
>
> Additionally, it's important to review previous attempts or related patches
> to understand past design decisions and ensure consistency with ongoing efforts.
> Finally, the global instance is eliminated by relocating the variable into the
> appropriate context and passing it through the relevant code paths.
>
> Example: Handling `is_bare_repository_cfg`
> The variable `is_bare_repository_cfg` determines whether a repository is bare,
> meaning it lacks a working directory. Since this property is fundamental to
> how a repository functions, it should be placed in struct repository.
>
> I have also gone through the code paths and analyzed how this variable is
> initialized. We can initialize it similarly to how hash_algo is set through
> the repository format. The repository format already contains an `is_bare`
> field, which we can use to set this variable inside struct repository.
>
> However, I still have some questions regarding why the is_bare_repository()
> function checks for `repo->worktree` and why the `worktree struct` itself has
> an `is_bare` variable. If a repository is considered bare when !repo->worktree
> is true, the role of `worktree->is_bare` needs further clarification. I believe
> that by engaging with the community, my understanding will become clearer.
> I also went through [4] to see how John Cai's approach was.
>
> This is how we can also approach for other global variables.
> Through multiple iterations, this approach will be refined based on feedback,
> edge cases, and community input.
>

So the approach you suggest is to comb through the global variables and
config and find new locations for them to be stored. While this is
definitely a bunch chunk of the problem, shouldn't we also talk about
how we can reduce usage of some of these variables?

In particular, I'm wondering how you'd want to tackle 'the_repository'
usage. There is some previous work done here, where Patrick added the
'#define USE_THE_REPOSITORY_VARIABLE' definition which tracks usage of
global variable and usage of them in different files.

A possible approach which has been followed is to simply go from the
bottom layers of the code upwards, cleaning up usage of global variables
and ensuring we can remove '#define USE_THE_REPOSITORY_VARIABLE' from
files. This is also the approach taken in some of the patches that
you've linked.

[snip]

--0000000000007ea8060631f4f11d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d3dc5838d65e268d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdjhKNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3FuREFDQ3pBd0lxWWNLaC8vVi82YjdmazNKSjJMWgpYTGJxVnZTaFAv
L25SRXZWY3FoeHNWMTlIZUxGbjlGQ0VGVWZYTHc4cEg4K2lPbXBmclVBRVhrSG81b0YwZlhOClEv
cEgzQlBZaGtUcTM1YnkxZmJTZHlhOG16SjNjYjB6Y2NYbU9EVDBmOTRjRHZxZjNqbmZDSEIzV1Ny
ZXhRM2MKUXRXTWUxUnFjR3F2eVU4N1plVlgwalI0U25NR0RiN2hBYXFKaGRzWGNLa1VqMFl5djBJ
MWVqd2twVGh6VWdqaApldFA3RkZoM2hYMHRBWmV2bDJUdjRPQUpEcTNWUXRmcWMvWTFpcGlxRk83
b0srWkh4TXFQT0NEOWx1YUorR0t4CkYzWDR2aExTUWVkei9zTG43L1Q3V2QxU2pmNU1EaWpzaDNy
SjcwRG5kRTJTQjNZTWJqRUpEZkdyUEpTL3I5TWoKWldiUEFkUWVNaEthTVVJT3hUR0xOZkhZZzZr
UTkyaXB6bU02Zkhyd1lBRTdGclZOaEd6b3VLWTFNS0ExNlV3NApUa0IrRmdhejgvTHd2aFdWbmI2
K0k3eHNQeFQ2VmFQVnRtOXJHRjBraksrVi9reVNJWWQ2RUZqS1JyZm0xRitwCk9YS1Rib2VqMmV0
bkljTjVEK1AwVXdBaDd5dWFEQjlXdzBsTGpYZz0KPTNJUG0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007ea8060631f4f11d--
