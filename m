Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA21FAC4B
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880190; cv=none; b=uLI3QoNnZtgiN0yCERXg7Dye6o2CSUEMlkMQt9WNdT8adJGOrm5jQ6ei5B/SJK+LPIfmxT+0A01XZkWHr5RsxVGet4nZBf9AxOmJU+mXMUFAaJO6YQzZTEwIyrHLI1MxuVAOY9NfGUVsb73fSmj+pj9BwsIU1Sde6vsUAPCHaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880190; c=relaxed/simple;
	bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YEDqvJt/7GroisCrGBO2AiBt7yXYw2ElUxkEEOUzD91mtt8DuAoJjxP4sOeAvo9ddxXU8DLCsqpwsRo3Mj1jLIHD266ngohiQ8bkn4RzVPWAgTpuIkIv4rnmoStoL8Tu2/0+f5tfqWEHuY1qwgYxVgd9EsMjhjmDpvs2vEdifGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6+KcEE/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6+KcEE/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-796d68804a0so83023086d6.3
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880187; x=1760484987; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
        b=B6+KcEE/c5vDnU84k+ym2w3G3EANCiFoOpzkgwL2S8R7T4YzebL7dzGvhBxIgF+SAO
         vSChlO+v9HK7ewybjkY2e6KfDrIrDNH1oH6IddS9tocnKZ/3BSebPNratP9XGFtswrgE
         qLTCLm80OwNG+WPEEnRN//ZFCQ2P+t4BPJFYBH6oowieAZa6ihZ+Upk/vrksHhtVQQiY
         oRpJYoaxh3wuRQkI50TZ/ugGP0RpLVrdzkNoZQFcqIjbBsTKiNdlwZeOsuOIhJz1anTl
         rlKiZ9AybV/OoU+YunU7vwXosh6qsv7kXRcQhaQRHrPx3tKoCCAyBmmb/lyGxlmRA5OS
         rr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880187; x=1760484987;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/xmaBiLPlBm6/T/NyH9GTWq0g6WcUdGGd82LybMk4Y=;
        b=redlPyNhruQ68CK4VUflPkNzFW6v13Jz6m6VJLUFaFxyZePYD7UIYEtprKseO9hAv9
         XDkrwpcjvg0MjvS5lfJJ6WaXlqHIqXVzAjEmdZhw1Et0B5UhIAa7H/ZLkzgkn3HX8bEr
         FNpanZSA9PsxsMzioJyrKief6cFAjUxIhAeO5vYpDTPQSMROilG7TGHYshuFtIwBdr9+
         qUcwWTp0x6dEQm24V7So9lSD2o4xDw7IQwxEpsneC3ZjqsOzis2Wg5FwOReHQ/QHVzJ0
         2hOfFjgUyoK0lQHMj6oZh8Sinc4agmZ/l8k9YpDsBtBc2YcxFDI+34qvj+WbXIJtHC9V
         v1xg==
X-Gm-Message-State: AOJu0YzYb1TBwchiu/D6nrLYqp6tjWyOvc7BxMUUL6NbJbDv5h64koRV
	S3exYzwQ50oLQD03MDhqQd6El6aV84yvn6UxNLqvu1WEGdt8kga2GHNz8cbLFl438WL2Cow3xx+
	pDem1JS/FhW+BSVsqwzCdws3IbqxEgbp2xnlkshbIxiZC
X-Gm-Gg: ASbGncuaBp32ZJBjrrpw9iK9i80qfLDiMJr9/6thyUWJhNm9XzWzl1lQSxnii9ETE8B
	vwVI7tOe2K3b4oh9INKTr62AFg/5/eC0ign1hETSC0+cFcBECx7KZQRN7DIuiZglEJZWjWg0Tui
	gBwBASt0yHOHXJb1ZszauKaIYtGs6SwEXjyCzZVTw02L2WvGkH+vs8hotKT55gs1TnBs41Xn6wW
	QJht6LXrPK3dSshR7JeGmj490di0e+IH9D5C1wqGRpi7ANDQocuN5XlfSzmQS5IQ6az
X-Google-Smtp-Source: AGHT+IFioRAcAaSJFkdI2x0O4oanbEZYRDD5LagmFZQHZuPgAE0UYiO8592M4+YvIDLTZR1UVaexHFeFFAWFMuJFnz4=
X-Received: by 2002:ad4:4eeb:0:b0:7f5:b2b6:2a30 with SMTP id
 6a1803df08f44-87b210320f1mr21242666d6.18.1759880187116; Tue, 07 Oct 2025
 16:36:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Wed, 8 Oct 2025 00:36:16 +0100
X-Gm-Features: AS18NWDsJSLbD3j9Zr3cK7Sp8xO95di3ZaTyGdgyuq58DlBQU5xroRMwCWyq_g8
Message-ID: <CAFpMFfAid6KasvR_C31KNDyZ30tiTDU3T+cp9C5mw4oJn83eqA@mail.gmail.com>
Subject: [Outreachy] Introduction - Rosemary Ajayi
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git community,

My name is Rosemary Ajayi, and I=E2=80=99m an Outreachy applicant for the
December 2025 internship round.
I=E2=80=99m interested in the project =E2=80=9CRefactor in order to reduce =
Git=E2=80=99s
global state,=E2=80=9D mentored by Christian Couder and Usman Akinyemi.

I have experience with JavaScript and I=E2=80=99m currently learning C and
exploring Git internals.
I=E2=80=99m looking forward to contributing to a microproject and learning
more about the Git codebase.

Thank you for maintaining such an important project, and I=E2=80=99m excite=
d
to join this community.

Best regards,
Rosemary Ajayi
