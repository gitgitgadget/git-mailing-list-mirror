Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDC18BC2F
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279427; cv=none; b=OghPDl048ojUFrakR1vi5xkh3Of39PqRxB1TFxRMYfAFUEQYOWsn0Btn6qTndZff/QnvsoBSl6okVtFho3se+LXMQTz6wztcyMgQTU/H4PY3RxkGaZV4dfCRNXWIeBEQFQOw3Dc+v8EZ7+529nSqQYombRcYEUpxf0XUxUPT3Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279427; c=relaxed/simple;
	bh=otxhmvmo7GFfWw3nmX2kdvj5dKrbPbnLvlP1spg7WN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4ldwEBkpJ+G7RlWjzJDuswZsWoUNcsy6qv/4J4KK6gEmLnYpGkkS+hml3WvZJbBfpWTvcoBG7G7A3wT3YICgRbWJbo4Kyontb+7yiXcDl4BDEAvBw4xh1Wznrv6digDoqHZmuUe3eaB/yiwhOhU7tgjzcUsW9jUXZOGNCoAD2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THhYr+0j; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THhYr+0j"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d84179ef26so3851189a12.3
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736279422; x=1736884222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FMRqt3BcxvypqZSlYHZz6Vn6psSCVG7q20E4WZWUTw=;
        b=THhYr+0jDUZM2gxOlLKaqZmQyYWmS0ufRFsRl0pn6C/Ygujf4erBsDcwGL6iWXMi95
         yJWtkskzp7wjBHDoViDn7tEQnna7sTQKPF/TG57snZE5prxr4+A8uj7G3htxPibUDFAe
         EV6J68OuQWOc3lulkdIGe/syYrEY3+YEfmrD9KuPi6oUnUkLRGW0xe2ZI1KFMMGyKhwk
         3oI1KAGAJi04K8GwN1pdENmdNlto+RRZluCg8qPT+Ch5oNcS1coGGPWY1ikHrrzFNCkL
         WqOs79PU9miGyt6V+DD/U+hGoHuCiZRHCpGdSrzgD+QoetgwnsIxpoJr0qzUwmTJZ2wG
         8sTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736279422; x=1736884222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FMRqt3BcxvypqZSlYHZz6Vn6psSCVG7q20E4WZWUTw=;
        b=wA/iRPNYwxkgHejtCGA+ZixwSE1K5VPTp+tf09WcCuJJTDSc+x7d/K+VTsWloo6zBm
         HQ+kQaR9JeQDy8MuI1sj7Kf05DfNXzY6FFvliZ/5gChvqp79wr8TT9rKOVkFDdp/PCpC
         62D2/22w8U+FdZen3I3kWSniMM5pWI0ww79roaqAq4gJmt5eWBHuG7/wYD2AhSjhRzd8
         5Iv80adSGWQWtSaRuikNifSHLY3o70w0bk/aLyYhxqRrCoczEUFAiXyCAbG4P3/Ucbrz
         UaxLhveVJHwJuM85QzVUPsS/Wa8apsgPajKEHwm13D7Bk2p2vIBAcDdCmtrrFPZUI51+
         KzKg==
X-Gm-Message-State: AOJu0YwQmRN5c/9tTsed04rImP8iIsGOIWl4HdCgzQuhi+LPsADHh+Vg
	zFT32LeMSBHcQJnCBMi5JPred2kZgT5f3Sf9OwsohOTxPciDHSsnYgAWhA==
X-Gm-Gg: ASbGncuvqhouyY14Ik77iYj0nS2FcsflUt4HaWJ+ttGW+x/wwIyfG/A/3eHg9RguVMS
	7MyCMPbdXTC57ePOWJhg3iGpgEL18q+L1t4/ffXflLj4i/ooAnlS0Dd4QrZWlXnSZmKtr0Mv1qL
	EAJEL1D3g5Mc3qUftfljwLcRIHiAhZSs30O+Ln1aBFqAIdW43d59Tm9pb9E0Ic0EHZPrRCdc7V1
	oABi0ToV0g8IMPSqvJHX9rwl9b7R0ncJT5uGME3W/DVXtn/GsK5KcQNcMZJ/g==
X-Google-Smtp-Source: AGHT+IGibFq9zSPvoO59shjLqbyD0YJXqcvX1a9WwZt15meIr9B3rvOV9dNCAg2x7JxU9yBBc+KdmQ==
X-Received: by 2002:a17:907:daa:b0:aa6:9ee3:e51f with SMTP id a640c23a62f3a-ab2abc6f09fmr6752366b.41.1736279422201;
        Tue, 07 Jan 2025 11:50:22 -0800 (PST)
Received: from localhost ([217.156.233.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e5029f8sm2399333066b.0.2025.01.07.11.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 11:50:21 -0800 (PST)
From: M Hickford <mirth.hickford@gmail.com>
To: julian@swagemakers.org
Cc: git@vger.kernel.org,
	wiagn233@outlook.com,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
Date: Tue,  7 Jan 2025 19:49:50 +0000
Message-ID: <20250107194953.2104-1-mirth.hickford@gmail.com>
X-Mailer: git-send-email 2.48.0.rc1.35.g1b4e9a5f8b.dirty
In-Reply-To: 20240228175329.3371-1-mirth.hickford@gmail.com
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Julian. The patch looks good. Please could you add instructions how to test it? Which servers have you tested?

I have a gmail.com account. I configured Git following https://git-scm.com/docs/git-send-email#_use_gmail_as_the_smtp_server

	[sendemail]
		smtpEncryption = tls
		smtpServer = smtp.gmail.com
		smtpUser = yourname@gmail.com
		smtpServerPort = 587

And configured git-credential-oauth following https://github.com/hickford/git-credential-oauth/issues/48#issuecomment-1966486513

	[credential "smtp://smtp.gmail.com:587"]
		oauthClientId = 406964657835-aq8lmia8j95dhl1a2bvharmfk3t1hgqj.apps.googleusercontent.com
		oauthClientSecret = kSmqreRr0qwBWJgbf5Y-PjSU
		oauthScopes = https://mail.google.com/
		oauthAuthURL = https://accounts.google.com/o/oauth2/auth
		oauthTokenURL = https://oauth2.googleapis.com/token

Then tested with: git send-email --smtp-auth=XOAUTH2 --smtp-debug=1 message.txt

"git credential" was queried for an OAuth access token as expected. Note that Gmail access tokens are very long (~220 characters).

However smtp.gmail.com responded authentication error "535-5.7.8 Username and Password not accepted".

Looking at the debug information, it looks like the SMTP command "AUTH XOAUTH2 <base64>" was corrupted by a space at column 241. Exactly one base64 string should follow "AUTH XOAUTH2 ", no spaces.

The same problem occurs with OAUTHBEARER: git send-email --smtp-auth=OAUTHBEARER --smtp-debug=1 message.txt

I can reproduce this with any sufficiently long combination of user and pass, such as: git send-email --smtp-auth=XOAUTH2 --smtp-user=tim.arsietonarsei@example.com --smtp-pass=arsteiarositanrestnerastarstarstarstarstarsetnrasetnearstrasitenarseitnerasntearnstenarsetnearstarstearsetnariestnearsntenarestnerast --smtp-encryption=tls --smtp-server-port=587 --smtp-server=smtp.gmail.com --smtp-debug=1 message.txt

Can you reproduce this problem?

Any ideas?

I think the bug must be in the call to Net::SMTP.
