Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2EC446C5
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481295; cv=none; b=eqtXbklj1fmyezYyYZwlivmWZ56VPvDq1DtPE5tkvRj1cK/MncILFJ+bz/exrriLguhcHz2Ika2nDWaKAt1mcQCTZ5SzRxivf43amNt6GieEeQFUvVrNV9jd0Et7fhTDqP3CoUHKZVru6LZoAPx3S1YECUs2ZhWotb6zMwBlKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481295; c=relaxed/simple;
	bh=Q+q/y6uZT6blpKYsM+HtyVb3QeEi1rr7swsSTExZ/Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk841qWStS95G/7EeVZ59ibZNhdVsAKBAjkSC01Od+xUQxRrs7XQSWhFbkR0pc7KanmaLSABAROwcYUQ9Eow2hvL9IMt4wbk+LguBQ5yUCRtmXYajfRcMrRNTGWVP5WpqWQB2vSEex3zEccmT6aMKjv6VTnB7D036A6i5XP90vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivlFMkEV; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivlFMkEV"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bd72353d9fso1902052b6e.3
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706481293; x=1707086093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqtZyW4IvS3bvGHhbR9BSu6WC1gV015enXjMxrNzJiA=;
        b=ivlFMkEVtZmQC8TzNX306zBiy+risC5Ms0nqa3lxnv/OYI2NrYl4a+n0ewH5Nyuww+
         ws2TGNTG9OfFcnZozNuFQCp3ikDxQlGuECsu8TuY2CsquTi6bnjgkqdhYFqSA6F3wcDB
         euGxJoWwmy02HqC/Km0SQ7B/kb2KYbQoLfylhVy8aFMAO9XG7SJ5POob1o+ct3+c1s3x
         1kWIxcFMZC/0107pk4ksMeQ/YUuI0IrxBtTdXaBSlCUHr84EUWXs7ky3AV7WApm3w4pO
         j0XNK5u7iT5iqacBpS37xvm6JMDWQFG4CZ8NVq8ycSvSSPqhPH0amAFEeYjM7TXXz/dh
         Q7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481293; x=1707086093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqtZyW4IvS3bvGHhbR9BSu6WC1gV015enXjMxrNzJiA=;
        b=ZKIdSdMzNpmvv4vx6Pmr2I1pmF2fsSHNo0T6N/FLaO7fzEveTg9pf3r7pzi4GE3hv+
         QgyPgLS3XJyQYd6VGGf/6myNcW62kIG29pRkFk5bZSzOv8tWeQEoKlyyyzPY3IRKN3sG
         gDmC/U/t4m1GENpT4c2bHXfCg+ptF4o3wdbvD5oWVDGUjaG8tfr2IUpF8gW89mV8zph+
         BY4Ho7XLYEGRPK515tBNbCyq6GTmM4xq2zIYeR+RW8w3W0sTTKpNU2mZ89Pfnuoae9LE
         WQIZBnSUM7lUi8GIxhy9Np4x3JUOBy5k3vpZHdaY/P8TvPaNod/m0hT55+5bvqdKt9lP
         bcAQ==
X-Gm-Message-State: AOJu0YzAPrLAnhRUzCtRX6FydYPwqoM7CQYVYSmdrO9z0rBJjbh3kaXX
	3MK0wYN9naSRs8CH6BdKbJ+3Uda2dbR/TwjSHXTTqs3qVJl5/xsO+zlNW7P0
X-Google-Smtp-Source: AGHT+IHb+/ISfEdsGRI+Kvs42hNjzmZktLzDU+gErzfeLVbrWl06Ra74vKVkWnaISeEdTv5VRAF6BQ==
X-Received: by 2002:a05:6808:2012:b0:3be:4cbc:ca14 with SMTP id q18-20020a056808201200b003be4cbcca14mr2432312oiw.19.1706481293440;
        Sun, 28 Jan 2024 14:34:53 -0800 (PST)
Received: from brittons-large-Vivobook ([209.112.166.194])
        by smtp.gmail.com with ESMTPSA id u33-20020a056a0009a100b006ddc335ab6fsm4580279pfg.158.2024.01.28.14.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 14:34:52 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 6C71852027D; Sun, 28 Jan 2024 13:34:50 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v4 3/8] completion: bisect: complete missing --first-parent and --no-checkout options
Date: Sun, 28 Jan 2024 13:34:42 -0900
Message-ID: <20240128223447.342493-4-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240118204323.1113859-1-britton.kerin@gmail.com>
 <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --first-parent and --no-checkout options to the start subcommand of
git-bisect(1) are not completed.

Enable completion of the --first-parent and --no-checkout options to the
start subcommand.

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8baf330824..2ed600244a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1478,7 +1478,7 @@ _git_bisect ()
 	start)
 		case "$cur" in
 		--*)
-			__gitcomp "--term-new --term-bad --term-old --term-good"
+			__gitcomp "--first-parent --no-checkout --term-new --term-bad --term-old --term-good"
 			return
 			;;
 		*)
-- 
2.43.0

