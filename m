Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00672D1913
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204956; cv=none; b=SvPPi0sg1kK+/dSzsbIOmYrVu1DC9JkP691xnH7+wgkARju1b4UiQcuIwPMr//G3J1zqQQKfWPH+er9ysKvYxf6xdGGEinLLfBIZJMq3wqPu7XFfG0YdE5rH4neVH7HAxcx3IoewMi/djaD9SCcn6vrx46o0WUzTtfEBUka827o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204956; c=relaxed/simple;
	bh=DUq5oDr1TTM3EPW1CoJBF37ReL9QgUpok+3xGqPvoms=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2vnvGu8Vo4IvEHTJTebOcGMXH3zjrFhoimj1HQmIe5rQJXqpTqoAOq4geQp5CxHAQEYgtcTj+8yVQTL0BdUGpHZWAqr394433HPoTo7q6wlCSNWU1oDIrKAolGnp4dJi6Eq/Mp940c3fGgoxZ9ETtRLVQH4n8SJ9qzs3h8Pp+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDBvQioZ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDBvQioZ"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so935290241.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 13:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762204953; x=1762809753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2i2eqkHrAz/0VzhcwJjxImlmybfy00QzdZHxDi5sZ0=;
        b=SDBvQioZgrCsjvRhTONQMVpefKBWD5EycLKvbwyplykFzGwohYorYuzHuzesANFQ9u
         J89jwhVzF6q5qsQ8yB0NBpkwpJIHVUCWMjOs4O37N5LV7RmwyueEgZGrpcPeiF2dD52Z
         CPJeJKHsLrc0KFApiMeIROXVElgs6mHBBhNPLGg6BY+wLM8iNim4u5DlBOOi5vbbYfil
         zucwTVc6OowgF2+8F3EgwjccJISEvbfTJPIf+/x/cxmeU3Fl3aklzvcuRkMk5e+1o3Zo
         TMQgbijRXddBep5XAsZy7z7YciWrWrUfGRzCdPI3+Vqlo6iRUQeny34xJn0dJn3Cz92b
         fceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204953; x=1762809753;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2i2eqkHrAz/0VzhcwJjxImlmybfy00QzdZHxDi5sZ0=;
        b=wF01vIuAjWLWjpb/rTuiPaBSoklRkcmS7itZ9hizrHetRupCc0oe/OdWiyRpBQCgTi
         +PwcAHvH/X7LqsY6jh9W7siVtcbRzo9jlwx3Ws9GZLgEWL3uIX2Rx1C5MIs2p2+DRvP5
         8sXD/Y8yykK0cKsYAXhft0behrX8elPpGxgY5s2ZzFcbonvneaW19SxLo81MLIGEPW9F
         LwSS4K304sd1odjPbJKrjINoXnCzJLqWWG0Daf3QEnooLJB0n8LUKq+ycxxwX4ZZNuWY
         HiRqNlEkMUdAXH44Gdko68z1CJ+1DnuTJYjExBw6xRXaf2PiuXtj506FOqYDmVKJ5DT6
         VoZg==
X-Gm-Message-State: AOJu0Yz6KJbcXQuEUEsJ3YQ8hJ7I4XN00eXGkX3awv224PrkK4AVXZOM
	pooXLnNL5vszQdTQ/zdcm07G/Xn9fJWfmO/d5XtSaEMjE2HvR2Q0BdWkB3H8Cg35erCULeoxsoJ
	KHAS/Cb1eEQzXhldoWf9YoiBG/xj9m+o=
X-Gm-Gg: ASbGncvs3JV8GzaM80y8ib/a2TiKgwbT73b4z6qNDnH2T6Hsvt2gwAo8Ke092pQKVvI
	Zmy9mrAqiAgSFedmHV+e5BNB9sOLcJAfL1MFhm4LoYx+Y6T3Zrl2VeXQSrCWR9xvPnPFOtQYJxU
	CBAI5NqzTKxRtbuupUdr2cOwKwvum2OYd+ASohYdV/J69gghNfpRC8fYJh9Lw0l2aMRg1EljZ+/
	W8xMsgWYjBwsIwOACNnOBpiSjqiBPWNzvK38ti2CpCYCEh/z1QREFaOaZbPGjwxokzFP5cZ+cFI
	33R5Aj7otzUBPYpc
X-Google-Smtp-Source: AGHT+IG9qgiA5jPaQJmsOKr2QfONWMBLF/0XZFSFjWuwO9s0+CGH4TFJe1fSoIeDyLKESy/OUhkuUOWvC1cVF+0oaA8=
X-Received: by 2002:a05:6122:ec5:b0:54a:a048:45a4 with SMTP id
 71dfb90a1353d-5593e596d30mr3977879e0c.16.1762204953349; Mon, 03 Nov 2025
 13:22:33 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 13:22:31 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 13:22:31 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPig+cRF1hb_RQQCuzZWrnu4AvmOUgVT1mVh=LhP17f7_hYVGQ@mail.gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com> <CAPig+cRF1hb_RQQCuzZWrnu4AvmOUgVT1mVh=LhP17f7_hYVGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 3 Nov 2025 13:22:31 -0800
X-Gm-Features: AWmQ_bndTVs7cIJBUFJdXkdRLCkPlDfwsb5PkFfgXU835_bjLQdortnlG0S2-oA
Message-ID: <CAOLa=ZT0DFG8jx8x=OHouFxinobBbqAbdegaUgkNxy0xLY910A@mail.gmail.com>
Subject: Re: [PATCH] fetch: fix non-conflicting tags not being committed
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000442ec00642b75051"

--000000000000442ec00642b75051
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Nov 3, 2025 at 8:49=E2=80=AFAM Karthik Nayak <karthik.188@gmail.c=
om> wrote:
>> The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
>> updated the 'git-fetch(1)' command to use batched updates. This batches
>> updates to gain performance improvements. When fetching references, each
>> update is added to the transaction. Finally, when committing, individual
>> updates are allowed to fail with reason, while the transaction itself
>> succeeds.
>> [...]
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
>> @@ -1577,6 +1578,46 @@ test_expect_success REFFILES 'D/F conflict on cas=
e sensitive filesystem with loc
>> +test_expect_success 'fetch --tags fetches existing tags' '
>> +       test_when_finished rm -rf base repo &&
>> +       (
>> +               git init base &&
>> +               git -C base commit --allow-empty -m "empty-commit" &&
>> +
>> +               git clone --bare base repo &&
>> +
>> +               git -C base tag tag-1 &&
>> +               git -C repo for-each-ref >out &&
>> +               test_grep ! "tag-1" out &&
>> +               git -C repo fetch --tags &&
>> +               git -C repo for-each-ref >out &&
>> +               test_grep "tag-1" out
>> +       )
>> +'
>
> What is the purpose of wrapping this code in a subshell?
>
> Same question regarding the other test added by this patch.
>

It's not needed, I first created two subshells with cd into each of
them. I let it be when I merged them. So let me remove them.

>> +test_expect_success 'fetch --tags fetches non-conflicting tags' '
>> +       test_when_finished rm -rf base repo &&
>> +       (
>> +               git init base &&
>> +               git -C base commit --allow-empty -m "empty-commit" &&
>> +               git -C base tag tag-1 &&
>> +
>> +               git clone --bare base repo &&
>> +
>> +               git -C base tag tag-2 &&
>> +               git -C repo for-each-ref >out &&
>> +               test_grep ! "tag-2" out &&
>> +
>> +               git -C base commit --allow-empty -m "second empty-commit=
" &&
>> +               git -C base tag -f tag-1 &&
>> +
>> +               ! git -C repo fetch --tags 2>out &&
>
> Should this be using `test_must_fail` rather than `!`?
>

Yes, will fix!

>> +               test_grep "tag-1  (would clobber existing tag)" out &&
>> +               git -C repo for-each-ref >out &&
>> +               test_grep "tag-2" out
>> +       )
>> +'

--000000000000442ec00642b75051
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bfcd984035e9273a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rSkhSUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mKzNWQy9zRS91cExNSFNKMmo2QTRQOXZCbEZnK29hRQpXdXBydUlvRTFK
Z1VOcGVad3YrM05oZ0xRQjJGTTlQbkI4bHI5VnFKcEFEei9oYVozemZoOU1XNEl5VElVVDlhCjJ2
bWo4VHcxSDNsUGJzUzgrcDZPVXdEMHN1dEJBMms0MnZLeFdCNDlnb0FGRzR0K243SkF3U3l0d0pD
MHVyaFcKdzQ5TlpjQXlwUittaDlkeTczcGRybGM4R0dEUGRZQzBnSVNMVzVCSyt1Qlc0ZzN4TnR2
VDRvdWgwUmpnUDRCeQoyb2dFWUh5a2hUTmdMTCs1SVBJRXRDNWVaY0cwVDhGVGJ3RjgzUERlOHFw
OFNKL2prSXdFV2FuSGNzc2NQR21UCndIaVZadEc2WUM4akxVYWVYUGxNT2ZXTGY3aFJuSHJEOURN
bzlPMndZQ2JhRVk5Y0xxSW10clptMXpHajlick0KUjd1c0kwOStabS9lK2lXcExoNGYvdXdoSWk1
aVo4dVp3QlczNVd6dWZNOW9EOCtYZy82dEVJN29YSU5WTnJuUQpSeVBvZXdESG1vcnBYSlhDNGdx
dkk1TnJEQWRRdGFJbHFUODRvY3lBcTY0MXlVTDBhelQ0SWlCMC92SUJVQjdXCnR1NENZcXRQcWdo
bXA2NHB6TnFZbnRvY3RVTmxrRTBkNXhrd0hxVT0KPTlObzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000442ec00642b75051--
