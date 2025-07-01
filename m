Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8B2798E6
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383171; cv=none; b=JFG4P5HWUClXrDiqEA0bdfm+27nZBhhonOWoHLHunDlIVZOiTYd/4sd3Mvugr/arxMayvuDmvE1KZ0+zqcQzP/aAIjv5dm0qTizw75DH2bgcdmyDq9qM5YnFE6BOQKWoHxZKXPfY5YDWWV9uC0F29YPDERj5rkJBcHIGpteA/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383171; c=relaxed/simple;
	bh=1CUHmR/NGhTWRUDrqnbCQWpGd7GuWpgXlgq9kIgiW6M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aB6pRaF++2M3b2ZP34TLItYOLsetJciRmsgABz/qOZ7oyHfI2JIKUgV6WyoZNUx6J0psGibvwjGj8hc/ZMehr67GDpnP/t1FnW+VNaeCwh2NrCyibqCM3A/azNwu8z1obYWXhWi7vIM7dzIQL2I2DHx9/uEyDzdmw7aNYUCEE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+W8O8O9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+W8O8O9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234bfe37cccso69928945ad.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751383169; x=1751987969; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMap4cQVWHqkEFoNU2IBmR6aw5UhtluCbO9lIMPBfH8=;
        b=M+W8O8O9kSvCAVfrKhijkGgBia2ZXDtYTUa+mnHXlFyP0m3lEArcvKqQb7KwW2Q/SL
         gjxqZPqYlnoiKxgZ7TBdmZxSWxOKSyMJkJ9jRqXzbC91wum4JbNH7BVWrYqyys0Sk5Yg
         lB8512GKwswQFfTFjoK2BxWqQo/zdd72AYH1CdYTN/aZOqnrKwh3W4U4crUkeTdMcbnR
         XudcW1S4olKmJtnPt95vW66q6Dd0c3WHQ1ZM2+EmMUrYJuvaaZ/lEtTGqtljJv7llUW5
         NftJLFqeZVtKN0WL9G4RVGEOA7CGMqJcZltIU5Xr9BW4W8LaPDpdiTNMil6jrIRdzw5p
         OU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383169; x=1751987969;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QMap4cQVWHqkEFoNU2IBmR6aw5UhtluCbO9lIMPBfH8=;
        b=ivQbgj2vfsPPFqdIursU2qJ40YmFwHgN/H/tYb8Q8LQ+Tsre3EPLKR6bITgeHX/Bn4
         mtHubCLJCZrQDWKTw+1F/RE27yl6xSVz2owYleHycrw1zF9P6ZnNUSMxf7IgcMaxq7Eo
         5rnVzkZNHmNsiHMHxz2RBJd9YzjMLw3RzQG1TG51yR2JHKh3MHuofi336AHUsPj0l4Ff
         EITB+ZyGD+vjTcjJHmQodgwfooamfM+Wg0nyZLd9j1g5xGym9CfQWPVa+xeR8hXDkegh
         6kqQQd0bKiUEsffBBN1uulLY6ioFGbN9XB/CtxAY3ysnAYV/1xlfcCh2Mmr0R6n98CyD
         nkTA==
X-Gm-Message-State: AOJu0YykSw9MXycXudV9MsoWDYl7yeT1pI4ls1DskkuaizIhOKlCQjIY
	M2OykpH++GS4EE1o6CFa9Z6U93lnpATOMn/jEzqDtB4WYjIarz9yu1na
X-Gm-Gg: ASbGncsPNJuNuMiEX7ngX3QsEp+arspiVIJPZ3mkiu0FmS4p4PGsnJNx9oXTzaMArs+
	F34ModXxRPPiCurnKUi/i4Dr/vp5jgB4ENptYsxJG3EXAgduVaFt7xeTkFmToPz+p4mM2HXrOkv
	1paXnDltBHWPbM2VfRwZuZzrN/EC+o+dhOP81OShnQhqyTaXoPP31eb1CQsU674UJ54YVMdoMxD
	h1Q5JfJUzcBF4Y1za2vcaw1pONXe4aN3toqrZrSvMAqi15YGg5vqIEtu/GUGD4K5iPcIX8kkzTx
	RagHfYolefN8TD5y+Ia/HNGOKfJk/tTOyzyYZFN5D5l90up3ovjpbrpD0C6geAEG5ttaZDeVmlc
	eVtBqZ6Ac+8aKBNwfGlqve26dTRw=
X-Google-Smtp-Source: AGHT+IGsAxuhg//AMV28sZJp6cDGslViMsN3gkC0efhqmz7fig6V1n2n2rIcu9R032muIdbUGKcjbw==
X-Received: by 2002:a17:902:f609:b0:235:f2d7:375e with SMTP id d9443c01a7336-23ac48e88efmr292593835ad.52.1751383168596;
        Tue, 01 Jul 2025 08:19:28 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e39f7sm109876315ad.49.2025.07.01.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:19:28 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
In-Reply-To: <C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com> (Lidong Yan's
	message of "Tue, 1 Jul 2025 13:52:26 +0800")
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
	<20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
	<xmqqy0td8fa9.fsf@gitster.g>
	<C8E0D62E-11B1-4921-AD4C-2905F10E07B6@gmail.com>
Date: Tue, 01 Jul 2025 08:19:27 -0700
Message-ID: <xmqqo6u4kkg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> Totally outside the topic, but I wonder if we can further optimize
>> by adding an early rejection using .nowildcard_len?  Instead of
>> allowing a wildcarded "dir/*" pathspec element from disabling the
>> Bloom filter altogether, we could say "dir/ is not possibly altered,
>> so there may be dir/A, dir/B, etc., in the directory, nothing that
>> would match dir/* wildcard would have been modified", couldn't we?
>
> I think, except for PATHSPEC_EXCLUDE, all other pathspec magic flags
> could potentially be optimized using .nowildcard_len by restricting checks to
> just the dir/ part of each pathspec item.

A good observation.

I do not know about icase; though.  Asking about "Dir/Path" and
getting "Dir/ or Dir/Path cannot possibly be in the set of paths
that were modified" from the changed-path Bloom filter would not
help us optimize the tree comparison out, when we do not want to
miss modifications for "dir/path".

> Here;s are all possible pathspec magic
> #define PATHSPEC_FROMTOP	(1<<0)
> #define PATHSPEC_MAXDEPTH	(1<<1)
> #define PATHSPEC_LITERAL	(1<<2)
> #define PATHSPEC_GLOB		(1<<3)
> #define PATHSPEC_ICASE		(1<<4)
> #define PATHSPEC_EXCLUDE	(1<<5)
> #define PATHSPEC_ATTR		(1<<6)

