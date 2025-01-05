Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916ED481AF
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 11:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736077330; cv=none; b=PsK4CfkfVJnRVYBtPuUbiNimvmdhQz6RQDY/LYHGi9/QesQ+3BCZJr4kf1V79j2j2DH/tlXEtf6eD5GrtqYyZSLBEyIq2BBDOoGnGWY20mz0IQczPKyVprd0JOAiGeZNvgW9u+pdvAu3Cv1d/PiVRLBU9ZtC5SaLXRI/cnGyuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736077330; c=relaxed/simple;
	bh=RGyGRSmFIMgbbrMZ6/box6xHWheSCjes3VA0+2M+960=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRLdKk+ProUE0s4+1H3rJtnXTkz2PYdv3E1uQaT8PXhNlYzaihTfYq6b9tbZs9xwJIQXMqEGu3ErBBaZM7SgDShmDpk8E0wybGB20Pu/b1B6DjX6n24mSd5tqq2MhM+hzzXu96du7/6lZvmPxdQUgz2xEMhHAOxCv0wSHtMy4Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDSxU2Qf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDSxU2Qf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso178082445ad.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 03:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736077329; x=1736682129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiZ3lo/JGsL4q/F3Oaf+GVt4g/wjdnOjK4Aj1/ojRlk=;
        b=PDSxU2Qf3CCEFqxLRT+XNSDfhSOvhH9J3hDeUI9zz6xm/8sCFLVs7kOB4DNTaVuBi8
         XzHpDsq3wZcUnHsNdZKFuzwVW+nCg6BVqWO7owlxBXokE/uXiCuGai/86jfx2Jlb47WM
         u8EVXTi02301xjrNRZCJtP3XnHgLpeySVShOTVNnoDmLvBRgomwm4T2V5AWaUKZiHnC5
         WjteysZhkG3iWrjxM4AN2o84gda2w3yThlt1ihZ6K76ptHgEmAtLoi3KEMFg9PQUnTmg
         jEo3U0rXIZ7DosGOOnB8nqFjXD03lqiQ0/op+cCO4T8HmvkW2W+tBbI5ugxu7ANMUIPt
         Yeog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736077329; x=1736682129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiZ3lo/JGsL4q/F3Oaf+GVt4g/wjdnOjK4Aj1/ojRlk=;
        b=fSgPp+WXQI9QpxyN55eObB98SUU8J4ZiuiFz0Lo+BAOc0pZiVByhB2io6DPT/fDU9Z
         vkHf+fIKXAt2Q1pQMAut6vVGklM8XBQJW1ITcsxuGejJv3AF8ZASUEghoORj9WNYu0Ec
         XPgyEW4hEHJqm2zMXdMl7uvopziSW1vzOke55mJciWgs76K44mLN8d0PbtTwr31xB32n
         +PDWeDeD/Yx+b7Llyq0mQi4Cc9dFSOa8I+Z2YJzcjmn8U6Q3hYOZhRnqUF1sWuJ5GDMR
         F6NnA7AogWxkDz3b5hJNOo58gOqyr7vinHk3v+xPQKPZ5CFNn0rW4gus/ujxlNCDh0Lt
         1j9g==
X-Forwarded-Encrypted: i=1; AJvYcCW5ETSpHsp1q+14xTWeHu6tdXdP7g9diEgY2jmcAkF9iaOmwR3t3meWlL9fL+4bzfMrH+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFDCksEToq3SR5ZYATNZgLS/DiUJ+EZSTTfMV0OxBMlWRzasXE
	AyG7TKkcerAUa7+y8GKEKL9CemVfde1cldaBCf8GiyAUoOFeyTZe
X-Gm-Gg: ASbGncvRfiD1y+dmbrc+WbbLyoJi3Qs1XX+o6IGxjKemmJzN1bTUXAbdSbqx4CO6T3c
	cJ++mdIUYWLGnW6szuEnklbGzQ2BAzNqh8LIPtyjcjAQDoeIkBoMkV5pqu0ZN7fXLFhbAanh9K/
	/xbBvI8/g6hYOxUi01amgpWCUypVNRtUH4nqrmMRjFKAzIDW1qkBMg/yUpm4sx3ii4xA6BSsQmG
	MEkBdjwBLPJCFOLpUxESxH+c120tTt+OLZpcAXxP/5q9dfpxjSNUbGqnR2FXkq9TI4dNSeh+1ty
	lisAtYktnOUBvA==
X-Google-Smtp-Source: AGHT+IGbdNoIdgRhRF4Wweoahg+y6lD6td4l+1FdeUZj/bQLtyRmDREwaPEdEfZHeVpKdzF+3QBEwQ==
X-Received: by 2002:a17:903:2346:b0:216:3eaf:3781 with SMTP id d9443c01a7336-219e6f2eb9amr835619595ad.43.1736077328741;
        Sun, 05 Jan 2025 03:42:08 -0800 (PST)
Received: from localhost.localdomain ([122.235.242.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01940sm274208965ad.237.2025.01.05.03.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 03:42:08 -0800 (PST)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: bence@ferdinandy.com
Cc: Johannes.Schindelin@gmx.de,
	git@vger.kernel.org,
	karthik.188@gmail.com,
	l.s.r@web.de,
	me@ttaylorr.com,
	phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: [PATCH v3 2/3] fetch set_head: add warn-if-not-$branch option
Date: Sun,  5 Jan 2025 19:42:01 +0800
Message-ID: <20250105114201.35079-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0.rc1.4.g79da3975.dirty
In-Reply-To: <20241205121737.1181695-2-bence@ferdinandy.com>
References: <20241205121737.1181695-2-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Bence Ferdinandy <bence@ferdinandy.com> wrote:

> @@ -1584,10 +1584,12 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
>  	const char message_advice_set_head[] =
>  	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
>  	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
> -	   "if you do not want to see this message.");
> +	   "if you do not want to see this message. Specifically running\n"
> +	   "'git config set remote.%s.followRemoteHEAD %s' will disable the warning\n"
> +	   "until the remote changes HEAD to something else.");
> 
>  	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
> -			remote, head_name, remote);
> +			remote, head_name, remote, remote, head_name);
> 

Seems like the config is unsupported to be feed a variable named "head_name"?

Thanks.

