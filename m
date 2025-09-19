Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEA1274FEF
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317347; cv=none; b=AZxz4I6O0OrxXNDiMLaS7U8CLv0sMV5NtbVgq4FEhXqdqxO5kME1jqhVX6dgMIGnA6c9ipUM5LQpn9NzMW2t5IjhFS9clCu9hO4hgfnRQjMGoZMThtY5A5oUDbDkEictXApPMitLtvy8tuWRr1AXd9flwuX7BVd2YWd4RwBGf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317347; c=relaxed/simple;
	bh=DLVirt78A56LDLzdQL3zC1OJYWel6iafTq04/38A0AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1H7ku2ZZEYddsnCVjklhm3D0KdtkNC0C5Z1Bz/BIXMYMag0Up96BleApktdI7uBxwL97e0hKWan7kVLCnGFe5rIpVAUd/I4SwXHY4a7B/o5/IHhuN1vT1fIOS3ShXGHgkLuxWjOV6qAuXIzOsdMHLV9K2aPgfYFS9gspI32DLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlGB5o/c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlGB5o/c"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-579c95a2be2so1941552e87.1
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758317343; x=1758922143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLVirt78A56LDLzdQL3zC1OJYWel6iafTq04/38A0AI=;
        b=XlGB5o/ckITxnAf4jcpkfx07uYsciCP82v4gAg0LLm/c0LKTVMX/67Dt4opYxlfN5B
         kUKs1t48ShOOuOxLLvhj5OUlXGAE83jhQmnTPxnwwd8CTrJuyP551C6GZXcKXJU27q7a
         gtqsQvGkrxS2LAqHGXtarbXkZp1rg12YktHY+NINabDhycWvYJ6BSYrtB8rFTqRBD/Re
         aIEjJs9hW8PrYpalE1srNT39cpFYvnSBNnWXZVtfgE4sNCOlI3TD5nrXLVAchVXzeR6O
         XffheZff7Xdnv2yRlvRAGANGIG2NLfNuIfD4lLIHnRZnKwGEJLWy4hjrp2A6immWvjL5
         7+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758317343; x=1758922143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLVirt78A56LDLzdQL3zC1OJYWel6iafTq04/38A0AI=;
        b=UnOm3PL7bT2i13HeCCpNDa2MgR9PREj2o590JM+rSJ40la2CdeP7To/3vTHeYo8SEm
         UZIjBKjgpezqiSfKdYAljYVk5MfXdWurv+k+0oanoiQvI2Vl2FHgOIFPLDXGsyHAe4ue
         yWoce/O3ehtZK5omVpbYsAHlliFZyNFcwAPT+qEOiR6T3t25APO2PfB9mK4WP5EhrWeN
         /Gq8TQSExOwxGan9bXNmnRqyt7AcLCqht0XoSMTtCMXHbom+WEn8cu9ZvfFYfiZD+mto
         pnq2Ip50Iz2u9JW1IDFVcsPU+nwcmz+sMqNMtIilfCs1tr9fqDgTXjPUthliGretRFZz
         8HaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzAVsO/JdNq05cTJ1yZsYR1u26QuTnCpVF9WXEvKvMpzGjganSRTnTdTFooeAnGVfvRr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnY8aUII6CSpXrnoHqQKCdfQtKReO/Zj7gMT/72cJWGdv+8tok
	+uj9OgiP1igzB0kg8mMPBS4yZjqkC63PhKbNrntj+ry42/p+v0hGSAY7EnAG7O42RoCwshRG5sJ
	jOlDHtqglu+SS0yNlhx6HwETXEqQNAdA=
X-Gm-Gg: ASbGncsnvdUKTiLLBnBABje1j9cG6Tdjy6fS8H0FBxwxfP7z2Ov5qW/lmfzD85EGXKO
	WoIx83ea7CwE9WN6HwOnUgJxiQ0sZ16eSbP2GnMMiHtX30tv4Lbj6Q1nAs9C6coTOTYdtrintGB
	fCFSnqHxD6qDCXGS9OhdsgtTWgsjJeA1eQ0TUS/TRzSBuPy/h6MXUC2GTYRYgkdMef7/xKR9rqj
	+AXzVAZ
X-Google-Smtp-Source: AGHT+IFyfSrd9/q39EDicCB6vh9FljGrJVOXckHTvtg9YFuqPQvSRdRtHNezfG14+RvhbQBv/zHmnFadDiKKEdB1s74=
X-Received: by 2002:a05:6512:12d0:b0:55f:4746:6202 with SMTP id
 2adb3069b0e04-579e0ca90edmr1879078e87.11.1758317343257; Fri, 19 Sep 2025
 14:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
 <CAH=ZcbBBkk2B3PxKf54MRnAmURMK8W7ofFZBRS=ZzkuDNWsY9w@mail.gmail.com> <CAPig+cSBEX5QGnzpBnVs_hKM2iUqcmA4-DzKDgkwpG9ZzWZ__w@mail.gmail.com>
In-Reply-To: <CAPig+cSBEX5QGnzpBnVs_hKM2iUqcmA4-DzKDgkwpG9ZzWZ__w@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 15:28:52 -0600
X-Gm-Features: AS18NWAOb1xhVw1gf4KTFgSXeYstHYke3MsRjMZ3EE6ugrOzOmPgE3d34lcOzA0
Message-ID: <CAH=ZcbC9sgZg+Ghv=rRbq8aMbpgo+6ZvRPBs7+4876EL0w4NJg@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
To: Eric Sunshine <ericsunshine@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:24=E2=80=AFPM Eric Sunshine <ericsunshine@gmail.c=
om> wrote:
> When building with `cargo` (I presume), and it comes time to link the
> program, the build process is looking for the Microsoft linker named
> LINK.exe but, due to PATH order, is instead finding the Unix command
> `link` (which is a specialized invocation of the more common `ln`
> command). As such, the build process incorrectly invokes the Unix
> `link` rather than the Microsoft LINK.exe and fails. To work around
> this problem, you move the standard Unix command-containing paths to
> the end of PATH so that the Microsoft LINK.exe is found first.

Your understanding is correct.
