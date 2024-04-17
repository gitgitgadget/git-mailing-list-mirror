Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C18563B
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 23:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395617; cv=none; b=dzGMgcvFfZY3SRq2z0YH9RrtGInrp+e8SVZkxVSczQsWZGEng/eKpNS6YGLeszeG3yekuiZjNV/NxyneDM8VZ5ZHCljdb6E0MmlnDBAJBgXxKTMkRXeD7wfY3j/uvdrMAf13Dnj8RBIu28nI49lE1lZ+I+WK2AWB/6plq6aLdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395617; c=relaxed/simple;
	bh=0jIxRIdXmNX9sSC1yqx8XPXhcKS5QVNxyrWCuWuIFFw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhqcJzl3XSmG2LaEWqMgEiPyggbd9zuX8w66zs92fzL7S47DK87UZmI4ym6mh8Kqx1c7DcEVGTf+zwEqyFj8M/mNzDoTacBst3iC7sZc4O1sbDRYosaB/6c01OMPSD7qNurgccE9hqnewqcGqgCnlCKdakRoj6ZzLDrCy2DdA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYYbiS+e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYYbiS+e"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a2fdf6eb3bso333026a91.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713395615; x=1714000415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfp2z6Xggx3vCqZS8L+tqx9xFkhkhZFr0jf/cwegDeg=;
        b=lYYbiS+eir1h20NZB0Kv73sFt7OTh203DkHTjAyCvHWcMlH1ViCG46I2SFXAjd/TeV
         rUCYR1u0UKiAmB3zjpn+Hs5hBgpVU7AGf0j/8j8TK/rikhsjxal0Kq3SNKQmiHLcc4uk
         O+IDSwGNQvV6LaPOlIOHFdpkuPKeXLJuLSzD20AEmm9SsDh7ioDOctAWvOSclcFQD4l8
         j/bX9U28GF9Y4G3mP2H7SPiwRCgcuZyWygI+BpdxnN6QgJfVqbz4OeRP2SUFvW9rR9xI
         MtnW6QxviLwa2Az0BXWazTNSatC1gjMbtTLFrOidC4fVnjHwdJrbUFhz3BWtUwhTMRBz
         UfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713395615; x=1714000415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfp2z6Xggx3vCqZS8L+tqx9xFkhkhZFr0jf/cwegDeg=;
        b=p35HuZzHjfYxTxI0rQxAovBwMt0qVVF1kPlYPhpw7GbYQnGTNCIFoYV7J4TjqgQTeq
         nODYpuf+2jYpLOy6F56pBIEiW0sOX6L/lPzKuV4poEWkJaku2jNXeEVs5G1Dqkcqx5bX
         fO3xKRdfqOiI9FBdvMyyvCxXBXRiYcU5eCfY3LfcOqOF6/9hTelzbQvsuXdgP6JvRLod
         ueVSmuIjo/SDSnx3nuyPD3CldlguA7gROeY0yA34fmvjuoCG1gHEp5S0137ePvKrB7T6
         Qra6p0nh42jh2LtpK2Dd/Z5h5miisLtHo4FtTpGNWDykjltk3f83+crJz5TpVe+rFv15
         hg6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpK+ONyunufRsBxZ82trOHJoCLS7vjTSvAv7XOONPVBwT0KW8JymtVJONNxdH/r5lbN2Qy72M23hpEOn8YaZiO/x5i
X-Gm-Message-State: AOJu0Yx5wcK3cuORk5xUY2Z8uuOdxRjliQUW1zlPJ7+D6MeVW9ss/mGZ
	SZAC9J7LQ+nWkTkXg/cSU2Gq+JfkpQfh3XvJ6/oX/gJi7OKHP+7hA8SqazIGWVd7toU4re6CkJd
	0yQ==
X-Google-Smtp-Source: AGHT+IEiYGFos6XJ3L5YvDNRd7VLpspTKaSHzXcrAFMDKkxxrOPzuInfnl+LRm4z/+Ma/sT4NUoZWSFmUh0=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90a:7108:b0:2a5:faed:673f with SMTP id
 h8-20020a17090a710800b002a5faed673fmr2567pjk.0.1713395615313; Wed, 17 Apr
 2024 16:13:35 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:13:34 -0700
In-Reply-To: <xmqq4jc0cag6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
 <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com> <c43de19d867cb5e63fe6689b2b7d645dc4741950.1712878339.git.gitgitgadget@gmail.com>
 <xmqqsezqmrtd.fsf@gitster.g> <owly34rl53mr.fsf@fine.c.googlers.com>
 <xmqqjzkwdigv.fsf@gitster.g> <owlyzfts52ln.fsf@fine.c.googlers.com>
 <xmqqfrvkd843.fsf@gitster.g> <xmqq8r1cczw8.fsf@gitster.g> <CAPig+cQ=xgfExyCM2qyobv7CNRz7=J8S_=w-C-VoCNZ6M6FBbg@mail.gmail.com>
 <xmqq4jc0cag6.fsf@gitster.g>
Message-ID: <owlyttjz4m75.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/8] SubmittingPatches: clarify 'git-contacts' location
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>, 
	Kipras Melnikovas <kipras@kipras.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> @@ -1118,12 +1118,12 @@ valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>>> -codebase and run `contrib/contacts/git-contacts` (you must have Perl installed +
>>> -in your system).]
>>> +codebase and run `perl contrib/contacts/git-contacts` (you must have Perl +
>>> +installed in your system).]
>>
>> I wonder if we really need to hand-hold so much to tell people that
>> they must have Perl installed, especially since the command being run
>> _is_ `perl`. It might be sufficient simply to say:
>>
>>     ... codebase and run `perl contrib/contacts/git-contacts`.]
>>
>> Anyhow, it's a minor point.
>
> True.  In the original it was a good idea, but once we show the
> invocation that is explicitly done with 'perl', we no longer need to
> say that.
>

Agreed. Will update (but will first try to test the 'perl ...' arg to
--cc-cmd).
