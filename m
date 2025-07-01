Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299893D69
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404015; cv=none; b=fXvJjIny7SZMTuQBI9V+Mlk0q4roYhvdr1QaQmzcUqFBD83FXgTRmBBqeDlFiOI4jq2YIkXlZFVaeH5C9osKYy70eKXoLho8vAk5363pDDY7jXA3IGAxkkGFPAjnQFZjbGF/Zw3+EeXQG3Bnx97DIIY3ZiFYVdENT5Pelh4gWIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404015; c=relaxed/simple;
	bh=Gsv2ihk28p4xFLAialHBnVBahdq2+tDuSP85l02WU3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JReX9UxlEj3at8ay8xQfnqSHtWlKlgbnBwI062sYwFaQQZ4FXmHM7Srjt4vFxN6ho7p0/rga5FD81KoJmO9ig7FPSN4gZL2ZM/ZEgbEgh326Cqg9wn45EJqo6GFwY9g07seyvgrZ33SzZdHwojqhS37a6cFcmg/UbaBFpulYLNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L64znvUp; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L64znvUp"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-313cde344d4so3931830a91.0
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 14:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751404013; x=1752008813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=il/emyMeGxdTCmq4PM17S1uwJgLyjuQ2uJ1srBZJLKQ=;
        b=L64znvUpYvgfp09ixTfRiaVhW+7dOoRTKbBUiyh1mRJUp7DeCRh4+cSv4LmGQJsZz8
         +bB1cYpD3qEIW0EpMcFzOqAKV2JD3AbLkep8k+EP19pKBQMC3vFioBvKs2FoKVRuwBpl
         VqANeWnI+4us86JSEi13XwutOLjJYeRWFqfKNcgGz41K0uKUeyV5twgdF0YuSO1P8GLM
         9e5VXUDNBc3dSZB0432na2pVFHKHn+/zoqMpe0c5VFOsAwk7bbbW8RL25aMZg7qdMRs0
         wLC8slMr9kOfjPa1IHyvSIPbNIWULZd3aDZR4sEi+EfN8fuGP8gh4VnsH8UjO9JvbjtG
         +CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751404013; x=1752008813;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=il/emyMeGxdTCmq4PM17S1uwJgLyjuQ2uJ1srBZJLKQ=;
        b=geuFbJbIhvZ4AedVwBwMzBhEyTElKFSwjsmE8McVhRyZUfzCxqLNEt4pU/BgGRcCDX
         J/yVvJBWPaZOuJVEA6wgYAs8nCYBbrv4fqJcJkwo2DLaTltqFi41zWO7RU/iBfEJd7h0
         Q2tPzfLuXgcIP+odRgqgEGmULbe9SNkkXXCFgDS0k0SVS/8O8zJLbRiPCBmuxMxR2FAM
         5E//GrGpa9MX0vb6Rv3z5UzMW6L8M5yUlfL37TuSzDTLjJnNvwNquA4ySpq+wZeCfM2r
         8fAc3oeULyqMNO0FIiKvWSCQvS9TrfPaECNyWx2RaGprfx0iIvE+QFjrnAvERSOhVmRf
         bIMw==
X-Forwarded-Encrypted: i=1; AJvYcCVoFszSPw6tcMfolHMgq8W4VbjowhoVaUEHWdwyYIS9rMzV+tXEmNpgZ5JeZUmK4EiDsO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfSQ289R3DfugQon8BSgkS1kYwlJtQBfPHSNb6EixY1TFOv0T8
	PaDhFYmMS9GPeHm3javmlxtTxVZXqIuV++CQUrEyY8cTyz2ikNScIsFYJuiVCA==
X-Gm-Gg: ASbGncuYTp62vZDDm/Mk+UG7Fs9+q78jG1kOe8NaJy8Gzk/C4RZ+4CRX2EObM86Y4Fp
	m+82AzodQJmF5Bq4hOIvW6AAIxQncdUvDFmHSzWyqTf2yxOZXun45Wp+odaIfSfHPVAzEZhM56X
	Yud2AQBLgGfURD8ABX/RiQvn72rbdW8V7lKbyWuqGXTrz+ZJap8opK7+2hBYho6399VbrBPza5S
	BTZFd8f/qv+rln7VITjan5Klg34CNloPjyZ9NOLGtEZaNoPIRlbjsXIzkqhZqfRTRwHTTZjgN1t
	euqPp4cLJtHy4HbL7dWwyvBtsRxl9Mj2iCzh43yJslBjzKzNqc9ybDaHgu5tD+BZ80h0y+I61W8
	fUQCZQy9BsafJgA5H7RhKJ/ThB1Q=
X-Google-Smtp-Source: AGHT+IEKXUDFct8h7BEK23GSIlLCZDHa392Ul4edtIe5JVMmpMFS3p43XCeHKELMVE+Z7wrK1ucqFg==
X-Received: by 2002:a17:90b:2752:b0:312:1b53:5e9f with SMTP id 98e67ed59e1d1-31a90bed455mr684718a91.24.1751404013200;
        Tue, 01 Jul 2025 14:06:53 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-315f5437e97sm16095755a91.40.2025.07.01.14.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:06:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Toon Claes" <toon@iotcl.com>,  git@vger.kernel.org,  "Jeff King"
 <peff@peff.net>,  "Taylor Blau" <me@ttaylorr.com>,  "Derrick Stolee"
 <stolee@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 0/5] Introduce git-last-modified(1) command
In-Reply-To: <f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 01 Jul 2025 22:35:13 +0200")
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
	<20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
	<f0c508cc-5c6b-4c4b-a3f3-0cdd8d1071e5@app.fastmail.com>
Date: Tue, 01 Jul 2025 14:06:49 -0700
Message-ID: <xmqq5xgbk4d2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> It feels like the command strays a bit from the usual patterns to me.  For paths/files 
> that is.  I like this:
>
> ```
> $ git last-modified -r refs.c refs.h
> 062b914c841329a003f74e1340ea5178391274a6	refs.c
> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
> ```

I am not getting this example.  Unless "-r" stands for "reverse",
the above looks totally expected.

> I ask for two files and I get those in the output.
>
> But for individual files in subdirectories:
>
> ```
> $ git last-modified refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
> 3691fe72d927658ae77ade7fe967544fc6739e67	Documentation
> 062b914c841329a003f74e1340ea5178391274a6	refs.c
> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
> ```

I am indifferent with this outcome.  I do not mind the tool giving
Documentation/ even when paths inside it are asked about, when it is
not asked to go recursive.

> Same as if I ask for `Documentation`:
>
> ```
> $ git last-modified refs.c refs.h Documentation/
> 3691fe72d927658ae77ade7fe967544fc6739e67	Documentation
> 062b914c841329a003f74e1340ea5178391274a6	refs.c
> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
> ```
>
> But I didn’t ask for the directory first.  I asked for two files.

I do not see anything unexpected.  Have you seen "git ls-tree"
output without -r(ecursive) before?

    $ git ls-tree HEAD refs.c refs.h Documentation
    040000 tree a0f7113f63a19b70dff14bfd9f8f82809f5068e1	Documentation
    100644 blob dce5c49ca2ba65fd6a2974e38f67134215bee369	refs.c
    100644 blob 46a6008e07f2624239139cd8b2ff712545f07d3f	refs.h

As I understand that this tool was written primarily to implement
scripts like repository browsers showing https://github.com/git/git
I do not mind non-recursive behaviour being the default.  After all
I view it as a plumbing.

> I have to use `-r` (recurse):
>
> ```
> $ git last-modified -r refs.c refs.h Documentation/git-last-modified.adoc Documentation/git-config.adoc
> 3691fe72d927658ae77ade7fe967544fc6739e67	Documentation/git-last-modified.adoc
> 062b914c841329a003f74e1340ea5178391274a6	refs.c
> 47478802daddf3f9916111307f153c6298ffc0bc	refs.h
> 0fbe93b36c05bbf4156c157f27998938ce312265	Documentation/git-config.adoc
> ```
>
> And `-r` with a directory like `Documentation` will recurse through that
> directory.

Totally expected.
