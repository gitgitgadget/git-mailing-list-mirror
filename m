Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7346B9A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885370; cv=none; b=eYfKxOvV8kMhC8CpBoqZJlAm+LoQ2yxDUuZWJYfEDyWJiq76oPqnRyDwQxPBfNkIuXHZsbG4/OPzwVwUveKljJrVjqXeBcQqWi6irPWfHa3Gk7q7JLfImf7/PZG9dQYjpkDRg/qVprEYBffwyAqC3gxMEZrANwTwwYbLjoujtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885370; c=relaxed/simple;
	bh=zCIlE/agAp5Z8/vQOsTkztSyeW94tAH/S55AZAI2mLE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=k0cbhmcgE0XFjfTiKQoSPDkX7Am+Zyhw2x4GjEqEMu09VyKUCPC6P8b4SbAxvf4p21rKrTpxHtfx1W4bTqGJulnGxsB3TSYQKvRLMW3w2vC8s/K1PJMCIwrAQ9UvXcH+lemyxhNPFSOyKKF2dShrXw4OHGjLmxPzEfqSq/lwfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGChFC5E; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGChFC5E"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51134caba39so1228968e87.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 06:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706885366; x=1707490166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xpjrkRAsi8Rv+akADjE9jIluv1MnQ6mNcdKQtw6xeO4=;
        b=LGChFC5EaoWqwAagrQa2hhcu0fzDVDZiqJNyWaDg5xIeGtphDD8KUvYZOx8o1NRgyT
         EbQh9COm7Y2pe1jS4GOppZMZWTMLYf4QL/HK1ndxcw3Uk7b3GBw8wYzur2KCEVowCcS6
         jIDnNPth0fUbzrMZ2ZpvFALzmfyFlWUUlX3dmLQiWIejk/pMMw0a0jkPmXUhjHm4pRDb
         9tfot+J5Cg9EbNJaoXGg+OB0P404Tbkxa7qBCJjJyLXkTMf5zBwlIYqJY6FUzbUMyj+R
         TjnXym1hyFUIy59d2nGXGOgYgeGlaQVMhl/zLZCnc3M21dPlV09+4/C8bSggOqBQmkHq
         J02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885366; x=1707490166;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpjrkRAsi8Rv+akADjE9jIluv1MnQ6mNcdKQtw6xeO4=;
        b=mhUEHw5CQRDMW0OLmfqEjDFNm3azjyivtywmirvJYVwyCRMldYBKGPHB8akkbvRXcz
         vOc/Yx0mzOkIg+TirY9z4zt56TRdhlxY83On51uYt0NWMeXVa8j1wAV4pm/fvj2IFJaZ
         cta3xVMMwl+76NHjIbol4JAEwNFJCBC9NqKs9q7NToU4TPOyKxCj6c6IBx1FpkNZgSen
         jcN/Y95NNL/iwtnl5MA81qbBluDb/owEBCYevpzadYb5dZC8pOxb/kFcnXykSMhO5wjM
         hcODpKpY2m0ifA2L0oHhiu8upNnd016SP5liz/G+6i7Gz+NOW2hkGF4L6az1qYbQdrZ8
         yoLA==
X-Gm-Message-State: AOJu0YyaUIkP8LEF9hkCZi8RtZldSz7sI6DPcL6l/RiBkwda2aPXua0Z
	UqMxArC3+qYZG9/fAafyfQn6v/TR0Ia+aE57+iyTUt2qSB9ji+J52ib7qbxM
X-Google-Smtp-Source: AGHT+IGAFAaANlYeIG/IWi9J+Nq5JDer62u/YynJJDKnoOkdRte72VwjceeL5T7VaqYhkFuV+btiKg==
X-Received: by 2002:a05:6512:2804:b0:50e:7411:2489 with SMTP id cf4-20020a056512280400b0050e74112489mr5598006lfb.31.1706885366186;
        Fri, 02 Feb 2024 06:49:26 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h11-20020ac2596b000000b005112af32296sm324813lfp.139.2024.02.02.06.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:49:25 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Hans Meiser <brille1@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	<AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 02 Feb 2024 17:49:24 +0300
In-Reply-To: <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
	(Hans Meiser's message of "Thu, 1 Feb 2024 12:10:11 +0000")
Message-ID: <877cjm53bf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hans Meiser <brille1@hotmail.com> writes:

> Hi,
>
> is there any current discussion about moving Git development away from
> using a mailing list to some modern form of collaboration?

Yes, now there is (again).

> I'd like to be able to follow a structured discussion in issues and to
> contribute to the Git documentation, but the mailing list currently
> just bloats my personal inbox with loads of uninteresting e-mails in
> an unstructured waterfall of messy discussion that I am not able to
> follow professionally.

Did you consider to rather read the list through
gmane.comp.version-control.git nntp newsgroup?

This way you get only very specific mails in your mail-box, those where
you are explicitly CC'ed, and you usually get more support for
structuring from NNTP readers than from mail clients.

HTH

-- 
Sergey Organov
