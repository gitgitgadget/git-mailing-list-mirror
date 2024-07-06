Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6CC1B949
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720246011; cv=none; b=RY3qNAdO3cfh9Fw3yeZUxhq7E25mkVS3SfbuK69q5Oiz2r6QuGZcFqALbNkIyCR4uPwQuiXpkR9Be313XLy6DRKWkOTy7Eq+/mAEYExwLs1agDPDgdlZcwRVi4kVhmpklpDcivgmciGjMJwavORo9nsz9XWvsUnho53DeNVEtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720246011; c=relaxed/simple;
	bh=+hX0N0m/Q8hZoR9MRgS531pgQRhf40y/O5HxxVRagmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tYXFsHfLxZnAxEcQC21i/+Zh5aqqTqg1O2IdPwFXgbs5U6yGY+Sj4D1ofQvd2HBiBKLIjCzVqjOKY0582/W+aP3UeJmtlGdjG5zp2rUb0R0nsai/7kODNb3XyJfx6AodhmnIGa2UWNKsv8nmll3XYq4Ps28w2+xpEDOgcfD1bro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GISEHB7K; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GISEHB7K"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fb4a807708so13889275ad.2
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720246009; x=1720850809; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2ZpPW9uyOtVIcl53Rk+5SATrGnXM0BdGml5+EpG+v8=;
        b=GISEHB7KYL5XD6jNylvadb5arNRemITvufxiyNYslnhUf0tq2VIhCUXdjvf0m4UW8G
         6K/UKalYe1eUoTomFQ9ZjcgZ9akgKGXMrQISu7mlPw/a3OQfDzAaDKZoTLqJdLP/8VT5
         aJmaYkwBB0YeJcFwKj5CDQZ2XUGGR+njKi8+SdZAEOPS9oGOjoPG6DICJruFhqu0DrVc
         BW05+Gsl2K7MEQGxTU33m981YtwjKMSLuC57RfRxRq3UsGg7S+A1vu4BFoyKnn2a9kZF
         HIrtdgxkkCCv6wqWkYtxtc5Zzorz+NLNmosOLCfZgNp7ezL+YxepNXXc2x4gPr80GI99
         //Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720246009; x=1720850809;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B2ZpPW9uyOtVIcl53Rk+5SATrGnXM0BdGml5+EpG+v8=;
        b=BYPdx/3nfzJ9QzybpEnYoMEHo+5k3+6N+WJ+lQ29MWATh81NZUqc+l9Mi1kiz4N6rn
         RnQtiTnuWTZhB0nf18XupV13s/esJecKmVKRk7IzoPBg4/C8SbfYYntKpgsGwLaTAS5I
         1IfRTRZVdNmH5Lac8XAzTjoaLhxDejYd+4gjQBzSFTzRn5Mtegn1oa/3jklVjJmnJ5q6
         HyfY3FS8UJjof5B1suZyZGAfOJ4V/Mofqrj8b75DXaUnLieQm14cb1V0oqnDtffx/GXh
         uU8ptbZXATjaB3cr4n1Vp4e7kJRXamm1lhfZUJ+3U7MbIDLswbza6oxEDohfBuAsOhCr
         DeSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS2JVLt69oTn0qdB4aziIZmBw+CvZDwQwvifUWsNhD1CZmh6pv9oaNRBFTpFaZqQxL3GgSRWeY9t/BQcV7vTDEw/AM
X-Gm-Message-State: AOJu0YwsJj5QxQXse24q6K7pB3h5WyROcU59A5yPcEhV0/Fj0khls5VM
	Pq+dkmBAWY0Z2zqMvGkWW2aag8cxbMJv5CzIjqOEQ4HhkPMQ4iqJEJyBJw==
X-Google-Smtp-Source: AGHT+IEMnwRN8HFEPLphqjSLPAjFYQnjtRaqxNNE6/X6KX3aOMeDBPWbQUbmp5epcQ5PY43LA9XcNA==
X-Received: by 2002:a17:902:ea02:b0:1fb:5c54:36c8 with SMTP id d9443c01a7336-1fb5c543ac1mr23268705ad.50.1720246009231;
        Fri, 05 Jul 2024 23:06:49 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15967f2sm149236385ad.260.2024.07.05.23.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 23:06:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Antonin Delpeuch <antonin@delpeuch.eu>,  Antonin Delpeuch via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH] merge-file: warn for implicit 'myers' algorithm
In-Reply-To: <CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
	(Elijah Newren's message of "Fri, 5 Jul 2024 10:39:46 -0700")
References: <pull.1741.git.git.1720016469254.gitgitgadget@gmail.com>
	<xmqqmsmycriv.fsf@gitster.g>
	<dd1f768f-a137-428c-8a60-c5e875b66592@delpeuch.eu>
	<xmqqr0ca9qkj.fsf@gitster.g>
	<CABPp-BEspjHqNXSAwptgxP059qOFU6MzwAd23-893Nw99ft_Ew@mail.gmail.com>
Date: Fri, 05 Jul 2024 23:06:48 -0700
Message-ID: <xmqqed873vgn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> The previous discussions felt to me like we were moving towards
> consensus, but while I found that encouraging since I think histogram
> would eventually be a better default, I did not make any actual
> proposals and try to push further towards consensus because there are
> a couple known issues that I think should be fixed before we consider
> flipping the default.

OK.

> I have some work-in-progress that was put on
> the backburner a few years ago that I would like to pick up again, and
> if successful, investigate how much that helps general cases in a
> format that can help people make educated decisions, and then again
> float the idea of changing the default.

Sounds like a good plan.

> If consensus is reached, then
> we'd change the default across the board -- diff/log/merge-file/etc.
> rather than just the somewhat rarely used merge-file.  

Everybody uses diff.c::diff_algorithm somehow, will be affected by
the diff.algorithm configuration variable, and everybody should
honor "--diff-algorithm=<choice>" command line option to override?

It sounds like a great plan.  If ort for some reason performs better
with histogram while format-patch works better with minimal, we
could extend the configuration system to make diff.<cmd>.algorithm
override the more generic diff.algorithm and do similarly silly
things.  We may want to also teach the diff plumbing commands to
ignore diff.algorithm for better reproducibility but we may need to
wait for Git 3.0 to do that.

> At least,
> that's my current plan in this area; if others think I should
> investigate things in a different order or would like to see
> additional steps planned into this journey, please do let me know.

Thanks.
