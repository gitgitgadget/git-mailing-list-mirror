Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5E418DF8D
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758998976; cv=none; b=UtSvWM7/sZ6FRGFuGPE4wGGWAvERtrAfYUxG0uGh+dSobakZMLk3ElTqQYn+Rzdiel+MSH35/qw2R0IT0mSR/nfiDpRr9CykC6jTjp8YfXGO5vKw7X/obWKlc210g+jMhNyxRT5aI/rKbW3+OjCWN/EPCWojWyRr0LjV3Mvsf8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758998976; c=relaxed/simple;
	bh=6lnQobDiQkInrPMGvwzkfGj2Pe7y+Gdk4x8/B8SB3Bk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I3ztjaQltperpq0UQRj2OXIHb1F7Lv1OB8gBhNxVy+G5+DKtOp1jNnOmvI3uNe2jA1hqfujoW/JtoEcH6gX1KucRGGVAucpgdHiIds5MTjQKg1dqEsCiGmINmW5tcZ0Fbg71UoAWdfkyLD/AKElKz687thqMO6ugrYvXwrIr+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSm1Bccx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSm1Bccx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b267ca7c402so48429366b.0
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758998972; x=1759603772; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6lnQobDiQkInrPMGvwzkfGj2Pe7y+Gdk4x8/B8SB3Bk=;
        b=KSm1BccxWrE5yiLbW5GirTdD4Qa3qbJsf/QjhOz3hYzVAuXhLgeOS2piRHjJy98GMe
         L0to5QEnKjTazuFFi3xrUN8myGsLwqtuAPYpFN7U46t5fOjyRfO+0FD49scG50+JyrWB
         zQhDE0cUZoYq7pGA8GvZ6i9A5ICBs7PLFvF/VsPz1wVBsH24FMpFNaxrt6qvUSG/F08q
         5vmiVqQXLZ3jLzbnOD85SiE+Xvsm8mqoYC6sdELbOAQk9sbRCyURYvO9lHEMwBF+720v
         rwVK/KpcI7bH9bppLU9xPa5Kexj2ND7B48SnH8wm5lBICChJ5Buo5ymNVQV7BtvbAcVg
         ETzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758998972; x=1759603772;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lnQobDiQkInrPMGvwzkfGj2Pe7y+Gdk4x8/B8SB3Bk=;
        b=RuNr3CABWJ2lh4N0Hvzz8EjLd5HMfNHlRvCd8FHa6E+tmawbd/9LbmO4AMN9mM1jUU
         +npduIC1HFVc6Lkk4V98CWYHK3nj3nwBP3du/ApXccpxDK9/Nymr3gjAK5dW/hKzhggH
         Zk11gAFNTPWjveoEUOdTpZ8ytM9eSaMaL2nUZuDFAZvzpLDoZ4p1VLlafC7+6G7XH+jq
         ESisCnTLKnvbJ03vK8HV36dtLz/fQlKRkUWtgezOmxCyIFA2vA5eorqCwc4QnxvThUCp
         qYQk6HzvWvZPV1ab9UFYyVfc35iaCj6F1VfBxHs0HtSDQh/CAYKdQXHw6ieEvh56asxV
         julw==
X-Gm-Message-State: AOJu0YwP/ilyvgi+SiUFASq/rwZXDXeW1ai2qtgMuEzTN6uKzcdRovz+
	Ssd0AZ7zXuGNirmFh4OQniAgjyFYJYxv7hs0arQzmaD3g+IFkd4M8rxMGVlVuleCggYj1DSHyjO
	87ctEjVGEIUiR6jfzhr+K+Imer19lsxOrHkmD30k=
X-Gm-Gg: ASbGncu/WoAq0Q4158VNBF/E10TK1cUlzohGJCrjIVmtQAHXZ9tjXScsWvFfqatzcwP
	yl5rfgfhDvG39F8eLxoOti0N6YQQ/WQhZ4h/+k4rdX9lJZq1lW3ohe85cyZJezmGs5xRK50+V7C
	MNom5yZNbrrXH8oFA/0babIJlL7GCAzHzt1eoiVxcQjLFBgjgGPzodI+w/wuxscVQssR+NB0eLC
	wDCM3OGi3dhA//s55qTj8gq7kPH4W4D9TRVSiWHe0M6VMfr96v+ANlrAIF6jZcjkHe8tCaOVVHu
	9Yg=
X-Google-Smtp-Source: AGHT+IFPNnOppOeYIKqzweljaTscn5W+7fih6hpnig3W2V4FKJU+ds2v9YzXqVvc7fwpuwxoH1heWOhDdeQHDhFCKlY=
X-Received: by 2002:a17:907:7b9e:b0:b0b:8d02:f34b with SMTP id
 a640c23a62f3a-b34bb6055bbmr629810466b.4.1758998972358; Sat, 27 Sep 2025
 11:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: M Hickford <mirth.hickford@gmail.com>
Date: Sat, 27 Sep 2025 19:48:46 +0100
X-Gm-Features: AS18NWA-jEMRRtJG6GSjxJfBgzh6s1s2ugQLy5zDcpF_fHoyW5Wucby2QYgt8UI
Message-ID: <CAGJzqsn7BbaVckJ17XhsDHLtmS3OZPBG=oniwe+FRjhEwGc+Eg@mail.gmail.com>
Subject: Feature request: partial URL matching for credential config
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. A git-credential-oauth user would like to define separate
credential config for two URLs prefixes of the same host (eg.
https://example.com/org1/* and http://example.com/org2/*)
https://github.com/hickford/git-credential-oauth/issues/83

I don't believe this is currently possible
https://git-scm.com/docs/gitcredentials

> If the "pattern" URL does include a path component, then this too must ma=
tch exactly: the context https://example.com/bar/baz.git will match a confi=
g entry for https://example.com/bar/baz.git (in addition to matching the co=
nfig entry for https://example.com) but will not match a config entry for h=
ttps://example.com/bar.

Any thoughts on adding support for URL prefix matching?

Example syntax could be credential.https://example.com/org1/*.key
(explicit wildcard) or credential.https://example.com/org1/.key
(implicit wildcard)

Peace
-M
