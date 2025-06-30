Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CAD5FB95
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290293; cv=none; b=Dw0VHfpSnv01efLGfm4A6D54gZyESruPkXSJxyFei/+Jj1URG8wYsGATw4fET/Fs2wHoLHtHqS/cFhNdb09afs2uEn+OLGzqcWFmMCUwSaN7lSU6N9Xd3xx2KFacRlCkfZhLUM8jm3NVPpLGkPf6JLMuWe3wRt8jBIZPdo1xwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290293; c=relaxed/simple;
	bh=W1caJ2/HSG2P6ebzpDlpI6XwwC0X+E+EU1dCo6ksOL4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgGl5ogi82OhMcqVfcz5S0hRq+pjuLFCuS00aoKCvQtOQjSuiDk5lVEUaroFXV4070OOQMEh+zzA6Zin8HgdHXhGle+tYMpgnh8uj8+ow3zFuotmrbHF0uRQzu+cXSJoWoOuTNrO2lyJBQRk4I1VC9nBJ/xzIqy1u7DizQ6yjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kah3ELxl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kah3ELxl"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73972a54919so1865409b3a.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 06:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751290291; x=1751895091; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FliMnhi6sx+Q9NqfDlb60biq0sNhzwXVSa9dzQpDWxg=;
        b=Kah3ELxl+bYypeog72h1mqDhtHE1YtzKRL7i3qRF603Lz0/rT+TJpM/skSHEFncp1A
         fK5dfQA80TnMllXihb+1q953bApkovfTbeY2Ucphnv/yezVGqZXAzzVX9sf2OjI+Y1hi
         UTL1mG7V99MHyDAtaXJsJHNWzA2KXyF64amijPLCEmgSdEwrmmnVR8hjX0nm8k4Gf7Pv
         i+3kf29KIqIuYLfzN1x5LmO0YBlMvekmwiKNBqKlzlbErP7dJ4MMpKxkJhSGL4XJFvDZ
         oYcmyzDNhKTlCgZSJ3EAXs0grNu5RzVFwsk5VxXYELc4GkSc6hGolu3DmGKqK5Iyvwaq
         j1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290291; x=1751895091;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FliMnhi6sx+Q9NqfDlb60biq0sNhzwXVSa9dzQpDWxg=;
        b=GyT6IFyaxHinKIv1C9IMwKSc6NY3B9+GPEceL+i/Thfe84eAHHMTsg2qg6yLMn9kuF
         g22LTMC38i7Csh6dbCT1QkvgbsLzERoKWGARGN4cCMbw/n2ciW/IUFng1EpDEVILFC2u
         PsV5j+ErbpogJx7KZGS/Ulpg/gBNkcXwoeAwAKUQ+DuAQP/8o48LAAirzQXdzHv43B2H
         JFNBzNhgMbq5EyagTbL/mqPCoAsV0JFXn+bHkFiVHoErTf7IkbVK27JpaZFglRyio9B+
         trfxtYmla5x1gHdQVcxXgbgyOcongPiC3qUh4TH/t8aAkeuNEssVsmz7iIedRHo7Fe4R
         Uc7g==
X-Gm-Message-State: AOJu0Yx3mT0NDE2R/PzD72zvI+3uZJt+QFdwqiTrSBL8tdrenNjoYw5W
	4k14m9SpVXKStldNYskgGAdH4lWWQA3f/7qqIJmil6Flp51/Q4ubqyqBYAWUGg==
X-Gm-Gg: ASbGncvyJRmOf77HrTJ9YG9rjrU4fBNp5U1KksL7M3bcE07PH6sHCfYS7Wo/pXhmuBK
	BL9d0FyKptpCLPGMR6YsuECjGOANAfVCdDBW4JjXHEb2shJoLIEJ3Rc46iEMmzBxhYb0SPAf9Yv
	B+XZuSbEAbEJub8lW/64UAf+0yupS5SzImGXjOzZM/lZ2vQtPJDRrrz8XyD3ukOcB9Wcpfz32xJ
	fDR2yM+2aR6wWdJchGzKTELTEw6cb6J8+c5hUibQ2z90PwxGMQDZiiVv6HP3cvdQKtX8A2LroU2
	07tehBk9JKadAPDiAOkpnrNG8aJPk2VUh0ZqJIEfI3TKFeD7CvGjJKJmrzZ+DHKoVrARBZY7/9/
	Y+WnPpHYpwZ2E/MGz9/7+lOIbQTs8RA9shDqaew==
X-Google-Smtp-Source: AGHT+IGg2xnJNuz8WwNbzBk+dpi0KCoZ29AtKlEpx7xBP4pRduEcAHwKmZI9+pEBMwmeKOAw5V7Mug==
X-Received: by 2002:a05:6a00:894:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-74af6cdaa50mr16765666b3a.0.1751290291113;
        Mon, 30 Jun 2025 06:31:31 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541e64asm9332065b3a.63.2025.06.30.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 06:31:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: git@vger.kernel.org
Subject: Re: changed output in git branch -a
In-Reply-To: <20250630121839.6252d9d9.olaf@aepfle.de> (Olaf Hering's message
	of "Mon, 30 Jun 2025 12:23:32 +0200")
References: <20250630121839.6252d9d9.olaf@aepfle.de>
Date: Mon, 30 Jun 2025 06:31:29 -0700
Message-ID: <xmqqsejh5pam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olaf Hering <olaf@aepfle.de> writes:

> my dumb script parses the output of "git --git-dir=some/dir/.git branch -a".
> With git 2.43 it gets the expected list of "remote/branch".
> With git 2.50 it also gets something like "remote/HEAD -> remote/branch".
>
> The newer version runs on a different system. It might be that the repository
> was already cloned with a different format. For some reason it does have
> .git/refs/remotes/${remote}/HEAD, but the system with the older git lacks
> that entry.

I somehow do not think this is a version difference.  Assuming that
your default remote is called "origin", I suspect that you have
refs/remotes/origin/HEAD symbolic ref in the repository you use with
Git 2.50, while in the other repository you do not.  Both versions
are capable of showing that symbolic ref information.

You can try in the repository where you use Git 2.43

    $ git remote set-head origin -a
    $ git branch -a

to see if the difference indeed is coming from different versions.


> Is there a way to suppress such lines, or do I need to filter them manually?
> There is no obvious knob mentioned in git-branch(1).

Scripts should be reading "git for-each-ref" output in the first
place. Output from "git branch" is meant for human consumption and
is subject to change any time (even though in this case I suspect it
has not changed.

