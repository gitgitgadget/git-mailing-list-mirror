Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7D918AF4
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720207387; cv=none; b=FPSvXzP2r7w1b4xa8K/IvrYfvBMSzt8rrHGTJyPr9MzaLMYrTHQWSu92mQxnh69IRxK8sBBFNIyBfJ6g83MpN/jGIvDf+gsvokVLsXvKhUfbmxwK0YyG93T0/Wd59wQpMTt6mCQrNG2unLAxetfAJHd+6tvqoLn45i3IE+c1wPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720207387; c=relaxed/simple;
	bh=NrMCFcqRkyTU7JoDJ9Br0IqY/LcXxdxRBUQlChN+Qn4=;
	h=MIME-Version:From:To:Subject:Message-ID:Date:Content-Type; b=fAQ9TPBUbGR0qnmYt10/iiCSzT/0U0AaT+sw70/gTJ1S6TLEXMOAJ9m4Uk55c9dNwwNb5O2pSPGtg6yFJPfxrk3hwlpaXT0t7PUn7pjb6cjvJnRwFPSl7x/4LUYlhdq9BJNTx/eyT4VxO8vbTEYw/kGzKfWXcI52Az9h9Z6JzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4SeiR4q; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4SeiR4q"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e0360f890a1so2485309276.0
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 12:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720207384; x=1720812184; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RT5rqzGqvzghZ5r51avWOrZEmDxLsZPUr5XRmGG8HGQ=;
        b=h4SeiR4qPrWzE6CIN9eZwLbtQ5So3877awq6JCL/4hqpuo5Ykq3nYJOUu5pnXKShvh
         nniLhubWvc9FKihs+z1damKyfhN7Qll4R+OSjDhrcqPWx0CKOY9Nse/3ggXuMveQFzSK
         nPZx23eOb5oqA1ONO5WhEI8cX9SXYBUPfnuEkiB88Gfx3eEMEN65SEjAy/a9H18EH7lz
         yHmyDBk69mPzt9xoEjAjCaJ3DtSd8657k0qa35+47m7OL69O4d8EjyPn0lKwokfCUJ19
         I61pP9beUXFZPixls881bMRpuzBXSMPKKs3vH8SFkotrrFUbR6Le3YBNOXCus71Rk+lK
         Z0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720207384; x=1720812184;
        h=content-transfer-encoding:date:message-id:subject:to:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT5rqzGqvzghZ5r51avWOrZEmDxLsZPUr5XRmGG8HGQ=;
        b=ssVpeK2HxvNO9aOygoCz+SPQlnE3krBXMENDpqLt1ybKjCsWKqoVIeZi3E9AhbTryo
         8Arkc4zFfUm7p8nrS4aYEqJNGEDh60mp0S/XaF45R5ubjVhjhY6Jw/Q37xdBu46LCr94
         8alhM0NDB2OPF89csvJJLnk8CBLNWa0VOVIODOHyj/NWixE1IGon+/RwMPggp0uDThbB
         AyGwKzFaOoBadvpKGnN8+KNzwZIhrkeIAK+4SmzK0hFrmrvUvHnU6GX1KgwnDayswBJt
         ZeeHpjbmraRi/mp9150HgNtr/SxRpB3Fy8v8QADJTx2vl9hy7t+/vcjkvlPV6pPPYTx6
         FM3A==
X-Gm-Message-State: AOJu0YxYfH8nwnL/0lyNCTfPVfLwnr7CCf7Yi75LxEpVkcYAsCl3RxTo
	n8oamShs2UHZlobojPJZRDZfQQZaeoR6GHJX8si6uIpQvRaQr7yzuvV03A==
X-Google-Smtp-Source: AGHT+IFu4LZbdnq+JivEtAkb2Me6BQ65yhWqEcu0aZhWLHh0P06sprRQL7xzLuNyaNdO7T3L801nQA==
X-Received: by 2002:a05:690c:6d8e:b0:63b:b473:1b91 with SMTP id 00721157ae682-652f6ccafb0mr36479177b3.23.1720207384278;
        Fri, 05 Jul 2024 12:23:04 -0700 (PDT)
Received: from EPIC94403 ([2620:72:0:1f14:b026:2206:d6e2:81e9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9c4fdb78sm29298587b3.145.2024.07.05.12.23.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 12:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "brianmlyles" <brianmlyles@gmail.com>
To: <git@vger.kernel.org>
Subject: [BUG REPORT] git-gui invokes prepare-commit-msg hook incorrectly
Message-ID: <17df67804ef7a3c8.df629cdadcf4ea15.524a056283063601@EPIC94403>
Date: Fri, 5 Jul 2024 19:23:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I noticed that commits from certain users were ending up in our
repository with comment-like lines in the commit message. I traced the
cause back to the combination of:

- Those users are using git-gui to make their commits
- A `prepare-commit-msg` hook is adding a dynamic commit message
  template using comment lines starting with `#`
- git-gui creates the commit in a way that circumvents the message
  washing similar to if one used `git commit -F`, but invokes the
  `prepare-commit-msg` hook without any additional arguments like
  "message" [1] that would tell the hook that `-F` is being used

[1]: https://git-scm.com/docs/githooks#_prepare_commit_msg

The result here is that even though the `prepare-commit-msg` hook is
already correctly short-circuiting when given the "message" parameter,
it is providing these comment lines when called by git-gui, and thus the
commits have these comment lines in them.

This seems like a bug in git-gui. I see two fixes, but I'm not sure
which is more correct:

- Have git-gui pass "message" as an argument to the
  `prepare-commit-msg` hook so that the hook knows that `-F`-like
  behavior is being used
- Have git-gui create the commit in a way that causes the message to be
  washed

The latter seems like it would be more consistent with other workflows
where the user is seeing the message in an editor, so my instinct is
that it would be the better fix.

--=20
Thank you,
Brian Lyles
