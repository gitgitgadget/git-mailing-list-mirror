Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B4D2DE6EE
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179204; cv=none; b=aZoQGcysL3zJ/fKRFMNaJE03Klw3mbsyd9wVuN+d0XTUJxRAx7bTel5f39jt91dZp1HGfKlpr1UtafSi9Zo6sQ7x7MItDgvFIDY9py5+pReFptFT5VpcZxsq580lQY/9fM8wHyaFH+XzfkyPrHrNV7Acrj+LMX6H4ZxmtzZU6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179204; c=relaxed/simple;
	bh=lSrfdYcxazOglGnpfjlmq7O1giMVfctkLe3HKYjq57A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKfT+ZY6dDMLbG16whhxcnSmOE6oKHfbPrO/atTlIEF9xoRtezs5IVHVVvCj6D3R4f2TjHVzY5jkTOmOiSOo2e1UaKLfT9Bhc9UZRiNwI1z+k7Gil7W0euxgA+Ml1FlJUUNKFlERqoBez7RVGvdRNJJCzSitdxefiYBmcXWPU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K68xianb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K68xianb"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-837d73dddc6so8679185a.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 00:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758179201; x=1758784001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjclFkDT/DcIDCtie2AR036wvnhqsqcoRAOzidaFKn8=;
        b=K68xianbZxHSL+8o7oq7C1JYCjR6kCXuM9TOz2EOBJFboTL1mI40/Re0eH6ikHH9WO
         +XIaDBwR+dOiy5XitYqLqBOea7kz9Us44HRa0ASjbL2yaSuj35rFd/L0ml2RDwBNKN3Z
         OtsKNbY+9BuAnor9UAUxhgd/yz5gku/mIp1IHEN88sQ+fOMlNqIB+IiwRzbJG59Rlzg+
         XUnQkqZdqXQTdgcrrD6rbxMF9tOXZHOwELhPZaE8shBASQ9CSp21mOPz6i/JJ6drlHtm
         Yc8PpU2pmbdlHV/0SfCJjh4Nk+VDNyrthUPQ0ExZnYe0q1WkNdlzQNk4h0HOwePGdR1O
         bi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758179201; x=1758784001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjclFkDT/DcIDCtie2AR036wvnhqsqcoRAOzidaFKn8=;
        b=gOtfMHsfQ4AXDLhx+dG5iP5MZmWnCo68138x0gvTFHAqhZWodrf/kuTARVj+jBwfK1
         x4hOqzpqe+CRqJBPo9xJQPVJNA9/ZP+M9Fl6MxXXeoEzgoN5csSZEOEcsCWdGwd5hUUj
         ekGgpVgD/FaFsN0i1NxmWpB0BYyVdOlt1mRW3d1G1gE6GC8SlgydEsIsJ3Uq8GfD7uDS
         krGwo2Py88Kjv+2wulnycCOUjpnB1xOiEfohSmIZR0lV8qpN1CaH3R6OKweqOtINdSR8
         kjcPIjAR3ZHAjM9+LfF9AluPIf41aXw3/6x1P1UAlBGFOSSIOCP46B8QYI7eX//TFW8c
         Fbtg==
X-Forwarded-Encrypted: i=1; AJvYcCXXQYCJmQu3MA/FzgrPgdk/FFITslWvyQHX/uIcrBnr+cck9wy/8oJvLholrbEntXWF6d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoY3MWocQeQNRSFw8/srwoNwlZ+pJpa+UQUzok2OOeOi0T7zuG
	Z8OTC4bV1rz5xVp8mKl8TNmKuO5ikI5Vkrusylfu/Cz6vUTGVzg+0TiOD4dyf3sf1XYizIr5TLk
	nZtHUfi4k5II/AYaqPBcVEPvPHWb8VPr8++w0
X-Gm-Gg: ASbGncu/uP04nLZjFk/wWdGqZyCHf2672Ht2ZNDVTvvKGR/KFXYAM/KlnggBok9i0s7
	copIhJXlmzHrrxWmzkdgBLVGD41YTKq3xdywKG1Tzr964ek9gnvpvXkICDaakB4VzHHs7IbBFEp
	2GuS2bydtazGlkJrWmJ41lpB2wejdB/GOQ6i7MYGuegNqfVtxQiRug0aNg8q78i7gkM7BZMr1v/
	uCTS82rGv5ftOwDOfmgQv4c87pPnJH6aVIqGqIzIYQSQIELmSpISXpOU5w=
X-Google-Smtp-Source: AGHT+IFVS08DBPTcoTK1NMj9zgBDbTx96D0klGcdRmmsTV9/QFMieueNeAMR/dLkG3nVTfvDQ1AntZD2zqEe6e58oys=
X-Received: by 2002:a05:622a:34e:b0:4b2:b591:4602 with SMTP id
 d75a77b69052e-4ba6a201826mr40384851cf.9.1758179201131; Thu, 18 Sep 2025
 00:06:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com> <xmqqh5x1f7tz.fsf@gitster.g>
In-Reply-To: <xmqqh5x1f7tz.fsf@gitster.g>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Thu, 18 Sep 2025 03:06:30 -0400
X-Gm-Features: AS18NWB33IMoGsBUAZPtbJm8_v5f9pF0a947z72r2kuB48s4MGHGajTKJp9SxlY
Message-ID: <CAPig+cTHtxwr6TRJOmLj9ktaaRdQFLXDewfQU0zxZ0m8ADmMnA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 10:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +.idea/
> >
> > Is ".idea" directory detritus from your chosen editor? If so, it
> > probably ought not be added to this list since we don't otherwise
> > ignore detritus from foreign tools such as that.
>
> I knew that the above was our official stance but somehow thought
> that we loosened at some point to add common ones like *~ and
> *.sw[op] to make life simpler for majority of developers.  But I was
> wrong.  We do not even have *~, which means we haven't officially
> loosened.
>
> But there are oddballs that violate this policy like ".cache"
> introduced by a5c01603 (gitignore: ignore clangd .cache directory,
> 2023-08-04).  Three are many other that are *not* our droppings,
> between /.vscode/ to /contrib/buildsystems/out in .gitignore file.
>
>     /.vscode/
>     /tags
>     /TAGS
>     /cscope*
>     /compile_commands.json
>     /.cache/
>     *.hcc
>     *.obj
>     *.lib
>     *.sln
>     *.sp
>     *.suo
>     *.ncb
>     *.vcproj
>     *.user
>     *.idb
>     *.pdb
>     *.ilk
>     *.iobj
>     *.ipdb
>     *.dll
>     .vs/
>     Debug/
>     Release/
>     /UpgradeLog*.htm
>     /git.VC.VC.opendb
>     /git.VC.db
>     *.dSYM
>
> Some (like TAGS and *.hcc) are our droppings (in other words, what
> "make" with some build targets may produce), but most of these are
> tool specific and according to our original official stance, they
> should never have been added, but there they are.

It's been a while since I had to build code with Visual Studio (the
proprietary Microsoft product, not the open-source VScode), but if I
recall correctly, all the entries from ".obj" through "Release/" are
build detritus from compiling with that tool. Assuming we still
support building Git with Visual Studio (which I believe is the case),
then those entries all fall within the same categorization as "our
droppings" similar to the `make` case, so having these in ".gitignore"
is probably in line with the project's official stance.

Others, such as "/.vscode/", on the other hand, fall into the other
category of "someone's favorite editor or handy tool", which has thus
far been frowned upon.

> I actually do not mind having common ones to the project .gitignore
> as long as it does not get bloated too much with droppings from
> esoteric tools that majority of us have never heard of.  It seems
> that we have been punishing needlessly Emacs and vim users while
> being sloppy about others' droppings.  A #leftoverbit may be to
> have a brief discussion to gain consensus and add a few common ones
> and/or remove too esoteric ones?  I dunno.

I don't have a strong opinion aside from avoiding bloat; I've seen
(and inherited at $DAYJOBS) far too many projects which grab some
overly bloated .gitignore template from somewhere in which most of the
entries are meaningless for the project at hand, yet which is used
as-is rather than pruning out the unneeded entries (typically >95% of
them). As with dead code, those unneeded .gitignore entries tend to be
a source of potential confusion, which is rarely or never the case
with a well-curated .gitignore (or with well-curated code).

That said, I also probably do not mind having the common ones in Git's
.gitignore. A few which come to mind include:

* editor-specific droppings (Emacs, vi / vim, VScode)
* .DS_Store files which macOS's Finder drops into *every* directory it
visits, thus which litter the filesystem
