Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5678F2E
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784603858; cv=pass; b=U+84N3NeAwYMyTVGOg2rKQCEO8XDIrvN6poHY6yJE/wfIuLeOM15ann0FDLc7ZujVuoIS9aVlGXpfWSSrQVBmJL+UGO1Lg1P7e560WXy4ODEiVL/ALnD5slZ3bQLB6a5nkGrS7PDB7UPQB+6Rxa9dkaL7iqnhX0GLJRMqcfYrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784603858; c=relaxed/simple;
	bh=SyTBZOm+ssWheDBC4xlVn/BF8P/imobuLSCZp/3K2sk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=cz2SbRDprc3YV6E8QToak6pPo+so0im8M6rhr1m3TChQSOlgK+Dl+yiUbOPuYhIxWRosqXdUnNlFYu+bEhZb6DhlEIguzn+qUlgdmj5GZh93rafwtOOS05V46tHkufy0CjILkXZwSOBJ/dLew8D8cjx4Qz+JwEoeTJhT6oa071c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com; spf=pass smtp.mailfrom=atlassian.com; dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b=qxeq0aF0; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atlassian.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atlassian.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian.com header.i=@atlassian.com header.b="qxeq0aF0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so20194585a12.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 20:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784603856; cv=none;
        d=google.com; s=arc-20260327;
        b=OT8UR4hifDc1urDRQ1hFCplDKUYRmdpkStt3Ra7KDCogTpP0UNoQ32NtaBaSpgYit5
         +0/jKyCclWUr/n+H4gzhaldpVS8x8Ac09mdgCDHjQRunU1EeE6mI2lEl9B9HmqlHqWHB
         piRH38hi3U/LdQkK7IW6fgK1a7f2sjQtP7aX68CnKi+h3Zu+YlSZT8GbU1fRgoeyUXvr
         nat7euPO727vVehxqgbNG+k7hT0Ttjxf2H1yih4Z6lzqsnveFdZEiC6GpvLdqIaE/X52
         XQ3N9l8wKB3n2Vw8xFprLOPJE+BQCPl3P/B1jKTVqTcPGHbJZzLe64+05ori8zccCeo1
         bUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SyTBZOm+ssWheDBC4xlVn/BF8P/imobuLSCZp/3K2sk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ix60ZRAuKH6sWQmAdAUgF34HrNHdMwp2F4Xrlz57+BR54FHUXf495za3fQNfgenVgC
         yZg2lFeWjSlul9JVQRihPBG93BB8NUqNoHUW/ALeOMO38jyumUXjg4w0L19sqD9OoQUB
         1af1nx2sLBda4BvI9BWYCE07YEQhc3T8nW6RCt/5mwMCjJtaaN/RmSsASfuqwPIlj7RH
         uAozhTtjmtVeVnmOHTXTfFQLE/aErQP2+1a+Pen+Ey8Jt8Gm6z7T0PneCosES4G7ndQ5
         jbJ7kEOlX0ziHYNHCowiWn5XjKGxNTPKLDXqKRQuPK3zOalAPnMgXhLS6/xLlBaR6F53
         ax1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google; t=1784603856; x=1785208656; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SyTBZOm+ssWheDBC4xlVn/BF8P/imobuLSCZp/3K2sk=;
        b=qxeq0aF06AsWzLC4BXv7iV9VYmoTBG5P3CdZS6aW9LLStHZ5OIVcFMgVG4mXJXsLxl
         d+rIWYLT+g/judtan+z+iqVvGfns8yheixPDh7u3HB7pcU/NZr5qxxrX8MsnxbjrFv6G
         KS2c5PDSVJbjqjNCm4ktz9vWV7a890+99IR4iIBGsi58uXQ9P092jZUnn+nCHDSsB8eA
         1noUiQCKmq+Uo7NRgp3T9ZtnI+mqeTKVZMpzH/5oqwdyouCdNLAWiI8HeqEoefQgp0tj
         anwaIlkHCUEO5alZLKsPia0A4D0xakoUsZ6w1/eys1+9Hyi+jnAhzUWqfANdHSBQZRlo
         oi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784603856; x=1785208656;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SyTBZOm+ssWheDBC4xlVn/BF8P/imobuLSCZp/3K2sk=;
        b=rnDFq/vfcdOUgEweWlpnqpyvNqNQIPK8/bhuhhozdu7RHgASFJmDJHRddsp0JJCIBK
         gtIDywOmi+UzQte5zWyCiY3owEWVBWRZ3pi0+ZG+dGZoUe/eCwy6ymKCkHDVEGodHd4P
         uhnpB/i4PpppR12mA5ljHPtqN2nv1BRLXCpev7dnwP8qtx/HuIBab6bPOuIGfUZTtJje
         0HQ2+COnCykgx3+nvX5euE5GwDsbZ8G8euFikFNxt7sK0VcG1asOZPO6aufGYtaCvVUC
         ZMiDM131A35nbYDy7r/xcVtbSWwbKrbA1EF/F8Nxl7N5IaREQI4Hyj3GkQ//upz/7wDi
         afOA==
X-Gm-Message-State: AOJu0YzDVEIUXVhtD+V2yv4GvxmHFaCEXDYF8gkXJTQqWi/iEWQjtY9h
	cWZfFMu6nWS2M9w4mE+ul0HnUNWOFAJ47g+GUST5/QvAR2GsFkGQHr3bhUlPpgCKWCVOQ+1t5Kl
	SdKo0ZMSjfWY+nKj5Iju6mUkthDtTiHZC6ccrmEgXz77mJwwW+lGOYMhS20w=
X-Gm-Gg: AR+sD10caGUyAPI1wtw42m/qnhM2j4Qw9oNaLpT+Wg2ZP09XeFqgoEO0uAWOQ4Xi5ER
	uTmjN2AaAdzb1IGy/b7vr0klM1rJSly+kA+0OOwWV6qr9ad1LcCWKg81EoY61sQYZxmFe7Byf9a
	EdSPJkIdxgDdRUCwuOByKN7VUYD0n3hkDr1INPHKnlcrS8kwXcDW6DGaA70YpWQ/hTRwqLWzE5b
	MEDHE59WvoYnWiH49wgk69dd5QTVgLxBYHKq16/W3vQ0QpgchCUUCifVTrZ6ljHfc7B6Us7rtVW
	LA==
X-Received: by 2002:a05:6402:274b:b0:698:3602:d0d with SMTP id
 4fb4d7f45d1cf-69e6528abd0mr5861758a12.17.1784603855797; Mon, 20 Jul 2026
 20:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wolfgang Kritzinger <wkritzinger@atlassian.com>
Date: Tue, 21 Jul 2026 15:17:23 +1200
X-Gm-Features: AUfX_mzgCWHsE8sWWpG3vMNM_iToISVnq7D1kVJ79lZ25BxgDMej8PpxGd8aI7I
Message-ID: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>
Subject: Performance regression in connectivity check during receive-pack (git 2.54)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

I'm a developer working on the on-premise version of Bitbucket at
Atlassian.

We noticed pushes to Bitbucket got much slower after upgrading Git
on the server side from 2.50 to 2.54. I traced the slow part to
the connectivity check that receive-pack runs:

git rev-list --objects --stdin --not --exclude-hidden=receive --all \
--quiet --alternate-refs --progress=Checking connectivity

`strace` shows that after a push, 2.54 does a failing open() of
of numerous loose objects -- once in the quarantine (incoming)
directory and once in the main object store -- before finding it
in a pack:

openat(".../objects/tmp_objdir-incoming-XXXX/ed/58..", O_RDONLY) = ENOENT
openat(".../objects/ed/58..", O_RDONLY) = ENOENT

2.50 does not do this. In most customer deployments of Bitbucket,
the Git data lives on an NFS share. The extra latency on NFS makes
this process of checking for non-existent loose objects take too
long, the push essentially hangs at the "Checking connectivity" step.

I believe this new behavior was introduced in the recent object
database rework. After using bisect, I belive the problem can be
traced back to commit 8384cbcb4c.

I don't know the codebase well, but from what I can see is that
the order in which objects are looked up in object databases
changed.

Assuming there are two object databases configured (Main repo,
and the quarantine directory, for example), the lookup order used
to be:

1. _quarantine dir_ packs
2. _main dir_ packs
3. _quarantine dir_ loose objects
4. _main dir_ loose objects

With Git 2.54, the order appears to have changed to:

1. _quarantine dir_ packs
2. _quarantine dir_ loose objects
3. _main dir_ packs
4. _main dir_ loose objects

In my testing, within a well-packed repo, Git 2.50 actually never
performed a loose object lookup.

The current design seems to iterate over the configured object
databases and perform a pack and loose object lookup for each.

Is there a way to avoid these costly loose object lookups?
