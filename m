Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56061359A99
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351473; cv=none; b=d+GKDq3fjEZcHRHYeY+jqSqFm3Bd4VNDHl5g1ed5nOcjQajXJssYwkrKZxlfF9SBmaCaiPnGuk3d09EU7vQYfDmS2ZLj8TlKSj2m2EyniEqVXzaJOwra5MNKoi2jntijnEIq8CBz0VDSP2Q5ieXxmIS7FOHZDC4KhuXPkvap1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351473; c=relaxed/simple;
	bh=UASa9mpT0bD++VSF/jT1m3AjO5qRPDaXwRcKsWmI5oU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tkf+RDF8SUZyWtW5dpJdrhFQjb/MYIA/2bvQP1+SZy2NtsVLYIilfhQlcD02b6elAbmm9Gb9W8Z9HTAgEVHhrxY5N8bPuI0G8ZY5DKyagrM8gN2wVRh4NgT2DnPiMYDH3Oq0Q0FmxEVvv3NsytB4SQytE4kd0YmiWcDs8Es4tJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr3Fj6uj; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sr3Fj6uj"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-963a722ed59so934455241.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780351471; x=1780956271; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UASa9mpT0bD++VSF/jT1m3AjO5qRPDaXwRcKsWmI5oU=;
        b=Sr3Fj6ujDk7VT4IRJMuWdYVD0rawfs6+cCGS4E7OR4fzcu8M3MQZVZBcCASSlF1oJu
         5OEl4xnjASWLkTivgSuDh7aytztazrPwXNnpba9YplLDM0nrEizWgnkMizOex6ibR5f2
         GEsIO23TMSP76ZXdIxW/3EWKIvDijFdsybhFirXP8p5zRAnzG0zAmkDZkaSTOLfrq9Hc
         833OxsjmRf9DIBYF+Pl4UWpkA8XwS1M/U34kzKhvm2cIGlIzAANAomsi+Iyq5pxwaeuc
         BPlEIV57piRN7esdPOBkMWc3bwCr/7qTLH1t8s9eCHuv5YkSr/VfoD11k8UIBQbrEd3k
         4/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351471; x=1780956271;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UASa9mpT0bD++VSF/jT1m3AjO5qRPDaXwRcKsWmI5oU=;
        b=DcEB66FkxuDLTj+PkEoQ7gg3edSSb1NRaf6gnxjanET30+iLh/go3ZOXRxC1hUjrIf
         h7RI+mKgFEbf7s7KsOhL68Z/gAUJ1Y6Mu2yh+Rz0z6Y46GbHLWk2yFkrC4Bps8dovCHg
         r1a43+2sm1ULfGgDsOe8ns9ScZGGJ1S6GkdvV4aMk+OjafMlrCDRQFd/vaD6ZpxU7X5E
         zL7Bjn2sNoE1jtP5gNSf1t1EO+RC6FqGShUAUwqz+ZpfCDyXpjrRdJH5kt5WtvDTHE2z
         RbD7U06sXJnaA5xwT7k7RceVBS9k5+lkbbTDCPH4allbim+M/ufSKHWc1+UGuqfUj6YW
         /gIQ==
X-Gm-Message-State: AOJu0YysYXwumbloWj/NBn2S3b/8+mfPpIvukM2Zz4UAfmurnGpmXmZa
	AHbMqUrnQ+HwDdoJdM+vCYuGSOVDGz4j7DdYdNudBQY/T23BgTe4kmEz
X-Gm-Gg: Acq92OEWWKpiX+YgMpXhvu9iAvNOZDf20xFD7ugumxucscie3t0niFMy2q7OdhtHSTS
	/RB+8cqP5jtkByD5iuv3JbWJog/U+ixSmXkU1ZJqtqS2axP70hDudxPHxauAF//+KvQ+TGpQ8KD
	Xfc4eZ5FKq+AGj5oQsE2EBSYIcdcsKRObE4UVLgFiGZv1NjU1Q7CifBU396lmO+R8yDC6ZWTsYl
	p8eTaSRPSSTnidbYxQvyfn940urg7nDFfnEqcBshhr47Ae2pj4ITwRf4UTjJKqz1+yNft/X+nMr
	sTMcFwFNBX5NxYjlC7BE5Es6MoCB60aIxt95uI+aILgnqwPhbkqTSAB0WtgxJwireDsws/pULDw
	sX+nM8GrgG21S0Xqve1ZaqEZ7CUT+oIeZweplg7ARpy7J7T/AYlBYGMTekzVHhmMskXNSrrE5VD
	AE/zI1qOyiUXn2vFF4X5WDjDjatn02iLL8J+A5IJv8j8LQyeXWH25Z5WYL2o+w/uo=
X-Received: by 2002:a05:6102:32c7:b0:632:8eb6:7a1d with SMTP id ada2fe7eead31-6c6990c0f75mr5702072137.9.1780351471391;
        Mon, 01 Jun 2026 15:04:31 -0700 (PDT)
Received: from smtpclient.apple ([189.62.148.96])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963aba249f0sm7147132241.3.2026.06.01.15.04.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2026 15:04:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [GSoC][PATCH 0/4] teach git repo info to handle path keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 1 Jun 2026 19:04:16 -0300
Cc: git@vger.kernel.org,
 jltobler@gmail.com,
 gitster@pobox.com,
 phillip.wood@dunelm.org.uk,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 a3205153416@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <921ED129-FFFD-4F40-9232-EDD3621EBEF9@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Nitpick: use [GSoC PATCH] instead of [GSoC][PATCH] as prefix.
Use --subject-prefix='GSoC PATCH' in git-send-email or
git-format-patch or set the configuration variable
`format.subjectPrefix` to that until you finish your GSoC:

$ git config --local format.subjectPrefix 'GSoC PATCH'
