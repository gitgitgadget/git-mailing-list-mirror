Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CC1EB22
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845816; cv=none; b=HsdCLnGz+NNHxqfh/2fqV+xcNgkeso8Ezm0jrnId7TrDu8C92xXUofIn6pCEh7lqdPdlD7DF6b+3iatcjLIuujh4uEY/OqG+/cYYDQ26+i4kVsuLDNL3rrSNLpA5dBJCkjtV2r1Asobyc95TP5J0J5d1hFhctlQEOO+RuLaQpnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845816; c=relaxed/simple;
	bh=tVH9qw0MhtzvmdfxpNq2t/uT02exJ94t9YeCjtJDE0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhiW/B060SDAwqIyDBHm8fA8Anc80zEydd+oy8H8XtHsuED/eu4Y5VhodeG27H32mw8lC7e/kZ4wNzU8cz8eZZPh544U6n8XO05QZw8OUdIHH+WQO7f/oJ/YBHHWlg6kvnuXpCHVt/JLIJPrEJpmhwWMinMqWAM9gCo2HiqV2zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YanqFdE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YanqFdE"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso93615507b3.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707845814; x=1708450614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVH9qw0MhtzvmdfxpNq2t/uT02exJ94t9YeCjtJDE0o=;
        b=1YanqFdEzpkV/6Joc2H4xtOvc5/SEct2pN3GxUCHcyYIpFaowriNQ4/QUb1nIAeyJy
         lSrEo8velWMmfTzGdG2emmAMh9G2NeCUnsKGIXB2NAroNhpD82Jjio7dBChh2XRGAeQ0
         Mk+sAuuLYS7TDvMG9L0f7+0SWYHg6rS+48EYkmf7BMO1MxwrA7YGYvBmDtmuZTfJO1B6
         NX9XvFmTpod9mYlfszQcpV4jL5XWyXKB3T8d/UIdM7bhTf3v+b1myYaLAefHpEw19pKc
         Wr0pOsETl+jlGwu79nJjrjoBWtMuiqW1DDmvqDRzhhih41haq2lAKPZId+wcGFDYHb8p
         WeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845814; x=1708450614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tVH9qw0MhtzvmdfxpNq2t/uT02exJ94t9YeCjtJDE0o=;
        b=fZFgIte6Cqqp72vajDBkLnzFOkoFCX9a9vGPDdjRQSKtNbsLYjBQtrVFw0/KkLrz4J
         ciNqUqTatayKcBsS/1dHgjQbtnO/eDyJZy18BcElD1IkGliUbiHT6YOsDMvx5CClBM5g
         5ajyPQb2dImtSA4FtQKAkKIMQiheRRR/0BLSK4ioDu71Kjf3YPKb32zGJTnQAWPfHVbp
         70GG7JJ4BOY60U9snYdGC/gIG1nVLLogxlvaOdnLbxaY+AQK9P5DNnVwxWPJJ2qHVb3y
         6qWTLOhc+9O6ICMamoHnVbH046Oimh3IrxmFQSwonMqFGJtSihZvP4Dljd4xQjk2yLRx
         ap5w==
X-Gm-Message-State: AOJu0YwLlutXAAZ2jSyBaNGbuQNnAqiDoh1wyrV3x/JSyTbbIeRaKkS3
	9rcNqP3+J9Ccc/YC38xi0TzY0bHPIu1Y41m9HEWIgQ4szR0s8ILWVJwriEbELCR1SC0KcxO/mso
	EWw==
X-Google-Smtp-Source: AGHT+IEpZq2Y6V4yCPaVOCVZrMgTB2PDOdsHed3aCOUrswhOOr/aS8/d5Do/ar/hmL+4873V/g0WsKF1gKw=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:dbca:0:b0:607:74b2:579c with SMTP id
 d193-20020a0ddbca000000b0060774b2579cmr5426ywe.1.1707845814261; Tue, 13 Feb
 2024 09:36:54 -0800 (PST)
Date: Tue, 13 Feb 2024 09:36:52 -0800
In-Reply-To: <xmqqjznde235.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
 <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com> <f5f0d06613f2701af9bd3a1a9274aae232e03d8f.1707196348.git.gitgitgadget@gmail.com>
 <xmqqjznde235.fsf@gitster.g>
Message-ID: <owlyle7ob70r.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 19/28] trailer: make trailer_info struct private
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Emily Shaffer <nasamuffin@google.com>, Josh Steadmon <steadmon@google.com>, 
	"Randall S. Becker" <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> This patch believes that the benefits outweight the advantages for
>> designing APIs, as explained below.
>
> "outweigh the disadvantages"?

Will update, thanks.
