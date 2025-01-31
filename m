Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59838DD3
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307124; cv=none; b=mB/gkQSUPUar3/502kGYvV+Ekmdprd99CLyxBTkyHlomD9MJi8/6ns5nk54Ru8r1OEy3pTFyY53bWnWy0HGpZ0+EGEl/F9CJNy//Qi5NWL0eHfIL3kI1KuHNsucIV+wj4Ww2FY2Wt82eyRql9i55+c3fuhKAR5KOdtqFuEb1Qww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307124; c=relaxed/simple;
	bh=3hBA1BVc9vj0I/GtTrmOCZeKC3RzgpmIRo+NKbiElhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM1RZ4SqnvsA3TN7W1TMtC6i0Ks/GTEXMPIt+OS7HRV73uNPY0r8tuObtmtBbB5Ifrn8c5kywZci7OgZFRWX9QrVEWv0Bsc1bpU8RQllQC7LGU2mSP68uz8uotTSDLetsdjZZFcTSHbgv0EWDdpAxN2Q6JD3ZaA1XjEcHh7eBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com; spf=pass smtp.mailfrom=shopify.com; dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b=V8nVqCjf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shopify.com header.i=@shopify.com header.b="V8nVqCjf"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5f2dff625c2so44632eaf.0
        for <git@vger.kernel.org>; Thu, 30 Jan 2025 23:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopify.com; s=google; t=1738307120; x=1738911920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hBA1BVc9vj0I/GtTrmOCZeKC3RzgpmIRo+NKbiElhE=;
        b=V8nVqCjfP4/V5RreVag4sHphL31OqUKyJL6UFqb29ITVhMwAVBDUdi+ZjwQscDKO25
         oyzmcFSwMrAiOZeiM9SkUx4dYZQLt98H8c9jIwfL5A8uDrS0iw+YUmWmzozeslpl45Ry
         ZBqT1Gl+1vG8I0Yl80k40vOt6LP2W8UkGH9+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738307120; x=1738911920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hBA1BVc9vj0I/GtTrmOCZeKC3RzgpmIRo+NKbiElhE=;
        b=ngHC5wZKMP65nZkBgTj/yqHVzVLduXf4UCula0W55s91vUL6UQCL0aS21Yz+BPh7M+
         ztbZsSxpCq8ocXre8S9aS9HdUe3gijTsa96JAC0iSk3jgVNL0gURJHoJQCIqNlpUqSUW
         8zIU+9QGRLkiEyw1c5jvLad3mRCL3eVaJFLDLV1Q27VtnX00VZpQaOdl5lYTJc9Hcl/j
         QsiiE3qJU8zl+S9hq/QXaf4XUUj+sCv6C5TvJ6NPK421YVwmXjhC2rQ+qvhmpMsQ66sV
         fu/OIUNQOJ/+Jg60VYHYiYFQXe658paclgRWqn3xpcA0LxSfF5eKpcEh4JRYxg7FdyQ+
         uNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCTDiHzK475tNu/hLCOHrOeGVj2b0IZBWVJhB7lBKB2ltZ6xMmKePoKiOsi5qMOGrjpak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw767Z+cHLqB/dDMiTli20a9n6ZsNGsYoonVm7VR5+Ibm24/N1U
	GK/krn1xWEJZ2YJRtikrq1GCrhfS6Lhh/ak8jf/MZkccKWTHIJE/XQdYo8pCEqkg+K5dbCBg4D/
	f9acA8sIH2otC6qIK8U5rIofbYXm/g3TzCqrzPQ==
X-Gm-Gg: ASbGncu07fGr5XG7Z2QxSFbXsbDl5rwV0ajyBV4ZKMy6ZTC0kwdmxbxNebflokV+LvE
	8yAkGe6+Hjg6Yw68dvRmSQVJqaxUVAQbS1zMPOSdEYem+2mH79i8RmJsViRVCAIlaBWWdjDVDvw
	6qou3krPMM9BdyUxyXVGTtCwKEdL+umg==
X-Google-Smtp-Source: AGHT+IGDPET2tphLDibZmiqNnSESLXMyXwsmmyT+Fp+xkwpXpMRB5ixsNuGCxb1mTvGmkXkV9o4u8BydPaSqiEvfo8A=
X-Received: by 2002:a4a:d0a2:0:b0:5f2:37de:5808 with SMTP id
 006d021491bc7-5fc000e7e12mr2065300eaf.0.1738307120545; Thu, 30 Jan 2025
 23:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1829.git.1731653548549.gitgitgadget@gmail.com>
 <pull.1829.v2.git.1737063335673.gitgitgadget@gmail.com> <CAPig+cRpKKpVHT8x6nOx1KNjWR=hywz-nHZga9fhiXMXD7KOSw@mail.gmail.com>
 <116C27A8-EF7B-42E1-9606-815FDA3CF94C@shopify.com> <CAPig+cSdbjzTmsBOmFnMxzYLGrUzY46=mkW9S+si2KxLhS623Q@mail.gmail.com>
 <F15C12AB-2238-4553-AFA5-18277B18CE5A@shopify.com> <CAPig+cTHfD1fK73+S3fqQ+Oz_VpBzap5=nFFE1bntSeaHLcu8g@mail.gmail.com>
 <CAPig+cRv9Z2mQ964PNgbbgk+ByGvC1EMNc6=-itD_7v6_4Pg+A@mail.gmail.com>
In-Reply-To: <CAPig+cRv9Z2mQ964PNgbbgk+ByGvC1EMNc6=-itD_7v6_4Pg+A@mail.gmail.com>
From: Olga Pilipenco <olga.pilipenco@shopify.com>
Date: Fri, 31 Jan 2025 00:05:09 -0700
X-Gm-Features: AWEUYZkJAp6vOQ8dKwAFEI76QFXIkncgm3nnrHVV_0yCoUwsiTsTxkutC0dleQE
Message-ID: <CAFLeGL5L=Pv4RH7-7Os+khewvtxHDTX+a4hmmORz=b_e-1FLoQ@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: detect from secondary worktree if main
 worktree is bare
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Olga Pilipenco via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 7:44=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
>
> On Thu, Jan 30, 2025 at 9:32=E2=80=AFAM Eric Sunshine <sunshine@sunshinec=
o.com> wrote:
> > (By the way, when replying, please use the normal ">", "> >", "> > >"
> > markers to signify quoted portions of earlier messages in the thread
> > rather than using only indentation. The reason I make this request is
> > that when I replied to your message, my mailer stripped away all
> > indentation from your message, leaving all earlier quoted portions
> > flush with the left margin, which made it very difficult to figure out
> > which quotes came from which authors from which earlier messages, and
> > I ended up having to reinsert the "> >" markers manually to restore
> > structure to my reply.)
>
> Examining more closely, I see that your message was in fact multipart
> MIME with an HTML portion which was using <blockquote> and whatnot,
> which my (plain text) mailer stripped out, hence lost all formatting.
> If you can configure your mailer to send plain text and use the normal
> ">" markers, that would be generally helpful on this list.

Ufff, my bad, sorry about that (should be plain text now).
I'm having trouble responding to my previous email and keeping that
quoting format,
so I'll not waste time on trying to fix that (please forgive me, everyone).
Just want to let you know that I agree with your response, I'll adjust my p=
atch.
Enough talking, let's get the code out!
