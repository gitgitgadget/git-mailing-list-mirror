Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37ED297
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707544241; cv=none; b=o3etjA2wVryutp5+/CjQm+iS3L8wG3dljcU1UhvHmQKa+mjdq7yVuXryU9tnebfU8zql2Nmboovqd7fb3iRCm/5LUGo6CZiMO2t7gfwoqmehhYO72++iXTbZPJEaLLRXYA0p/bYnG3ZPtFSvQQ3hnbbXY9zl4kWhqILyINmDMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707544241; c=relaxed/simple;
	bh=LT7TOMwiY0U8T1kiYiGrTaaefMuDI07ZWqe3KXI4HSw=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=fTXp4LBsiiiWuOP/gnKFZekqcoG+wr8W5B6+go8aJNT55LgtG0x1JhSZRA4ZH50XIDVMGXOfFwcRDLAW7Q5CHdb+48NXIjtiSRDU3vNa9OIGVH2JSSiqtTpVswRqmqY+fl2wKEkWM0llAbDm7tI9XfxRbcg9swvClUgXy4XuStU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBc/m8QY; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBc/m8QY"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e14b858785so921458a34.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 21:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707544238; x=1708149038; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+rCLPQunG+vB1b1Qc1OrtepENmtww0Kmsva/Rlensc=;
        b=jBc/m8QYUPIEFDptvIjloMHqkfx1BV9o9TjCG7Y7V+ZgOOmz8AIP1uhnAcwhBXZRjY
         f4ztVJug2qqZIqquwLSWo3ZcfhIZzBP05uBeuGFEhGmEnPPd9s1h+Xy5eppQFTpKRzzJ
         KzoRRLws+4TZ4iV1RGiv0IwbFPP5os4fw+5l3ECVeeHh/G4t6LmQ+3TpC1aepPHAfESH
         Bk5jwflObLjbdUlVwDaqzhF8ud5+EeAr4jdOr8u2m9Zc5MwvMjLWpPmflqXLBGRiq4Du
         NrkT4wfKkLbsV1TutpRbOr7WXUBJ7/lX1V21ObLZB2gFPxc9IpoaPImEV9Oqd9FChBm/
         FNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707544238; x=1708149038;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+rCLPQunG+vB1b1Qc1OrtepENmtww0Kmsva/Rlensc=;
        b=DEZ2OJ4cxdx2p09f3gmRw5p1RyWurIg2h/qh4W7anf1t59GqTYc71nu0PaIm+J5hHS
         titnZQxMOuON2GpeeCjt5OEd5UD9+mQjWHMSjWZMOwxpzwZFTfDcDgtIulYYQuxvDDmx
         S0EMIDIpWtWnpqLvJFa3lGFQeXow+sS0p5+oqQYKAw8NapxBP04QS92L83b3/kpEsR5q
         Pw5EnmtEvYhHanhd2pcZOv0LBOJASJbuvM6Mq5IVQPFKFlPPxCcpQonzaRADCvkjiNLM
         wcOHPFPnTbDv0TPBuMOPX5dyFD9of7llXq0uXL5fMfgeDyzsGR7EQKrb9i8gHTAmRrvq
         yDcA==
X-Gm-Message-State: AOJu0YwQ0VJ9CBJbJWsYr6rDHUtXqjg+PqnH6QQEqx0mlVbLvRoWoR4l
	aYaU1W4g+gmKplJKqno6mi0rOTALKxNquUcWy7t0prNXRIG5wf3EO2+C3dXv
X-Google-Smtp-Source: AGHT+IE2Uq8ihab9TUQNmVKNUglJJxDS26/fMuXBubnzXySJwMfsHd2BsGWScz8360lWwCZUkyr7FQ==
X-Received: by 2002:a9d:68d7:0:b0:6dd:efd1:763a with SMTP id i23-20020a9d68d7000000b006ddefd1763amr1089844oto.31.1707544238361;
        Fri, 09 Feb 2024 21:50:38 -0800 (PST)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id p13-20020a9d694d000000b006e2d631a133sm143516oto.64.2024.02.09.21.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 21:50:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <phillip.wood@dunelm.org.uk>
In-Reply-To: <b5213705-4cd6-40ef-8c5f-32b214534b8b@gmail.com>
Cc: <git@vger.kernel.org>, <me@ttaylorr.com>, 
	<newren@gmail.com>, <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant
	 commit options
Message-ID: <17b26a6fdb07139f.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Sat, 10 Feb 2024 05:50:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 4:55=E2=80=AFAM Phillip Wood <phillip.wood123@gmail.=
com>
wrote:

>>>> I'm not sure that is a good idea as it is hiding an error that we didn'=
t
>>>> hit before because we returned early.
>>>
>>> I think you're right -- Previously the error could not have been hit,
>>> but now it can. An error is still an error, and we should handle it
>>> regardless of how `allow_empty` was set. I'll address this in v2 by
>>> simply returning the error.
>>=20
>> As I dig into this more, I'm noticing that this may have unintended side
>> effects that I'm unsure of. After making this change, I noticed a couple
>> of failures in the cherry-pick test suite. The others may be a knock-on
>> of this initial failure:
>>=20
>>      expecting success of 3501.8 'cherry-pick on unborn branch':
>>              git checkout --orphan unborn &&
>>              git rm --cached -r . &&
>>              rm -rf * &&
>>              git cherry-pick initial &&
>>              git diff --quiet initial &&
>>              test_cmp_rev ! initial HEAD
>>=20
>>      A       extra_file
>>      Switched to a new branch 'unborn'
>>      rm 'extra_file'
>>      rm 'spoo'
>>      error: could not resolve HEAD commit
>>      fatal: cherry-pick failed
>>      not ok 8 - cherry-pick on unborn branch
>>      #
>>      #               git checkout --orphan unborn &&
>>      #               git rm --cached -r . &&
>>      #               rm -rf * &&
>>      #               git cherry-pick initial &&
>>      #               git diff --quiet initial &&
>>      #               test_cmp_rev ! initial HEAD
>>      #
>>=20
>> It looks like this is caused specifically by not hiding the error from
>> `index_unchanged`
>=20
> Oh dear, that's a pain. I haven't checked but suspect we already hit=20
> this when running
>=20
>      git cherry-pick --allow-empty
>=20
> on an orphan checkout. In do_pick_commit() we treat an error reading=20
> HEAD as an unborn branch so I think we could do the same here. If the=20
> branch is unborn then we can use the_hash_algo->empty_tree as the tree=20
> to compare to.

You're correct that `git cherry-pick --allow-empty` on an unborn branch
hits the same error today, and that using `empty_tree` seems to resolve
it. Thank you for this tip, I'll include a fix and corresponding test as
a separate commit in v2.

--=20
Thank you,
Brian Lyles
