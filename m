Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3C25EF90
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751402986; cv=none; b=VrwCQgRwXBeYhn2pJm6hSwj1NTeE0OpC/kF8tc9Q+md7ZfkDNX4KcUcjoKjvL5xKUiqnO30SWDaH8PMMzQ6Jg9TD3WdusKiXYUEb+/5HaqVMSxp9R4WVjGluHZ1AtlBLHNPXWuni9hZtTbwtQUQ6HSC/SDk7SMDCu8SeMqUAhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751402986; c=relaxed/simple;
	bh=Yq5ey6iT2cS/y781BoBn97FZxqqy+EvQkZeOzPEm2Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lKBh3hsoNg3gSQfEXP6jmZ0YM3EqtzL+RpTGdoK/W3YPQUQ1vSHXTcKJ9HcMCBCMibmV13DvpX4DQW+1xWEBbQvidrYBm8Fpl9nQFTl0XW5ndUdzxeFLps/BPSKuflNd4ua1vSHtIJtM2Mo2aq/r1CtA0KL1nB6MGLF3wPjG/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM4ENDea; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM4ENDea"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7490cb9a892so4361557b3a.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751402985; x=1752007785; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BY8rC96d/WFcatQbu6hWo0bQwXAWF6zYmnm9dLdOonA=;
        b=eM4ENDeaP7rXDNfGyghIds7ePCpimzH5/GJGY+d4Tk92cfm2Zrm57cNx8RYVsoJHWm
         zCfbU3dHCDLPYMj7ZfApdfkn492ca9z3G7pYOmgbYbphfnaoANtEU4rQOUoUolr4lln3
         M0J7udqx7QPulDSM1fAw2oFbaJLl+kPqOcAlL/HBSoGFY4r4sEpRxMYeUSMw/5i119ic
         2xR6Kbusatw3mvF6VHctbZwUCui7Cl3FVfqhvnUPTaDcv/M7riwaAEgyIlyowuj+hkmr
         BQ0OHYpo3GTYv/rynppjqAoSOSRzKgKYDYRUOs+VqbpEZxTw49IArBGu0ythnxpyCJ28
         x8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751402985; x=1752007785;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BY8rC96d/WFcatQbu6hWo0bQwXAWF6zYmnm9dLdOonA=;
        b=ascAm4x7zB0wAFyjyHMHualXEepA2V0QsSFH5dUDJtqd9UubmfPPaSlBk0kuDu8dCA
         otXPZD5mzec1Gn8eqEbNfg3p+S19QIodzL2s9UDgbDxkyPIKVGNoqlQWpYF3iAKERTvt
         KJbIh9SyzwxpZ0/l+9INfwQtcwdCZGkttEpAY8FVIFrt+p9yATiu+mRQnAXsM/4YVm8u
         2IhYQ+Onq1Zkug0TknHj2vuJMPOfMZyupfMoSZzYXmRDr95Tab9/asFIc7VuD3pbUr3z
         +WGlxxs1XsIUtX0D37ICeeN0oz5w7BVSrkBMRq2bA/WXRdvsyJGoTjukAwZlke1L2W9g
         Z2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXfSeiET/UncDbpIOVFr+1sYLbTj2fwyi6TKftv7ErY0Pd1paY6mKYCID9oM0CqucYgXgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbzLrUb8G2F9mJ4PSK7RCNo1OtT7jtrxKSIDKg7FGBMTT9qiR
	3QI+HXVvxkX4OPz8LasUeAvhq8SumH2Cc+SEWdki60z+TkWEorJUb0fLi7I91w==
X-Gm-Gg: ASbGncugTKMNpelArddYN5IyIO5f+r42KWvwcLkEHJOI0Mniwm0/FGvGbnBUbqL3HLv
	SiTQfp2klZlT1xbb67MKS1IfkRRT+3BmgcEPH3xZWpO9qhDm9prlENAo/rFYv74NUAgYmD7/U0l
	4hgs9qTVhl38XQWsMzzCqPadkyDh2lTxz6H1RDfFyPKxIBrCzwF+P1IJy9/L8KqL+m98bI2vu7L
	KDsmdQ9+l4A7IOkPJ4TTmVsPTWCYH4o9QNG7iWXJHRwZmNbJLBbAb1mZJfcz4OIkeJrmpg9xLz2
	UDeLAH/lzaoqeEUw/FNmm/bt5TZdReyL09OJd/jaegJTaaNfvgHT8hzMrfWod2WymzcAgjQywb3
	lKWDlMwBGaLobCdzOkMsWQ+0pxXY=
X-Google-Smtp-Source: AGHT+IH8GQ3pNOHDXP/4cOdp8lQck12MYhRZZnc2yq6/NxOFT0GT7hvGCN1THH4eHLWePYsDcJTskQ==
X-Received: by 2002:a05:6a00:22c4:b0:749:540:ca72 with SMTP id d2e1a72fcca58-74b5126b841mr338639b3a.24.1751402984584;
        Tue, 01 Jul 2025 13:49:44 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af557591asm12787788b3a.99.2025.07.01.13.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 13:49:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 0/3] clang-format: modify rules to reduce
 false-positives
In-Reply-To: <878ql8qbhp.fsf@iotcl.com> (Toon Claes's message of "Tue, 01 Jul
	2025 15:36:18 +0200")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250630-525-make-clang-format-more-robust-v2-0-05cbcdbf7817@gmail.com>
	<878ql8qbhp.fsf@iotcl.com>
Date: Tue, 01 Jul 2025 13:49:43 -0700
Message-ID: <xmqqcyajk55k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

>>   -#define PATHSPEC_NO_REPOSITORY (1<<7)
>>   +#define PATHSPEC_NO_REPOSITORY (1 << 7)
>
> I'm surprised, but I couldn't find a setting to change this...

We do not mind spaces around binary operators like "<<", and the
change suggested by the tool is an improvement in this case, I
think.  The lack of U suffix to ensure that a bitmask is unsigned
bothers me more, but that is not formatting issue.

Thanks.

