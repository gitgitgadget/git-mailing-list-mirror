Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7252E64C
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712413329; cv=none; b=VgVxRd86o5dQ2A4cdBlRwFi0HDz7OdAazHeEq4T/uxl3HgYSfNa+XN3iZkJ+qAFDNUZSoTkHSnScjlTnuXBYrNO2o0hPMcCzBY9JKAuwvx1KWmYUpJ4VF+H9soiRa/JpJx8sTsLgZknVI1RBMG0s99Y+RZE8M76epYszZd2jI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712413329; c=relaxed/simple;
	bh=aGXoev1vs/c1kNIO8+fZfeq8C7BP9EqiF+MzJdScaMg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VgAO0c6YET8gMqEqRBpEW+pFxMiuJZRy2OkbqCOM6ZbUEPOmiv+ouizq9tn3GhR1/K5FfFPmtCD0gnEPDiG3dHLto6K77NZwxkjsTwC1kc9X+9lxw1Yq+SYDCHIVKkU3pBthjD5/Cu2m5UFO+4a8gLo2jQbPmWlJA/WILv9T8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHlEonfX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHlEonfX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e2e09fc27so3047905a12.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712413326; x=1713018126; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dMt+vFkxPGBlAO+ngsiuItSMCTEXeadDp+uzTBeTWmY=;
        b=kHlEonfXkhS6Quefd3acvZDplMZMsg3ogWuaNq5CMmClTOTn2fePyAUjstb5MgjYL/
         aNfcm+gG3pIydVS84C4hDVGD/BRuO6pyjl2wBqyVC8/YhBIZGcmqUmGq9rajT3Yza/5d
         s2xBn5olDhgvtPQoxbiAd3pgNl8Q95w6dpAHQURKmrDS9mC0VxF9Ryr6KvqzKAUAvXEU
         tUqXVDYjhcvBl6AyBTiPp5nAYJdPISKpCuF6hFSzP3COxWvhp0EpD7OdyL4uRiRKySOt
         mjInJ68mDhqwKgyJlEfyCIPEOV86PPXQbDsBc2QmLHe+Hb5TIK3lZRp7XdQUt2q/vM5U
         So4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712413326; x=1713018126;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dMt+vFkxPGBlAO+ngsiuItSMCTEXeadDp+uzTBeTWmY=;
        b=vGIZCVoyjZPQnCu+SjaXSu7KMRuBl9lLFqxxg7qy0G+zgVxJTqWGkPj/oIq/i2drOc
         p8TOjK+xX9uA6Dm7RzqSAgZTFAzUvTW1j/fqleZfAuJ7G1G1b+gh3mcD5wwYgG1eD+RO
         Jy+SOTTmI45UNyzOHFXpTvFDJPpmbht/jMZYiakt86N85SdSNeAgnjoe6c3+WVglfebK
         HEv4fhM1dSTognd2LQsFG6I9UJ9SLdl4Wi3sXKg+qU8BjglYuqJDSHtMLJ9x9kCO8k05
         uQqwKTon9qHNU/y0pKsTf/9z3ffFouUYEZvBVDSGbsH4YSu6D77+GaFFjD1GYZRhz7N/
         kj9A==
X-Gm-Message-State: AOJu0YzVJpTH9g1yIJjzoB2EQACVGHXyvb6NhVLs++4rz0zPn13bMCWJ
	JYJFpVoK4EAVCVvPsgS6fn84X5fK7Ermz8g8TwiC7n+f1GGX7uek05RdHOnNAcj0Qse3uXiN9I1
	saA/mlzT4tT7c5Nu8KH8eZ638XVkRbywBBbs=
X-Google-Smtp-Source: AGHT+IGbWi5J22skQkLybUlVHg17iRJn4dWD73G/1Bm3Stk83No9/KRzgzneKXVZVhybjU5bKn+aQyeuEQgDkgSJk3g=
X-Received: by 2002:a50:9f4e:0:b0:56e:2e77:169e with SMTP id
 b72-20020a509f4e000000b0056e2e77169emr3594264edf.20.1712413326041; Sat, 06
 Apr 2024 07:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: prpr 19xx <prpr19xx@gmail.com>
Date: Sat, 6 Apr 2024 15:21:55 +0100
Message-ID: <CAA1Aqdvj6Eyp9jGaAxTf8p0Eh_rCPydOpin3D5QYHy8sqOoOsw@mail.gmail.com>
Subject: Warning message in remote.c when compiling
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I get this warning message when compiling remote.c:

...
    CC remote.o
remote.c:596: warning: 'remotes_remote_get' declared inline after being called
remote.c:596: warning: previous declaration of 'remotes_remote_get' was here
    CC replace-object.o
...

This is from the "master" branch, but it's the same on "next". It's
easily fixed with this patch:

diff --git a/remote.c b/remote.c
index 2b650b8..347f504 100644
--- a/remote.c
+++ b/remote.c
@@ -592,7 +592,7 @@ const char *pushremote_for_branch(struct branch
*branch, int *explicit)
                                             branch, explicit);
 }

-static struct remote *remotes_remote_get(struct remote_state *remote_state,
+static inline struct remote *remotes_remote_get(struct remote_state
*remote_state,
                                         const char *name);

 const char *remote_ref_for_branch(struct branch *branch, int for_push)

Thanks.
