Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D215AF6
	for <git@vger.kernel.org>; Sun, 14 Jan 2024 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLY66dkw"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9ef2422cso9848709276.0
        for <git@vger.kernel.org>; Sun, 14 Jan 2024 12:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705262755; x=1705867555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ABRx7U/a702iCAjvqB9BXJci4RPCKe08L5J3Dg1p6uk=;
        b=wLY66dkwK9A18y8Zg6m+csZx6O7oL2CEXcVbVI013DyC3EqImcQGAhCfr+Q56cpcJz
         VHKGODKmm0hmJpmpIqeBPdSIo5eIhlDF3VLTY2pBKcJH03Y9FMg8sp4xDfTnFZQRBpDG
         4HSkg6asDeQIwR7U8l6Ta8iVKaguTFVzGrhoDr53aRv68LtM+SxXXhWinHTSvGshtd/w
         IzJ9U0ghZdBO9VnYvvsjqj5uf6greOHwYUq+ARclHk7sTBsoFmTqZuexHhuAy/OLqjKA
         130GOhCFxacACyo2jtqKvNDOVa1Vy3zwW4Ca82w6ChbKqYQWvPMwKp6y82d5R2dlf2UW
         VCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705262755; x=1705867555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABRx7U/a702iCAjvqB9BXJci4RPCKe08L5J3Dg1p6uk=;
        b=HKyxoQEphfrHaDdyhtEet1PaYadrG197FWyONV5Tx1d6hLiuJZsZ8lcZOeezXe9tDA
         Fgsa0nN6iglHBEsQ4ZCseuKvHP2XR2+KEBjlA9y9/hJ5vZMij5fYJL422sPb3mDX7z/V
         i3r6QMOzazaAGKOekKoSvgOufhne7DAulJX7pMlQbe06XyW+Dmi2eKf9pyXnnecRt5EG
         AimztfblAi5kcL5/UnK+ZdrsBUYbAELBJLTKuzR0y3OF/tTbNBD7PFFh6EfcF4NmPIwN
         5hu+SJ4sprHxm+jSyr9MXDV3qqYWWcWYnLrUT1peNmGbPp0BUNKmc/5dw8z7W1tjaHwp
         rQHw==
X-Gm-Message-State: AOJu0YzefU0/rsuQEzYYhqhCWu1jNKDBrKTQcVf/lbojmRY6AZR4a290
	MJOXd/kVEK6AWIBnowWLslmAgg4iaWIzupoqJQ==
X-Google-Smtp-Source: AGHT+IHHknIMdLvnbxWrkvljOgkarZjEl+zPjGgArjOmv4Dbq5SSgnAUI4U41vDWHPLJnF5PnUaZjXwAUIE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1002:b0:dbe:ae9c:ee49 with SMTP id
 w2-20020a056902100200b00dbeae9cee49mr194042ybt.6.1705262755067; Sun, 14 Jan
 2024 12:05:55 -0800 (PST)
Date: Sun, 14 Jan 2024 12:05:53 -0800
In-Reply-To: <owlyil3yhv70.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
 <xmqqy1cx9dm4.fsf@gitster.g> <owlyil3yhv70.fsf@fine.c.googlers.com>
Message-ID: <owlycyu3ista.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 00/10] Enrich Trailer API
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

>     interpret-trailers: fail if given unrecognized arguments
>       (Summary: E.g., for "--where", only accept recognized WHERE_* enum
>       values. If we get something unrecognized, fail with an error
>       instead of silently doing nothing. Ditto for "--if-exists" and
>       "--if-missing".)
>
> The last one is a different class of bug than the first two, and perhaps
> less interesting.

Actually, upon closer inspection I realize that we already fail if given
unrecognized arguments to --where, --if-exists, and --if-missing. But we
don't explain why to the user because no error message is printed. This
commit has been retitled to "interpret-trailers: print error if given
unrecognized arguments".

Thanks.
