Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681061B87F0
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751314242; cv=none; b=O45iHt5kFUvYt1shvvum7dxP+N0QRt/2y9zowoXuJf86OMf1LI5OPCKbc3yiOEMlCW08ysJiYnFJ8NfqJ4tLHEWbopMOK77dPYAR4QR7eOYMv6qhxvnDfqLtJDsp0NBxdm1l5mtIUwNnQLPTAYKLDGchYC4XPkaVSx1u/EhOlvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751314242; c=relaxed/simple;
	bh=p/JEShm/HkXR7G3ojJgOZep/nfm4YX7iekuPEXL/BDo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tvve75NkQ/FKFaAoRtkZUHHaBLec4kmuCJJxHEx8TytgjzeDXFNfY9FHMBZKR4dWSvgOG2ziMzueDqSRyHQKluwbCNSRdgvzMmLMMNcrD2fe3BK43OIdsbcvQrVjMvqhSFsMxpeMww74pWflUAekX6w2GocUESD1qJZbKLeA7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPZQn7tD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPZQn7tD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234c5b57557so23241555ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751314237; x=1751919037; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vLfrrfMDHVMwdsGb2LavohTYK8bdW37jGG4Tqcqf7wQ=;
        b=YPZQn7tDR25K6O37EGVRr3PFWQim1m6IZaVrBzFrCdjmUnUGBJmLtOAMY3NNjR8IRO
         uBYWA40FZ+nV1aop3SwKNLqcUnYkVJu5FkzKnGB6RRFAdYAftTG4HnZnX8VNulFBbPKo
         rA2I7ALpjLY2Ezg3BTveGsZWtGbdNU+uJxCGMBTCYCNImg448NMDdxtD7DWwhDukp3Y+
         Bu6rlicA5VE38He6L0ZzHtUEzMY04mIDFCvHgAfaN+AIbrDuWpChX7LE6FY9ufKv6hW5
         czK8pc9TLsk7q/OpHunrtmKYnhi8Y8CcAZBw9hXhazVO7JpDDmuQVowOx0t4BvPKpOPB
         TyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751314237; x=1751919037;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vLfrrfMDHVMwdsGb2LavohTYK8bdW37jGG4Tqcqf7wQ=;
        b=ks5VVLu1WnPXiMkw4SToZqMw4HElZ1NbhESyuPQp4uDLMN+l+owleMMlQzKY4HVnGf
         eFheYaKLnY2jiMUq2dD4plAO9MoEFRueY4OgrWTGpDHh58WTs57ouC9ZEt6AAZqHkKT5
         PPKq0Vd96tpjoogrzycv2NXPEtpro4Hh46yCZkLJrHYeQ4hSUev1b2Aq8IwXE2VeTQCM
         E3ZnaH9ev+Fb+mS4/EFCqdcoJSp9u+6tN8tKEVF0Hfihlbj2JhgqvUwnDcFOQxn0DgBO
         darG8xsY3ycZSp7GFbrOhaCEQmE88Ya84SZwbkpjBeHkopCui4RhbEQKq+p6uCM0xj4w
         0SfQ==
X-Gm-Message-State: AOJu0YxT5Rj78S+I3Y/5O2ABEVXXBMCPANYtEacVzLNAhhnjg51cQcOF
	iZubLIjUW7WoACgf8epaG1P4zrA00F8lGKJHAWfOPr/jPy9ycgivRXt0JoE77g==
X-Gm-Gg: ASbGncuVySJahx6OZELXlUjLUZSLn27Slcf7q/u5ZTnclSU8QccP7qK6sQsXXQ9Ktff
	Lbyu073hd7+ohQnS0eBoLCOEXCTK+VhC3UlU+8JD910DtoPU8utlUMu6vovF4BHp9/bsaFPgNBa
	F8j/wQXapzCLuM0Wj/g4cQxglgCECANOj7OrDz+25OyBetThq1EV2FW+HZqVNQa242JLHMKrJRG
	JHmu+bC1a3NPHzs2qF+F7RCIYvS/OL9SRfE8jg9Vc+UFRTZY/RWLDG6J9+dIpJEIgL5UYYpCLSn
	yE+EONjEyeZPHS/AWKb6RKbU+tJXTUV09aVba9+Yb31RdsizTdiv6avIXOO6KwDi7E/Oa4E9mlR
	3TGGrJbDUb4A40nL6MeOzE5x0TDo=
X-Google-Smtp-Source: AGHT+IF27lBVfNLYesEhGYyco1nU5npolZDSDYhkHrnSL+sj2IQ1fbSBx8sG4nA+iKOtzuMKAmEG8g==
X-Received: by 2002:a17:902:d591:b0:234:bfcb:5bfa with SMTP id d9443c01a7336-23ac3deaf19mr228384395ad.15.1751314237523;
        Mon, 30 Jun 2025 13:10:37 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c8649sm90675945ad.236.2025.06.30.13.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:10:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com,
  karthik.188@gmail.com
Subject: Re: [GSoC][RFC PATCH 0/2] Add refs list subcommand
In-Reply-To: <CAPhwyn01spdT-hFxVPcr4cnwBJ=YL3Ty-johXvGKXKRdCTpHXg@mail.gmail.com>
	(Meet Soni's message of "Mon, 30 Jun 2025 09:23:44 +0530")
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
	<xmqqh60183ku.fsf@gitster.g>
	<CAPhwyn01spdT-hFxVPcr4cnwBJ=YL3Ty-johXvGKXKRdCTpHXg@mail.gmail.com>
Date: Mon, 30 Jun 2025 13:10:36 -0700
Message-ID: <xmqqldp9m1mr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> To clarify, I don't have specific options or improvements in mind right now.
> The idea behind mentioning them was to acknowledge that having a consolidated
> interface like git refs might open the door to such discussions.

One complaint we heard a lot about Git in the past (I do not know if
people got used to and learned to live with, or they are still
complaining about the same these days) was that there were always
multiple ways to do related things slightly differently.

The machinery of for-each-ref is shared by branch and tag to give
them feature-parity.  Adding yet another command that behaves
slightly differently, with the intention to make it diverge even
more in the future, feels going backwards.

> The primary motivation here is to make ref-related commands discoverable at a
> single entry point - git refs, rather than scattered across several top-level
> commands. The aim is to improve disoverability and set the stage for
> potential future
> cleanup or enhancements, should the community find value in doing so.

We need to be a bit careful.  There was a case that went in a
totally opposite direction.  Even though a single command was there
in the beginning that can be used to pick a specific thing out of
the histories stored in a repository to externalize it in the file
system to be worked on, it was later split into two commands as
folks thought it would make it more discoverable.

Even though branches, tags, and symbolic refs like HEAD are all
refs, from the point of view of end-users, they are different things
built on top of the same underlying mechanism.  The fact that they
share the underlying mechanism does not necessarily mean that a
single same command is easier to discover and work on them to the
users.

It may not hurt too much to have "enumerate all refs, and for each
ref, allowing to limit them or to sort them with some criteria, and
show them in a customizable format" as "git refs list", but we do
need to keep the feature parity with "git for-each-ref".  Adding
unnecessary subtle differences would only confuse users.
