Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518E23EAB8
	for <git@vger.kernel.org>; Sat, 25 Oct 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761399738; cv=none; b=UQxVRJgIiuBrApwkdByFek15iU9vCD84g3W8d6U1I6nVysqMcvxmhdL9bpgHQLBnhNb4VsEsvcR4FvU6kN8lJUOxIyFj5GcfcKMJi6kBjBJtOZ8zcY4NqimSkDwM3mTSrlqUH3vA/amPUbDy6d/L/STYZijFmWrqULzaQ5AI1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761399738; c=relaxed/simple;
	bh=u3AXPqJt8dl/vw8z26bkP+NqUnEBPGU1nQHC6hgyq10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYNX8da3foeekWwu0pZLZ1Xnq9r1lRGwHix1ph0p5jCXqvtTtdV5A0OOHShbNGak/KyBgDVUfFG/aad0uPfbzaKO+bB1gLloE+rbmzrFcFGn4n+aH7Bmt/6o+3gO3dH1SILOC56ig3Xvn+QmyKMKrWyr1YYQC+dFAEsGj31NSvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F00pcJqz; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F00pcJqz"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so322859266b.0
        for <git@vger.kernel.org>; Sat, 25 Oct 2025 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761399735; x=1762004535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COmSLcDHAJ9dNH7ueRLKTIli0vhQunD1X4EiEEqY95Y=;
        b=F00pcJqzmGo6J3tKGW1cT/OiWHvQLricvmrJQ7xNg3gV8C2YFS7F7MoK6kYXcfF5+g
         peTcpmnhcXDSQHr/KmNeQBi9AOLNF9GIlY2Smj0uVTVcWWCgO6iDpKU14swQVIpiKaSr
         WNeNB/sBO5j4OSLJflVbEDpjAvHEdo/0y/IE4ijzIvZAutBsdJNaZdLvxhFWIzd4Q+oW
         2Tyt0wiNC++SVY8wy15UoHo22eWyADLoZLGV44MKCm8EuhcqIFn9PnAglfvU0ZMfB0AD
         /ujw0LBGofD5xdxxb8oF63UtTvLixkkhJ9DMj9A3avdyBJoUR/ZjAX1QFRePgVawa9Xw
         eFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761399735; x=1762004535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COmSLcDHAJ9dNH7ueRLKTIli0vhQunD1X4EiEEqY95Y=;
        b=CSUQJcdh3oThzpUJGaOilNCu5PI23yGb64dtlnuDPaOdUSChCuHups9KoMsAum5Mo7
         +cUMM22IXKeCVvIyEKu8mtGXpVMQISfNk1/01IQBXztboitQpCLYw6gCmyHHEi9YtpDf
         WUl4iP7op2WXQF6VKAZ5FHN+jDCNmFMe1facM7RkXs1V5bWC+W3lBswmxlUZkqH8cyh0
         O8lTSw9XOnqfCzDNnitvgDapaym9L7qe0uMPk0tvGCNmW/DzBK+wEyZrYl9FXxPJFYs+
         kW5tvljAZuBJBnENO3HXADIIjZ6ZiOEJch78UDxJAg4AnS+gvrZx9ACgJOSvIkE65JRA
         e/pQ==
X-Gm-Message-State: AOJu0YwXofd0nTXal5dz+bdZo3dFQCaTciOhNamDlc903K7s5OSSGD0o
	UzfhzSsQo+pmhe4Ez+krInRnIb3CcUCRxI938knVL3/B3NaAO4bqNKV+HS+WUyoPD/x95dPcZ6B
	TmlfHLbTsw7Ro0KoMDZe/GwtmqUV3j/KOiA==
X-Gm-Gg: ASbGncslqn4EsjHJgDER4E1OXtt5S12bkgw4CP+jN2zfTRMUgwlC4Rx+beg3UV+QM+l
	Cqss0wB3BzjYr96EKbCgGnameGUnJRMPxjKhtsOr8iWA2MuQk1f0tva882JamZiFSpTOTfxYc7o
	WY1HHI9bTRUrlLkOcCNapoDxfVE5PJVJMoZzlz7sbkO6tKp266nyCG/NmKG5zd/5xbINtN6VG8g
	vEobHOIOlnhW9GwqTQfAO6IHiGHvn63GW1Vmgh5aes8Q3CSXXq4Mqcot5S/5Zpt5k9BZQ==
X-Google-Smtp-Source: AGHT+IG77aSFQNCUyIylu6twVNrdN7VwmlP1gzPcGHZYWpmZDHcnN/7Ea0wEq64SMmRjeO2ZrV2PaJUYzXlKA9L5XaU=
X-Received: by 2002:a17:906:fe46:b0:b04:830f:822d with SMTP id
 a640c23a62f3a-b6475708ebdmr225871566b.63.1761399734901; Sat, 25 Oct 2025
 06:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
In-Reply-To: <KL1PR03MB5748DE5406618053D0A6CE0AEBF1A@KL1PR03MB5748.apcprd03.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 25 Oct 2025 09:42:03 -0400
X-Gm-Features: AWmQ_bnRAee9kQ6q7UgSdRpXvu1VWeiHc5WgLYyA8ZDXrlvf8SR_dmS6ZcvvYks
Message-ID: <CALnO6CBLUGgBMeRf0uLA=TKVaMQvap9Wpa4uTAGQD5he40xeWw@mail.gmail.com>
Subject: Re: git log format documentation/manpage
To: David Moberg <David.Moberg@mediatek.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:07=E2=80=AFAM David Moberg <David.Moberg@mediatek=
.com> wrote:
>
> Hi I'm trying to replicate the "oneline" log format and add notes to it. =
What I can't figure out:
>
> 1. What is the format string that corresponds to pretty format "oneline"?
> 2. What is the placeholder for the title-line? By searching for "title-li=
ne" in `man git log` I couldn't find anything. Surely this is in here somew=
here?
>    Searching for `full-commit-message` also left me empty-handed.
> 3. How can I display notes (%N from `git notes add`) as in-line informati=
on (stripping away newlines at the end)?
>
> How do I figure out the placeholders?
>
> Suggestion for manpage improvements:
> 1. the pretty formats (oneline, short, ...) should come with a (t)format =
string that it corresponds to. They will act as great examples.
> 2. Make sure the descriptions of the pretty formats ("<title-line>", "<fu=
ll-commit-message>", ...) are searchable.
>
> Kind Regards,
> David, kaddkaka, Moberg

I don't have the answer to everything, but for your goal, does
`--oneline --notes` not give you something close enough?

Since notes can be arbitrary text, making them "inline" with the
oneline format seems like an uphill battle to me.

--=20
D. Ben Knoble
