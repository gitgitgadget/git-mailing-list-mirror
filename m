Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C511CEAD3
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738874088; cv=none; b=S0Xce2Ccm8v8dijAiFx+5rv6gy5/84s+6aJ6cPYG6oE/QS3jSlJQpeBOo+kvKC1uM8AdKAXmu9qoeSO4PacGj5WxTCTsmocTiSdQ5nGrCqwykHv3tSbpVqlZaU/Jpcr3ucaPts7CCmsBYGvhZjroQUevAC85opvu0Y3DT2yTemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738874088; c=relaxed/simple;
	bh=ed7o4ey4MGraErwTgZKZbJ8XNq+0sG31U/nDd/gaasI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uJY4X0WzokUo1Z4xNmN+f7nUeT2NA5UnmE7y2CWlq6IaETSjvmxL8ASnVUBFlFP05CwH7wQeCBXHWPseHFr+R26mpCsY5pVxzu2trokNAMadH0zAo9WgTv3baFBoNc7hqQh99v/HF7bj3luVmULq1ClzKWQUkbc4EGnaSE3vxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS594GqH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS594GqH"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa680fafb3eso18965766b.3
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738874085; x=1739478885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHkXy0NbHQ2xLNn6CuDdjry/8jdZwdb1YxMwTgLhAR4=;
        b=QS594GqHh7qhFS3Aur2i/R1IIecpshyVTyv4pRg/t7g2LJ3N7imu2nV4dcfq24NsK5
         0/aGWv9BXTuNRH+mV3H6de2vfPnzxjbvW7ojaEApsRCyi4vxC7rdMQ4G84QdHGZ14U5m
         eLFLOqSDcxWczhMs8FckNtKS7lEtAdVmuX2GV7AIUAvylTWJZGImRYblou3zTuXsaxr3
         xWcV8Pz+wM7KUjUQaL6mk42tzc/N7+wME0GvjIHjQmkTprvhVZZUkFBXQmMOR1rWbRyO
         1YhYK0zyhsmtcPN3F9hlS9pq1XvH8+VwgSkBderB+7vw7j4vzM2Nrqt5BXMBvzD/BuAc
         YMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738874085; x=1739478885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHkXy0NbHQ2xLNn6CuDdjry/8jdZwdb1YxMwTgLhAR4=;
        b=hT0t0jVwGRsccg+EYUciXg6KaMBbooaROU7XnAHdA8p1BgO83gpultwntVZPy2+l7A
         W/TzA41Bnn+JBFVcUWj58MliXIjEpvsDu2rhopPm3xOhL5I04tsQginEe8B54+vVLjk/
         XhkncDQFdUanMU7ENWUSgTVQaXkxmhVOpYVmmt+AYBNrGuZJT/LP7lZPrMjWN549K4Ww
         RxO6Ewibrj+G3OFinIVsAsrs9PXA4xHo2SzRnVtScOK2y+q8V5wUcSUMQSM1ybajiGbI
         onosirvTQNZfQ0HNG7qBGwB7DkTSFYrcIR8vK/r46zu5pUQV1tNwhIqjBDNoo206IIPA
         Vs+w==
X-Gm-Message-State: AOJu0Yywnbgd+eVh+Rqu2MfYmGpIpFS+z8/2f33QaqU808KIangB0Gzs
	aM4QF2aYHvgIi8jAOCKf26PtUvlXdTSM4i6WUhOXzvPDbmUosntiA/ui1r6my34jICBZexVFX2W
	F5ny6CQs89Db/Rja3oTzkNUHBmx9vstat
X-Gm-Gg: ASbGnct3YEVnptsik1X5G36/aak9nWuA1e03R3D7LOrnYCc0WdkBPP+Y49FZoJHi3qt
	/AW4OgJGkGrC1KO3BLeIXrC6dwKH0EjhA0WD5sqbT3EMCJK8sctVyZLn8cGoKhJGvpL9kSQzr
X-Google-Smtp-Source: AGHT+IHx7HZxPq5VdOAe72JnmDZ2/cvY4PnOu62+bPSg6XTfFClJRUbUk+KAo6SjgcT7TGTcKASd2qk0BySWiCFekNk=
X-Received: by 2002:a17:907:7b87:b0:ab3:7812:b3c2 with SMTP id
 a640c23a62f3a-ab789a65a3bmr16418266b.2.1738874085051; Thu, 06 Feb 2025
 12:34:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120015603.1980991-1-sandals@crustytoothpaste.net> <20250120015603.1980991-5-sandals@crustytoothpaste.net>
In-Reply-To: <20250120015603.1980991-5-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 6 Feb 2025 20:33:00 +0000
X-Gm-Features: AWEUYZkH_x4OwXncOhbnJssASsxyQ0Mwyfx3Qm-fO0yI11a89gIqpEuZc7oJIH8
Message-ID: <CAGJzqsnFNfK6DEcbRQsUB4S8qVBnQ2PcJBgbvCPYLd-xAVVQBA@mail.gmail.com>
Subject: Re: [PATCH 4/5] doc: use .adoc extension for AsciiDoc files
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 01:56, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> We presently use the ".txt" extension for our AsciiDoc files.  While not
> wrong, most editors do not associate this extension with AsciiDoc,
> meaning that contributors don't get automatic editor functionality that
> could be useful, such as syntax highlighting and prose linting.
>
> It is much more common to use the ".adoc" extension for AsciiDoc files,
> since this helps editors automatically detect files and also allows
> various forges to provide rich (HTML-like) rendering.  Let's do that
> here, renaming all of the files and updating the includes where
> relevant.  Adjust the various build scripts and makefiles to use the new
> extension as well.

Hi Brian. How about also renaming SubmittingPatches to
SubmittingPatches.adoc? This is AsciiDoc according to 049e64aa50
(Documentation: convert SubmittingPatches to AsciiDoc, 2017-11-12).
