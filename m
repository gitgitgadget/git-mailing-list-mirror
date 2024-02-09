Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9767E80
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471563; cv=none; b=VJFd1cNn1mTQEsn+rWL37SaDlvDS9sV/ou1jdousezdRI30CwuiLfySWOEjm2YHIRacYLgxedHQdmzKkQv3c/RvfvZKwgG9XsgXqvpd84fGXpOGwqC8iz/sB/LY3IseUvkKhqmKEbAiLkfZu0qBz2iVtjP24Qbo4jSJ3K+oH5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471563; c=relaxed/simple;
	bh=KSsQ4W7ZwwYdjqmg+H/l8eWlqyCHpwmFub6EPKLPXPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPDc5FWaDqYj1xX9T5HZyokkIjDf9bz8UmOepsCsObyfQ/rRobuZhfLwlf/eUj8Yor5uMhSAJ6SCYfDtNi/ZdqtYMYoz0+Jj6BSZTbLCHF5e+KX1VHLq/onP9zScWkPiTOf+XdDbsk7LQqJC3h0VnFYUyW7bWGHO9Geclteow2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI6dyOY6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI6dyOY6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3bf9012637so31950266b.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 01:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707471560; x=1708076360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhhNH18EC+tMS5IAQ5eTwke9Qq7zj6c2ItHIALRaHvs=;
        b=FI6dyOY6+NgaFQrYmy99/QDUrz5l5zNB996Tb59QhN/H7bAcAhCOogaCv38h4fsqBq
         ST29OwxAHhqZi5v943C6QfqlEcrIefrIgOrQZrCCOfTmI35xYZjyIIcJq4dU0snr0PxD
         q3ctdhrFMhpKEGTcCgQPYM/VRMdNftvhyPsf31mIOFODbkM0+g4rSh+QmD6xX/JEH8lc
         +HztNbO1DrL0i6behQ0M0ZPrF/E0XpVjhbeHil3nyXISjaq6Hu5P/WC4OxTfGowsSPKz
         ylZFRbU04pnrxDrcfFr0bxrY3cedP42UOcw3JMU0Z+27xuNJh9j4rr/j/4iREPOJm5S2
         E+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471560; x=1708076360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhhNH18EC+tMS5IAQ5eTwke9Qq7zj6c2ItHIALRaHvs=;
        b=eV9+tZ3WFyS3pTtjOtJw73Af0owNxia4gGDPS2iNHX292tAMroEU+P0ZMz0E2jXI2e
         8eGgrB5J/mxe4Ye4+1lZqtM/6MeMRWq2FZ+bVa7TijVloRRY/VYQ0pbbu/ow+N0cDrpJ
         BjF5Qvy9nClWtewhkY9EIXJs9zGpIGk6mm9uA7Cts+XKHOo4yXg8gvZMutDLCSAUfiBp
         +ayqj+C2YeTO3mzlxi/vGKydziUMuApbrIFi0m6Hrr8rgnkJ5qs+rnf9UC+wZ8J0yGWJ
         lmOvGby/40Qux++QTw8qWuWb26BUtpr6g5rSK9cZBa1/Dr8v4xzX3NxLyV7dOq57q4fR
         VOaQ==
X-Gm-Message-State: AOJu0YwJOSPP75+ek4LaL+jnKOGErxPN3bF+yjD0YRuf+pxJvKjrDh56
	WkbD0EE8okPal5cIMjhESjtaOmj4YytZitCAjSREUJgt1ZmmKMYF19Rbt/F7Mlj4IN4xQrSeOEM
	eHT6+6xJEsJZ72OwGVHGH81cqO4RwLAEe
X-Google-Smtp-Source: AGHT+IHhD0WB8J0RJvzkh9lrT6ZAgaLpUNi3mDuG27Yil+0g11Wpbj3c8CRQBxMMQjULjX0PAMobHnO8r9zic/eQmiY=
X-Received: by 2002:a17:906:80d0:b0:a3c:5e3:ad19 with SMTP id
 a16-20020a17090680d000b00a3c05e3ad19mr21616ejx.57.1707471560050; Fri, 09 Feb
 2024 01:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <24a42fa6-7bc4-4a3b-8bf4-a0ef85dc457a@matthieu-moy.fr> <20240207214436.538586-1-gitster@pobox.com>
In-Reply-To: <20240207214436.538586-1-gitster@pobox.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 9 Feb 2024 10:39:08 +0100
Message-ID: <CAP8UFD0eNvMrUDshZBfrE+3WbRWGr6oa-o8Q4ecrLcY1-vhyFQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] minute "git bisect" doc updates
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:13=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "git bisect" documentation was a bit sketchy on alternative keywords
> "new" and "old", that are used to signal if a command is from the
> part of the history that is newer or older than "a significant
> event" the bisection is trying to find.  Here are two small patches
> that improves the documentation.
>
> I am trying to flush my "stalled topics" queue.  Here is a small and
> (hopefully) easy-to-finish one.
>
> The original discussion was from early December 2023 and can be
> found at
>
> https://lore.kernel.org/git/CAC4O8c9ieZC4SBJf54ZuTfAvnkhGuDaibBQ-m9Zw_n5V=
hUFPag@mail.gmail.com/
>
> Junio C Hamano (2):
>   bisect: document "terms" subcommand more fully
>   bisect: document command line arguments for "bisect start"

Both patches look good to me. You can add my "Reviewed-by:".

Thanks!
