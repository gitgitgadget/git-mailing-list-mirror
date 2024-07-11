Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0D045014
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718140; cv=none; b=sImsHSuFfA+b6fjqU6EMBrXKWOB2ByWku5QmIFyaGYvU+K/AdF11VqTG21aD3Med46MsaU9XdWW5Q02KSRmQwF5CjXz7AxyPOz3JR/diOX8VINoBzilW+R4yfd02yPjNwlDvJcPUYWThfMDWHsMo0jIH09Qa5NXv7zzSX4wbNOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718140; c=relaxed/simple;
	bh=mnPb/vPeuAG4oNBgqGUiSeFawoCrZWxyl+k9M44zNsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhizclGY+OCLL8kuXU39woIu+Zfao6qD76MUxCMNoP43lHfF/SXH4IGCqm+JYyD2OYQLSZBVdOB0I9gIGa2FhSSR1HFVL3dA9ynFPfmwRBr7mjZNF9Fx1zbxmHbhyi7eJRLLqUDyJAY+nypmubZSRGnRArE8oEMF/tUPhW6qR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5def3916bso6099326d6.3
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 10:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720718138; x=1721322938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ClWB+k3Y/nCsS/590lNQMXQFtTydXm2bCjWQ/1vTNc=;
        b=sXPG7kRyGb/M0ADKzsFXPbhPXADpS7Y5BZC+/pUyVXOoveunlLEuolQbyeOU6N8XY6
         mZKi5tFXWJoKjCh11Wo7uBIQ/mZehBJmS3L3B97oLjh95jV/2GJ2Ez5SVG1o1mupzy01
         iDEyPq3d80MmwqgjIi2I6IkQkJnYTrvWf6e8PvL+isma8kdLB62Q05+tbexUT7TmBIht
         UxiIOoLrlld7dC0dxP2bwVgVDDMsNirOFNcQd3ygOXS6ZTUPH04HCDPKfPBqcpos/I6R
         cowZ80wBsU+vysWNcZm/akVeU6/Anor5nRRrwyrPeTzaU4g2kogbUaVXyLsIfh1hZ92D
         +mDQ==
X-Gm-Message-State: AOJu0Yzrx/EPhbHR3Wde40ftfcPcEUpUtwTrYt5C4jqYPEYt5B7KBDEu
	AxLtMiNjLLpcTI7CccnF6ZwTqB3RUxpE+m8gD3+h+HpjuAnx5bFKqpaWvCp0GGsvudyzU4rG415
	DE33/Q1TDT0MZkiG4Doi9bW9Ded8=
X-Google-Smtp-Source: AGHT+IGIHwpVUzrxnswRqsdkvE0iR4mK3VR78i2QY1MuEmxZlA3Di0nggy9isRyVd3EgBtEzX2EyEnEc7H8tMsNAvsA=
X-Received: by 2002:a05:6214:482:b0:6b5:e5bc:3d42 with SMTP id
 6a1803df08f44-6b61bf131d5mr117682946d6.34.1720718137929; Thu, 11 Jul 2024
 10:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711132542.9792-1-anthony@loiseau.fr>
In-Reply-To: <20240711132542.9792-1-anthony@loiseau.fr>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 11 Jul 2024 13:15:26 -0400
Message-ID: <CAPig+cTV6e=D3L3my5igCewnDNyx12o=j+AAqRCry-UFiQoASg@mail.gmail.com>
Subject: Re: [PATCH] git-gui: do not exit upon prepare-commit-msg hook failure
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Pat Thoyts <patthoyts@users.sourceforge.net>, 
	Joshua Williams <joshua.williams@qlogic.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding the current git-gui maintainer[*] to Cc: list...

[*] https://lore.kernel.org/git/0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.o=
rg/

On Thu, Jul 11, 2024 at 10:04=E2=80=AFAM Anthony Loiseau <anthony@loiseau.f=
r> wrote:
>
> Targeted issue
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> git-gui is currently unusable when prepare-commit-msg hook fails, since
> it closes as soon as user dismiss modal error popup shown on start.
>
> Proposal
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> Next mail is a proposal to make this failure non-fatal. Popup is still
> shown but not in its fatal variant (which removes the "you must fix this
> before commiting" unwanted sentence), and git-gui is not terminated upon
> popup dismiss.
>
> With this proposal, user is clearly aware of a prepare-commit-msg hook
> failure but is not denied to use git-gui and can even commit.
> Pre-filled commit message content is likely empty or not filled in this
> case, which is not a big issue.
>
> Other hooks are not affected. commit-msg hook and next ones are still
> triggered upon commit action, telling commit can not be performed (fatal
> variant of the popup) without terminating git-gui upon dismiss.
>
> How to test
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> cat > .git/hooks/fake_failing_hook <<EOF
> #!/bin/sh
> echo 'FAKE FAILING HOOK $0' >&2
> exit 1
> EOF
>
> for i in .git/hooks/*.sample
> do
>         ln -svf fake_failing_hook "${i%%.sample}"
> done
>
> chmod u+x .git/hooks/*
> rm .git/GITGUI_MSG
> git gui
>
>
> Anthony Loiseau (1):
>   git-gui: do not exit upon prepare-commit-msg hook failure
>
>  git-gui/git-gui.sh | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --
> 2.45.2
>
>
