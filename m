Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D638B7C6
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747294; cv=none; b=ll6c0ux0chq4E3DENxl9ur7jPYgsjTFs5NvkGY3mbbYzsLXkVYmY91LeYCs1IXT1BQBSFyjWdQH2I42gnwZ0oZtrrx9nVlBLnE0F8Fj4VDyFv0gGyMqDgWXlt3nr1dvZYRLhR5JMGjMQpquF7LXg7oXVNnyJ/qhbN9DXu+fPvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747294; c=relaxed/simple;
	bh=wd2UAg69Ay1f6fYZ2/mAPs4x1kk8K4zpk6nm2z78u+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6B73NrDZgY+D46b53nquAZM/hKKr10DVKral2Uab+YGR2Puxjp1tvjvoWKZSMAHMvdZyhNZv5a3GgSKDmbdr7RhMLeIC39pS9XPsaTvhqKdroyfnu10ePnH39Maye1vIkq9vMFY61Xk7OZ6gsh2q1kr6/ZSvsmjbCjEJGemU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJWgPAHh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJWgPAHh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-354a2a7d90fso662767a91.2
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770747292; x=1771352092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BS2xyitEK/n3Mtka4JcFjG8WJcYTak4U0pb2mHPh6hg=;
        b=bJWgPAHhMjOWz6uz4qHeSjD0U0fjzQVCMyUDK7vRGWwfjOW/nABjOekuYUa+tHCLhQ
         Iw+DnjqPli/XjSpWnFqpmr1QAc9UI9maOW1sWyGvaNj3SiVFyelVtq+zO50Uktq9C1XY
         XVy/qt6wk/8VG6ZE4fnMelmAN8DmGr3uh92Svc/EZ2giy2/ChLopmBusDWTj/urhH6IC
         aiPkOjmh3CKf65NsFYw5mWmff/mgemf4k3Rvw90cZnfeYJXpta1jqp+67vJ5usXP7mIB
         L4VJAZFbqXfWKMAfO/CRagcwDmHAGQbgnH3VMv/vdwOs5XrkSUjS2UBiQtrDfBMjLgcx
         cZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770747292; x=1771352092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BS2xyitEK/n3Mtka4JcFjG8WJcYTak4U0pb2mHPh6hg=;
        b=J4GLNxlutuYsjKJEP81bVg5qQ1oBMhoMuGAMYt6/dgj3UwlFHmTthXir+y2bMFFqXI
         uXdlmGXZ0proPrOAJGqFBCu+LlfWo+qqYZdepvPuroARvgJLaGFQrPX4C0G1RzzOxA+9
         F6wrN+ilKaUdQEP5EXoIKZDqPx1lcifLe11V3eh14Lg+rNiR4OQW/y2PQOX3lmbDIMu6
         XqZjgtTRzYNoQB5UXdeboY5Rcmn4mtwhsfc9F+4XocZVz7wPCZmdJX46FjXciY/EpBwn
         WibJHAzi6gf7id9H9uJ6VMrg2r778fWQsftjBeKocf5dcHqu/bDAnK9nd4gDdf62M7ID
         WYNw==
X-Gm-Message-State: AOJu0YyCd75jF7OArrph1tc4r/uzCp0oFunHuMdJZjKQfgke1HzxSkyO
	NU/JQZYUxByVTY39EdTMbk1pZJhsynNZC0v79PcbpFtfHh35OAVbW9zXjHUQtQ==
X-Gm-Gg: AZuq6aIr3+ra8vyoWanouvg3X7hirijlcVlfK/DW42wsZyebJS8o/7YrrndBOLZPOPZ
	qejP5cvwA+dG9epvD4pZ4xdC34aS7t3suOPS+WG7bI3k+hkpKTnxXXOCo6bSYx65w2QaFxzdVtP
	meWyJhcAgdbB/YGHFz1z1gPmnF/mUBHOAlWtnnVYMYmKRAwZ65JW5cjbMbjSVkNq84lI7Act3m/
	c/ao9MHaIifYb9Dret7BnCFIc5NpyNs8JL59tryGZP+uOLgQpVXZmncADQiHmWx0n3lI6KtX/YD
	vxpXHBC25Ihj+FH1hswzhM3bJmF1EmGqfmx1bRF1ipehxz2ptdsvKB7Nkea9fTMWIEXujXv1zPv
	UpkYc7+1VfrQoFNYy4h60GwBLy5TR3GMl0ANQ6ylVzInE/L6OLjUTs61hg9kwynWrFzGnoRYsvp
	7TT4inX60sqZweqfNMOxgDFe0ZzoA/FKazqfprgFT693U551+ad1XZlKIjesJbGiUEKfhsqKjCB
	iTh8vg39suOGO8lK/jzUG5488/mDdJ801dRqgh2M67fCwuygg6OPDaI3d6eHr6/PCoB1vhWDkbt
	uNB4GVGk
X-Received: by 2002:a17:90b:240e:b0:356:41c2:897d with SMTP id 98e67ed59e1d1-35641c28a26mr4460780a91.8.1770747292401;
        Tue, 10 Feb 2026 10:14:52 -0800 (PST)
Received: from localhost.localdomain ([2409:40e2:100c:822b:c98b:6ad:2fbf:bfff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567aeebdf2sm21112a91.8.2026.02.10.10.14.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 10:14:51 -0800 (PST)
From: SoutrikDas <valusoutrik@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	valusoutrik@gmail.com
Subject: Re: [GSOC PATCH] t7003: modernize path existence checks using test helpers
Date: Tue, 10 Feb 2026 23:44:45 +0530
Message-ID: <20260210181445.49380-1-valusoutrik@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqpl6d4wjh.fsf@gitster.g>
References: <xmqqpl6d4wjh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> All the checks involving "is-missing" are now stricter than the
> original, in that they used to allow "dir" to exist as long as it is
> not a directory, etc., but if we audited the code that leads to
> these tests can never create a "dir" that is a regular file or
> something that is not a directory (which *I* did *NOT*, but
> presumably you have already done so?

At the time of sending the patch v1, I did not do so. Sorry about that.
Now I ran the test from start to 11, since test 12 was the one with two 
of those risky changes, ie `! test -d dir` and `! test -d diroh/dir`

and after doing that I can confirm that there is no non directory dir 
present before test 12 starts. Neither is there a non directory dir 
inside `diroh`

This was the output of ls -la 

drwxr-xr-x  14 soutrik  staff  448 10 Feb 23:16 .
drwxr-xr-x   4 soutrik  staff  128 10 Feb 23:14 ..
drwxr-xr-x@ 14 soutrik  staff  448 10 Feb 23:16 .git
-rw-r--r--   1 soutrik  staff    2 10 Feb 23:15 A.t
-rw-r--r--   1 soutrik  staff    2 10 Feb 23:15 B.t
-rw-r--r--@  1 soutrik  staff  128 10 Feb 23:16 backup-refs
-rw-r--r--@  1 soutrik  staff    2 10 Feb 23:15 C.t
drwxr-xr-x@  3 soutrik  staff   96 10 Feb 23:16 diroh
-rw-r--r--@  1 soutrik  staff    2 10 Feb 23:16 doh
drwxr-xr-x   4 soutrik  staff  128 10 Feb 23:15 drepo
drwxr-xr-x@  6 soutrik  staff  192 10 Feb 23:16 drepo-tree
-rw-r--r--@  1 soutrik  staff    2 10 Feb 23:15 E.t
-rw-r--r--   1 soutrik  staff    2 10 Feb 23:15 G.t
-rw-r--r--   1 soutrik  staff    2 10 Feb 23:15 H.t

And this was the ls -la in the `diroh` directory

drwxr-xr-x@  3 soutrik  staff   96 10 Feb 23:16 .
drwxr-xr-x  14 soutrik  staff  448 10 Feb 23:16 ..
-rw-r--r--@  1 soutrik  staff    6 10 Feb 23:16 D.t

One thing is that I am not sure if what I did is ... the correct way
to test this kind of thing... I just copy pasted all the test commands 
into a big .sh file , did a git init -b main in a temp folder 
and ran the .sh file from there. And then observed the changes.
That big .sh file : https://pastebin.com/9QQD7qYA

> ---if so that is worth noting in
> the proposed log message), then "test ! -d dir" that is rewritten to
> "test_path_is_missing dir" is actually a _better_ test.

I am sending the v2 patch after this message. Should I have just put 
this whole thing into the v2 patch cover mail ? 

Best,
Soutrik
