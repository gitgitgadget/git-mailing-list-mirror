Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA4A27E7EB
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 12:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751892047; cv=none; b=XMmJCA+Nut2AsrD82O7NtR9nrZI4S2mjKaEWPyr9H2lRJcypGMeW1GvoBRfGCRj/GiO62Gpdh5N2FphvBT+tVzl0dQQg6wmh06tAA6BddLa32bKU6w/otieu5ubznIwnMnStaRHlPtCZKcqWczHfN9bpqpuVUZvVC3ceQFqpIl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751892047; c=relaxed/simple;
	bh=qe4mIc5LgrDg/YeKG8bmXbNte4E/L8haAvDOzcBX+lE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUUMXVVn0MV4BNsLA7xTtfTwlEyglE1cyRrDeRt6yf1gseI85nq01Wv7dBGc/bdj16cyrx1/ByfnGntEAC97p3GScdlck96hryJuz9wPVvC0d7X+c3wGpKduXtnX8PF3MCpQN0SfwHGNsn7Wm1azlJ4E5dyleMx7Hvs7a6+NpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTWNMTZ1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTWNMTZ1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-74b52bf417cso1877324b3a.0
        for <git@vger.kernel.org>; Mon, 07 Jul 2025 05:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751892045; x=1752496845; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXA4LhY7N0hMr1Jq1RFgk7tpwKJFJf3sKhFrExOSY1o=;
        b=NTWNMTZ1j1GNxy14mH7mN9zo9FhTI376gAPevHhah3++TQCmactqvFFFIApBIrqhgJ
         mvrhuaDZE0UzlpgOUn3igk3s0pnzim7GelDwQtUdBH6ERx5GVFbjwasCHXsD8CRQoDyM
         H0a2/7DBJuaTunI2NULkOsWSYbhol27tDnhyy4bGJgffhrLhuB8MS6OW9/U2edhHVI9e
         nGCw5wdyjpQ7Dl7/7Iy/Jti7w4E3RVAhGSjYTVnb6cZyl23PWjiqlwlvS6QVhoIuD2pw
         loFGkNxVUTxTW6p+5OYQ/3cjp5N9zb0ysXLCKJ4z4IDS8NeL6/4qla2e3iRofKi4iljZ
         XwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751892045; x=1752496845;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dXA4LhY7N0hMr1Jq1RFgk7tpwKJFJf3sKhFrExOSY1o=;
        b=kwnhXlZE2SefooRolYOuaVIguUaBAEQ2kEn5E2pQ4EfwP1Z9EXf4H4+buBw8IT8CXI
         5aPxFLWENDQVmrB+/gEWrLhOfMYxt+Gz6W6/DUMx+FMwogRMvVa4EUrw9XebWFxZxd1O
         hG2VyCMp5uLlgm2xLrUS4Wjz4R6MZ7H0S88Y/IZZqGIrANXPHPMZMqhSZaOroYGUqu9X
         Tae4HvlSPTQEu0rYqfUygRkeWvQgLlP5rjsTb8mItHbBrIpzqFk+rCVHQ5d79qZk5Try
         MoPDpcI0mX3NEs7uQhK0C8xxEhBJiQsyXipBfdDnBuvuEEWxHQAch9Ap2On2aiOLMIV7
         XFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnU+umx7nhxGlBWwt3ST0l9iTkW8yCdQWLeaol4j7toAJH/UwUlryTV+ceam8oS35ZEUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoRMbUITtz30VDH0MmHphE2yRE2s0kd+VA7/8v4EUceDshLTN
	TTQ+7ZUfTnJD/3CZICVBE4z9gFG3wx/JXpZ73g4DevD521EeyukZFqYF
X-Gm-Gg: ASbGncuRQtV0OEJoDYIC9XqnRC3Vtbtl2NfsasHTVH3xNfAe3hMmRKwfG9WrJuxKw9r
	2elO6KBjwuiBu4Vdk2c8gQ5WkAGsUVQ6yGUMgABHDR+ZGqBChtPO09tpshtskTyG6+nl7D6LDca
	4SQOtRdcaz/7l32Av/dzuzuVxmArPBUvUueWXP8RkmWYsmf2ZuzKS37hRLiiCpZhTP1qVR4TprE
	XPKaUPRFCVSx16FI9Di2LLuJHGQy5SehRVSKVsda5ev9PlXUJj7ow82LPz9ZB2fP87L/6CpgyFV
	F57bjgi6LRBY+PVruI6Axx20U8uK6TVumoAkr5Gb4uSw05vKjphEXFodSG/GC4CwNLaTm8zYx8u
	baYYnO/M5jZJf9N6dDtrLJ2Nl3v8=
X-Google-Smtp-Source: AGHT+IHW2KnWBu9GKwk6dgEP1vgeQWOreIu+Ow4E1geLov+yGyiTdjBBfmeJwLYu5PfIyR1a6/ZVrA==
X-Received: by 2002:a05:6a00:3985:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-74ce65a90e7mr18067622b3a.15.1751892045273;
        Mon, 07 Jul 2025 05:40:45 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce4299c3dsm9004895b3a.116.2025.07.07.05.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 05:40:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Drew DeVault <drew@ddevault.org>,  Aditya Garg <gargaditya08@live.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Andy Koppe
 <andy.koppe@gmail.com>,  Remo Senekowitsch <remo@buenzli.dev>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
In-Reply-To: <CAESOdVD-gWts6H-pSFBQfVn02nPBT1b0Xpfzp8Hea-QXsEA_TQ@mail.gmail.com>
	(Martin von Zweigbergk's message of "Sun, 6 Jul 2025 23:59:58 -0700")
References: <20250703113505.11889-1-drew@ddevault.org>
	<PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g>
	<xmqqfrf88s28.fsf@gitster.g>
	<CAESOdVAGEBCYOnFGUFojRk=6s=7RHc0i2jzuOVdBd91dXsCTEQ@mail.gmail.com>
	<CAESOdVD-gWts6H-pSFBQfVn02nPBT1b0Xpfzp8Hea-QXsEA_TQ@mail.gmail.com>
Date: Mon, 07 Jul 2025 05:40:43 -0700
Message-ID: <xmqqecus6uno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

>> Does this also apply to commit signatures? I just created a signed
>> commit and checked what `git format-patch` produces. I was a bit
>> surprised to see that it doesn't seem to show up anywhere. Is it not
>> supported or did I miss some flag or config?
>
> Oh, perhaps they're deliberately not included because the commit
> timestamp is not included in the patch so the signatures would be
> invalid even if the patch was applied to the right parent?

An excellent observation.

Yes, it was a deliberate design decision to omit cryptographic
signature(s) on the commit object itself, based on the assumption
that the primary motivation behind e-mailed patch workflow is to
convey the essense of the change in a readable form, while allowing
minor modifications to both proposed log message and the diff
while/before applying it, and on top of a state that is slightly
different from the state the patch was taken from.  It was out of
scope to reproduce the history bit-for-bit identically.  Besides the
author timestamp, the committer timestamp and identity (the
recipient of an e-mailed patch is likely to be different from the
sender), "git am -s --whitespace=fix" would be a common thing a
recipient would want to clean up the patch sent over the e-mail
anyway.

But with many past design decisions, the underlying assumptions are
worth reevaluating from time to time.  They may have become
outdated, or new use cases may have emerged that the tools are good
fit to support them with enhancements.

Instead of only limiting to convey the essense in a readable form,
we could also aim to support the exact bit-for-bit reproducibility
under certain conditions, e.g., the recipient has exact objects
named by the "tree" and "parent" headers in the original commit
object.  Think of it as an e-mailable bundle file whose contents can
be inspected before unbundling.

And for such a "inspectable and e-mailable bundle that can be used
to fully reproduce the state bit-for-bit", ...

>> Is it another option to put it somewhere in the body? Could we fit
>> additional headers (e.g. signatures and third-party ones) somewhere
>> between the `---` line and the additional diff? Or how about after the
>> final `--` line? I haven't checked the specification. I just saw these
>> lines in the `git format-patch` output.

... I think a far simpler and more robust approach is to dump the
whole "git cat-file commit" output somewhere in the e-mail, not
limiting ourselves to "extra" headers, in some "less susceptible to
corruption" form (e.g. base85).  The standard headers like "tree"
and "parent" are good thing to have if a new requirement is to allow
exact reproducibility when the objects the patch was based on exist,
and the raw commit message with trailing whitespaces would be needed
in a protected form as well, since e-mailed patches can lose them
during transit.

And below the three-dash line as you suggested is one good place to
keep such an extra piece of information.

Or the "cat-file commit" dump can be on an extra e-mail header.

Some e-mail environments will deliberately hide anything after the
final "-- " (signature) line, and saving a message may even lose it,
so it is not a good place to store anything that is worth feeding
"git am" with.

Thanks.
