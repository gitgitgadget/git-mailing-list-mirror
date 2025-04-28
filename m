Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F421294A1A
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868205; cv=none; b=pZgnhWYSxnoexfLfn8EiDk0WW7+Cspkzgl90ww4wcHlwrhiCTfLH6Zgndbq21buj0cyy7Lk+yrAlfevM0ZMZrKeuzxZ+Y7Tt3sHIcNiB55EY7ux1jzS6ZO8yipI1YJ3zZr3hYFOVc2DG40w8iJ40w5D8pUTlCUpdaiepNND2yO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868205; c=relaxed/simple;
	bh=i0+nYZgHuUqXioK1FX1J8BLJRl85xakfm2whcNjtcQA=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FACktLJu8GdUUrJIbZZbE7yJ3+0eXc1cwpAUUDiEeZypC9j2MRHyTnsgVcB+XmhNyFUC4JQkRyzBKZ60Il2AHD4fq11npfy6uAj8DyfeDGeqRbQsJCemEzBAxLjJ77hvfpUIFkvV5bjGGfXLU8BWZ+AF09VMtp7W3BC7ltGEUvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1QxvKJKh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1QxvKJKh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af9564001cbso3133908a12.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2025 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745868203; x=1746473003; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i0+nYZgHuUqXioK1FX1J8BLJRl85xakfm2whcNjtcQA=;
        b=1QxvKJKhkDS8HcBzYDF3OHsxGACqVBJ10heiiyQhlUW6QqSWYVJO/G26JRt34B9ZKN
         X+ZyaNvZVO6ar/o8sZ2Dw/a8DyMOB7DT6ZDb8qxWlKNP+wDioM6XaC6fZvgW53IE1G91
         afihtZBMzWqtl8fhxB0Ek0pvDL5BWI1MCPH4nR9BGGHP/Lx+YqUhlMjDODU3oX49W5S3
         RwVbZdSSt8TGd5OicW7AtH9LNt5wJlHuVShjCRuvDI77yj7HzTvXD7JznOfuZ2qO7GuJ
         GJPziog/b5+RAOHZJXj6VuEFJhotLFK71ni3dLjZNiszAhe7e1tmsF9504qdyV45KvuG
         UwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745868203; x=1746473003;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0+nYZgHuUqXioK1FX1J8BLJRl85xakfm2whcNjtcQA=;
        b=rme1hERzr1Q3seWk2D0UW1O94lrBL5SSxnj1v7MKqJdTFf7U/Grk3lFOJYGvGg8OBQ
         DJYgzFFw2JgKnP/AwAxnMJEFrdPeiHGEa3WHnTlRkEg5o4lkKMzDcwJF2csuWjOqH5uI
         QimPdX538V2YIOBNc57jYp3REqgkU9hBbV34vb5DBnQN+vZ/krd5UcE1fJ8I5NjBvIDK
         dtmZx+kYaG5rfWpnC4lnwfJlOFsqwnyRAbovx8r3zTgoOyczuU+ChlgUesqlGpwBj3tw
         bg1HBnoKb7uKelrvizJbZnu11atXQIHxA9Wx7w0/89PeSu0YDOPSfrs1m2W7vZUxvy0C
         EWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKkZJWqkhSCHXpUyDvqBSSiW1iO+ZYlYBoQAitD6wQRQ+sSSsFjYXx/BqwdLjw6dr9QuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lQfroJoaRDrwG9LaBFLT0Lvfak52RAGl5bZwb74YItjVe/1G
	9wN4IsEIkxSydLzHqqRIx/kxf04oI0tyiq0uxORtqzrSeqM1dx9NKhccyDYISjTXlxtcfRumaaG
	tt0EQ/nWdLGUqfueB9cFR1bWd2CbijA==
X-Google-Smtp-Source: AGHT+IGiqEouSL2f/X4cw/IGUD/+MW3SBuy9wpwJToi82t4KQIvQtRsIf16fR0TAPLJaLxMN5JOgpxVqdjc3dOZuNV8k
X-Received: from pgvn7.prod.google.com ([2002:a65:63c7:0:b0:b14:f6c5:84fc])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d0a:b0:1f5:70d8:6a99 with SMTP id adf61e73a8af0-2093c2cff46mr998171637.4.1745868203454;
 Mon, 28 Apr 2025 12:23:23 -0700 (PDT)
Date: Mon, 28 Apr 2025 12:23:20 -0700
In-Reply-To: <CABPp-BFiLURYmELQ1omyPJ+49cVxk1h4rPYj42zMwGUW-NUUGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428192320.3595509-1-jonathantanmy@google.com>
Subject: Re: bug report - BUG: builtin/pack-objects.c:4310: should_include_obj
 should only be called on existing objects
From: Jonathan Tan <jonathantanmy@google.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, Nik Garza <nikolas@applied.co>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Elijah Newren <newren@gmail.com> writes:
> Cc'ing the author of that commit for his comments.

I took a look. I'm not sure why I made the assumption that
should_include_obj() would only ever be called on objects in the repo
- in process_tree() in list-objects.c, the case of a missing object is
handled only after should_include_obj() is called. Looking back at the
earliest mention of this on the list [1] I don't see any clues either.

In any case, the fix is probably to change it so that
should_include_obj() returns 0 if the object is absent.

Having said that, I couldn't come up with a test that exercises this
failure mode. Nik, do you have a minimal repo that reproduces this
error? If yes, if you could contribute a test in the form of the 'after
fetching descendants of non-promisor commits, gc works' test in t5616,
that would help prevent regressions in the future.

[1] https://lore.kernel.org/git/fb2c202591b466eea33b4585e47b70e9086603bb.1729549127.git.jonathantanmy@google.com/
