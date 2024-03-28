Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5A80020
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632986; cv=none; b=d7dP7w1BWIwsoXb8KR0GllyJmPraUrb4dqcz9LciWpfhzFVbwGrAm9W8vCGqt2HDwxMpeuxlrBIlw8tYOOnWxHLOzVH9SubjK0jKB6xLkyWnZ9lusrPjuqOX8bvKGLJWHS+neNHUC6pMx+oLgu1kSMst5w9Ag+CV7i65tO9TnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632986; c=relaxed/simple;
	bh=TeyBbxiAEQZXCGlGesEX3R2yLjXJg95V+iWsIHB8/yo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nswZB4w7sATY1MlhLt1LrIPIgoIGsXnjoC94kZge2lLI9Oeh84FPELeD5TfWm9eg/+e3otft6AQIBLuOOoxf7YPFjrAM43Tzq1vrfe5lDvM6jroREUQnHYicqvw/bm4LyRrVKBwPuL8uZfKhspcb69H1EENutVb8/8hiIAzZ3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5I2twQE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5I2twQE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515caffe2bcso339545e87.0
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711632982; x=1712237782; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TeyBbxiAEQZXCGlGesEX3R2yLjXJg95V+iWsIHB8/yo=;
        b=N5I2twQEj4QwBpzXSERHqxIRfPeZETZKqIoJ2OVnRixvV3jR8vrpVzVqwH0IVubjpM
         ZwXiXiAXoctNa4pcMlY0m3JO8k35Eh5xDC885TtLbEjg44FnmnAj5B2Nuf8wBBeFqOGE
         49+5y0+szNBmFCFL8LZmZwfYiZtsJIK62R0n7MMa8n18675xbTvkhwFJ9S56Gy8hz0e7
         nYWQF2tdulsj4IIJVCNJIG0tBEKdl9DHnaHaGr0mjQpYr9pddY0wOBd1A+bbIfQO7diu
         a4NEfj3CiGinkJ8lDhqhLvCsITyRMyQTbf8fhZkq6w2sda6kyNJ/AbwZqYt5y4eVdvYz
         G+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711632982; x=1712237782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeyBbxiAEQZXCGlGesEX3R2yLjXJg95V+iWsIHB8/yo=;
        b=PD7TO+E1wjiaEJAnhDB298FAXSf9LKCEqNw7nmF2yJpfj9jFVq1jDs+ebSDrjmlwxz
         j8CKV98QwezVY3kP7SbA2N52woBfx7gHP+DJgNFKv0m5i89MQ71c0Op0rejKFXuLy8ow
         QRzpaBB2IyDB/fiAo4toNg6DrN40LHySUducklO+oXt8FpXkFC4kJYTkneT32tuXDD94
         3PgD++WSU6e8t760P+Qf3mA8/FRDWxXSRcP8Ag2pD/VTcy5BcPST1/VzVmkQr5XXmALi
         H6IzS9bQcfpO1j+VwEiJvPVuEcUJSl1CGGTttFE56GJKeWBgYBZxOKgnhz4bLUlhXr+/
         yRdA==
X-Gm-Message-State: AOJu0YwH1yAQAUVESUH5BnxygI6O/OviTKGI65ZXd3TsRYrIqXx20XEA
	zMgOmymQouo0lxwxTlzrdKkE6nVVk/XhIVWNjUfBh0KHsnHXRczEl2DhDidn83Wg7ajFpm9Pe0Q
	4pNWUjdMF1CGFB5d7sCQzT4YZ31BxjyU6FSs=
X-Google-Smtp-Source: AGHT+IErBPNdoq7GyVde3zkHMkb/6Bx7gFXILqNJhiNARWonxNdcfCaIwi3fXzrV47+WzCYITlQCR+1KXfQlQofjVy4=
X-Received: by 2002:ac2:53b0:0:b0:515:bb56:51aa with SMTP id
 j16-20020ac253b0000000b00515bb5651aamr1816404lfh.15.1711632982343; Thu, 28
 Mar 2024 06:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eugenio Bargiacchi <svalorzen@gmail.com>
Date: Thu, 28 Mar 2024 14:36:11 +0100
Message-ID: <CAHfn=+snXChcPFiEgxvK=XFCq2uVMKQTyfrN9RNfAod18d0V=Q@mail.gmail.com>
Subject: Better visual separation of hunks in `git add -p`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm looking for a way to print some sort of separator between hunks
when running `git add -p`, as I have a bit of trouble detecting when
the previous hunk begins and the current one starts. Being able to
print an empty line or a couple lines filled with "=======" would
really help me out.

There seems to be a StackOverflow post with a similar request but
unfortunately no answers:
https://stackoverflow.com/questions/68534891/insert-blank-lines-between-git-add-patch-prompts

Thanks in advance for any help.
Best,
Eugenio
