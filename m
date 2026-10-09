Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4133C1BE
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791513528; cv=pass; b=IVf0rEKHu1Y+bi1AhtlRjVBanB5vjP2WBRXivUO85KW6SssL9Dl7MXWrwo1YevynbcQR9kp7E0f3xaxImXwAiZz+F0Jgmi87DW3nhBe6V3pJLxQ5M2zNXXZcp5xk66jfx50YT6wl8PRsSfsqLBO3hCbzeJNoByPda0fZIsqL93Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791513528; c=relaxed/simple;
	bh=W4GKsixfzJiPx486lOFrtxhYNSGTWLvL4XYlg3dqw3k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YS/YFd7Q6qRgmq8TeLIyInHJEEqH2YX9P80ch1xBHXKf3cbO9c6lkNnQ/UZI76LsdzoAeEXWmlcHWMw8CCi2WuyJI0uJmmQooR9Ryyl+Bt0jy3/kaVBFBqViaYOIPnFCw6fkCMMkt0prUyXiwru+GXDUmIUm3XndIagTUO4QWG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzfvQtM4; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzfvQtM4"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-49e08af5fd4so2660843fac.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 19:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791513526; cv=none;
        d=google.com; s=arc-20260327;
        b=pXU5QAp3xL/k41bwNn2nOZhi7mAmuhLkVtpoK/KnnZDo/48FuS4/8QuMXMkwudKz1O
         fBv59xt77aR8zyg9xLMuzhbp9Fy7NuiHy8CCCGYcQVb/2xNSkQGeMB9ZtwS8oHgyeo26
         h78fz35r8pT1k2oVW0W5VtpF4sFUWqzrijKU2LtW6/98eLxQuVu3fE6uknxr7CIw9/Ut
         kx9gusK0uxr6ieQxawj0BaC9xQobGZ52tG7gSWu1sLgA7GNMjagLgia5lUTqppoH0NuD
         8odn9Pn/U5ymuhYDPzuTf08D6am6zbT4q/ujM6o7KdByyXm1figCNvoUJEzto8fp1uIp
         voUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=W4GKsixfzJiPx486lOFrtxhYNSGTWLvL4XYlg3dqw3k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=SXM9ecp3RvV4aP4feAJQEnBvGqRQW9TIPhulH9XiR5Y1pZ+YvcMVItvPieO1QY3yKk
         ZKQpvjBo0Y5F3weIqZaFoH8AFkC0Cknm8T0odLS3H2drBsEMY3CDTlWntgeRs8N6ohDK
         tmp16jG6EoTnmPBvZHaHHQUllmt5ImrpiX7fasdaoUY2JsKiJyH+SZGdopf/6TJTJ3mx
         VBcj2q8GKDjEQEBvxFuuWBCQFN1YMKXOMpp2Nw4J92RoF3iVkBEvDrO6LVhoqjP3VqxG
         FzmnuwMorUrttqbWfFBJD3UTjZ+d15lQTISMFRveuS60kvwAEZKTFSpfXJMDNoblKA0l
         LUcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791513526; x=1792118326; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=W4GKsixfzJiPx486lOFrtxhYNSGTWLvL4XYlg3dqw3k=;
        b=HzfvQtM4WMiN6jPTPwwqORC3nGPkLWGMnWgTzdm6XtEsamULNKJgWugbq9YdhNNBxb
         d9qB56syyM+dxHwCMN4qjwHsZbmoZyrPTmsT2R97WXPvLJVc3HDcFMeLa/f968INTJM7
         VKO2RVfDKXNKHuaJgDFubpNCmFc+/zobAwI/S8wGovhPu1kcizVmB+Ib5ovOj2auIOI8
         jPYYgvORmVR/65RIYHZiy0/YrBJsvtvL3frd5HqWmPGzFKKp1zbesBC0WjVj/T8EEEqz
         x+fxpS7huXCoReU52ooJQ6RZkEZTU6JkdvbJiDx5ZfpGgnA7pY0cPnAxTj2RtcVCSB09
         U39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791513526; x=1792118326;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W4GKsixfzJiPx486lOFrtxhYNSGTWLvL4XYlg3dqw3k=;
        b=cd6zuhlK7nLidlialccTnghgqh8YdrGaLaf9Os9nUbkopM7Bo6FjdCDGdoyyoG76DW
         oNuyj8k2fSYXkT4dEuT05LPlLHdtr/JHxl0xh24Hb2EgqvQ5gFhcGnKOOH7bnPS+IZ9U
         vAYSdI9T8KJl6ZIqrqZlEBLkw4O9PwyjOX7N5MTxer0kURuiFKDqyC8j7g1OWuBJXePG
         MNGSxFt/JNxozPftNM3D+pgSimE+flMqjO1iVBtQslH7gUyJogjDWLZRdHnyUxEgDnyl
         lybYCkYkWof7YpBUpH0j13Ds1YzFEnGyKitmSvykyyL7ssjk1LDpfytnMdfdmxwKMBQz
         nkOg==
X-Gm-Message-State: AFuF++lfMr3oHugm/BK5Cuetdiw+Hvcq1eAVLaiYd7RTGZw2aa8Bme8k
	SVKmxxzkHz/usiipwUrf188j5RlD6CCniMRqbgkbc2gUKoKfHNAbla6yspzFlR1AbvyU7juHZg2
	LS4YWPY2UB7/uoWIs9H1cn40mFs3rG/ZIEtu5nrM=
X-Gm-Gg: AYBFou28iWHhpa3zZkWP1orphLFz3jw5O6M//3xvwB68T6Vw0FgIDitK1La1n60O99Z
	SCHoE64BgkfV98CQXBPkIS+7/MW7+dONqrQ8lVW1Rq9rVwxjaQDILzusY7W/GKLnIloscU32wSZ
	+P76CG/fh3TEvCGGDKJmb+ln7kU3Pxif5RGB3VwW+kM1I9W+HuwUm3DJJIi6Rf0BF08CcR+zWpl
	4u5o4+08vgio9dhfZOUbA7bYzoAzpHq3Iz5LfMjFmcB0LRn3qSBUaeQpxqDuMbyMvLSzCDSGlxK
	tJc/qAyWUnrqVmG5G8hsoKTjEaa0TDHsiD8Lz2YqsFd07OXGfUFWF4Qs+haYqUJnPB0WUt3M7YJ
	NhIoICz5KcO0=
X-Received: by 2002:a05:6808:1813:b0:4fb:a7f3:4211 with SMTP id
 5614622812f47-50c599655bfmr419854b6e.58.1791513526228; Thu, 08 Oct 2026
 19:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 9 Oct 2026 10:38:08 +0800
X-Gm-Features: AclHuK8bggaYLk4aynYKxvoHm-WKUttWBeVhrc84dCLVekQn_RYLhEs-jdysRDg
Message-ID: <CAAXyoMPJ1P6RCRQgPpZwZjFZJW8Y07paXJD3=8LXtD3KuVnWnQ@mail.gmail.com>
Subject: [BUG] git diff go mad compared to diffutils
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Git community,

I'm using git 2.53.0 on Debian testing. During preparing a new version
for https://lore.kernel.org/all/20261001204851.2576101-3-mmyangfl@gmail.com/
, I've noticed git generated unusual distorted patch
https://github.com/yangfl/linux/commit/01e2de4664f60528dd9b4f15b5995fc5cb0e7b4f
. As you may see, GitHub diff is distorted as well.

With diffutils 3.12 (diff -u old new) I can get nice diff file with
delection only, just like the v2 patch.

Should this be considered a bug?

Thanks
