Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FD202F9C
	for <git@vger.kernel.org>; Mon, 26 May 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267790; cv=none; b=O8UXvRbbFQ/rkKxpavUWZeDSsvjhHG/UxdmukLunlJMRaZlCvKt8akQjHU3NyqhUXd5RNzT4uaZ3uNVLT9aq9DbYqnRh0uaVycmWbbLDcjKL2vBef2kiOMyieqqTaMIr9dfrAIJDGeGo0JrDVkota0rJqhGKcwQ+Fb4bgoYiD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267790; c=relaxed/simple;
	bh=oPslPCLPO+KJq7VNCQPSZWLNTsvNuCEmf2Xs7g6GGAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tea2si6CTLy7QKS5AvGvoY5xhGxo3ry+JWh0vLneqMAOanmL/16a1muWRrkUdbSZlKbDRzUkGdYmIV8iRfjRiV9zBKnVxzAGIk9VwIJrB+/E/A4Kv+Jz3EHeRACpnqidjzZlbYkP98nZnMkLCpy+g9MIEl88E64Nu0pvds9suy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqzGKnVi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqzGKnVi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748267787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJm3mUqS9UQwVZF2e8oYp6T+FBZoxa3Cr20XyCWdS1U=;
	b=XqzGKnViuQFDEc0Uhnwg8blSk4xnHnMLL9RAfQftEkNJmq1bSteHlHL3ECU9J9RQW+L+Zb
	EREt1lqcKxZPOcdDQl/DqT+NATdH2k+1+RkAMif7QMdkEywQS/VTBfaU0NUTf1JaFXuHqo
	dkNrLXyG6dO/PTXTCafWVN9gJzMpvi4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-uOTZAUzVM32sbXpa88cJEQ-1; Mon, 26 May 2025 09:56:26 -0400
X-MC-Unique: uOTZAUzVM32sbXpa88cJEQ-1
X-Mimecast-MFC-AGG-ID: uOTZAUzVM32sbXpa88cJEQ_1748267785
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-601df3b434cso2846954a12.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 06:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267785; x=1748872585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJm3mUqS9UQwVZF2e8oYp6T+FBZoxa3Cr20XyCWdS1U=;
        b=OH/0p76nBABSD7oxyTY9lWU/u00rHNyjyTobVqiPHzjuS7gIAkbAW4n4wsu/Dd6qoH
         S2oUPSv+mAAyCVujQTO72HZhZz/xCaZoPFN/R2MmTNwGOFIChp00J2SymXQqt564UJGB
         gsBVPbRFDWN9kp7PQVVppdnMqn1E5EK6lVKQcSs3vAsGM6SLmHL48oJHCIX8CS2R36z0
         vo9tJGDQbpkt5Vu2rIDiBcBgBtBZ69bjzg8ftsQj2dQMmayX89sQOgKGckn11oiH7j46
         37/TRFyvCuG/yT+nmIVzkJ56QNcV9mSbxCOZweZirGdKvf1YkDROo14HJPptH8ENxApi
         erZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpHxaeFQbhIt8jvMIiGs7O9BPm9ZGAGZtgFC6V7E8Lv+Z43lqa8mKvItOpBV0kEzfw0rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlkYiaKlPvL8FTXR9rebnuv4g/uBMSUi+EqTAGc1bSSrbaQs1Z
	yk/B0HybBBGjkXsFZCftiTMrLygv350TwVbLKnZqKC/RnlDkEmygvbcQFaxjmbk7C2x0qRQk5r2
	1cDF3aEEvzUkV3p9cFU7B3svKlkr6y1g4J6qrhAnPMSJhMPw8zJ/5sje6NVoUtx4tPMJ/Xs/vex
	XgsLyC4sGg0sODxxKCUn3fwU2BEI1s
X-Gm-Gg: ASbGnctJIPdXzBPZxu6YKNQWUnzBk64Cqii0JFLkTiPx6WDRx+dUpBtHgKHMeQ/IoP/
	By7m7VJ3O8Xv5UqhfHaUylzeRllDiECmsyA0c+jYk3+VkYEoOrRBQLzp64/+EOFZVrCFU2XQqBj
	we0jqSsZOCW96G6iE7AksGP5/zG7o=
X-Received: by 2002:a17:907:6d04:b0:ad5:1b14:15f4 with SMTP id a640c23a62f3a-ad859b536b7mr782314866b.25.1748267785201;
        Mon, 26 May 2025 06:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY4ThWET2xanxUl4VPhQLtMlWMz/lPwppDgf71V8sB1dLXF/CIB09fctr1GbiqrFSEk7zjZUNdbHNRJqIDz/E=
X-Received: by 2002:a17:907:6d04:b0:ad5:1b14:15f4 with SMTP id
 a640c23a62f3a-ad859b536b7mr782312666b.25.1748267784832; Mon, 26 May 2025
 06:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com> <xmqqh61ear4s.fsf@gitster.g>
 <xmqq1pshc2vs.fsf@gitster.g> <CA+B51BGLK-3R9ev4a8EwkGHQEBi2QhgxvAd0CHMbphrxPM74eg@mail.gmail.com>
 <xmqq7c287i7n.fsf@gitster.g> <20250522170536.GB1613@coredump.intra.peff.net>
 <aC9lM12GyntAp2tR@teonanacatl.net> <xmqqtt5c5viq.fsf@gitster.g>
 <aC_90R3ohRRBVIV7@comcast.net> <xmqqwma7z5th.fsf@gitster.g>
In-Reply-To: <xmqqwma7z5th.fsf@gitster.g>
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Mon, 26 May 2025 15:56:13 +0200
X-Gm-Features: AX0GCFu1esnuvQkzrOHbaQeCPGiKubat4ul_j39QGGyeYRGUNuOhoNlrb0RkW0Y
Message-ID: <CA+B51BFJ9abjP5pDYwV1-mHpwg_n-jjz4_YX+nm9wOYF4nKuGQ@mail.gmail.com>
Subject: Re: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
To: Junio C Hamano <gitster@pobox.com>
Cc: Matthew Ogilvie <mmogilvi+git@zoho.com>, Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>, 
	=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've just submitted v4, which removes the 'escapeRefName' function, so
we avoid the warnings and test failures when we build with new Perl
releases.
I think the next step would be to remove whole git-cvsserver as was
said earlier. I'll take a look what it is going to take and submit a
patch with the removal later, if that's ok


On Fri, May 23, 2025 at 5:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Matthew Ogilvie <mmogilvi+git@zoho.com> writes:
>
> > However, despite writing and (incompletely) testing this code, I
> > have never *really* used it, and probably never will.  So I'm not
> > in a hurry to try to test or fix it further...
> >
> > (For that matter, has anyone ever heard of anyone actually using
> > git-cvsserver at all?  I think I would be surprised if there was anyone
> > using it, especially so many years after CVS stopped being maintained
> > at all.)
>
> ;-)
>


--=20

Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

