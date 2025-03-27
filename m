Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF2219E0
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743042434; cv=none; b=I0+hrDntv90D7zry9D7E+EgP7Sgi1t5zWAqvyBscrT8uGYdLnNwY6wZZR5THExFox5FAuETy2NOOL/E9p72S5zRxJDXQoMI1XitPi4cFh2uCv0LhxPXO59OUCPPBdKRvcp1waaxdodFppcBo4F76Ea8LJKsP68akfbrUx9Y/jEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743042434; c=relaxed/simple;
	bh=4KGbtKw6dkKl2hO25mmm0qQUQJhNTsE5Insu1IVv2KY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LbhZzsPWZwk3oQfVDkgj22Eodpk4t7c56kx9AAeMLA8YAOVUwKbWXjgmSzZghIwUOrfPUW6th1YgSqUHvEJ+F012boQSbBycQ+ss/TGyCVuWwZqE/pG9xQYAS38y19DsyYHCalgRPMgej30Pp3kZDyzUwn/lmClRpkqGcHLy3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTvGJuWr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTvGJuWr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2260c915749so7756215ad.3
        for <git@vger.kernel.org>; Wed, 26 Mar 2025 19:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743042432; x=1743647232; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KGbtKw6dkKl2hO25mmm0qQUQJhNTsE5Insu1IVv2KY=;
        b=aTvGJuWrFrJxZX604YflHeAblAR+avTY/zQvsgD4qeqKcV7AAeIl5Wwris1O10F2fp
         3VzT04OyQJTHxt9MR0X/gvmW9NW7j53Ce8onRcT2kw/EQmIjKaLgSd0gFVAk+st+Zocv
         /kXc3NA0RwCmLxgXJ/oP2g56k/Vcumg3AAzZLBBU/csXxLbtA6NtX4j6lvReoORRSM3c
         aolQbRoXyuLBjNJ6CjpY6PSjL2UYrqLsSqUjwGJVzCE3RMH1+gobT3NVy0BdUc+DY1ay
         k9aPtxku3lRZMtCi1OUtGNbRITKKe9XDpKG4IwKIdKhXPBQHNprmX6kbPmVDsgnJlrmi
         pK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743042432; x=1743647232;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KGbtKw6dkKl2hO25mmm0qQUQJhNTsE5Insu1IVv2KY=;
        b=N8ZKd5TxQUGmGEUv1a/tHkjABv0oeRK6FYX4QuRwRURqBb8uqmD49/UXydnpQTPxhQ
         rHK8VMFMDkg6tmhbqcXKJs5NllgE3/fEFG09cBs0dNrDVt4tLjj8DfdTqmhu/RCfIaDc
         +3Ua+BubtAv6LagWbL4QSxfnoCbKnG7F/mb7aMQDr/zOE7Q/8l3LJGptemH9FYzUY9jN
         p0yqOKWhcE3aHM+ryDzpqdnA6WqehU5v7SkcJqEE/63NM4JPkCD+2BNDJ0xK2G4URcrY
         EHMLhIGbwVeaRS0exKopJ3LU11reLoxXuWR7nN6otHIcJgEM8jkrr5t27mSnuktZwP7o
         9yjQ==
X-Gm-Message-State: AOJu0YyNQAw+adYGa8K/NUT+1uDSXVPlEAG/9v8pvUh3XOmVAQ4JawSP
	rA7IZGaCmXlIDxMeIrARnjuymNAAD/94Y21wMCax96de6OuPpxkGQ4TZwlKa
X-Gm-Gg: ASbGncsP1H5wBJ2VLknYw3InEQlo7GJKlpArJFoiaQ8kgNFAODNWH4pztywSnspmUtJ
	8VVXj+rMdA5taMm7N6crtcg03LLu4e/rss0lTWJQoO0ltbMZo/H28c9tv7iEJJ0gZZADz4VdO7e
	Qejdo1ZTA37oA4bK2ArVUlZxbF4T0YPbZaYlFGh4AnkpJSe14N87uqNauHnXfrrBA8CDbegsiLK
	ZVtmttI8vw4PsCR0gloIEAMj+FNXkeM2c9vODP9vDVHzDT3z8moA2iSEHwMTv37hRtC7VxLDkPD
	wIwyXRZdu3+pGk8PKwJVB4bdY0esbEYQa6VLow==
X-Google-Smtp-Source: AGHT+IFdg9ZgcLG2r/YlnQrBqitNB3F9ipNtn3rsvJDjvWDfmj02uElRV5k47i8EKdvnWQrtqvovYA==
X-Received: by 2002:a05:6a21:9990:b0:1ee:8435:6b69 with SMTP id adf61e73a8af0-1fea2d32fddmr3941970637.1.1743042431987;
        Wed, 26 Mar 2025 19:27:11 -0700 (PDT)
Received: from localhost ([39.184.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a284825esm11810475a12.43.2025.03.26.19.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 19:27:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Mar 2025 10:26:49 +0800
Message-Id: <D8QOYSD6NLCS.OVF4RKHUCX0A@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [GSoC] Proposal Discussion: git-refs Project
From: "Yuting Zheng" <05zyt30@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
X-Mailer: aerc 0.20.1
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com> <Z-FJ3EQdFIkQgtkR@pks.im>
In-Reply-To: <Z-FJ3EQdFIkQgtkR@pks.im>

Thanks for your reply!

I have reviewed the changelog and noted that Git version 2.23
introduced similar work through the addition of the git-switch and
git-restore commands, which replace some legacy commands and incorporate
various functional modifications.

After examining the updates, I have summarized the proposed work as
follows and would appreciate confirmation on whether these tasks are to be
included in the current project:

1. Code Modifications for Command Implementation:

- Implementation of new commands.
- Necessary modifications to existing commands to support these changes.

2. Test Modifications:

- Addition of tests for the new features (including help tests, basic
functionality tests, and extended feature tests).
- Updating tests for old commands to execute tests on the new commands
(for example, changing the command in git-checkout tests to git-restore).

3. Documentation Updates:

- Creating documentation for the new commands.
Updating and unifying existing documentation (including git.txt,
git-cli.txt, and git-commit.txt).

Additionally, I have a few points that require further discussion:

1. Command Migration:

Upon reviewing the commands slated for replacement (e.g., git-update-ref(1)=
,
git-for-each-ref(1), git-show-ref(1), git-pack-refs(1), and
git-symbolic-ref), it seems that migrating their functionality into a
subcommand of git-refs could be sufficient. Could you please confirm if
this approach meets our project requirements without introducing
additional functionality?

2. Function Call Integration:

Regarding migration, is it acceptable to directly invoke the legacy command
functions by passing parameters from the new command functions?

3. Test Retention:

Lastly, should we retain the original tests for the legacy commands, or
should they be fully replaced with tests for the new implementations?

I appreciate your guidance and look forward to your feedback on these point=
s.

Best regards,
Zheng Yuting
