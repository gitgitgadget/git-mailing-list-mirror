Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C372E30FC3D
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695655; cv=none; b=DGrCEdatkyUHp6e11w6hbi/Qr4PnWR3L23RInTdi1pkUgjJYbxv1C/IeFHVB6u1niPr9CzI9DIRFq0hU3cDhFr8ia6OTm2SF/87SbUtr7IAael0cK6DjF9NMnKGeIQTYDI9KeGbyiqVtt5GNttgVEwP/urPmEqKy6YXlDrdY+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695655; c=relaxed/simple;
	bh=28Ci9EuyhdOW68lNueMsqmlfsUqEfCyloQUonYZlVAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwvhmst/y2iXP4MQS3JrU2yHggARzafU9MYiKDSyjvXr+LFHAMfxSk2IrCZIw02puqy2DdFIDI048/3yBkk53dlhcgTPxnQuYTU+iRmRR0nqBp+S39tsRj4EEHOJDieRkEtR0B92oesdd70Um9t6sLhVu750nE4GN4TD28EQBQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gt4BKqH8; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt4BKqH8"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290d4d421f6so6193465ad.2
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760695653; x=1761300453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCuziooS9GFDrPD5ZnOCqpAJBUiG4mxkddnacsoh+lg=;
        b=Gt4BKqH8Pom1M5jNwuzl0Ud1X/TjKTQ592RGlwMh9KRe++a3q6Dn0OsB4sfRKOK6Vq
         EvqDJXKR3LRVjboGV/KW8Xw5U3Useku2vIwWQs5pp62avyFqUVYZfCknTm2A52Nts3hC
         uem3mdiTbmdAnt/e4bj6PjELrkSEvPqGdfxw2RDNJEFOAlK741L+NQwYEGeUw0Ee5pFj
         bAH99OJsbc49Fws3P9djUaj9VKaw02m1id4NjA7uP+xK+S++IfwO38aVglg98H/Ft70i
         UBbqvOWS0XFddlSFlWY5HHhGeOT8BEk/nBSeNfbcRrjm8bx641Tf0D/jMjtv606lWNCB
         o6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695653; x=1761300453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCuziooS9GFDrPD5ZnOCqpAJBUiG4mxkddnacsoh+lg=;
        b=MOD/WIwoKLqJ6QggyZbuUevlpxXBSionisKNItLEjjRyRF2aiEAn3MmueASV/Lj1La
         XyKljhQ6eRSNk1Su+J4ATBrqmznvF1g6IgIcDv2JijMqPayVzncF+usI8TbClrnACoMP
         5ux/bpkeAS3jnPo6uf0smFVtLVBRW0X5dXkY4ry8ISNuajTj6hv8hc5FQM+cd5/Ep+G2
         5RFGaMtDfJQc2e4JLI0N5MC3asL/+QJOIzGTGs9+tiUaD/aIEd8yhyHLZmLkgUXLc+P0
         6GYmggyRLiKMHBJT1O0zRYJMoC5u2/wuNiDHPMBPE+eZARsy1/40dzuMstJY6lsv5Gku
         2Nhg==
X-Forwarded-Encrypted: i=1; AJvYcCWMVcMyP7fiYTIxzM6MahwfgVUBMzoQ4NiB9pYoJ2Qfq3PYMo7XSLz+iQOIQLMuWt6Qh5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQFHmTeszTk2yBPWBZ+0pOnAr+uxefs/nIdrfJs8ulJkVd6ETQ
	CsBLC5y9gq0MgbcrTXwfTRKrS9quaLPfhu9l1AHj+y6Y8PkRlUAa8lTTm5lY/aTFdE7tADAJh2d
	xFg8NnU3JJB2GmQ8UfHGVhNCW9P4345g=
X-Gm-Gg: ASbGncseVuuGY3WbyQMsbREye+7w2y6uVwgdP6jmhjiSQ+SuYfNQGQ2vP3xC2mIBLDK
	2a1rZ14dBjLrPzx0nhdcQYq+PGYsY28AHQKo0dIPZLLY0RZFIoarbrEfRvsJVqCT9sfrdBXOFd4
	1u1WCd6VDUxsBXxPSNNy9gNgq01owZQzlts54AexKyHQCnQkqWO/vHHCPzAaKM8M+LycsfF6GKn
	hxRx1fKU5eHWsV62/UvqbbBSBcR4DiXr4nMYX+4fx0SF97eohnRusXl0xNripk9iBH0ROqzMQlV
X-Google-Smtp-Source: AGHT+IGXDZvSodRtzb0PlrE28G75SzEPCOkVn7BzfOj90fIpDx7CbUGRU/eEHGqYM31AxOCun+MnsPQKMxhxs5tiXI8=
X-Received: by 2002:a17:902:d4ca:b0:275:b1cf:6dd7 with SMTP id
 d9443c01a7336-290caf844e8mr42679155ad.34.1760695653021; Fri, 17 Oct 2025
 03:07:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760571220.git.belkid98@gmail.com> <818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
 <xmqqms5q4v0r.fsf@gitster.g> <CAP8UFD1FMwrBxbZ6Ck8JwBPBOAhB039US6pHSTusb6qzW=crpg@mail.gmail.com>
In-Reply-To: <CAP8UFD1FMwrBxbZ6Ck8JwBPBOAhB039US6pHSTusb6qzW=crpg@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Fri, 17 Oct 2025 11:07:34 +0100
X-Gm-Features: AS18NWD_vZt1j1aPFf_XHhZ1uzpDoSBD7MTxxEPajJ0n16ZzYQRri5vnEwzSnUo
Message-ID: <CAD=f0L-EEWe7T72iXwA26N_7rA4gaBktzxJPzCku1s8UCj=bwg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/2] gpg-interface: replace
 strbuf_split_max() with string_list_split()
To: Christian Couder <christian.couder@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Oct 2025 at 10:15, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Thu, Oct 16, 2025 at 7:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> >
> > Olamide Caleb Bello <belkid98@gmail.com> writes:
> >
> > > @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *=
signing_key)
> > >       struct child_process ssh_keygen =3D CHILD_PROCESS_INIT;
> > >       int ret =3D -1;
> > >       struct strbuf fingerprint_stdout =3D STRBUF_INIT;
> > > -     struct strbuf **fingerprint;
> > > +     struct string_list split =3D STRING_LIST_INIT_DUP;
> > >       char *fingerprint_ret;
> > >       const char *literal_key =3D NULL;
> > >
> > > @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char=
 *signing_key)
> > >               die_errno(_("failed to get the ssh fingerprint for key =
'%s'"),
> > >                         signing_key);
> > >
> > > -     fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > > -     if (!fingerprint[1])
> > > +     if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) !=
=3D 3)
> >
> > The original splits the thing into upto 3 pieces, but only complains
> > if the second piece is NULL (i.e. we said "up to 3", but there was
> > not even one place to split, and the request to split_max gave the
> > one thing as one piece).  IOW, the original code will happily accept
> > if the finterprint_stdout is split only into two, not three.
> >
> > The updated code asks to split at at most two places (yes, it is a
> > confusing API, but if you split at two places, you will end up with
> > three pieces), and insists that the split results in three pieces.
> >
> > So the rewrite tightens the error condition.
> >
> > Was the original code too loose in detecting an error, and does this
> > patch tightens the condition "while at it"?  Or was the original
> > code correct to expect that there are legitimate cases where the
> > payload in finterprint_stdout only contains two pieces, and it was
> > the right thing to do to accept when fingerprint[1] is not NULL but
> > fingerprint[2] is NULL?
> >
> > This is a genuine question.  I haven't studied the code path to
> > reach this point in the code flow, I don't know what the data in
> > fingerprint_stdout is supposed to look like, so I do not know the
> > answer to the question (in other words, it cannot be an oblique way
> > to point out that the updated code is wrong or anything like that).
>
> Yeah, I think the problem is that the commit message should explain
> how this whole issue is dealt with. Currently it talks about passing
> "2" to string_list_split() instead of passing "3" to
> strbuf_split_max(), but it says nothing about dealing with the return
> value from string_list_split().

Yes, I will add this to the commit message too.
>
> It seems to me that fingerprint_stdout should contain something like:
>
> 4096 SHA256:PelI2esT2xZlv20wJJyYOkQsli5RMK79oJ2VxqYb2PA
> christian.couder@gmail.com (RSA)
>
> and it looks like the 'key_size fingerprint_hash:fingerprint comment
> (key_type)' format is the standard `ssh-keygen -l` output.
>
> So I think it's safe to say that we should expect
> `string_list_split(..., 2)` to return 3. That should work even if
> there is no comment in the key file.

Yes, in this case fingerprint_stdout will contain something like:

2048 SHA256:BoQYpZX7zNZFOc9BSprkHoIgPhMTT1D5d5tqbwXZ1hA
no comment (RSA)
>
> But on the other hand, I think it's also acceptable to say that we
> just want to keep the same behavior as the original code and check its
> return value with `> 1` since we only need the second element
> resulting from the split.

Okay this is noted.
Thank you.

Bello
