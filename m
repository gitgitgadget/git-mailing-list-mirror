Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7A2727F0
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754903590; cv=none; b=FS6oTgeQLPrp8ZiBJ7CHnarVPrlKK1qwoAHWJNIDfwTAIbGmQR0r1MQOmBPa1hLleDz45AcB28R3pAwFKPiK4BhmhuxO2PrgFqTCMRGFv0+Lou3c84suNX02+MaU0dikAkQOCGg55TdwPHXd8Hy2aMX+TVGKd6O0vAfXdcIkcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754903590; c=relaxed/simple;
	bh=TPjRtkfwd5UWszceJzfCHvMlX621xfG2rZ/H6OAxtyc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evnJRPtOJYUfZjdRE4Y1BLTOn70YhcLnazPuz6XL8GuS+3Kd+00R2bO276mVQ8MWenSFe4O8fyKEZjDZYCQfxyykPrqPp9i/lYEhHYzPLPKofWfa7+Zcd2cOwXcTIAAXRqMXGg5tNOhTQHHLyTa7lrjbXL9k7LsnU2HaIGkzYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW2P0m8s; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW2P0m8s"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5393776550aso3479395e0c.2
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 02:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754903588; x=1755508388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9K7x8QMlUJvyBu8dnugQGS3uRqTRoDlKWJaBcBZl/E0=;
        b=dW2P0m8s9sn9EAl+Z3gNpfvApKV991Rv93lCMxO9BaD0hCLSiX2xOJqUt8z5xQezBj
         UA0zaaSLqz3oplF0PC+ROQPlYX1BPqIQ6pleEhqCH4RG/lvKBNjFYjcvjJJw7hclbp6l
         ROzeU4nSaD3zMk0QFJ6UvfrUBmJdnd4o8seKVp4etaaPNkHJe+U+BXMkscjvAB6DYi+X
         CYLwF/tRhHw/ayXI40xSgrS37IN3aGRjwO1Brcn8/VXUxbx/j9d2i6VLjOqtxRtkiXBV
         +sX1itHwFzq0lcnOSkzttMAO71R++jCysXW+Ntpo04c4C4vL+9RBf0DXncN13QIECuHX
         3d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754903588; x=1755508388;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9K7x8QMlUJvyBu8dnugQGS3uRqTRoDlKWJaBcBZl/E0=;
        b=cXVxeSJep5l6X7OmcCmiBYO4VDrzCMA2LhhpED6OokltBRFLXk8vRCRqxAWPeOxvEM
         ELOSKPYDS41+1s+UsxPsqLAeG1DzreAWXCztl3fhzk5tjJc0F/MnCFwLy2/WeBMdJy96
         vFqwsbg/zYd3UpPA6Qhf1P7Yp0DGi60h9x5/d8PyYjrGUT+T69CsF3ZD16Plk3rVVdj7
         fT3KUyE5ZbQSJ0j2JV6R8B39I8bb4hEZzLXniXihTftycTsp3t3r+cfZD9JdXW/8xxC/
         4VJACqfHT1BDJa/OeJ+ulAwD6ae8UTJyJOY+pHHrqQbSet+Id46diaaJI4yA0pKl5ZA8
         tjBw==
X-Forwarded-Encrypted: i=1; AJvYcCXEpgobobgfWlR9Ygovto2ssw18+Cm9RboyzYKJPFkSWX2GBkJ291TzWRveGD9O+TtE8/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVuyvg8TqqvPLLFjQ74f85it+GkNMJGleG9RG6hA7qetNFb+K
	kryZxoGjq67NDuuUGPmWeSKo9hhS9oBMi0+8zuavWosujcgn0n8HTKjbu8ySReZvTwcyKACvR8S
	982rqZHFVj/diJFzGETkWhkm1j8nvQck=
X-Gm-Gg: ASbGnct1F8vPN5Kdsy23vrp9A3VxiXPMQNCV0cHpx+7+BQRlrebxQml0ff5ck3nsztL
	bHYGsPJ37WjxQ6yPwFWcmDHToGV+fajKdTGJDBMVhIS9ooVk3mRPZKEHtvZW6VgJW6bbGWWZZZm
	LCqXU8ff14sr/nzku1gdho0Y2LRPPNpGIu7nCUL71azB6rVcdT1QZtJnQHxy7jBhInLEtUsia+y
	6HPMg==
X-Google-Smtp-Source: AGHT+IGOC38ejr9DR5LSGL5tO8ShP8KIo0xjBZxdn+8fUq6u1ykVfE8AkNkvvFzM9lEciWo48/Ni81ia26C+HPPk27w=
X-Received: by 2002:a05:6122:512:b0:537:3e5b:9f66 with SMTP id
 71dfb90a1353d-53a54510e67mr4089224e0c.12.1754903587939; Mon, 11 Aug 2025
 02:13:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 02:13:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 Aug 2025 02:13:07 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
References: <pull.1949.v3.git.1754693552.gitgitgadget@gmail.com>
 <pull.1949.v4.git.1754702057.gitgitgadget@gmail.com> <07a4bdb7ce5eb456bd81972c350d0c4f298ebd46.1754702057.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Aug 2025 02:13:07 -0700
X-Gm-Features: Ac12FXxVZwS_nS_JKFpBasw9nLeBdbQvPP51OTxeUj8q3eiKfu-qGXhygUrUzZw
Message-ID: <CAOLa=ZSTaAaWJWeXBkoxPx46g_Equo-sHWgCESE9G6vk3HZeqA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] doc: git-rebase: start with an example
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Julia Evans <julia@jvns.ca>
Content-Type: multipart/mixed; boundary="000000000000f9854f063c135441"

--000000000000f9854f063c135441
Content-Type: text/plain; charset="UTF-8"

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Start with an example that mirrors the example in the `git-merge` man
> page, to make it easier for folks to understand the difference between a
> rebase and a merge.
>

Happy to see these changes.

> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-rebase.adoc | 49 ++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
> index 956d3048f5a6..449f01fba560 100644
> --- a/Documentation/git-rebase.adoc
> +++ b/Documentation/git-rebase.adoc
> @@ -16,6 +16,29 @@ SYNOPSIS
>
>  DESCRIPTION
>  -----------
> +Transplant a series of commits onto a different starting point.
> +
> +For example, imagine that you have been working on the `topic` branch in this
> +history, and you want to "catch up" to the work done on the `master` branch.
> +
> +------------
> +          A---B---C topic
> +         /
> +    D---E---F---G master
> +------------
> +
> +You want to transplant the commits you made on `topic` since it diverged from
> +`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
> +by running `git rebase master` while the `topic` branch is checked out.  If you
> +want to rebase `topic` while on another branch, `git rebase master topic` is a
> +shortcut for `git checkout topic && git rebase master`.
> +

Nit: now that `git-switch(1)` is no longer experimental, we should start
recommending it over `git-checkout(1)` as necessary. So perhaps, we
could s/checkout/switch here?

[snip]

--000000000000f9854f063c135441
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f40ad03c4812424e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pWnRDRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0ZiQy85dXJDRjdlaDlFRnQyMHZzK0tZSk9XNDE4QgppRXQ4SUl1bEN5
VEhEa0VmNlg1WCtHV3Nad1VlY2cyVzVWVG14cU8zM3RPUTc5czJrVVh6c1NLd2RLYlB4c0hwCmxS
SHdRWnh5S002QTRWTk9jK05MdTJBMlhHNmpjeG1Ya1dOUFJ3STcwTm1qQWkwWEFQaG4vOFNTL1FG
S2ovV00KWEhxcitIN1JueFkrUjQ3bkswRDhIRHFtaDdnaUNVMTg1QzVhNXVJWU4vYnVocGMyanlm
ZHRWZkZBc29xY3UwYgpQREtHR2IrSzdmY2JnYXRmRmNRUFpmVTRTcmdVWEdubGl6bFg0a0tFOFdl
L3M0Y2NRbHA3Y1ZEMFZ3SHV6L1VCClJ3cFh3cUNtd0oxTnRuODhhQlFWMFRiaXdwWlhqVlZ3bXFJ
QUZNa0VoSUpSYmx3MDJOYytzeXlkVnp4OW83ck0KZGNNTFFTN1pGUit4elJQaWJRYTBhekRVNHVF
c3htMEo2S3BsLzVoYW5LdVVZV0tvMXBmdHJ2UjBFSjl4cjJSMwpWbUxnbmQ3UDhwZmtQMXplQ1Zl
SDRVQTA4UDlVdS9aYks4WHNXV0NiVS85YlVtYWs3MVpRTEtuUmlSTVhKUTlRCjlaYTlYNmxiSWVW
SVlXNmtQTEJPUEpQRVc4WEE2TGFtM21LMEdKMD0KPWhEM24KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f9854f063c135441--
