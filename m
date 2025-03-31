Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1931DDC07
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743413844; cv=none; b=VCnT2HVN3rt6tdbJgQc+vcc+eG0k5E8wlUhHMZcpAFtd/TYyk7YhKB2vp7HnVtxstn9ADQ7QT/n25X28RWAJtu5xyW/D2PjoXh1K5vmItXt+RojEAVCKrfgV8uxPBemJyn9xoRTLjEO0hhfi82coF2W2ESS25pW9AfBUF2WDDAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743413844; c=relaxed/simple;
	bh=uKhhOOr6E8t+U9VAwPdX07ucGfykJ7fchgBr44LVqQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SY2yW6oD5gANEaC419pkKMPjAUUdgt/d1mI2CvImmsnlfKdrMYCfADpzGHCV4Z+YyJEo82AMhiF70Q6d7IyU4gaRAjP3TyMlXpGCOlPrYJOnYXIyaSd7KV7v0Thl7o5WQZMA4QP9Rkh8wSMTj2E8fCeCQ7BfeqEc/a1xzw6U7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8dQzm/5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8dQzm/5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3145150f8f.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 02:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743413841; x=1744018641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DoPJiYKrS9iQ2pGljPVto8zD20cb9Vdtduu+MC6vE18=;
        b=c8dQzm/5yFbeB+8vCL7KRs8wNQhnacNatmM/cVIvNfDXFjK3fEAIZE5Jb+l+W1ZN/7
         YviCLI3M99XAKGGQldi/LmYBEbWi/r370rLTH4NYxwHxadIBZA4BGlLI1SlhGG2asRqR
         t6jzMz+M3LcCBgRGs0t26wa+w799ptccU38yf2Z6pJRMgzdNEydsyAAgjeDhKy2E//Rb
         0ko5WK81jP+alggEgfbA/Q3xXdVZ0vzemnbrIGcwyJiDkHZ52a5+2HmteRi1g1Fvtsy1
         CX+uw4286rSzTat5T1eLRTePDnJoohSnvbu+erkgv10y+808lQHgtHteaBI/QSoR8XrL
         W6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743413841; x=1744018641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DoPJiYKrS9iQ2pGljPVto8zD20cb9Vdtduu+MC6vE18=;
        b=PGKWNs5b035kB42g0csrT//NF8oWgCoRjXX3lGXoi+yVzn/jIZxFxYy6GIon7myp6I
         qiFP5Mu7+viUjPXemqLNgWlVg7oSVWfcLDjgOoPFredJX9uut8wgsl59EwheQcwYjld2
         JsCjqmxdktOMyH+Cf6hLXq7jYBQIYUhM+TBMsWt9NAwPN8pSH2BnPwsBFyi++iy6LBox
         WYSB65MTK6HVK27A/EHRxyEpWPyL1644EC3L+Q6KzZZAEYTl+jGQBbcIWkpDvy1A3m5i
         3UwNuzi5DiWoGYIHZuYuvX1W2Ej9Aqcjnl96rHePrKM6CNXCahDEVUkPCQhJ7ZiuoFal
         7RXw==
X-Gm-Message-State: AOJu0YxpBPfNEp9xhiAeS4TtkkJc7lEc95VuDDLbW5+Htu40olqxIyAP
	G06ZxBNcA4Rehvrhp/xZESux4KHKFqQOAe9O4ktuf6EO9d1+vlLE
X-Gm-Gg: ASbGncszoU1cWqnnR/dut2zKl8aZgy4EXH7GDDCWcR2NXWYsYubzYMyKQ8S/ABFU6it
	jd42EJJvU4mnoaMd4CLmCZe+1LPUU+YQg4dONZbMNeGr63ttBGqkkSe2/rNr12uIahw6e+25eJW
	BkAxzpp7VctxgAJK8Y6S4YsLt17VTiZbKQ5QyFH3N9XyGjHOOfQW3s4dWtboCtvTQbvBswia+8C
	LY5OlqTyn6l0J1ySuZFPpznJ3x2i8f7Qf2W4u6IhlKu2zwYAZpA3YVPdGzqmdrAhTC9l+WVJKdT
	30zHqZmLFWN9Kqd01GPAs9rsZz9iFn6d5gI1OCjuhMa4FOPVE29u3wO1e/FRfIYhMOzsHqqEGko
	=
X-Google-Smtp-Source: AGHT+IF4moZ2rO0wILoQUm81ry+i2nzKz7is5QAqLTXbFK+FbjGQ75hLttc4g2j3eD6ltoHDySN72A==
X-Received: by 2002:a05:6000:4014:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-39c12114f62mr5637337f8f.42.1743413840615;
        Mon, 31 Mar 2025 02:37:20 -0700 (PDT)
Received: from localhost (78-131-14-102.pool.digikabel.hu. [78.131.14.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6589efsm11012061f8f.16.2025.03.31.02.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 02:37:20 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:37:18 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 1/5] doc: git-diff: apply new documentation guidelines
Message-ID: <Z+piTsfJdx4BG2oI@szeder.dev>
References: <pull.1769.v3.git.1731785768.gitgitgadget@gmail.com>
 <pull.1769.v4.git.1731967553.gitgitgadget@gmail.com>
 <fd3ee137fe4f22eb864f1f972c216b7a7f05d0f9.1731967553.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd3ee137fe4f22eb864f1f972c216b7a7f05d0f9.1731967553.git.gitgitgadget@gmail.com>

On Mon, Nov 18, 2024 at 10:05:49PM +0000, Jean-Noël Avila via GitGitGadget wrote:
> From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
> 
> The documentation for git-diff has been updated to follow the new
> documentation guidelines. The following changes have been applied to
> the series of patches:
> 
> - switching the synopsis to a synopsis block which will automatically
>   format placeholders in italics and keywords in monospace
> - use _<placeholder>_ instead of <placeholder> in the description
> - use `backticks for keywords and more complex option
> descriptions`. The new rendering engine will apply synopsis rules to
> these spans.
> - prevent git-diff from self-referencing itself via gitlink macro when
> the generated link would point to the same page.
> 
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/git-diff.txt | 122 ++++++++++++++++++++-----------------
>  1 file changed, 66 insertions(+), 56 deletions(-)
> 
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index c065f023eca..e19f31e8b9d 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -8,13 +8,13 @@ git-diff - Show changes between commits, commit and working tree, etc
>  
>  SYNOPSIS
>  --------
> -[verse]
> -'git diff' [<options>] [<commit>] [--] [<path>...]
> -'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
> -'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
> -'git diff' [<options>] <commit>...<commit> [--] [<path>...]
> -'git diff' [<options>] <blob> <blob>
> -'git diff' [<options>] --no-index [--] <path> <path>
> +[synopsis]
> +git diff [<options>] [<commit>] [--] [<path>...]
> +git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
> +git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
> +git diff [<options>] <commit>...<commit> [--] [<path>...]
> +git diff [<options>] <blob> <blob>
> +git diff [<options>] --no-index [--] <path> <path>

Since this patch the synopsis in the man page looks like this when the
documentation is built with Asciidoctor:

    SYNOPSIS
           git diff [<options>] [<commit>] [--] [<path>...]
           git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
           git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
           git diff [<options>] <commit>`...__<commit>__ [{empty}--{empty}]{empty} [__<path>__...]{empty}
           {empty}`git diff [<options>] <blob> <blob>
           git diff [<options>] --no-index [--] <path> <path>

I'm not sure what those '{empty}' strings are supposed to be, but they
shouldn't be there.

A similar issue is caused by 0b080a70ab (doc: git-diff: apply format
changes to diff-generate-patch, 2024-11-18) later in this series,
affecting all man pages that include 'diff-generate-patch.adoc':

        2. It is followed by one or more extended header lines (this example shows a merge with two parents):

               index <hash>,<hash>`..__<hash>__
               {empty}`mode <mode>,<mode>``..``<mode>
               new file mode <mode>
               deleted file mode <mode>,<mode>

I use the distro packaged version of Asciidoctor:

  $ asciidoctor --version
  Asciidoctor 2.0.16 [https://asciidoctor.org]
  Runtime Environment (ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]) (lc:UTF-8 fs:UTF-8 in:UTF-8 ex:UTF-8)

When the documentation is built with AsciiDoc (10.1.2) these all look
fine.

