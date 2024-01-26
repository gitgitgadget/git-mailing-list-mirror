Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082A0250FE
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 22:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307243; cv=none; b=i2d25xT6iWYziEFtihFdckNJQV6kPJFSHILMMYb1NYktbDMnf7KE7lB+NoBOGNe0BqfTxX/v3RZJ4LlnkXchF6a7bB80SnbAW2fy4gJRe7i2NoLj35xTDxvuS/hM21oyKdXjS5U9MUE//l3izoubza9aQDi0QJ14zNxrwImqtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307243; c=relaxed/simple;
	bh=zaA4keLvPxPRrUvgAJud+jPF8BUKPuiVvC+S3nx/mfI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=GKWmwLXBwxay3s7MsdO19iB0fWjWSH1ruRrb5NgoQgYBIAWnucMWStjI5G+ZIPIN5iUUUaRNbKGX5v+crzQhuwdLfuVxOGy8cY/Ztj5oKXqD/2J3pO8KZfSJhyqAPUiZWievOE4vViOopqv3WTnsJo8n0LaFr4//k0oTCwfQRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rX3TmZC+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rX3TmZC+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1573640276.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706307241; x=1706912041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FeSho6IbvSjDFCIYrnKmtP4l2rxBs72BGw8UsLq1Uww=;
        b=rX3TmZC+Q9iqr7zW7M9kF99aSGsgINpzZ2xu62y7qHm1wAeYN/Ondxp0XBj1oahY3L
         KVi2VpUfZHSk5uXO2Lx60NLmxSIm0B4hUZSev2W0NVjtixsY+Kpedkw9FHAkcYepNhSl
         YeyiinIhGp1C6hdlFfkOq6ZR4DLm1w8+Xm63gh3e/9l69hcu1zTfPz8/AioRV93F/HJ5
         DLzKja7uSqFqSpvFhEl52l/tmap/Id7q/AWIw6Xli7DQWx6vzPEQ/oBKV+pcxvbMwGnh
         vcYomKkdHy6zJ0op0Aq6YlpqHYZjf5PxAtb8LsVKQZNGffax2m12BaPpSQXxYnnwBywU
         afAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307241; x=1706912041;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FeSho6IbvSjDFCIYrnKmtP4l2rxBs72BGw8UsLq1Uww=;
        b=mn8q3oR/OyOMEdmeuHwcoKtqQSHy22imkvAeVe4LyJua5XzcoemhTDNga20FVGMHYN
         Ae2qxEwBzSXI/hOV7HLsE+NZ2Q0xKp0Mr1wHzhdpJk/Rp325u0muyJHxFLJXo3sdAv00
         cs8OzRk4bsYhWVIOY8Gs79Fd+BlBPfTXXnGj+1FWeADKJcCPDzEuj1hnMevstljffL4k
         k+w6WdEYIbKtY7XRXPRJAIS1M0rjN+4Gkcx5gjZKuANUD2D0wWFFawxZnpIQ7xIfhMYu
         PfbzP3EXxpYWnbkQfaNnUjUcGSDEwKufo5IAjQhZdff8reF/rVq4CC8Y/aqxe/3VIdVw
         D/YQ==
X-Gm-Message-State: AOJu0Ywac7pMZWCTTaSvOjH+WFtxmd1bttayuHrV/wavogwD+XHcCZwW
	B1CLAp6KICl1jt/mvx3Dnm+H2Erw80t9S8FjQ+rlzu8snAv0LiaGUq0V+YkFZj0ZO+b7ZDeKS9M
	/DKK0DL74pQSTmobOBvZRefrS4trkxg==
X-Google-Smtp-Source: AGHT+IFoG+gYkGXuDmFweguwX4mI+lI0yW29Fwi0ckDHqzuQnJUMQu5gmVtBxuXDQRa+fJuTaZbyg+Iw4701PihhelId
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:4a3e:ea86:9cf0:d695])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:2406:b0:dc6:55ac:d08d with
 SMTP id dr6-20020a056902240600b00dc655acd08dmr277409ybb.5.1706307240911; Fri,
 26 Jan 2024 14:14:00 -0800 (PST)
Date: Fri, 26 Jan 2024 14:13:57 -0800
In-Reply-To: <xmqqfryjn686.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126221357.2940676-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/2] index-pack: fsck honor checks
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, 
	John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> >      ++--fsck-objects[=<msg-id>=<severity>...]::
> >      ++	Die if the pack contains broken objects. If the pack contains a tree
> >      ++	pointing to a .gitmodules blob that does not exist, prints the hash of
> >      ++	that blob (for the caller to check) after the hash that goes into the
> >      ++	name of the pack/idx file (see "Notes").
> 
> Not a new problem bit I have to wonder what happens if the pack
> contains many trees that point at different blobs for ".gitmodules"
> path and many of these blobs are not included in the packfile?  Will
> the caller receive all of these blob object names so that they can
> be verified?  The reference to the "Notes" only refer to the fact
> that usually a single hash value that is used in constructing the
> name of the packfile "pack-<Hashvalue>.pack" is emitted to the
> standard output, which is not wrong per se, but does not help
> readers very much wrt to understanding this.
> 
> [jc: dragging JTan into the thread, as this comes from his 5476e1ef
> (fetch-pack: print and use dangling .gitmodules, 2021-02-22)].

Ah...I can see how that documentation isn't clear. The intention of that
commit is to check every link to a .gitmodules blob. The tests perhaps
should have been written with 2 .gitmodules blobs (in separate commits),
but I think the production code works: I tried changing the test to have
2 commits each with their own .gitmodules blob, and error messages were
printed for both blobs.

(If someone changes that test, e.g. to have 2 blobs, the ">h" in the
"configure_exclusion" invocations look superfluous and is perhaps a
copy-and-paste error from other tests that needed the hash later.)
