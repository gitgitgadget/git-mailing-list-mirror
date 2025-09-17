Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC92E63C
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758075401; cv=none; b=Z7uMsokLTIxtkESe5OarLEPpRYUDACvS6vhsGXNqlKyfUNEg5ZP6hHbHO/HSIuq8XMIBv2u7clNnG7mMZ0PIDKRLhYTZMd72lDWCiUJgMEbIZzD9GwTebt1WTp+iVp3N+G8hGsGWu83k6+Jd+zL9GMmj+xEG7ErO74SCvPAxVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758075401; c=relaxed/simple;
	bh=TIVN00oZAEOcbxmZMqkhzGiu7oJSY4veaM8tjKcg1UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy3L9d52rAq8aLByjBP3PrqMmdD/RQ66rXhKkujiQJDHZUpIEVV5KqnA89nvenYo0cS4tOuzLOSaiVCfDv0tWkS9pta3+2UgfMyuthWHhBOQJ+FVDouCNWW14Mj7tTSf+VwXIjysiCbvBnkRjZsNTnvrFlRQ41XzaH5OtmWOlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoGBw/6F; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoGBw/6F"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3fe48646d40so2716335ab.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758075399; x=1758680199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdIffloiKkG4hmoETS8NhKgayMGCq2X3c+WqnJcKdJA=;
        b=hoGBw/6F3YI5lMjFOpWxEu2bXckL5rMoVypMFTnPlNaT4FFTigO5/vS79Me69KxNy3
         NA+vFk3Mm+xOs3bRCmqtcYQlqvYGQFPFbLmdlU8exYbheUqzAxNeHqOIJJTkYdXlc1dk
         TAGEnbQvwqrajNM7pa16fDlOeozDzsJ9I6StsdCtrUPyjwf6aGW2ahty5kpgaaMdRVtD
         YAqqLlG8M9z9UFf3SGwLen03sfxTzpyOCyI12tec2sprFRF6gheA3E/sTUdMbw8LKsw7
         5g6NFBCMns/nYIOd9O69XCxmf605dOKHeG8JuKPR1WVmrLjrFN92rY81WHg1slrNGxD3
         04Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758075399; x=1758680199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdIffloiKkG4hmoETS8NhKgayMGCq2X3c+WqnJcKdJA=;
        b=rQXPYDjOcSI2hvDEhi1P7rtgDHDJpUFweufNJKiQaeYEvelQ53ulMEdMtv6fhEYK6J
         Msz0Dhwmih1oPgDlAuCf87Sd/OnXnQZzSCrkv7ilNm/uv7R/++ywxZWqKB3CquDcfxmc
         y63eCjOoj0B+izV7azfEpqV2x5gxavWr3f3VebN84/r4OcYaR0Vn19LFaAgcZCiVzwgm
         tHyKuL4FWGMLvecXLTOex1vvhcEikKDlr2szjlHvVIBjAmYmyEAB/LTy1D2kEQpQTJhF
         ArwOOU4U7V2SjtXR9CPsKVTacWeYVa7QaQcfSP+Kyuis3F31QVug5XHmkrFWgKFNa6hO
         tZkw==
X-Forwarded-Encrypted: i=1; AJvYcCW0/sQPOlxVn3GRaa4ADoGXySPI6d21mJgkRYT1ELCmydoW4/Q6jnaHgDJiBQpLFUvmiA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmms0z0ST8ToMSaY41IgS/Wkok0ytnSqwEXBbxy24edEEBJA5+
	qhUH/Jk++s/7Yiv0O+lhyUG2gxY/mr3B1OwmUyeSLALhO0VN9+rNmSqrRB+f8slblLrdZB5iTBI
	tHYWgQnYWquA4TUGwRKjA0QonHKB3eC+giA==
X-Gm-Gg: ASbGncuiqbxLVP4RoXpsdusxiF7xvWCzTApGmx9mTiefEi2ezXh+T41tSg79r1LGNux
	80ViLgR1X8+KJDts5PnPoGZVpa+q1nEAQL2ftqgnYcYTXcys/xEfNCa4NTp1a/GN91w+TG9++/p
	jT9ncHC2xz31CITk2kAHbOzGV30ZPkSrPlVop0Z8sPqcKiE3SZGGwKoKHisj3z1TzX7HBUhuueY
	odt8HmKtjyV2B2rHz1z7qUxveiPY9UAZ/6HB9tVEEt36ZIauoE=
X-Google-Smtp-Source: AGHT+IF3zi9HsVxtZK4gu0FhG/ZD0vTnfowHXN0sp+IMc4E1d5Zl8z27qvZQiZCUIWlZWLTbc07Zf8xT54m7ROJZ4Fc=
X-Received: by 2002:a05:6e02:1283:b0:423:7873:262f with SMTP id
 e9e14a558f8ab-424114c4984mr31461345ab.11.1758075399550; Tue, 16 Sep 2025
 19:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
 <xmqqcy7qm582.fsf@gitster.g> <CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
In-Reply-To: <CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 16 Sep 2025 19:16:28 -0700
X-Gm-Features: AS18NWDvt8oAyb9wq0GGNymVKcmk2z08SkPLqKpukqrVQzZhC4EE_SGcbeoHlz0
Message-ID: <CABPp-BH-oaV+fJ4u50oofy54ycE5oKoYJ6O1XgEt_JfDSgXvxg@mail.gmail.com>
Subject: Re: [PATCH 00/17] Use rust types in xdiff.
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:01=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
>
> On Tue, Sep 16, 2025 at 3:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com=
> wrote:
> > I think we saw that the earlier part were read carefully by Elijah
> > (and others may have read without finding anything worth commenting
> > on), so should we split this into two parts and start merging the
> > early 9 down to 'next' and then to 'master'?
>
> I agree. 1-9 are ready to go. Do I need to create a new version of
> this patch series? let it stand as is until it's been merged into
> master, or something else?

I think 1-9 are close to ready to go, but there's several small
cleanups that would be nice to have in a v2 on patches 2, 4, 7, 8, 9.
See my comments on the patches, but it's things like adding detail to
commit messages or otherwise touching those up, removing orthogonal
style cleanups (or making them a separate patch), and removing extra
blank lines.  Could we get a re-roll of just the first 9 patches with
these addressed?  Then I think it'd be ready to merge down to 'next'.
