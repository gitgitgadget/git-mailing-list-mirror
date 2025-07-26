Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE07263B
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753537484; cv=none; b=t+0pSh/lM8Llr1dDG5QOF3cTlPTlT1TEqz5EtZiTN1lB8pXHfCGl2P5hTydCVY3AKDM9I/WzvYiEij70yIfrFb3Np/JqyZP2Xvuoy7u/DGnwYH9jxKbVc9RefSynakg1coHm1zpA4fLjzhGukB2u4h58BbGGsTGWeXBRJl1w4ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753537484; c=relaxed/simple;
	bh=Khdx+O8lcqwNYDAJAQLQ8Q00alBwOCYnKDxwhuoZh30=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qLyIDS+bjtI+G+P4uWqcNRPBpIWPfThQkHa26NaU1U7tEhbodYkL32FdpHvtv9N5ml2pK+6lHrAHEwFd7IuvR91L94209oXynY/ouCpivXQ+WkQ3FPEvrzp2ljAru+PDJXCCdQRFnzab7XncMOg3FxLjLWs3axeBTJy51AiDMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5GdYMJr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5GdYMJr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so640470566b.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753537481; x=1754142281; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Khdx+O8lcqwNYDAJAQLQ8Q00alBwOCYnKDxwhuoZh30=;
        b=l5GdYMJrPd+r01vISPdgDPhCp9ihoIUBDkEOC0HxM6CzpbDFOeEIosK5hWBhFlpvS3
         gpDLm/GviC9hcJrvwQS4h9hpIjuSoidygp0l2isXK7P5XmrL5PLe2iMPByPxbrOMTk1m
         M+zbr4I+eGKZjWl1+RGo3d+P7Wg1xZ6csfVo9ZjCzIQziMX53pODHGpb/fNTpam3mG2j
         X/bces+tI4dHdUeNZfnlPX7a42K3n4REkse/2Ou6Z0JZgJJkroQ8I6B14rfJaPyojDtk
         3do/9P8VBbQ9R7SfjjdfpDQOBwnksd0l71k8xEhITEnsrFxXSCvdZjcYI6d4AX0CTPt9
         RaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753537481; x=1754142281;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Khdx+O8lcqwNYDAJAQLQ8Q00alBwOCYnKDxwhuoZh30=;
        b=S5Xw7FG7KoljcEdFAe/htdJpyI4EQSGZx5BZ+6fedS8OCUNxs9o3xaUm3MAB9mBs4V
         XbjA4VDFh15qytOz+0A3rMAkErTmaAm2TjaTpw24quDnYvAwgrwnNz2NvyoTjGKtVNwe
         ZcMU9OYn3/CKT0W0XkZdrEYaYZX/ZqmsDP5UVhQSZ/uHwRgYlVE+D+NxJo4GqLzuYeuE
         ZfpsizjRxxhxQW+lLxLeOFZ4dyIwgrtQfEDSElEMthYXM4xu5YnEyX5XPYfP1VwSTRbu
         A3VuznaZa5z4jiCecXWR8jalmuL6bu2pPY9zWJ61zMlB4gzGtNZfol7esNRuqAf/BStg
         cNTg==
X-Gm-Message-State: AOJu0Yx0AE/rjB1Fpvj1wojkvASpmSHCsRGQEJeH0jPKMYGMN8HLV7iT
	pS/6ai6jiiCGUTuCyZWAWQaXsUyOM1Kq6VW8ltdnGvpIRYyCeyIeiJZDVvfmTvyiXMwHXseXZ5D
	A2BR3g/ECIRcIbHAdaXPr4TKwsqYzt6EDCClmOfM=
X-Gm-Gg: ASbGncvcZCaq6KKMyPewZOtDtVcFS2ASxJ7Hv7h3sSCJ2gSUikPRQxAfoeJsl7xFmjs
	ew0S2tOMoMB4zw3jqlqnHeXbn/2P56Dad4s6bGvS8j6YWVYV36IGKHCwmRk9Aubb0sgk52UumYF
	ctNX8jrFvJWsDk7PrShS51rm7jyJj15UedQjd/QZm1eKKV/AmWKwWcw8wUnhi9mNCHEi4tkdxae
	QBsd2WxELcWELx+g4SPEjj/KvKAmCq7eEYZsjlv+w==
X-Google-Smtp-Source: AGHT+IHKVyAlq6NZttaTXj4KOXvg7Bb61OtbWnMfzKyHnx63zK5/kK1AMLDOFy7hmeMTQ5MYPTmzl7GImF1bK5giYR8=
X-Received: by 2002:a17:907:868a:b0:ae0:bf99:6c5d with SMTP id
 a640c23a62f3a-af4c48081efmr1052280166b.26.1753537481242; Sat, 26 Jul 2025
 06:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 09:44:30 -0400
X-Gm-Features: Ac12FXz06WUPuetCGSJfCna72kbmX-eS0OWcneUN2FJTL5Zb6axmyWXgPegseYQ
Message-ID: <CALnO6CAOOTBQf3s9B1G8AgwcbYnv5VNY63q-6bGPeoaLy208rg@mail.gmail.com>
Subject: Why does git-grep appear to treat exclude pathspecs differently?
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With Git 2.48.1, I observe the following behavior:

- "git ls-files :^:Documentation/RelNotes | grep Rel" yields
"RelNotes", as expected
- "git grep squash :^:Documentation/RelNotes" yields the error

fatal: ambiguous argument ':^:Documentation/RelNotes': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

- "git grep squash :^Documentation/RelNotes", "git grep squash
:^:Documentation/RelNotes/\*", and "git grep squash --
:^:Documentation/RelNotes" all work as expected

So I suppose, upon re-reading, that my question is really: what about
":^:Documentation/RelNotes" is ambiguous when handed to git-grep here?
There are a few revision syntaxes that start with colon, but none that
are followed directly by a caret, I think=E2=80=94and :^=E2=80=A6 can't be =
"revision
:'s parent=E2=80=A6"

--=20
D. Ben Knoble
