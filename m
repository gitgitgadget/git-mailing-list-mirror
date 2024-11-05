Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A91D90A4
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825998; cv=none; b=QU/Gn8tY67ImDhZGpxHhobTxKWGN5gwTZ7ZzZxemHBLIknm3RWsJqln3TvEqz9l7RWs4z4tCQ58nXplkfBXyihCkn4WyStKwb2Zs4Yp+CjimYFTwE738PDTRx6xo5wYDqV6brqt/T1HQLVPgzwm3Hx8OEooyqNas0GBKiNvUe5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825998; c=relaxed/simple;
	bh=rWjynT9hpAO8lpRb8+FJgQQXhWBVFBKRitOgu56+FBM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JtiXrMImFLV1+PjfNnnIXCpA5R+Zq+hALzRxyq5a50M+zIPQzwapoxSt24eW3zTOuJQnuTsGu7UZaIbxgseVcFJ7ZWEb6tYpaPibXQ4bgJ50n9eRWp6dmOIHh3XoJG1bHgMxywLtmdvetLJ0gVVbQ1yg8+mUd3rnniOYHTl3UTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STvTfyo/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STvTfyo/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43152b79d25so48991785e9.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 08:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730825995; x=1731430795; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWjynT9hpAO8lpRb8+FJgQQXhWBVFBKRitOgu56+FBM=;
        b=STvTfyo/9xsJ2Zmihk/+gUeY+gwcCNgPi//F3NCjIsMhp1Hoi6NOu9AuyqtGUDCTjF
         tWxtwyk/EtwUOPPfmxi5ZgEr8Vv4EmBpi/gQ7GSz18UW1REB3JMJ7GNRlgD+bZuTiO1x
         dx79Ra5Gfp+toLyOMMC80hamz+sxamTz04JagzSvxswZMKzZwZJenlv+1PZgwHubZqfd
         DQrrbt4VaJT3xmskgUOcGl6JZPDh3ZuMV6HbwHnq3wJVw4I6xBItjMzUoESXR4tuOGC0
         +pzkTnR7qcEIAZ1bSBgruAghLH2/U1Z05WeZ7Jhk2iNetnoYJcIP9CNZqAl0lbrq0Iji
         YZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730825995; x=1731430795;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWjynT9hpAO8lpRb8+FJgQQXhWBVFBKRitOgu56+FBM=;
        b=wscHjB9ACd4wke1s1mU5icn1+rh/eFwMnAtXb2VdVkIJiSql85nYG4m93WPjpQfygj
         JJtonFCO+fjnmZuG6tO5qkY/1zdC51IeHyUo1cEcFhp4cglGjY+H4T+HDnwEID5b9YQf
         TYRLwacqhcp6N6F14Vd3COgcAhX2TMdCAkmJ2UMOYQsMQY/MjILf1AX8G8V1OeI33iu6
         1OUvPHKrNsamHYy57sukavVWyqOJb9v5HnlFKTI4iXPl7QvLVVEwrJMP3+S6fMhao0bj
         kbU7xsF/mPiIGfaNdzxuhlddDA0C1Qkq1mwnlRjwwOq15SOWf1OT2aYcw+eMDdf2t0IV
         eJdw==
X-Gm-Message-State: AOJu0YzAhDmj7WE7mD0BLSVHezYJZlD4O62NB0v3Zwtl03sE7HePRXKy
	mKoQ1A+jSLjdLMZO5UzHa6TRab13uFSp2BpCYWd4ZTYVYDUZ04tUdhQSXfS7UGZZ0LLq5zjuAkt
	SAoNklsOSW+v4zO5IpchPVtegHygPrttvzDtGAg==
X-Google-Smtp-Source: AGHT+IH0dupdp+23dv9Xgv3Wtdj1KaGpb5SQduzE2J+0NhX2ZrqLC3rY1a4kKg9qvWS9hoGldTU9bsJU+F4t/ifVR6E=
X-Received: by 2002:a05:600c:4fc3:b0:42c:bae0:f05b with SMTP id
 5b1f17b1804b1-4327b6f46c8mr178710985e9.1.1730825994722; Tue, 05 Nov 2024
 08:59:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5Y+25b+X5pmf?= <yzs981130@gmail.com>
Date: Wed, 6 Nov 2024 00:59:43 +0800
Message-ID: <CAH1CY-=FtMTSisCmcz7ovciPomXYBogjNCmqO1mEjN9H6zEfgQ@mail.gmail.com>
Subject: [Question] How to force relative path output when using `git status
 --porcelain=2 -z`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am experiencing a problem when parsing the results of `git status`.
My primary goal is to parse the output of `git status`
programmatically, so I am trying to parse the result of `git status
--porcelain=2 -z`.

According to the docs [here](https://git-scm.com/docs/git-status), the
`-z` option only changes the entry terminations and implies the
`--porcelain=v1` output format if no other format is given. However,
the result shows that the path returned is a relative path to the repo
root rather than the current directory when using `-z`. Simply using
`git status --porcelain=2` returns the relative path to the current
directory.

I am wondering how to force the path to be relative to the current
directory (for easier cutting and pasting) rather than the repo root
when using `git status --porcelain=2 -z`. I would really appreciate it
if you could help me!

Regards,
Zhisheng
