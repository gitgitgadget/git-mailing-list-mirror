Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5933D6E7
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964642; cv=none; b=KzvpKgfslh2hKPS4IqIIlaAo8td9s35HzLkyhRox0uKDvrU6mnhpxE4QctqKdvpxZWcveAm6p6qv3rnVQW+ldPTlUrT3zIsHfn5algYC4Uk+SuiBd5kWp68KuBznMMEiC/2O65sgQtbWLeh3ePOmuuxywzBjBeTB+t99Nl3uBPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964642; c=relaxed/simple;
	bh=6K5VwqhaoDTS11+1pLD5KGRppVFkCsH3cnBsxKEqt1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWK0xHo11BMJImT/eH0M66xhprRD1NIKlPsoRhSW0qc0TkbT539x1Tr87lXkcGz8dV0IWBoK6gx2Ca8ezlVCUw0lBSnZRFNC+Sy8CmP2IBdApELQ/mUDkn5WhjqIjcgKLd0yFH0+GTbobx6ih/aaVezBUjjytwg/+HHxtlXNAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee4nBRQO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee4nBRQO"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so207736966b.0
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762964639; x=1763569439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmpwNMVEgHnaW8ljIB8RdNDRBiGRPt9LrE4ULeKWQbY=;
        b=Ee4nBRQOaR0Ya8zczJyGtFOEV2M1exxgJI22iHzjKbmWB49M2gHHqIzvyKE7sBwln/
         MhotvlBkeicWCPIdICqRUTrIF6ldYnq2h+ScVdtVEwfNnWp0WnyeOKBabnjS/B98NPCr
         MYsr0WbZkpQ6iQITGxaQEChRBnypwp5xi0M0+61e3bw/JUohuMoKasqRLcPnYdsuGVx8
         w1HXITa1tKswKtyZn4mFVWcsuMpWODXkOElJsOST8qbHl9U4s9jVkVQTZkIbuqIGR31H
         HrCtRlYpuyHmZZJmpYGttVfHDM9HunMT6Bo1U/AhzdJxyzrjy9APRDWqHWwhWfgh+Ui0
         ipgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762964639; x=1763569439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fmpwNMVEgHnaW8ljIB8RdNDRBiGRPt9LrE4ULeKWQbY=;
        b=GzaW51tyzBsVaHZyLyp5ThqghjUv/ubbkQagyiaHLHyI9aY4fU8SPpggjFVg2ZIur7
         VopdpBlEWqcEtVEjrdY2pBsq9cT08NNbjsHeNVrJLiXEyb+S19K7Z0r6hbN4MHTmhSBF
         L3W/N3MpTaEpoDVAoce9wPIJd5wkinjsUPVcx673xBQGmhygFHFcXG0sPfLVehSPoOUm
         iIsJdddJofu1cdKVD9lEqnKwXsFq7NethpRSxehdDW6RXv/PIZnVBrje9LHWkg3TNtZe
         kAhOUKEYRKbRdqL7asb6GpCvkIcXfX6aDRM2pR5MYQe2ccMENMws9/sCCcGkiP1MYye6
         oZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWu8oMqAYgzC3kn7jBCvq/78WSa+ZSxboonzzK56hWuG7eSXkFJUk47/tcOm7GexwefAmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTgyPSzGtuvw93AQWZsoHIj1bPwHphKtV/2ooEEaJymmPcPEc
	DFBeGxlOk8BgReYYo22wpKbLlxOoae60WjAk1RXQ6+Vs6Zecb/cW/5Uz64YYbVDankx0rC38bV9
	954EMleHmJPY6grhFWz3pebpheh1vYZQ=
X-Gm-Gg: ASbGncuM5xiRmmo9E1ikmRP3D68ZrFGHTNSLHq3I04IlkcknZz3gvl+ZMoLZmqICYvQ
	NDV4m4GjUL5gD6JbhWJcuiVrCpyXZUm6OcrX028VEw6JfEVusfUmrpv9fEvg3XRFZoZC8vZ05b+
	ZSYPOiiXtlbYDAJUc9iYXcU6eT6AwaCjqw5eZjyOd6RlHfBMdVBdTT61im4YtNq5RRktknWZNRS
	a/O590BDC/TdFJhGm2Mactan5dvMpWiARIn2EupdVG4hLdKOCAdP35G1KQEMRUOLOu3qyRpk3Ig
	fRFaDAFpJjK+
X-Google-Smtp-Source: AGHT+IGqyMjie4GL8Xz8mHCywJxM469XsbvSNXIJSrw8EKhwKAF61EDziMznYKUFyZIF6zTYVck6GVbXoYpJcCXU95M=
X-Received: by 2002:a17:907:94c5:b0:b71:88eb:e60c with SMTP id
 a640c23a62f3a-b7331ac02eamr409155266b.44.1762964638568; Wed, 12 Nov 2025
 08:23:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com> <xmqqo6p9zo8f.fsf@gitster.g>
 <CAOLTT8SDpVfk8XqOJDL1=ASJwLf8EYtCo05NS3M2zZUx9JV6fA@mail.gmail.com> <xmqq7bvwy3vi.fsf@gitster.g>
In-Reply-To: <xmqq7bvwy3vi.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:23:47 +0800
X-Gm-Features: AWmQ_bkSyXLMlJeS3qOnMm2QZ8f0TrQ5CMFTKB8XjcVkBXnblhYZY9lJehD3IwM
Message-ID: <CAOLTT8SN1xHvCCCo7b_RqMqQ9TGZR5=0SJnoe0uQ-Zv4-4V=1g@mail.gmail.com>
Subject: Re: [PATCH v2] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=8C 23:40=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=BA=8C 03:22=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> >> > Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
> >>
> >> What is this second author and how would its presence in the author
> >> list interact with your DCO obligation?
> >>
> >> How did you make sure that whatever is in this patch were not copied
> >> by the "agent" from somewhere that we cannot copy the code from
> >> before deciding to send this patch?  The "cannot copy from" may come
> >> in different shapes, from "their code is proprietary" to "their
> >> licensing terms are not compatible with GPLv2" to "they welcome us
> >> borrowing but we must give credit to them", any of which we should
> >> be careful to avoid.
> >>
> >>
> >
> > This was automatically added by some code assistance tools.
> > I indeed forgot to consider its impact on the open source license.
> > I'll remove it right away.
>
> Please don't silently remove it without answering the question you
> were asked.  "The tool adds it but I disabled the agentic features
> of the tool and everything readers see in the submitted patch was
> what I typed, with no agent input" would be a perfect answer.  "I
> did not consider the ramifications of use of the agentic tool, and I
> do not know where the code the tool added for me came from, so I
> cannot be sure I can contribute this patch to the project" would be
> a sad but may be an honest answer.  "I cannot tell the origin but I
> can remove the line and claim I wrote everything myself" is not an
> answer that we want to see.  I am sure that your answer would fall
> within the spectrum, and am hoping it would be the earlier, perfect
> one, or one close to it, but we need to hear it.
>

Ha, I think my situation is closer to the second case, but I'm certain
that identical code cannot be found on GitHub or any other platform.
Moreover, this code is entirely modeled after Git's own code
(e.g., determine_identity is based on determine_author_info). There's
no possibility of copying code from other projects with licenses
incompatible with Git. However, your reminder is valid, especially
in this era where AI Agents are heavily infiltrating development.
Any similar open-source contributions in the future will need to
pay attention to this point.

> Thanks.
