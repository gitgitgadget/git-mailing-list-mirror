Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133B1FF1C7
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552619; cv=none; b=AC0ioaUFGfoyyX20FmZPx50fcsgEJ0ftnTNBlIZRJA9rFX/XtYv2bmt5UB2M7Hc91+5rxaSTokpdmTntCehXeyzn4ociEfDi2i/r2MjLbd9wu9LobHH3iOiPSHTa3c2VyHbR+z9C2TqcXDFDI8bAGiRU5hpBQilG2Xn3Gc8SCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552619; c=relaxed/simple;
	bh=hej3CDnHUXNvIB49f/L6NCIZVS2hiXtXkxe8Sy2ZE6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiXxWnPx0aSiLEzT/DOlqSXSitSBeg4ufFe5ycSOwIxKzqADDj1x9tjz2jp6MWDr8T7C4qG6s8czYU5pg5QvRgCKeErCN2Ec1mLdhv6D5kNFYloJZZMCWUUlWZ146qL7GYB9CNT2gHV9+kVRvkPb5SCJFNDBOr88ebF3VpCItl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWUwhFV1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWUwhFV1"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22c336fcdaaso75140255ad.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746552617; x=1747157417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1DiO85VYUoAtmww/lpsyJJHbmvKnpsUQe7Uy2CUjqU=;
        b=SWUwhFV1ih54XAUl9ugzR5jhvrS2qZjAHUZ9ORtpNfYqT7e7uRO4CIDy6nEJWf3WPS
         4TsrmduA6QAcUNnfnSwJnz4kWdn6D4DF/dNS5Di/7m3fGb0ATr72/9BV8JXv1X0vqGb8
         zQmUVpkA9nHrpZuTQqdSgtN1EVa+FRDp6B483WcbzTTXZO5RwV6c7fyPNpVMNjBvvpwp
         wA4z24ixlwf+mPNYtj1PRfWGfgaMYf4g3CmKE/bCNmBvX9x8eiYtiSEo/J0HnV0d3JbU
         FKrXFWgk6q/dkEFArbaSdRh0fmOBCFakAaqCF5/GCz6n70GlF2IX5bXpg2E4BKm0zDKs
         W1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746552617; x=1747157417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1DiO85VYUoAtmww/lpsyJJHbmvKnpsUQe7Uy2CUjqU=;
        b=M8hgpi8OtWQ3ro4JnNNYfi5YnU5u8Mv1c8y96V4z9GCjkGpw7L/WwFDYPyY+NyqLcG
         nTnUc1a/c4SeGuHbRb4iesFNMNnXpCvgNQzNGHNM+r5madQPlZeU5iZUfr0g3TUgxsZ2
         N2oaGvVI+YhPJ7ZbEKQaTVENB2qtplsfWDwOIpUOouPXRVpNbO9WdDjxLTJ/vh6xznzm
         8B42e7ph8W+ZQMYpyaQOCzv9ObK2lkKNeUMsvNfU0ovbl2WeblcOy+ykfqkGbSKZiXJn
         lWoTB2NzL5WwkxGusM6V8adojyK4o7vAuaIMJ3Itctwi5rIYieMJBAxo5GEGls3a41bQ
         Ptvw==
X-Gm-Message-State: AOJu0YxFS4mf+ROQNRpshnY7lU/Xky3MpdstfoZW8FO6i7f376WesTiQ
	s0YoNfv9t38wEgLnq5JKnlH+rNH9xta3+cqCS+VhyBrY++Q8HLy/6EeWQQ==
X-Gm-Gg: ASbGncuRKE1VJiSLYgmXj/29pUOtdYhpYZOP1Ji85YyqZGwuWkduxmzEJpizz/uXvwZ
	ngDnBcZrGOtGORzlJA4VW5qqcQi/0Zqr1moEmnxKYRIRRH4XpHXd7e05bVKTzSr8Cf56xQwEi5g
	edP+nWxepffHDeX0mwRMgxU0bYeMHI6yKzSg4/fnc4iZBFJzbuzgqIIiKBxoLbnzPWZl5LibWYH
	YDfEhSzvDTkj7lY3TFiodJi1DCR+1PM6Kv/BRG+AOjxb4Mb9ves2pRFeyITpdm+pJnpo+A3QIpa
	cEZWJ0HOGOw56TChNXGZC3zDG6YYcHkVnJHBzWkcdZUKuJt8rS/klIuOHADhqy7PDpo=
X-Google-Smtp-Source: AGHT+IGroPtcchnLSpEJR2285ihS3vPSHWG8jlm71oNfUyrd4hO+cK05GQNoRTvKDnJiXO7AoT1yOA==
X-Received: by 2002:a17:902:e78d:b0:223:635d:3e2a with SMTP id d9443c01a7336-22e5ea72f29mr1245795ad.23.1746552617008;
        Tue, 06 May 2025 10:30:17 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e194aa391sm65067095ad.154.2025.05.06.10.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 10:30:16 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: mlell08@gmail.com
Cc: git@vger.kernel.org
Subject: Re "Bug Report: git submodule overwrites submodules of same name but different path"
Date: Tue,  6 May 2025 23:00:11 +0530
Message-ID: <20250506173012.92414-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <5b8e60ba-b05b-4389-8c06-88c143ceee10@gmail.com>
References: <5b8e60ba-b05b-4389-8c06-88c143ceee10@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> Dear list,  
>  

Hey Moritz,
Thanks for the report

> I have encountered a problem with `git submodule add` that leads to info  
> of a submodule being lost if another submodule of the same name is  
> added. This can happen if a submodule has existed on the path in an  
> earlier commit but has been moved (`git mv` edits `path=` in `.gitmodules` but  
> not the submodule name, probably to avoid moving the corresponding  
> folder in `.git/modules`)  
>  
> Find below the summary from "git bugreport" (Answers in English).  
>  
> Best wishes,  
> Moritz  
>  
>  
> # What did you do to reproduce the error  
>  
>
> git init parent  
> cd parent  
> git commit --allow-empty -m "initial commit"  
> git init child  
> git -C child commit --allow-empty -m "initial commit"  
> git submodule add https://example.com/child.git child  
> git commit -m "Add submodule child"  
>  
> git mv child child_old  
> git commit -m "Move child to child_old"  
>  
> git init child  
> git -C child commit --allow-empty -m "initial commit"  
> git submodule add https://example.com/child2.git child  
> git commit -m "Add a new submodule at child/"  
>  
> cat .gitmodules  
> 
>  

I could reproduce the behaviour, neat observation!!

> # What did you expect to happen  
>  
> I expect that both submodules have entries in the `.gitmodules` file.  
> Git submodule names are given by the path, so I expected some way  
> of resolving ambiguity, for example, Git appends ".path" in other  
> cases to disambiguate. So the expected `.gitmodules` content would  
> be:  
>  
> 
> [submodule "child"]  
>     path = child_old  
>     url = https://example.com/child.git  
> [submodule "child.path"]  
>     path = child  
>     url = https://example.com/child2.git  
> 
>  
> # What happened instead  
>  
> I see that there is only one entry in `.gitmodules` listing the  
> new submodule, under the name "child":  
>  
>  
> [submodule "child"]  
>     path = child  
>     url = https://example.com/child2.git  
> 
>  
> # How is this different from the expected result  
>  
> The old submodule (path = `child_old`) is not listed. The information  
> about the origin of the old subrepo is lost.  
>  
>  

I think the main issue is as follows 
in the module_add() function, 
add_data.sm_name defaults to the basename of the path you’re
adding, it re‑uses the already‑existing name “child” even though the
previous entry now points at child_old/.

Nothing in module_add() checks whether that name is already taken for a
different path, so the new write silently overwrites the old one.


The original code is something like this 

if (!add_data.sm_name)
	add_data.sm_name = add_data.sm_path;

if (check_submodule_name(add_data.sm_name))
	die(_("'%s' is not a valid submodule name"), add_data.sm_name);


Something like this in between works for me

const struct submodule *existing =
			submodule_from_name(the_repository,
					null_oid(the_hash_algo),
					add_data.sm_name);
	
			if (existing && strcmp(existing->path, add_data.sm_path)) {
				if (!force) {
					die(_("submodule name '%s' already used for path '%s' "
					      "(use --name to choose another or --force to overwrite)"),
					    add_data.sm_name, existing->path);
				}
				/* auto-disambiguate: append ".<basename>" */
				add_data.sm_name = xstrfmt("%s.%s",
							   add_data.sm_name,
							   basename(add_data.sm_path));
                        }


This is just a vague format. Just to compiler and check.

With this the behaviour now throws a fatal error and not change the 
existing submodules.

Something like this:
fatal: submodule name 'child' already used for path 'child_old' (use --name to choose another or --force to overwrite)
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        child/

nothing added to commit but untracked files present (use "git add" to track)

If this is good 
I can send a patch covering the patch with this specific fix and the test file
I don't think this needs a new test file, I will add in any existing one.

If anyone has a better idea I'm open to it too.

Thank You,

-Jayatheerth
