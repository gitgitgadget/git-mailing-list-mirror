Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E950200C1
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719746210; cv=none; b=ucwIDjgvt6NZV5kERPdv4cjBREAliMwmuMBZtie9j5OKSSHQJ5erDqMRA3fCdDLvBpkCrPb8h4BarxqVlClwM4JPr/l/xWeb97+EuFRHZmEtmoB8QW9ku5aMJlCdvKfjUSxei9c8YmfsWUmn58u3dsPXeyuXov6tS/yR4vea8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719746210; c=relaxed/simple;
	bh=oQNPlxWa9XKWSfWxgPLdIHfaXOqHN+NHDOVQm9EwDn0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XGv7BX483MFutKTTa77DgH9JMTsBnEMW6kPFiwAepG1urApH2f131vTkydtdSXdZ42ZYq+T5OkDH9QX/RlBzFVTdQWXCD/yqvh58ac+h2eRn15E2cy/1qo8L/Nwf5g3HO6xNez19iK9FsHpf9PK5AEIoRCgHhPYjSOG1ewirmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNbYnpYE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNbYnpYE"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso19817101fa.2
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719746206; x=1720351006; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ebzfvzzwjlXlBcpggw2Qy8CGzuWosYICI+oE/vtvc90=;
        b=KNbYnpYEp5tCIIH+WLQbgiv0GCxAn7TD/k6qiE1kPMBNVcY4OeY+EzmNllbFIiy0VC
         0VkI/dxzoSJ5uhKr66QEinpIq6vGd6Gk0mNS+HhA52RlywLhPmuo4eMO5kB2VaAhkw7y
         eIO/KmtjOSChahN5SJtpM6HHgJIDedHCYXtzJFJsRJ1WVJBYpH6P8qSm/e1O9zSKVtJd
         rR171ZXvPfzGyv5aIbMb1zf8g1qtannSYkHTVHjchpvBv0y2P5OzRTfpDXcH62zTu2oC
         1lFsvag2ceFOZzr27liRljI0mDJ2b4SKFsE45NU1Yjtk0EpimIt6cuEZ+1kurq03l+nr
         OoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719746206; x=1720351006;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ebzfvzzwjlXlBcpggw2Qy8CGzuWosYICI+oE/vtvc90=;
        b=NDRx9spBT7wWwYAii6aSlL3ApHUfBwHMN4HtgdhY+ibe9dAUryepv9StZfBlfZJOxK
         8Cng42zWOQdDgfrL41Z0JZp6GIZA/E8KihRUjrP3L1PbBdSuM/CIKlMu08r5IhYu25NE
         hkTZ4ZkQgZznYLX93r+qsqXbx1aXWvuDb438WAHDZs1hhwCHKJWySFR3SA+aHj9/Fi7i
         /0A+fKU8gqPbXKmBIya+BzhKLS96Do3U9IgzHKpLcmId29FuvXkjWlEYxNcdWIGqC7cu
         M/B4qaPF+lAskm8TXsCG5NPftVQE2DsIw588VPuQQV8IA9qvzXGEstajdPVPqliVrFiU
         MCDA==
X-Gm-Message-State: AOJu0Yxq1HarudxABWtcvSRiBs9uVPPnWYxCXqVJ3Eqdxr42i18lmFSo
	WjAqhmBpsl+Z0+Xou+S9GTpvfY7V4yIZx5+rhY4fCKiabTuOQiYf4U/HHS0rMJJhtWhjiMNzmRZ
	TF+oIo1T2kSlqgxRRuxEmg9WjC6H6aquBDxs=
X-Google-Smtp-Source: AGHT+IEpglj6SauaWj9F1pqXp23eo0vFeTrjuJNEi7refUEL4FPusHmP82MP2Du0HkzUzFWpg+Hb1/DVa5vHNetH0J4=
X-Received: by 2002:a2e:88ca:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ee5e3b3823mr20155591fa.31.1719746206053; Sun, 30 Jun 2024
 04:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <bsteinbr@gmail.com>
Date: Sun, 30 Jun 2024 13:16:34 +0200
Message-ID: <CACPtaxbxZV+DPAboY5ijo6AjbsbQm8ep8twM_Ai18F+OG-bDmw@mail.gmail.com>
Subject: How to set a default/fallback upstream for new branches?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

My current git workflow is to have a central repo with a master/main branch
that receives pull requests and I create my feature branches with that bran=
ch,
i.e. origin/HEAD, as their upstream. I push using `git push origin HEAD`, u=
sing
`--force-with-lease` when necessary due to rebasing.

That way pull/push do exactly what I want. I can update my commit series
against upstream development on the main branch and update/replace the feat=
ure
branch on the central version with my updated version of it.

To have the upstream for new branches set up automatically, I have
autoSetupMerge set to "inherit". This works most of the time to get the
upstream of a new branch set up correctly.  But sometimes I need to work on=
 a
feature branch that exists in the central repo, for which I have no local
branch head yet, e.g. because I took over from someone else. In that case,
"git checkout foo" will not find any upstream to inherit:

    $ git checkout foo
    warning: asked to inherit tracking from 'refs/remotes/origin/foo',
but no remote is set
    Switched to a new branch 'foo'

In that situation, I'd like it to fall back to a default value like
`origin/HEAD`.

Is there a way to do that?

Cheers,
Bj=C3=B6rn
