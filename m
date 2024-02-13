Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B960B90
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855796; cv=none; b=VlEukRXy1+PjiBq9ZLD8I3f5M5rdksfHGN+87WJvugt1HB6JCPy05oMCvx3GGfaPJyQTaz4DJleDPnLpwoFOkMNKWWBqqziHp8xwHh44dO2eDB7f0k54qlMJxMQRW1fr0fGmpB7B2ISqAzxZshzYFcTTHbG8lOXMRIIrQeE2CIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855796; c=relaxed/simple;
	bh=KEXOTJZ43VfvV+bAEdfKmPNTGaVPO0U/bPXQ/x7L0V8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oBRAw8purSiYjH9XqXDONlsJrubXaDq7CBPmST+fIXQC7UO6nXMfIptkkcErd8K5d4FimPpLKXG7uDP5n4aeyI22Nk8+WlWMfjfMa5lL782xFOBqLdGaNB9EWJA3T+upPeSV9mvnMIPjtrsu965BrS+CbCahgkszGE7Yhx8pn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPBODW3v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPBODW3v"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602dae507caso82986857b3.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707855794; x=1708460594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k60xuTFNLrgIRZo7FLBRDNrqNDLGv8K9d0UQbxL8CRo=;
        b=jPBODW3vznJ0ut3fBZgUHwevtD2OwQeXCTjtDvK4BUb6FHLPCwCd60iskA4H3fxv+B
         ltChuh7pToCQQpeF9PGo80mk8irCNvTl85smSYnLCtxx3bgLGyUuGqJZYX3Z9vdp5YGx
         jJSM6po8j3MiJ9rl/p0AthbXhXwnaFrxzKBw14XAnc+ICBr+NifV7ENykUD2uYX02Bwf
         7A/q8eK73N46+KJWbemn4B9xR8gFOxlNCV4JSwFOK53QmQ7a8ikG6GKB9Jn1fHNgbLTE
         VfK9AqMnwHUZIX/E5XLWbVFPPnJVn/LjWDJUP5Wx590pg+ZKy2ZW9IhVh9WSAPaB/6Y0
         vVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855794; x=1708460594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k60xuTFNLrgIRZo7FLBRDNrqNDLGv8K9d0UQbxL8CRo=;
        b=HE2Za67tpaZEN4U9Yqull7tz+1St1H4pNDrL/nIIR4+5ruOoHnFnxhGkXHR3znKQf3
         DnjkZg6KZ1Bv6hfLi+mPIfE2o6PPFFOZMeN7LpGqrpDuUp4tf1gNBjALrPNwxXDcW79F
         bbTEfE87AQlTBIgBkt/ajGRLX1e798+b4s81NsWAttx654qtVclWuMtzpr82eZcMlmUV
         uBYg6PMrRWfJp/LwZZ1T5aTgtvNoTi2ouJt+slXxDVsL/DhaZwky8tx6LVcFWtoYCFBq
         KmJX56jL9zbtBYqgUjQGXE5Z1jRNk06Bz19t8DKLNyMQBwWmJZvd5wIar0J24YKXaVaZ
         R40w==
X-Forwarded-Encrypted: i=1; AJvYcCVXHrHgi1fZZs8i6MSWqloHx2cLdsUUmbTUnPgOX81vMRQVX384B08qiVLxZbWc9yYhnH2QWRSuYQPrxOG4RB2k/pEu
X-Gm-Message-State: AOJu0YwlR1IqwxmBg36bjDXGK/yyDA0OXlUtW/XY6X4RLJ/VRDWJIOdj
	tQBuZociaAMdmCGeFA1HWTULcfK/li8n2u3dmt8d315lQwipyXKu24cJHcGyRABdtZ9lVTSfcJl
	0fg==
X-Google-Smtp-Source: AGHT+IHuLeiXoNOX/u0H1oYJ4PaNAWFhNvCoF+2oelzImfWwH8JNmTzuaScsMbFlk+IabzkTd1pvw6Fx12Q=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1082:b0:dc6:f877:ea7b with SMTP id
 v2-20020a056902108200b00dc6f877ea7bmr83583ybu.9.1707855794037; Tue, 13 Feb
 2024 12:23:14 -0800 (PST)
Date: Tue, 13 Feb 2024 12:23:12 -0800
In-Reply-To: <xmqq1q9mmtpw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <xmqq1q9mmtpw.fsf@gitster.g>
Message-ID: <owlyr0hg9kr3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] git: --no-lazy-fetch option
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Sometimes, especially during tests of low level machinery, it is
> handy to have a way to disable lazy fetching of objects.  This
> allows us to say, for example, "git cat-file -e <object-name>", to
> see if the object is locally available.

Nit: perhaps s/locally/already locally/ is better?
