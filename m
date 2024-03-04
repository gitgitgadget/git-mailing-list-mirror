Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B816166B
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578009; cv=none; b=bdfu7qz9t2zdbo8Olv4bHSRpL+4IHeJ4ZEF33vdIhQ3OG5WamiHMEKF4a65IwGMX6ORaTbOlzpoh9Y1K7oK6e5qp8JEz4quuWKWOliwf9J7maHPpDnQIX8uxsV0kMzj+Jd4erOBndOMhEziZyQfyumo0OLkUbIIYdU/a7unekTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578009; c=relaxed/simple;
	bh=FKLnV2zMfUB5/2KIBpt+Q/hwEZZ+8OgQs/g33LDpB8M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N8ZiQ/ECulann5dlrda4qA4lBVaxNJQfcawkdjrcI3iyedjJcpE8jl9WGjPVlm0T9kxEe+E3gR1TC3KFTluiZm/LMTPl14ZcxYw7BaGVDzG9Jy04MtlHqM1d6KbY+tVI0uQsjwbDgsATs65b2WBgYRegFtzPnhPLuxjhDt5NGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6V1/zer; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6V1/zer"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d2505352e6so61074531fa.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578006; x=1710182806; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Cd3sXDftTBIa7xRU9AaZk/dLGhoNfrjofXc+eNjlAk=;
        b=l6V1/zerHClsEMyjLOAyEcNxAiCh+qRvH8tfcJRLXEveCNRqxQCQTH90NiVgXrrmsL
         OrN3NwKtbEFuUtL02pY7a4MvT0/XIQvQoSFUaGBwhn45I1RDXANNKad4odN/+OJ8k7fR
         RaUGa10HuVk45hx5e6spoGF6XPe7hsR//uLDCYuna/fzH/ZY7XgcsAWa0nN99V32jB1A
         uvNWUgHY+t+UTKVBxSCbKd7dGuLed0OKdK1/MHQ6Ol1pOocJ/GTEFJwbGYL4FSWPlE/F
         Xwgt4L8j8EUwLBHc6Ej2TFhcOzURrLIbuj7dNVQ5vCTLBTCuUQhEH4bWjo2EVEeBBhZm
         xfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578006; x=1710182806;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Cd3sXDftTBIa7xRU9AaZk/dLGhoNfrjofXc+eNjlAk=;
        b=tb13SSNIMtBIb3DuDTehVyEq9DN+nXqWUKWQi9Pc1gliUOJesthL84t5E+RlJ95RtL
         rChEUNECz/g9u/KVDPpRXruyPOumCiMwZLIU8IJe15WAzrbW/6bZijKQ1EQjUfGp4+BA
         p7dMdys2CarLHFs7OhvrEFnxGiuMZHXZFvjTyw0YPNDiby/GNvG430PeNnGsk1c1/dl2
         otzjEVtahvoRc0DLy4ObFxSdzUiplJagwmY2LNmtd4Ozctgxq02AHUzuw7Igud+Yd69N
         j11Sh1CHkVQAqgyafekMNCbvcQ7sqQi32YfQXdKwayUsNpzh9xYdWuBj/iXEvI63gjoD
         I5vA==
X-Gm-Message-State: AOJu0YxfvxOrtadd7ejJo4SryWSrfNyYdIqyrTlTDmgrCTmysizd3r3V
	KyhTYCo9LxCIstJxOml+i3+4AE5R02opVwLSAl13xXwUCMrKwCF5gcG+XHrY
X-Google-Smtp-Source: AGHT+IEjF/7lmrJHqgdV/nDwjxMLACo6ylbgwg6IQoBIUmPbuhvY//DqNmmM7miknj+bMG7++pcSuA==
X-Received: by 2002:a05:6512:ea3:b0:513:2858:6a67 with SMTP id bi35-20020a0565120ea300b0051328586a67mr7483560lfb.63.1709578005839;
        Mon, 04 Mar 2024 10:46:45 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b5-20020ac24105000000b00512e594e235sm1838012lfi.242.2024.03.04.10.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:46:45 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] clean: further clean-up of implementation around
 "--force"
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<20240303220600.2491792-2-gitster@pobox.com>
Date: Mon, 04 Mar 2024 21:46:44 +0300
In-Reply-To: <20240303220600.2491792-2-gitster@pobox.com> (Junio C. Hamano's
	message of "Sun, 3 Mar 2024 14:06:00 -0800")
Message-ID: <87cys996nf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> We clarified how clean.requireForce interacts with the --dry-run
> option in the previous commit, both in the implementation and in the
> documentation.  Even when "git clean" (without other options) is
> required to be used with "--force" (i.e. either clean.requireForce
> is unset, or explicitly set to true) to protect end-users from
> casual invocation of the command by mistake, "--dry-run" does not
> require "--force" to be used, because it is already its own
> protection mechanism by being a no-op to the working tree files.
>
> The previous commit, however, missed another clean-up opportunity
> around the same area.  Just like in the "--dry-run" mode, the
> command in the "--interactive" mode does not require "--force",
> either.  This is because by going interactive and giving the end
> user one more step to confirm, the mode itself is serving as its own
> protection mechanism.
>
> Let's take things one step further, unify the code that defines
> interaction between `--force` and these two other options.  Just
> like we added explanation for the reason why "--dry-run" does not
> honor `clean.requireForce`, add the same explanation for
> "--interactive".  Finally, add some tests to show the interaction
> between "--force" and "--interactive" (we already have tests that
> show interaction between "--force" and "--dry-run").

Looks fine to me, including the patch itself.

Thanks,
-- Sergey Organov
