Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D628FD
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753567062; cv=none; b=EG6UOkJTUPYmXbolv0ANqaMuDLOUbLky4p25vM1ZPB96OvZuLOpCbdDhi2ZkM9U3ItZQXDkaK5wNl352ynXV0VSnU61uHOw2jS9j+xy/slDluNYHzGDbi9OiNxEi/75tVx9oT0eQVOmEM9KAq2HznIQUsnlf4MFyACis5FflzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753567062; c=relaxed/simple;
	bh=VYDAozAMwitPP1K1whBxE+EVOholUkgMTOpaL47M9JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opFhhfC+HLCTd+1nwu8vfPkZrIeDCD5xjSv90AZiDplyzoXyU4RPQpJ3WllOD1f9yOhx0IZyUtEEPur+ssScUN+ARSUtazfzPei7R02d2PxzgTTIuFLjUCWNLjw0CQ9GBmmW1ttaDIqvcE1ImizjyxwlmLU6hJxita0O+OvVdac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EStUKdJe; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EStUKdJe"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4efbfe9c7a5so2767799137.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753567059; x=1754171859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm7s6iCFsNSYD0vA+IkqQSrjvobyxfoWidC6Sz77J1o=;
        b=EStUKdJeQ/MEyjDN0zoDHmqtEyJaFdW1lIONISj4OHGjjhrHjrn6x8K17MnaYu6sHb
         mefdCf7bIkm83bKf+Ru8MYbu0DQoXUSUxYD9PlreXOxylQrUWJUFjmnM0MbgXGwZY0ES
         +GR1K7KWygF/i7Aw07oY6NV40/XHHqvfLWCI0uuvGLxLVeTO5Dil4BLY+RfUUxFxwm4n
         TAH9rKiDdTJSwsE89ysbhMaMSRPsAl6YdpwhvCoQ2Uv5QPv4ieP962AHk5/0loRLfSk+
         LAF7jW5FKlN++uJid5MkRxi1vcR9oHldpa7t4FRd4ulR2P5So1Z3cPMYeKc1sj2TAKAJ
         qzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753567059; x=1754171859;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cm7s6iCFsNSYD0vA+IkqQSrjvobyxfoWidC6Sz77J1o=;
        b=CWkk9rlSIBgjfIJxFz3FBYNd8DHKpg1bm+Fhb4vtiUYjpWxxI7K8Mj+Hvp0xPJx+Re
         Pz3R30Dgq+7l6kWQs5pcM+EKHENLnIN+JtUt7mRsz8cat+YY8psG4KETTTfzoL1k6G5j
         sVwgN5PJd3LvjbPx8gAaYVebEHGAxp9wV62fmujUgRhgjlNOY9uYUMzuGabvbar7k4X7
         1zALMoH+UxVEvbjjrlqx7w3E7Z+tMvXJ7bFSpW4fttY5hBb1cSUXe9UK2W9n+XAw4eM0
         Wo3epQ2TBRd7mYQeTgkNM/UpBmzIO3X9TFESBFMU7PEhVbcqHyYU07yMst1fTCd+IX8m
         Uplw==
X-Gm-Message-State: AOJu0YxMZQ0//7hqaljB4Cl6d3ptMKiBLK8+anFTPp0kXcthpNAo9cUW
	L1c+AkwgINvR1KG/Az8bU+vZfQhnGWSy3w7Qzm7FkWGqomyub35yKBK/QDWzb/+TsMo5nQJdsOW
	s01yM0x/3W5ENbYPA/fGdHZAmiPQsl5w=
X-Gm-Gg: ASbGncvEEsOLD/4xc/NhmFPRCKdb0yIoYx8cP2mgJPipz4b64WMoPaWYyBrn0d6KHjR
	6VH6L0QoEds/NigJ1TyhVbx+bvcI7alZfd+jalQiL47cptjT+ZLY6rfqXcLEt0ZdG9jEcU/jGRC
	/3ejlj8xvPbV9qrxq8X+WerJRuLsprnGnYpIE7WL7EPDDnXmbrt6RTwJzYjn1COa+M03kQiNxT3
	6NVK3I=
X-Google-Smtp-Source: AGHT+IGib7I1evcgSX8uFfbqG4CurA+WWITSb3tbEP2gPua0Tm2dOrmtQpNE6gQS/tyfzjCLcVpwAeSEtiV8/z+UBnc=
X-Received: by 2002:a05:6102:4407:b0:4e2:e5ec:fa09 with SMTP id
 ada2fe7eead31-4fa3ee2ff4cmr2858545137.6.1753567059551; Sat, 26 Jul 2025
 14:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726165320.4039-1-ben.knoble+github@gmail.com> <20250726165320.4039-2-ben.knoble+github@gmail.com>
In-Reply-To: <20250726165320.4039-2-ben.knoble+github@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 27 Jul 2025 03:27:28 +0530
X-Gm-Features: Ac12FXz9wZHifW8MFQtENqhqI8g4IgDZwsosdBtmr8dOKZyycE5Q6TMNFPc42CI
Message-ID: <CAPSxiM83fpNXsfBrtG4xpRt=yYaU7e0OFkAHK8dkLGpF7jtDxg@mail.gmail.com>
Subject: Re: [PATCH 1/4] t1517: fixup for ua/t1517-short-help-tests
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

> - fix known breakages that actually work
> - fix new t5200 test
Thanks for fixing this, I do not have to send the update version.
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>
> I expect this and other fixes to get squashed into the upstream branch, but I'm
> including it here so it's easy to create a clean build.
>

>         difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
>         http-backend | http-fetch | http-push | init-db | instaweb.sh | \
>         merge-octopus | merge-one-file | merge-resolve | mergetool | \
> -       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
> -       remote-http | remote-https | replay | request-pull | send-email | \
> +       mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
> +       remote-http | remote-https | replay | send-email | \
Thanks
>         sh-i18n--envsubst | shell | show | stage | submodule | svn | \
>         upload-archive--writer | upload-pack | web--browse | whatchanged)
>                 expect_outcome=expect_failure ;;
> @@ -125,7 +125,6 @@

>
>  test_expect_success 'update-server-info does not crash with -h' '
>         test_expect_code 129 git update-server-info -h >usage &&
> -       test_grep "[Uu]sage: git update-server-info " usage &&
> +       test_grep "[Uu]sage: git update-server-info " usage
>  '
Looks good to me.
Thanks.
>
