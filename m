Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AFF383AB
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770890; cv=none; b=tjV1uVm0FeyI28TbQAHKyNL6iy9tw4LMu4A2vw03V/Alop7Cp++jQOCD8iSXuVoUg+4vZ61OEiSAtufuwYv5FtKjGA7NfPBNdalqsdlRBcI5e5jZeuuFjrAns3WhNoHICWhd4XOnfwXVQtRX9HfJcavdpNb0h93cMV/8a0r3U00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770890; c=relaxed/simple;
	bh=fxtl5QsLbmXUwKWE1O0BT3TZQUI2mPg5FMgs5SPUmT8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GKjWljtnbN52vyPV7Eqo3sV9Vyh5Mz2nS29w+kw1tNNAEItDB5wLl7/eK+9zlRgsonOF98r0YBsEXGNkQoOSvn8PCRjzeXQFeZwkSA3RB/uVs+iG2n/rA9zeEFu53BqNcCR0KNv9yB1fAjzDOVzSH+vd6RLtJOxMDhcXhI/uicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQ/O4cdy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ/O4cdy"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83562f9be9so141749766b.0
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770887; x=1727375687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9DHN72HpQKFskjTfZ3OItgC7RJKcK2akx2ELBFCbec=;
        b=GQ/O4cdyBPMw6Zh13Wp/dEGGgQvgT2yVPLZt6wvnzt+V97Fuz3tlTkOa74j+9W/ivB
         qNyTb4NSxa/k5ULvcvNhG1iB23YJpskPz+rmtimWl6zKCVsru5CymAXQq26NYLsnBzBO
         qxpe88U1URmdYW1uL6qlY3fwynBgS6FarJsOHkSYaw+peU6PmwZEcJZWamsr+l9Ib/L6
         C5aMs/7ABkio7WIHkCu/BjyuRSVoLh7EWABentRYL9SCr0G+j3GEM3YTdO9D4htf4SYV
         ktppXscLz353kyIWXqQ+YytCx/6f0cpdPv4hbFruZ/a7p7ndt4IwG6NRnweroZslZ4gX
         BfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770887; x=1727375687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9DHN72HpQKFskjTfZ3OItgC7RJKcK2akx2ELBFCbec=;
        b=NYRc30zBbji6mxA9Igj0YwkBQMwXMh/U7nd02/J3SKGY50/5zUFBNsftu+IuHkOlkI
         Q6FjXWEn+GoxXj1WFn0LP/9jPSTHnclNfWWGad/WnYsdEG6Iyh6EGCoGZWpCU/4wAv6T
         hBPJx0AZn+FtDdOIAb8dT8NvuRBzWNQE8tu9ND3Z0TfX4Suj60dGavJaXtm1XYP4TTJM
         NpyVOAu0iew/WgG7EpoMTEYYOacxKVRhl8G7qWv2W4hp7gn0RnuaFG4M/pciZHtlbO2Y
         8Ei5cm9HAw+ON/4MHygYDfc/jX6JF7poCEH6EPz2llbBPlS02U/KgdmrRC8EVZK6VfkM
         3BNA==
X-Gm-Message-State: AOJu0Yx6A+RJNw+xaxrCgjdhWOYuh7TjSBnx5Q5XgqBJrU4Q8HZtW7Sm
	dryzJhPgXa6Vc00zU3nF1JHSfrSKoKaKKdf0leP08QpyEPfJmmsqlb+zhw==
X-Google-Smtp-Source: AGHT+IFEHHs4sMzF0QEt/2LTfDbO1Wx6W7ZhZB3RiHE8Cg7NpvRt89WR0PGMJ6kUZYW7kUJ/TBO+Aw==
X-Received: by 2002:a17:907:e2db:b0:a8d:5184:d94b with SMTP id a640c23a62f3a-a90d50ee9admr11356666b.49.1726770886431;
        Thu, 19 Sep 2024 11:34:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b385esm762181366b.141.2024.09.19.11.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:45 -0700 (PDT)
Message-Id: <4f48fced7296c6f924ad4ff1646c5e1c9635742b.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:24 +0000
Subject: [PATCH 04/20] git-instaweb: fix a typo
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 git-instaweb.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 994431c8872..8dbe21d5887 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -612,7 +612,7 @@ python_conf() {
 	ln -sf "$root/static" "$fqgitdir/gitweb/$httpd_only/"
 
 	# generate a standalone 'python http.server' script in $fqgitdir/gitweb
-	# This asumes that python is in user's $PATH
+	# This assumes that python is in user's $PATH
 	# This script is Python 2 and 3 compatible
 	cat > "$fqgitdir/gitweb/gitweb.py" <<EOF
 #!/usr/bin/env python
-- 
gitgitgadget

