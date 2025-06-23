Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54A29CB47
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701498; cv=none; b=D6QqhR0mUE1cQUBto3SrkTVYvTs95VgrmPDKXs51ljRgU7joFtx7uyJ6CauPpxYnytwLmeg7d0A2yeyncLo3yPHRIkzrYZhzXLlZULyKo+qDmjiKS1AlqMFF7wG4z2wzvvR9jWJNC9fXmj2VHIdPRh5qVYQaqHCPMQgY1zD16mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701498; c=relaxed/simple;
	bh=5fuVKiCaaFHX9gqwSeheF/ghfvZGWTfBbX2B+KMfphE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DqJp+e344NTIt+7f4FtFpCKQCWcKvlIdX7xim/0//W21S6FEQt7U8By4mKdLR/y5ZQ4PS31llAH/Trso+pye3F/EfhqP34V4mapZRmTm+P8cTxrCUq2zkBuyTG6RDmfbgQ6GDHWR5ciXczqiWjz6hDGvz3nQdDzpQblgLp2aSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vwg/OkZv; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vwg/OkZv"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47e9fea29easo47301cf.1
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750701495; x=1751306295; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OXzw3NALro7pcOgwZMZ2YhT3VgbigzrdIaS6aaLmqHE=;
        b=Vwg/OkZvDmwHs1aOLUQzGT1Aq5XCagk3V/jzynKSXY/md5tO2rUH/2CBbbdraOSNSC
         Xm6aZoovWp8+3+HRVRUpM64/iivxHdFbsXnjS48wObMXVAHu1vw+IWQ+BtTAqRx5XFMt
         AWLA5yIVqBNylsDDqFxvZYXn46DOagUcYMKtjX6SCMYvcQyouUerXhqsPzn/t3IXCo2A
         tz4kLUI4ZI1Bz/mC12CXl9uGNP6H3sjdJywwOPUFdEUvL1kDMQHTvQ0N+cyXISVsgJT9
         RI7xEAca+lIQF+aEn7Lu6UwWQUbKsgG8kjB6bgVtkE+AfL6aug/BBJZEkiSrHL2F7DSg
         CreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701495; x=1751306295;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXzw3NALro7pcOgwZMZ2YhT3VgbigzrdIaS6aaLmqHE=;
        b=IKbilK7sFsULGKQ/4dRL/8EJxHQeheKJw3zyLO7Qp0jTugbadiKg6CYeuHQcp4jtYb
         vBWuvb1tnk+uylz8UnUglSm6BxbWVuEISwPzVIrl6ocrYQW8zLpnnZ/RTdkQVJ6YFsvg
         BZtOCI9SlAMMIzAG4dhrnLB88JD0XORUCIowzzR5JVHHNOGLZ0PdNb91f+1jQkEMW/ux
         sQA059zYdJjAC/nEUG16koFSV5MH8AzSPWNyEZa2snN8D2KbgMzPamJU1z/JYrWI2ywf
         Y4TVM2GQsmDGC7dnjoOqG9Dj/VBYNaAkE/Db1+hnH0tfLjuNhLuuMPtLQ+7G3joUxjcq
         7YXg==
X-Gm-Message-State: AOJu0Yykt+vDpNpJdbS3Ee8QxBunhdvPvlTcvIoBL9ap8o5Dx04U7xxX
	Q+1dB6+GC/g8sFqWxEozo9b9MkiaXwg5IhV/1yV3BPtWyNfAkWFy6+j2oOW3RvIRCjDEZpAHHhH
	73Pn1dQwpiMOpznO9R0dDc+r/BirJvYSEUK1WUtkDzZj3tuULIdqGY/04orU=
X-Gm-Gg: ASbGncsUBy84Hz1+w/2mCs0aklMUEukRh56vyM4sO4mHDDCj6+Lb9YuG/Kh8mObBtvO
	T6KrVoRGJwlgpbEJcOM06zGIvvByI8ViWb1NGTMTR6d78th66ORmdZsjdtJ9Arl2SEofzDKx8KM
	CnDSbdDw/rQdHjD/9LKhIunfRFOHojhJM/PQ8OCq3SF0xBZFLSEGHJ/RX7xxBZ3KqCbjAuaTZhV
	w==
X-Google-Smtp-Source: AGHT+IG7iCRlCBHrm4ARyl4k+cSAMzw+9/zc9C7ujZoVtUzmYAY/sdoN8gMz1H3UW1xMmbBUv15Cwua/W5YtEHmnqBw=
X-Received: by 2002:a05:622a:285:b0:4a7:26ba:bc2a with SMTP id
 d75a77b69052e-4a786d5c17cmr8087441cf.15.1750701495070; Mon, 23 Jun 2025
 10:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Koponen <kaikoponen@google.com>
Date: Mon, 23 Jun 2025 13:58:03 -0400
X-Gm-Features: Ac12FXyyVWwLKVdM-c-Cl09sgFtwyy3F1RCjBPSdDxborili31NdKR1Keq5eDko
Message-ID: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
Subject: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
To: git@vger.kernel.org, Kai Koponen <kaikoponen@google.com>
Content-Type: text/plain; charset="UTF-8"

Reproduce steps:
```
git clone https://github.com/golang/go.git
cd go
git config core.commitGraph true
git commit-graph write --split --reachable --changed-paths  # Without
this, all calls equally slow (~1s)
time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
src/clean.bash > /dev/null  # ~90ms
time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
src/Make.dist > /dev/null  # ~100ms
time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
src/clean.bash src/Make.dist > /dev/null  # ~650ms
```

The rev-list call with multiple paths takes over 3x longer than the
sum of individual calls to it for the same files.

Expectation: rev-list with multiple paths should take <= the sum of
the time it takes to call it with each path individually (ideally <,
since with the count limit it should be able to early-exit and search
less commits for either path).

Also reproduces without the -10 arg, or with a lower count (double
instead of triple w/ -1), but these results are perhaps most
surprising with a count present.
