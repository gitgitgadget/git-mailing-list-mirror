Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576925A4C4
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800111; cv=none; b=eWXOj7Sn2sNz8A7RgSW9fdTReIJv819jQplHHsK/Q0s9HZre0ot4TNCgsycArHcHCs8WZvJzat8PT/daIKJhXAN5tukOW/3/0xUMv4iYkKWGedNGEgpjipvCwCgAbrd6DYWT7Fc5dn/iI7ZuJoQFOmMo6o0zden7nGh/P79/fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800111; c=relaxed/simple;
	bh=HMrPDgOItHh5N9mslooUkB3MC8VAdu6D0IiHrFg5F3Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ksIGoTQO1GOcNvMZvG13xVfYgiDvszsmgBg8imh2L+wQ2hC/s17MgvOzXxz1XejD0p8IzgA0cX/3kcbIHj4ZX9utSNwap1A4WBxd2/DkqBttiVVlQ0bfuFkhB3B6CM/G4Gjlinz7EjfUjXdHDVa2moTlEyJYNIE7Nhoav4IyE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGkmqZ6Y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGkmqZ6Y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29c75e348afso3647701a91.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2024 15:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710800109; x=1711404909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R0B+C9Ztuz3EgIOpY/IWwmk1whKorW4z/1UF/Ulu70s=;
        b=RGkmqZ6YzHecMPHtt01s2wJDpPWBsmVv5cLl0cKI4tCXU1XPlNb1dNNn3GgGHUnfnb
         FcgHTtO7LJ1oF4Cpps9BwMbJa+HhRxqG+OSLUzHXchHca8WWctA5Zaad6u3ss4CHj/Cr
         5uUuQZ0TxHnoUhuFVe301cOwzonYnV7inslyrL5/DOX8yumzxqA/5tqR+2VTY35CCRL+
         YFf15SvbXVeDOC/RI8awjd1T/6rLDP77vhx9nBUttHcx3FmzTqwIrmwcLFmr/y0n0XKt
         l88qeoIRpw3aWzepzIfw5zhSIGlzMgLg2o4T07m1H6Ay/GdomSHprBijf1BZ9FAt9/Hw
         zMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710800109; x=1711404909;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0B+C9Ztuz3EgIOpY/IWwmk1whKorW4z/1UF/Ulu70s=;
        b=lv5CZ3jaAcLoyKiJMk2LevYyHxmClrEyfOL9iV55Lm5qofRb82/Xw+/B+sFway0aTK
         VSL1qt8n6z1bhBgXdX78eaa4KFSDIO4Fx66Tmna/EYFuhvsKISL2MduVlCtjzyGGRQNO
         oXHUqXsHD/spRojBK257G9zeTHM/vS7ItYsrGedAeO3zM8z9AUNQYdssk1/r5mkoLUpl
         6kYWn+F5ImmIjMQfBBc+kjg7HPZ+zSSldaov8Q/ebuGl75FTUhD5CHiZN6+6DU74IdJy
         rEYfAciT3dlQ8jjCqbqZsDDPH3aDO3GUrfIG3LLXR9+Ka7Z/dkTWMXYKwpl8hakCJ3I3
         blgQ==
X-Gm-Message-State: AOJu0YxCd4/rynxXEl67VDa8k9+xs1DQA5ser/q30v3OrYOByS9GzDe/
	fWnSq8nKBL4Kkfm9oWGTTAsC/qjpVgh/w+7sD1MxSi5yDBi31Pln4OY6o/4CBQbU2qh8/nEn4pQ
	DhuV8rXwlFDsOrWPWOKDwnnixI+U=
X-Google-Smtp-Source: AGHT+IG0dQqSyLNrzN+sLyJ6+FGvO0ajZVRO/rtDqBLmjES4asLCZxXcctDIwu/m/5tXFPGCnc9JHviA8SJYISyVPN8=
X-Received: by 2002:a17:90b:3005:b0:29b:a4d9:b125 with SMTP id
 hg5-20020a17090b300500b0029ba4d9b125mr830668pjb.30.1710800109414; Mon, 18 Mar
 2024 15:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Mon, 18 Mar 2024 23:14:58 +0100
Message-ID: <CAOw_e7aEPE1QRsqsgvdBVGkk2uFo4e080wWbM5dsVwkiSpYcbA@mail.gmail.com>
Subject: [PATCH 00/15] refs: introduce `--auto` to pack refs as needed
To: Patrick Steinhardt <ps@pks.im>, "stolee@gmail.com" <stolee@gmail.com>
Cc: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I had a quick look over the reftable bits of this series. It looks OK,
but here are some comments. Nothing blocking.

* reftable/error: discern locked/outdated errors

It is not obvious to me why you need two different codes. Is it so you
can print the offending lock file (so people can delete them
manually?). FWIW, this was based on JGit, which has

              /**
                 * The ref could not be locked for update/delete.
                 * <p>
                 * This is generally a transient failure and is
usually caused by
                 * another process trying to access the ref at the
same time as this
                 * process was trying to update it. It is possible a
future operation
                 * will be successful.
                 */

* reftable/stack: gracefully handle failed auto-compaction due to locks

It's a bit unsatisfying that you have to use details of the locking
protocol to test it, but I couldn't think of a way to unittest this
using only the API.  Maybe it's worth considering removing the
automatic compaction from the reftable-stack.h API, and have the
caller (eg. in refs/reftable-backend.c) call it explicitly?

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
