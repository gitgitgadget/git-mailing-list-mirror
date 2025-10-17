Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D8321D3D9
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692555; cv=none; b=epJNS0T7+tuKYDHoj+EgFb+HDNfyVLWSPeLC8+YocouWxfdHam8DEAWyqlXat6SGcj+tcKAvyQTE/7dzbze8CseS9puU7AVYdfGL+ZzhdCrr3nJAD+8YQNyUhpzAAubvjyfRT7sF34FiluE+SEFQBt7Qgpp1fJRzhQoNiQBL3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692555; c=relaxed/simple;
	bh=Os5CThaSk1ycuCaA9FgY9f6ut27zmQiwD52CioojwBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4EsnG/VTC8+ohwE6Yqe8p4q3B6gf8JKwpHWdbWcRfbbxe8x/lh7L2i2/W/LdRhrwzlB20NubsJh9P7kT4YRGIeDg0Ci+sWT/GL0UbRa1YOJqUVyWfoK8EIPrKs7/eLF+X7b3lwbsKO9DxM4wjUAGPe2hU0vq2UuR1OQr/NkURs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7vpj94+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7vpj94+"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso2189780a12.0
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760692551; x=1761297351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTIQmvF7JZyZmqmA1nJKQmBQhUBRZ+hrC+nfWBAeYus=;
        b=K7vpj94+GOMsLlZ54DZ0JNnu5SSvwH96yJzM7kF4N1/XMcDBEln7g+sGkd1jMJjC69
         2iG8SDpBAv3IOPO6wKjYig4iCy3K/UgVNUGwiL+zmYpOu8LN7kSE47Eu4qMG806ynjEM
         aa812aj3qNeuwRaKCXG+qacaRVV4wO6tC4RKjvSzsEvdsADJqne3xE+8gUCtCPLeMU7p
         TQsTsYpQBZirucPnmZFr7+29eJjVI6SkYBCPv0ZkRkH8diKd+2ybuKsAS5dlvJqEASmX
         l+iRiizYRlrf71Kzu6/gI3jtQC+bqpJlzyjirBGzggy5tCkJBA8RMBlI0C0mbn9Lrd4G
         bY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760692551; x=1761297351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTIQmvF7JZyZmqmA1nJKQmBQhUBRZ+hrC+nfWBAeYus=;
        b=TXMtf5TKNBcK3vDjU8MDOjJx1NpFdJOVC3NodXfRLXhh7mPk86WcOTfjJwOpMrRjb5
         66QJQ05ZzCAIgow6l9Ge19dJc1dZX7Pu9u08B4xndxv77FKo67D/aJkiKtU+/FcekAyv
         B9eo4GkF6FE5P9dQ9nXgr8gUFyCPC6hofKFoeagb4XGxjHMbducU90fmV+Pj1OZhu+h9
         TPfJ6QUoyd5K0hqMQmuTsFJcVW73ci1iSRdPiNyKTg3yxn2QrLHycIauDtT2m0lzWGD2
         FU/O9528fk3VrqJBuXZHEkbri3IKJB419TP+vgAXjL+caKqBs8ME0r9nbWSr6GUhZneC
         1hLg==
X-Forwarded-Encrypted: i=1; AJvYcCXUNfHJpcEbMCh22lLEctyjWKaKc2QaG0mkpQZd3rZWmvfXQ03eIv4zH/lLpmOGtQCAGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykR22HSE2zleTrOZp7hgP/JsZo0Wrdoc49Wnw3jOfFf/vO5va0
	e9Yv2KKaJkBLWT4V5boM0iUCByaLgyEtE3Tw3PZ2jdJLU+XYr5tKhy9Qdts7WrrQjy/dU+RE7ae
	13QdN731mXrrnBRpinlJkvG2EOxw4Wzw=
X-Gm-Gg: ASbGncslHeivPsUJZy1lk2yX3cJcQzd19Gga6Oil07ywWn8zFe6Co8m/9RKFlBENYju
	N2m8iTEzusEL2Dqf09LlTTLr5GiA5wpcQfsIfgoLA8buXm839KBXH3TTx8RC007CWvkoH2E/6AK
	NqvJfPVAA/JVmQt9cjT5QIZaGS/kmyA+eutQlieGOcW5YxKxJcE9aVyXecn5j399oMg1GYDjrNz
	uS+TLsdnKADOJIb25rdO/w6vB5xzA+9233M2tGMy2ZIOGL1+hqa4+TOylb/
X-Google-Smtp-Source: AGHT+IHuhTJasTd+oqEOCOuzuF+CXWRRlh+XOdy4nnNkZzn9CoNlqSjbm2fVgE0mF5OOEalqb9UYmFdM9PLa7ToMXig=
X-Received: by 2002:a17:907:db03:b0:b5c:5df7:be60 with SMTP id
 a640c23a62f3a-b647560b117mr296642266b.52.1760692550571; Fri, 17 Oct 2025
 02:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760571220.git.belkid98@gmail.com> <818ca6b104cf25ebe4c60145d046029f057f4db1.1760571220.git.belkid98@gmail.com>
 <xmqqms5q4v0r.fsf@gitster.g>
In-Reply-To: <xmqqms5q4v0r.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 17 Oct 2025 11:15:37 +0200
X-Gm-Features: AS18NWDgL-MNVtZAcIzHXXukDEbuVzqZG0fqJDNygW_HEVBTVUMWaOtTZH1p1hk
Message-ID: <CAP8UFD1FMwrBxbZ6Ck8JwBPBOAhB039US6pHSTusb6qzW=crpg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 1/2] gpg-interface: replace
 strbuf_split_max() with string_list_split()
To: Junio C Hamano <gitster@pobox.com>
Cc: Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 7:27=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Olamide Caleb Bello <belkid98@gmail.com> writes:
>
> > @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *si=
gning_key)
> >       struct child_process ssh_keygen =3D CHILD_PROCESS_INIT;
> >       int ret =3D -1;
> >       struct strbuf fingerprint_stdout =3D STRBUF_INIT;
> > -     struct strbuf **fingerprint;
> > +     struct string_list split =3D STRING_LIST_INIT_DUP;
> >       char *fingerprint_ret;
> >       const char *literal_key =3D NULL;
> >
> > @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *=
signing_key)
> >               die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
> >                         signing_key);
> >
> > -     fingerprint =3D strbuf_split_max(&fingerprint_stdout, ' ', 3);
> > -     if (!fingerprint[1])
> > +     if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) !=
=3D 3)
>
> The original splits the thing into upto 3 pieces, but only complains
> if the second piece is NULL (i.e. we said "up to 3", but there was
> not even one place to split, and the request to split_max gave the
> one thing as one piece).  IOW, the original code will happily accept
> if the finterprint_stdout is split only into two, not three.
>
> The updated code asks to split at at most two places (yes, it is a
> confusing API, but if you split at two places, you will end up with
> three pieces), and insists that the split results in three pieces.
>
> So the rewrite tightens the error condition.
>
> Was the original code too loose in detecting an error, and does this
> patch tightens the condition "while at it"?  Or was the original
> code correct to expect that there are legitimate cases where the
> payload in finterprint_stdout only contains two pieces, and it was
> the right thing to do to accept when fingerprint[1] is not NULL but
> fingerprint[2] is NULL?
>
> This is a genuine question.  I haven't studied the code path to
> reach this point in the code flow, I don't know what the data in
> fingerprint_stdout is supposed to look like, so I do not know the
> answer to the question (in other words, it cannot be an oblique way
> to point out that the updated code is wrong or anything like that).

Yeah, I think the problem is that the commit message should explain
how this whole issue is dealt with. Currently it talks about passing
"2" to string_list_split() instead of passing "3" to
strbuf_split_max(), but it says nothing about dealing with the return
value from string_list_split().

It seems to me that fingerprint_stdout should contain something like:

4096 SHA256:PelI2esT2xZlv20wJJyYOkQsli5RMK79oJ2VxqYb2PA
christian.couder@gmail.com (RSA)

and it looks like the 'key_size fingerprint_hash:fingerprint comment
(key_type)' format is the standard `ssh-keygen -l` output.

So I think it's safe to say that we should expect
`string_list_split(..., 2)` to return 3. That should work even if
there is no comment in the key file.

But on the other hand, I think it's also acceptable to say that we
just want to keep the same behavior as the original code and check its
return value with `> 1` since we only need the second element
resulting from the split.

> >               die_errno(_("failed to get the ssh fingerprint for key '%=
s'"),
> >                         signing_key);
> >
