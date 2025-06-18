Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43907285CA7
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750241235; cv=none; b=o8av5zwO7RAg3qiCtC/FH/WLeVXHDM0T7pYbxDBRBXS//Gchz3m2boPefHgbGoOFn++snteuZzrMohAJNjSZdgj3m3TRh4RKULMzB3JL89xog5xlYypy0aK8EZkdLvMhjoS99ngZR5mb3h63V9cgKwauVtpXt2Qw+72UHDUvIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750241235; c=relaxed/simple;
	bh=zNNVhVmehvQjt0z50pE1vgUg4iRqyKIahHzpcJEEG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnRvR9I1yumBmdgPDbDzZKXnpVjCZcFGVsvHvsyNcipeIswcglxqQC+Rv+xF/1KQH+0gVzkdTljeToz2jDWeZvLZwFBJndrDbA8kQK+q4sEjWUYQGzpK8KPafTdQovZTawi/j6DLcJIXItW0Tw9u155zSsmtfkal1QuGLbVId4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo9EuROo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo9EuROo"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23602481460so66695235ad.0
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 03:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750241233; x=1750846033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tNlBJkBzyjYU7DIrYB4DxyzB9Z7apwjlZVXv/wapKOk=;
        b=Xo9EuROo0nWxHgkoOq8wrIt0ek9IPKhQfnMZmqXBaeiCD4PfP4r7nK+jpjESNPPPl6
         pBrqyfQnuZWfqadxyhSSOck/mf1U4QBNUeUc3Yev3ZOfYpBpo7d3cjKy1JkfVZ7x3hXu
         oiQDbV1DiXd64meaHlre/+cVqi2UCl21iCdpynZOlc5FjMncyF3eM08A2uPP9+BrQyd4
         PvmnRT/arouhAlD3jBmg6gLUqYI1cV3AqsEn27cpHOx17cO4lKwFHI6CArY66QDMgd0M
         s0GOyxZ5eKPBBDEvJQj3QUQkvYVxWamo7eExftJT0SmBvDNoysntpS9L6mSABmgS3Oma
         qW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750241233; x=1750846033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNlBJkBzyjYU7DIrYB4DxyzB9Z7apwjlZVXv/wapKOk=;
        b=s7L1PpzVnF52MJrjWtAcB9USueZpqcpnl+PRBX3jxVdL2yvkNVK0T9yS3BTvq//irV
         IHvRJR7YH5r3zU/jcnnemUNBUtQmD7o48df8MRYOo4ph1hJKU92ILPVdw49sMhQKAbH7
         1sErGvvCFLgH6/QaPoJ4Eewd6azKIoijN2O47KpbmyJCIALjr72XmOTIG48T7bkKGYXM
         dof1gHlK+bVgMkXfgkbVAnjpH8P8yCeLwhFFFt7PBjM8JU8iO1LHCQj7uLFZNbpBTZRA
         +RC23cZTaUg7jLIMEZhJbhX5tji7uSmCOIyea8BpQ56ml8nVsV68UbrQ3/4UzcnozGLB
         fe7w==
X-Forwarded-Encrypted: i=1; AJvYcCX0xQ8qZAmXOCZZmAGYd4mWvZVATCEfGQUYGGL0bTbz3cd6LdINc5Ag+F3qGuV8ZgYS6M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/F3DgucRctZvA79Cen88mgkxCCANRkbxajUY1QR9f7azuDxt
	ox8z29MtkmlxcLuetJwl0LWkbYABTeEdOH8lo1pJswHaV3n0UVGo/0Hm
X-Gm-Gg: ASbGncuR80Ry6x7VpamfRnPFyqb7QQCIdUz4GVnvkH2As9BH1CfoeAj1OnoGXoHdH53
	LOQP5xg7VrDK7Ko3kGRqwAyodyDFuCa/HxIgr8g8nkpi1uTDMAUBxVXedZdrMj9th6LAEq/5cUX
	5zYcg5T2gUq0+BTGGpi/AnqfOf9t8I7+nNdnkiPDfX+2FIDldwV8dTXH5oXGrsTZuYRxk96BRyU
	pWzlpQilDweZX1BbwBzV5f6E46mftsjl57CWO8IVqQD/eQtXyZ+ss8Qw59pTY5JejLlM3/H1hqs
	+oaf1MGL2M9COnSFmkuDb24BwsYAcSXP7OUWRqEqaaPVmMSDRwOKeRDg7ZTK5aKj/vsriK/ejeI
	6bt9bYFKdp9lEiETarLW2C/rRb9JrdtJ56w==
X-Google-Smtp-Source: AGHT+IHsiY70Yeyk1/ElYR3ciAIatufuptojFKpJqaGf3VLS8r+6pxksTqOSBWgoWdRW1FIFol2nQQ==
X-Received: by 2002:a17:903:1a27:b0:234:a139:1210 with SMTP id d9443c01a7336-2366b16e98dmr280796305ad.53.1750241233432;
        Wed, 18 Jun 2025 03:07:13 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:55ae:6bc4:8c5a:1603])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7836dsm96236595ad.136.2025.06.18.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 03:07:12 -0700 (PDT)
Date: Wed, 18 Jun 2025 03:07:11 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: James Duley via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, James Duley <jagduley@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure restore_term works correctly with DUPLEX
Message-ID: <zpv3nkpsjqlg7evklw4ui5q7wonak2376rclu5ksmumdvk3tic@tfxmcpjmj3nw>
References: <pull.2000.git.git.1750186571037.gitgitgadget@gmail.com>
 <xmqqh60euqhc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh60euqhc.fsf@gitster.g>

On Tue, Jun 17, 2025 at 12:18:07PM -0800, Junio C Hamano wrote:
> "James Duley via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > This is because save_term doesn't set cmode_out when not DUPLEX,
> > so an old version of cmode_out was being used.

To fully address that bug though, something like the following
(untested) needs to be squashed on top, right?:

----
diff --git a/compat/terminal.c b/compat/terminal.c
index 72b184555f..8a197ffea1 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -279,7 +279,7 @@ void restore_term(void)
 
 	SetConsoleMode(hconin, cmode_in);
 	CloseHandle(hconin);
-	if (hconout != INVALID_HANDLE_VALUE) {
+	if (cmode_out && hconout != INVALID_HANDLE_VALUE) {
 		SetConsoleMode(hconout, cmode_out);
 		CloseHandle(hconout);
 	}
@@ -299,11 +299,15 @@ int save_term(enum save_term_flags flags)
 		hconout = CreateFileA("CONOUT$", GENERIC_READ | GENERIC_WRITE,
 			FILE_SHARE_WRITE, NULL, OPEN_EXISTING,
 			FILE_ATTRIBUTE_NORMAL, NULL);
-		if (hconout == INVALID_HANDLE_VALUE)
+		if (hconout == INVALID_HANDLE_VALUE) {
+			cmode_out = 0;
 			goto error;
+		}
 
 		GetConsoleMode(hconout, &cmode_out);
 	}
+	else
+		cmode_out = 0;
 
 	GetConsoleMode(hconin, &cmode_in);
 	use_stty = 0;

It would be nice to know, if the problem with vi that this was meant to
address, and that needs further changes, that are only in the git for
windows fork is stll relevant, so this could be cleaned further.

Carlo
