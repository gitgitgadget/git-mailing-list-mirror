Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185B13BC09
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712266843; cv=none; b=tja9iJdnfPVXyafdrSxmZrLfQjke86FuAIiTZ10lCatTV7ksS6YGSx408kP6ilUdZOhbsMDUIphJrncYfdW4gBVrYr03RzJVK1TENhkLAWgiib3uK7oUFLKSRZh4Eu07nVHD3J96l7Qttflp9/4EtiBLGiAELNr5Uf1TPNi3TcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712266843; c=relaxed/simple;
	bh=a/SiryKOfW1B+y2C4yKT06BvFeGQHQIXnLSmuxPHpvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMPnztW69ggmP5B7cTBaru2FEkrJJD3REol9mj/ljr35uiD66+C2jQg/xARXt6gAKkZOUFqOlJEDW9FR/ll504Damu+Cgzg5xYEC6QPqWAOGZSk4UzC+vuU9kWstk5lR7ksspulJIXbiyaT5w/AXTmS+OQWpFl/1lQEbV0LsLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzPVeTtT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzPVeTtT"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6eced1dab1fso1038325b3a.1
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712266841; x=1712871641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQD0dIpPRCFqv84BnaEmmJnasf5tXZEbCBxUXAyaSHs=;
        b=jzPVeTtTevfqh72UZ5EHWlsmIjOv+AFLuNpMXKYk/Y6XYphXimODV9Tr0WNw3At92z
         3kEeMMZsYAgfl0RYW122N16Uth/Pc9IFz+qHFfYcQ/JsGwK+IrhMLJG3D6CWtV+JALL5
         K9VX7X/ZnVnjAtXScrvceE1xOVYafj14IzmvK4nL88l1OklGCjNoWMzV18jiaNkKrTHn
         pic927AdKQof8XHkR4sUrJVAO2dr/Ioaj1SnYrCPccM1436oQ8Gnl/rRpnwXvjZPqDty
         gs+aeulJlSrCGd0IShRhJe84/aBxCShvELWOSQt6mj4ZQ2kaB65/gLdsOJU9uG3kTERT
         j2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712266841; x=1712871641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQD0dIpPRCFqv84BnaEmmJnasf5tXZEbCBxUXAyaSHs=;
        b=jG1AAkC2raXW/w9iKbo1l9+wqh/0gXsGzSnR27YQ8I+FAccrLQc7+fLMtKap7cLNFi
         D2mymGKJcdxBsa9ybncxE6dZkLlfz6E2r6OygTczcB+vPpdP5XvAz5g1lYW0Yo4KtRKD
         00i0D2YoYDyk6R4cz1vf/16dAfTL97iT5dVnM7UhhJkDSxF5khckF62pwo8SYaw4eY/P
         n6cz5AFnIu2EugMfMCFvjZB+gakWsfWzsnCUHm3HygA1YU0NB+ulAB6HItID5sOwHMLb
         7sspS3N74YIlv2PUbLjQyIr2+qlzkx7o97XPsGxWPqjH3Ew9PYQW1qWXQGke3Tu07XH2
         rj7A==
X-Gm-Message-State: AOJu0YzWH3d8nkEWI5gpxLFR4P/zyM+ZWDPTEbCQIfbNJas3qxj6Yv8e
	X5NnIFmnoT0RM1AE/wGkDz2A2Y1jtHaVM6vepInKN/LPBvV3pD+Wo5dEquH4gqhZfgn235v13+6
	nktqD9sPMe43TDMxPd2n4ON8nBXk=
X-Google-Smtp-Source: AGHT+IFU2o7mivAjMV3qvKNcitEJSrvyCeUZ2mAfSVG4FbNovuptGRZRtDG1V8vW1riu96qxaJfv4Yie2H48Tbh/dcY=
X-Received: by 2002:a05:6a20:3d90:b0:1a5:6ae4:dc38 with SMTP id
 s16-20020a056a203d9000b001a56ae4dc38mr4139291pzi.40.1712266841345; Thu, 04
 Apr 2024 14:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712235356.git.ps@pks.im> <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
In-Reply-To: <db66dd4155d80b714719e80ff90f64c1d36b97d0.1712235356.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 23:40:29 +0200
Message-ID: <CAOw_e7b5wDKOcY9hSty+c+z-NWVUgri3h3ScF0qd1Y6cmfsyVA@mail.gmail.com>
Subject: Re: [PATCH 12/12] t0612: add tests to exercise Git/JGit reftable compatibility
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>, 
	Luca Milanesio <luca.milanesio@gmail.com>, JGit Developers list <jgit-dev@eclipse.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:01=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wrote=
:
> +
> +test_same_refs () {
> +       git show-ref --head >cgit.actual &&
> +       jgit show-ref >jgit-tabs.actual &&

This seeks to the start and then iterates to the end, likely skipping
indexes. If you want to test for indexes etc. you should also sample
random refs from the namespace and see if they are returned correctly.

> +test_expect_success 'JGit repository can be read by CGit' '
> +       test_when_finished "rm -rf repo" &&
> +       # JGit does not provide a way to create a reftable-enabled reposi=
tory.

You can do "jgit init && jgit convert-refstorage --format=3Dreftable"

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
