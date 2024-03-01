Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FE4438E
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292564; cv=none; b=Zy5quCDXQtDpDzzAABDfMDSNOXOapIqeejz1NKYKozB3vNjIeUVSyjeHNLwjvc9lSnnm2YiTmN2gTaZjPL/WmXm7JjXPwmMw9ms+N9spnYNkUSs5pTSmt1NP3wcMWyOtxDG/euiLJO49v4O9a1S3jN0Dodwpwt+8vsZST1TSx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292564; c=relaxed/simple;
	bh=IJGJjgHDViZCSOte61jfeLsQVTBOkcz/pr+cHGDqsjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSH2c6kL23bllStAWYv6v1jEPgWKrTj58LbrgLoN29wTHbTEEESXZ0uedr+Zlvk9iagnm54MHbufJfIAdsuhMAq6ZcE99yZB/1qMiaC+DocZl7ryEz6uqPRq9ltxkl0JLVcARKU6C5ylOrEYiNreJ86HNOKI17ivVsSgsGve3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8MPZlMs; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8MPZlMs"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e49812ba77so956049a34.2
        for <git@vger.kernel.org>; Fri, 01 Mar 2024 03:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292562; x=1709897362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fD2X4vp3J2G3WQtU1MZ4uy/HRKdGej6XLVaJlx4sAtI=;
        b=k8MPZlMslxJPEvfsX6odTqA9RWzqpbW1CRDW/pIEjsXqbSB5rVy/JoAe6AV/apnMMo
         j5tHkBv0isXT4t23Ygk9HFLrGesogJ0eUgTA8p8QcmKsV0iDaSxsh5NyXo8//HS2BQld
         pE2mxadTSEdGuncXwriVmkfZol5J5ASOfzTeQF7tCAEbdF6v8/kH6HZ+GZjXcdpOOtXc
         XzTxA11TS+yPyKH9eljnd9RF5oE3ZhATWhZ2Q9YY8ddOA7Y7/PdVUO+uzyLX2GV7iU3w
         77Vvj14pB5bA0n3kF2u7hmTOcnbyxA139AGuNz9KGGFqlpqT7qY0NnPTQs0BhK+j44il
         MXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292562; x=1709897362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fD2X4vp3J2G3WQtU1MZ4uy/HRKdGej6XLVaJlx4sAtI=;
        b=rg7xnavdy+IyfrVTcx8MCTfQ/cPGcIc2/7ot+xhN7m9ds9b0h06Q4e7DTwzirtMHPm
         gcTlOxMGzKXyhNMW8EFnX+InBP8eCU2cFQWMlq3Vc7QRhw0loVdvTGOWLEo0siCcihof
         WcaveiDmGDPOyoI1jhw9+HSu5KkR8hscGvUkx61EBpDddsKnS2KqfGsfnveI15U14Clj
         6BZpSfI3EMOqtBEFqp0Xw6f/PChJMQTvF0oiWQ+DIg7Z64sJu1r1Gl+SKA0k8OxGWiKN
         vqGBDvH3hrVeC3Ixz6SSLAFrPCaNFCs9Vq9lWG7gTflSYL+T5DnqDwY/Dy1Rc/fO9qW5
         nmmg==
X-Gm-Message-State: AOJu0YzKJPzvRYO9BbyDSfLSZzbYKsXDxneS/asO4x5wJpipBvOzm1hY
	ogQy3CbfGJkITNQETLkADJwf7ZZH9+SeqQq06TE+KPNDxxOEF0TX
X-Google-Smtp-Source: AGHT+IGMcSEtHKhv5kIaxxeqRumTgrtjjSndTgKZmJF4OJsQFbKdgDkv3gRQvmlDBRZ7cC8diRx1Yg==
X-Received: by 2002:a05:6808:f0e:b0:3c1:81ad:f45f with SMTP id m14-20020a0568080f0e00b003c181adf45fmr1629708oiw.28.1709292561818;
        Fri, 01 Mar 2024 03:29:21 -0800 (PST)
Received: from ArchLinux.localdomain ([2604:5040:11:69e::e973])
        by smtp.gmail.com with ESMTPSA id d23-20020aa78697000000b006e484e13454sm2750395pfo.32.2024.03.01.03.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:29:21 -0800 (PST)
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] t9117: prefer test_path_* helper functions
Date: Fri,  1 Mar 2024 19:29:14 +0800
Message-ID: <20240301112914.121184-1-shejialuo@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com>
References: <CAPig+cRfO8t1tdCL6MB4b9XopF3HkZ==hU83AFZ38b-2zsXDjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for your comment.

> Although you make the test pass by using `!` to invert the result of
> `test_path_is_dir`, the complaint will nevertheless get lodged, and
> may very well be confusing for anyone scrutinizing the output of the
> tests when running the script with `-v` or `-x`.

I have run the script with `-v`, I have got the following result:

  Directory trunk doesn't exist

I come to realisize the fault with your dedicated comments. An assertion
is an assertion.

And I am impressed by the following idea:

> Rather than asserting some initial condition at the start of the test,
> it is more common and more robust simply to _ensure_ that the desired
> initial condition holds. So, for instance, instead of asserting `test
> ! -d target`, modern practice is to ensure that `target` doesn't
> exist. Thus:
>
>    test_expect_success 'clone to target directory' '
>        rm -rf target &&
>        git svn clone "$svnrepo"/project/trunk target &&
>        ...
>
> is a more robust implementation. This also addresses the problem that
> the `rm -rf target` at the very end of each test won't be executed if
> any command earlier in the test fails (due to the short-circuiting
> behavior of the &&-operator).

The command `rm -rf target` ensures an exit status of 0 regardless of
whether the `target` exists. Thus the code will elegant make sure the
initial condition holds. I think I could add a patch to clean the code.

