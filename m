Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4293207
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 23:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759446239; cv=none; b=Ox3wXT36xPPbudCEV7xfqZzMVnsfRlC3gnzJigLXJb52gU6kzgD8sLDtLXPP0Yt9TAxJka7xjbRLzepfn1qn4KT0f4o4dB9jReStLusmKh8byYADRZZw+rg0x6+3LxbTHtOjzssuEnp7KNKyQCfj+euSy0K3qqqsj2Md0BLhtJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759446239; c=relaxed/simple;
	bh=7UiyqUKWo4sigWU4YLCSKvxNFkMpSR9rsVRjp9d94Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWor2EYh9dh4rqCNvpq6X/dZqSFBPcG6Pmb4vR2RxvQPnp+NLMI5XMLLmK/wAE275A9pAOdQV0cMoclhsZfJRCMTUde5vKcXRubz8leE6t4OvDSblO8V1zzePZMfXMbfrUtbPV7IaWjLErwojL22Iw+5M8HEtVH9Zn5RexY+m20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZhrmDhx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZhrmDhx"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-367444a3e2aso19019841fa.2
        for <git@vger.kernel.org>; Thu, 02 Oct 2025 16:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759446235; x=1760051035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTZBqyzym9HK7nfOxSomOSzuCVmHKLX9bhCLihknZ9U=;
        b=hZhrmDhx/ikuGeqWjOcFYY7ftvWr2F1m/zxnfSmlQ+SgPPpCOMgP+Wl5qJ0f1EH5IY
         k4zcOx7Yt6/PUpOFV648D/5Gk9gmtdIhfbUayRPyiH7Kkfpa6lFrEr1BEuawvAZyN9Iw
         nYrxAeMmk1VHZSwTAPKFo5+wzMehQWm7u+suVObOy89ZVTRa8b9pq3qOGFcaTM6vSTr1
         DhB5B+H2Kx2Fk58HRdhwjWzx7appjuBzBCPz7KBRccN7QaFjrqHiCl66nRG43EjKvs6G
         u5sZ+pIc9GCBWSW1Zu1jzagD1pikPnAUVk9PUb6bIO5ORFGoJfqNBnuWoQVMZ1CYTIJV
         Ra2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759446235; x=1760051035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTZBqyzym9HK7nfOxSomOSzuCVmHKLX9bhCLihknZ9U=;
        b=IDe1GdX+bz6NSV7WDKpkNcGB0+q+PjnsVtY37WL/5DCnn2fDbxR6RsBRowD0dlrgSF
         uzEO2Ro9phKlpANUO/Lqma53B2XCIJpB4qM2iJWLe3kDaTBT2HgypqwFOzBZIBBjoZqr
         CLiS55HbUKDIGNZQEMA88t2RVdVaN+9gd3oy3RECtHWjKoQYu6BE1QSnO3jsj6aAyol3
         GCS+3q6BwDfvHVhnMakAbf9u0Yfi0IdxXDuEyneyZ6YzT2HxxO/DngGyCBU0Ww+wJKBk
         vYFkchBMCNChqIT0dbDrFQQOqo1J6Kksz36RLrml/0KmK7RVf764+bOSyVXr7wmF+IX/
         Vorw==
X-Forwarded-Encrypted: i=1; AJvYcCU1kgCTyDviAjfb1j0SCESq/7EMRwcGb1mCrX5gAFhLxzLq5I0srsF3/fZbQrgITBab5zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Xg4guliLbd51SOOCgA8yAEF280tyH7FdTasN4+QO+dTVrK9A
	XGWiktmgcBCzZ5zi7Dw00WScXmsaGEjW67Dhp6zNfnkKvV4/mqrRv4nDT9CmdFoZuU9nvDe/kop
	nBUi3BkWzz3vw83ZogtGoUbwXEncMBdVMqcQUgzc=
X-Gm-Gg: ASbGncvdBVbazYjceXu8wg9cDze0hJHO3qjW3vDrrWMx3lEJpQwF6dcDGOTU1pDGUa+
	aWZKcUSZWW8UG0plTvsf1N8pGZSVYIl1Yd0xRFVw8daWZK8e1ViS0xwQ9z0BO7Lm3U7KparyxsB
	nJfk8nBi1Z6tfkkFeIOmhOoyHNJo1JGY4xllu2rtI21NTymp2XuKRSLUhfj/V0BJ2jtnH+EBfdf
	oCLreMlFr9i+xX/PYcWOF3QDot9mAWC3zVlr6HZ/ME=
X-Google-Smtp-Source: AGHT+IHERE8jdW6/plnq2KNy1mPjZBGM/TLZ8MBwWWdJ1QSvd8KTIe/X32crkZuJZ5fCfrITO7nKpShZ3NEGFT0SF+g=
X-Received: by 2002:a2e:a802:0:b0:36a:8c41:643b with SMTP id
 38308e7fff4ca-374c386153emr2185161fa.43.1759446235268; Thu, 02 Oct 2025
 16:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2065.git.git.1759341748.gitgitgadget@gmail.com>
 <xmqqecrmyz9j.fsf@gitster.g> <xmqqtt0huidd.fsf@gitster.g>
In-Reply-To: <xmqqtt0huidd.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 2 Oct 2025 17:03:44 -0600
X-Gm-Features: AS18NWCDu_u9THDTY9a9toEOWgba25Ue2lmI6_DqlE3aZbjQxE4fRuNXQx17CZA
Message-ID: <CAH=ZcbCmRsJ7mksVfshEAvZOcoKiLSn9WhAQoeQXBvu_tT9daw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Makefile update libgit.a: Include xdiff and reftable
 in libgit.a
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 3:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > This topic, however, especially its first step, had caused rather
> > unpleasant textual conflicts when merged to 'seen' (I didn't check
> > which other topic was the most heavily conflicting, though).  I may
> > attempt to get a clean merge again tomorrow, but due to time
> > pressure, tonight's 'seen' was done without these patches merged.
>
> I think I have sorted it out.  I'll push out 'seen' with this topic
> at the tip, so could you please check the resulting Makefile for any
> funny mismerges?

Looks like it merged correctly. I'd like to release a v2 where objects
are directly added to LIB_OBJS.

Here is what I ran to compare it to what I created:
  git rev-parse next
  a91ca5db0318b6fda5a6721ee843f56e7e2fadfc

  git range-diff d30e0f3024^1..d30e0f3024^2
next..merge_xdiff_and_reftable_with_libgit_v1
  1:  40d798afad ! 1:  fdcf5a0de8 make: move xdiff and reftable
objects before GITLIBS
      @@ Commit message
           with --color-moved.

           Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>

        ## Makefile ##
       @@ Makefile: CLAR_TEST_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
  2:  22d1910ec8 ! 2:  28e7fd27b6 make: delete XDIFF_LIB, add xdiff to LIB_=
OBJS
      @@ Commit message
           included in Meson's libgit.a.

           Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>

        ## Makefile ##
       @@ Makefile: export PYTHON_PATH
  3:  9f1670c048 ! 3:  8549f63415 make: delete REFTABLE_LIB, add
reftable to LIB_OBJS
      @@ Commit message
           reftable will be turned into a Rust crate.

           Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
      -    Signed-off-by: Junio C Hamano <gitster@pobox.com>

        ## Makefile ##
       @@ Makefile: export PYTHON_PATH
