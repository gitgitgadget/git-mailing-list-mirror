Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9C157A72
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 02:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754533629; cv=none; b=EsJySxxcc+dXzMss7B56NlarpWAlQ0WxNbsP1g1zFojFkgJVjFNZ4UTJk0ETqpucjS2Fz+Tt9M7i2AA7FEzMN/b5jct97MaL4wY+ztLTU9rCJLcH9W54dD4PBalkOE2/ZtIGuJl0Vavp8sPwlcuGH69BxabiU5dKhuTQICykdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754533629; c=relaxed/simple;
	bh=3wTwgn7SKXgimWXUzDKyhWFusMGBlz8y9C19h70h/Lg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=SL0QtGI5FhsMCUH78v/ti7LDySGHZtzhPqbEqnkMQThI+ZkHUBOxvtvBYzaCwulBoMlyf217N6QLc+7zHVM4xpsdFc3XGmUcVxhBpZ+QoMjsr3aseNfWZZZngQ7CQkJdYtluD9L4Q50Kb7BBZscflmsijlW+5YEpgkd6i3EJDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj+A3J9S; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj+A3J9S"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-741b1fe0dc7so285455a34.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754533627; x=1755138427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0JelStU+fsjmMMtx3OPBeztBEMK9S70VJd2nD3mB7k=;
        b=Wj+A3J9S7Tn8R+VhqYTIBRwDHR9HVqt6UmtJmYkd8/MK9LmleLu/P63d2sa5uESeKq
         s8tw2pCNumk6UVO2OFjAyYZg+CrE3cl3ZSOM2AFKmGjXZ5aH8kggnxz+ielErKzfwYyk
         tfA7xoEtKz7n42nMWMnCJIk7HFRZvefIE6OMdZiEOO3UMsSP9MM/JUXFuujB82fWWGf7
         KhA0sIC9yJGE0XG8Uu2DyMCSrHvImOlDURWEzvdXzG3TdwrJx0ZsBqEBCil2+DADuZb9
         H8xsrDlZtOOc2r6STLzi8jF68V6YLxVzXa+/322coINWFB+84VGRb3llTiMDvf3gSUO2
         sd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754533627; x=1755138427;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0JelStU+fsjmMMtx3OPBeztBEMK9S70VJd2nD3mB7k=;
        b=J8m8T1l8m3UiWCI4WV5QC0c65zAujxuu5U4w9ww892TZErHk0kjjrF2SpyEbU90kH7
         hjq+oWcYefEeA5NAofJHHpNhL/mQx/KKgs+A5zRkJLsAouUik8Rm2J6hjer5ciIYT4O+
         u9nsFWDOZA49EO34nRZG2TY5kG2ojgR259o8648v1Gt2uRNTyf1QZq+m6IccvZpRwjT6
         jK9RP983nFEKq+SJhf+B4XsMeDm8BH8aYFT0a9lpHBq6u8Eyl8/k+QIUxmT0LEwKPKpY
         drter4Xc0Zt2Y7Ho2yf1US3Ot/iN9hBnEovPDSDIHzDje5pGktlcwj68gI3qdS8/MKO4
         EPqQ==
X-Gm-Message-State: AOJu0YzBJbCWonqUMuFzwBSxsRQaLis6TZoUVbswaWYbydP/kl7yKG4z
	/oDP0YpILOSuETtsQrUugRjaLzie8A8MU7l4LryByMbKeMovlzx5NQK2VwHtvZmR
X-Gm-Gg: ASbGncv1Op0nFsLyUghLcBjK840KnqBIC5EoqUGEapBcYSSu84d0WkvirS0iIkGLh1G
	rJZyCbAISmm1cvLc2AeUKvaiBuI/HYp4OeOxOBzxJPrkQeD09+s9Crcea/OViZohkNQIVd2ltHz
	f4djUeUqwL3HEnvP7r6aGz5qNXOTV0E7BhUQPtFp/X43ZA0U+zLOrijt6UOYLwsMvvaBuomTR+h
	MdXYbH2325noVhvvMygd57L+n/tqs2hs/GYy4AuH1H6vqLM8wtotqDzvcPhyWFXZd4ZssG5A7QY
	uWRgfH/1rCn+JiQxrZUpJnDe1zMKF7u04eJUeg+e9IBrirnz1VYgufBXNlffOrhJjBdHuCKty45
	zji9h/AI1VvWLUo6PGo00RZvbXjf7TYlOkf75Qo7AQK8YM+CigE82ZdLAL43FZ0Q6remk9EeMof
	8B8IYnIIAlIhn1YNOZtn6BXQ==
X-Google-Smtp-Source: AGHT+IHX1qVP/zEpGMOZzdsk5GjkNGgJ9OhZ/0Nnyqq2ilbg/6BfRUYa+kpVDfZIFzWO06Sml1Sy9w==
X-Received: by 2002:a05:6830:906:b0:73c:9589:2799 with SMTP id 46e09a7af769-7430b2b9538mr3528702a34.2.1754533626871;
        Wed, 06 Aug 2025 19:27:06 -0700 (PDT)
Received: from [192.168.50.151] (syn-066-068-050-167.res.spectrum.com. [66.68.50.167])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742fc0d9859sm1239267a34.13.2025.08.06.19.27.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 19:27:06 -0700 (PDT)
Message-ID: <2ea19b6b-716b-4736-8dd3-8831056c39f9@gmail.com>
Date: Wed, 6 Aug 2025 21:27:05 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johnkw <johnkw@gmail.com>
Subject: `git stash --include-untracked` touches .pack files
To: git@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

`git stash --include-untracked` causes the timestamp to be touched for 
some .pack files.  It's not always all .pack files, although I don't see 
a pattern regarding how some survive the operation with the timestamp 
intact.  For a given repo it seems consistent though on the .pack files 
impacted by the issue.

This breaks backup systems such as rsync, causing pointless churn.

The issue occurs with or without ".keep" files for the ".pack" files in 
question.

`git stash` without `--include-untracked` does not have this issue.

The issue occurs with no untracked files actually even in the repo for 
`--include-untracked` to take action on.
