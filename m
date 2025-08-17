Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EE2367BF
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755412964; cv=none; b=NW4eyi0syCQeDDR3IT5zlx8YvR6SkOiJ2b8kWlK3DaX3r2VRiJCvrRSzWogKz87Kd9YR+he0ddJSB1SIOJdTZobDPht4siO2BbsjhVI9mPRf9k6E6YhjdO/sjYp7z2qAx6SAUSJ7wgvhMhy2OtnT5f+fMOIGADbEV9r+SkkMgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755412964; c=relaxed/simple;
	bh=k6J4KMP1XzG+XsgCIgjZOppZW7N3VM8EDQcaqSz5Y3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kL9AGBbHrV4Ql9CyXSaXu0vhUYttGBCPZK2IMd8le3aouw2wN23JD73Jc8pYNdUHBhFfPp193fvavJgmgWvng3EOt8W7etuUAmgC/gJ7560F0jPKzd0UkKKm+dBWbGAFaY3mnKQFxz9Cobz3x4gAFrlZwwrl5RJWR2qcz47hyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1yLbQ9w; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1yLbQ9w"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-53b175736b7so2610538e0c.3
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755412962; x=1756017762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FGfIgOpoKaPFmYNvLPiqT5GdjkIyvAXPbyOdBiZNLE=;
        b=c1yLbQ9wDBDXcxPkLx/rYavWu3Gf/XyneCEssQhjmOa3b8gzfTpR0AsCFWD+h9Xu1y
         EqHudroGI3Cz7ppcOStMCkqhcw3gJ0+NcOoqYVDXaOK2V/rGowgpxYZ13x6mvsYysxlK
         m/TxyPkIJk/SKmqzknzQxeaSiTKMLQK6uka/QSr0q4TN9QrmC4aobW9rHnqSBhwsGuWe
         RlTuaypP6OO+XhYJFExOn4Zh7+vRpAgSaIRvp7M5lPM37FOoMMGJsoyRCl7vJGunHz00
         3kw9y8YqnzPaYMcJK9pKM3mwEkMDHHb4oYACvAwvOpVWGPU0baki9kOzevXcB80Stvhd
         d1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755412962; x=1756017762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FGfIgOpoKaPFmYNvLPiqT5GdjkIyvAXPbyOdBiZNLE=;
        b=jzCTraucvsa+l9tbAIA+Cr5+lTfkfQp6yM+bPaQn6qVjvI7rXzsE7UZvFgXG8euqZ+
         cF4e9abzlhRXc+fRyNcSy7dlEvED1BqxKvq3/6j6QMjesqYkLcYupmVoNks8DOHY0y3Z
         kh1vsvm67Ccw4gSvyDUkCiplk2Jsyio6GFXqJkWgyhomsPaDpERGE9xooee2F2wd0Su0
         g+aH90KQV8dxWdO5GnfAjAcCXvY/ZugHopGCdDpi99QOTOt2QHIG4pXzevs6YyMYQeQr
         meADmjPG6Py9srhguxU/zNy4GJU8iaxnAjpS8LMuIDYLOGXVRvdbGoWgVU4WnxKpf4NW
         Z9FA==
X-Gm-Message-State: AOJu0YyMjeejaLqIdsqH8ONd6HpA3Vy9OLmG1L7QArd8FgCwepfCsfgn
	L1YR3t+KTenBOIgYL/yT8ZvZKYa1cfuLH4cO6u7i4/BXpsQjAJPc5CoZJLrS4mQEOEm/2tzVwvB
	WVqFCKQGr17tJDHwrZThLUg0V+5kl7DA=
X-Gm-Gg: ASbGnctCD7LYtYuJECkjHOKH8PiZ27bQSZz7M/mohy1mShTa1y4B67QlGtnKysVIWVk
	Gwx7G6YznfsFTe0hbyipIQjqrHyq8BYSZvYWUWdMiYEmkSvgV52vMPoHcVuDiDeF9VJ+3jyz3v2
	+WdvXgvNuQybJw/nqSEgrEVScMzac2CqS/sWi6oDbrM2sBxCOznpnptuRH4Vfs38Zze7jSZY/sO
	clAk4I=
X-Google-Smtp-Source: AGHT+IEA/gFIirZuonB9hts44MShQKxHJAeP0ajFYzQxWskWyBGOpvPvFa+IeKWN5zJt2KNM17/0Vv1M99k8nhrFwy8=
X-Received: by 2002:a05:6122:169c:b0:535:caf8:1198 with SMTP id
 71dfb90a1353d-53b2b750b6emr3165691e0c.2.1755412962010; Sat, 16 Aug 2025
 23:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816103656.1693607-1-adam@dinwoodie.org>
In-Reply-To: <20250816103656.1693607-1-adam@dinwoodie.org>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 17 Aug 2025 12:12:31 +0530
X-Gm-Features: Ac12FXyrlDFLdxsd7vmXO5BOqDpmFIzH_aeqgjBg0dG55hyo0SzF844Pv1WgxmY
Message-ID: <CAPSxiM_tOW7iGxMrekazXHSRhQj76vyGQUvbA+yHYWg-bVp14Q@mail.gmail.com>
Subject: Re: [PATCH] t/t1517: mark tests that fail with GIT_TEST_INSTALLED
To: Adam Dinwoodie <adam@dinwoodie.org>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	"D . Ben Knoble" <ben.knoble+github@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> +       gui | gui--askpass | \
>         http-backend | http-fetch | http-push | init-db | \
>         merge-octopus | merge-one-file | merge-resolve | mergetool | \
>         mktag | p4 | p4.py | pickaxe | remote-ftp | remote-ftps | \
Thanks for this change, I also tried applying it on my local machine
and it runs successfully.
> --
> 2.49.0
>
