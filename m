Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A44D338F56
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671411; cv=none; b=IAtiC1PHzW5FNGEN2JB+EwL37b/oE4558FyB+OleH9e5KZanIN4+Q3dv7YdQGJVrxHJeO3fpMsuzaP+vjAqOO28DlSfrAqB8CGyuJuQXDXWGZvB65NlxW7G2d1oiq1ZKVvao8UxDnPziMUz4tHVJi/nBAiOCSXI5MYUakb+mS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671411; c=relaxed/simple;
	bh=X3edWp3kCkFQo8I/6Sv4pSYVhp2YCuoXvWAmEuPneyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KK6z6RWhcSfTxrPG/m7qpqvwCK85ahMP3KaRbPJqAd5G1IiCWN7GPo8C2miG33K8522McYsOqfDoN5e892mfFCGWEv0tncYNJvkcIwaT+B7y7ozNZrDoO3hw+jAJkjhmadre+LKEzBalrYWuQq+zAmHVC8zckYTwy566S9xhTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/bQoypu; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/bQoypu"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-378d50e1c77so56893081fa.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 10:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671406; x=1762276206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8V5YA8xDD3NI84t5BMnByAk/niDBLCFSUTj/OmurhA=;
        b=m/bQoypuVQNs+OrxqHP8zETGR/sLifyla02jPUC9ZxEhRaO/Cx2VYiCtbj2PC1yXK9
         LV40BcVr2g5/Iw/4hiVFwI4xXLla5g1x8ezI8FVOYsFnskYM4Kmnpkn4BSy+Sf2oHkGZ
         KpqSZ4dHVrcnfkODqRrJ/Y5lsV2+Wuduiyo+P797SS1V6lETW1anoMFEWZo3zNszyOas
         s7114/nAD5BMTl1a4iM3BM14p2SgCfoxrZcJU8GivMoiI60AfZkV/1RCF9F5nJOxUWmB
         hkmhz1XRPqPOoKcveNlR+fihS9lzxngGtfbS8HrPG+BZs8a5OieXOgWHXgRU3RjhwFY/
         o0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671406; x=1762276206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8V5YA8xDD3NI84t5BMnByAk/niDBLCFSUTj/OmurhA=;
        b=c/yf0Vg0lzTPtPvz5acR5youlYxeUMxAxBnUKe3OGdgcxWa1LKJ6h7yhhruuXpjWFu
         2J2/QM4GWaWPkVd9dY36EvAuYWe+bPtITlXEX/JMXDhpwHwEf0zBMv4AooUgxn8Dvz4O
         Fhrp7Ua/+7EdTlPBsLmJu+c1oZCFwbJ54aJ675k+/zJ5anWVRK0fB4C08azGansznFRH
         fbgKmsXBvP9mhv0QYwIAuq3JeYZs3eInS08LW2vWlwjkl/cse29PejE4F+l8lWnwJGka
         CovC56zwilItceDwWHE3kVEZfLiJFDi8DmMLjq8z/sWoC3w51e98+PazMrEiHCQ9Rwjb
         GhlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrkpWr7CufYx8NZOrm2qKvCRyevobNomYO4cDQr6igu4xc2qRxbrpwCt7iXdtRzkndKmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssLwATrO3/qRjIY5BSnH58KjfActExoUVbmRvg4zEYZkbf9jU
	I4OcObc3FGEHPDKNgdz8KsFxlwXsdYsAxT6ty47uk6jGL6CqbXog+nT+pye+0CCarbuEOpjH0QK
	pFdwm5W8TzSlDu5L/lF35odoh6wbPjJY=
X-Gm-Gg: ASbGncv3sQwBouocEPeW6AZ7uA4noWeuhMM22jxG9MVotyAbZJwGCfwNfgvw9+3kLWo
	pIReJA0U21BwM91QyvnmQYc44RwdBB8C0tHBSxgCzX8HM8TubIk/IeIPNhPKWe2I+qOlRlfa9Pt
	d0Qpg3AMNkwWmPJpvmJRrORVi1Eyv0W7DCbVdf3cyjhqTQSa59TE5r/Up+j6Gy+EL72szswzzc9
	aRqWtnTiEuB9p/3rbe+bDLdYtYVFDXjQQ60ZrDRMbCT4wlqSvktCzU7IZ8wyjv9InD6fgV5
X-Google-Smtp-Source: AGHT+IFPAuQ6UQ/psAWPAfvxI4CwISNAPEjDsbjTjM+STfYx3OwMumeCfy3+SL1HG1oq+p6/oyvFi2zR00bdm1aOaAA=
X-Received: by 2002:a2e:a913:0:b0:36c:f6:a4e1 with SMTP id 38308e7fff4ca-37a023caa68mr668101fa.14.1761671406157;
 Tue, 28 Oct 2025 10:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-6-sandals@crustytoothpaste.net> <aQCKTFrmtlp9UEL6@pks.im>
In-Reply-To: <aQCKTFrmtlp9UEL6@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 11:09:54 -0600
X-Gm-Features: AWmQ_blU-jvB5sBd2Rd3Kijbd5jW9gmlMp53xBrpv0YtsOPkEGr-RU7vP1r26iI
Message-ID: <CAH=ZcbACQt6a=8AtsRD3UUx+-6xB14HJM1p0XC4Nu9ZWKL4fkQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] rust: add a hash algorithm abstraction
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 27, 2025 at 12:43:55AM +0000, brian m. carlson wrote:
> > diff --git a/src/hash.rs b/src/hash.rs
> > index 0219391820..1b9f07489e 100644
> > --- a/src/hash.rs
> > +++ b/src/hash.rs
> > @@ -19,3 +19,145 @@ pub struct ObjectID {
> >      pub hash: [u8; GIT_MAX_RAWSZ],
> >      pub algo: u32,
> >  }
> > +
> > +#[allow(dead_code)]
> > +impl ObjectID {
> > +    pub fn as_slice(&self) -> &[u8] {
> > +        match HashAlgorithm::from_u32(self.algo) {
> > +            Some(algo) =3D> &self.hash[0..algo.raw_len()],
> > +            None =3D> &self.hash,
> > +        }
> > +    }
> > +
> > +    pub fn as_mut_slice(&mut self) -> &mut [u8] {
> > +        match HashAlgorithm::from_u32(self.algo) {
> > +            Some(algo) =3D> &mut self.hash[0..algo.raw_len()],
> > +            None =3D> &mut self.hash,
> > +        }
> > +    }
> > +}
> > +
> > +/// A hash algorithm,
> > +#[repr(C)]
> > +#[derive(Debug, Copy, Clone, Ord, PartialOrd, Eq, PartialEq)]
> > +pub enum HashAlgorithm {
> > +    SHA1 =3D 1,
> > +    SHA256 =3D 2,
> > +}
> > +
>
> Seeing all the `match` statements: we could alternatively implement this
> as a trait. This would have the added benefit that we cannot miss
> updating any of the functions if we ever were to add another hash
> function.

match is more strict than switch. If another enum type is added then
the current code will not compile. While I do like the idea of using
traits the problem is that the hash algorithm used needs to be known
on disk. We can still use traits, but in conjunction with this enum.
The part where we need to be careful is HashAlgorithm::from_u32()
because if _3_ ever becomes valid then this code (currently) will say
it's not.
