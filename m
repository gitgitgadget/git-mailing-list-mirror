Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651B13AC5
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708065825; cv=none; b=dZ2dG0/8rzU5gGIe2uqhx4Weyd1JLsUfAsUCwiu5AATsDjxpvZ8rB3voAyI0XUFex5nsBZX2CtVvPPL81lc07vYN6Yt+IA4ECepd1octt6HR5erVjwjhnZlzgLUuxqbM4V+7NPM6Zur4z+H+csQEorbDtH6C8Dj+9UQCuT41hXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708065825; c=relaxed/simple;
	bh=6NCayeXHx6lIvsmfYdtSq4lBFcgIdHJhZcWJX5Cb+Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjlz0OhLYSKBn3Re4h7hreYs0HopmqD05hCksiLZpflwT7bVxUY7hV6ZyWsoScun+IJVHki3grWa2EkU7Xvz9wExSnq1cJVuHIaXKwAfMANe61T3vq9XkJsxv71fI6ZTaGMc7Wwj0FbKV976U0lg17moJdjJKYbeIt1gUsMZKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr51vf22; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr51vf22"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e0fc87fc2dso1091756b3a.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 22:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708065824; x=1708670624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH+K5tH4VSDmRJXCYfpYGbHDA00ZObEo2AA7A2sP41c=;
        b=Zr51vf22Reck2pNqadhURv8+CelOOsFJxzTLDjxqrQFhiF/vgNOBZDKhTTz8ahYpDP
         4078X7nd8PibJLB6cIuES3/AqAAVnAa/1Tde/tMz1dE026RgzMLkJlk2ikg5OoCDEUXb
         nKC2WDGPfUkwjwAfFShpdSwaEV7NmX4XRWUc+QNyk2UHh5ez40k5YRlaz+bSLYKZwU3c
         Sh/QPnEAj5yCmVJCzidnBSEsv3iwMr5yLcyIgwQqgBAcRosKIgrSMGULW7we7/apsVC1
         87KFg7O0HDhmqW9DWGlGtx5+7mIEzHhm2imjpyPJInFhCmUkewuSwwSE+iGNbFnXnQlF
         qVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708065824; x=1708670624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH+K5tH4VSDmRJXCYfpYGbHDA00ZObEo2AA7A2sP41c=;
        b=HLiKWwZvdN2NstMv3HDxLZfvzm9bGz/8o6p5ewMgjjqdQz5d3XHlVYPmKabXpsRV1G
         nqFqSJ1g414kZLwhsqUJUq62h2eQgaW+RyMErKzBUo4hIuFMZYAF4URv7eKIjyJEeLRu
         P41wsC+7i4pssMRdzgv0p139vadG90dQeU3XyImSFaQFaVfB1RyiSAt3JJMdNRKQYurB
         K99DotGV8hF4bOT6qO69VKB8EesdtT/9GxqK18y6gFJA3VOOLZZlyNP55Lz6wetJanQL
         d2WBZTDo6DdnoLRkI8oUQFR6Fik6zlHFLdlGbKIpY2Ba1ji61PHYGQRVnU9At3722TXG
         bvmg==
X-Gm-Message-State: AOJu0YyxHI4c04BocA0kGHsNmuy0hYALEtIOwVsDt0oq5NIqGiLraNZe
	QnmGl6jvNOHlDygZXS7kFsCuFq9izbHjlfYWaUhn+VxA2YxJEl9c
X-Google-Smtp-Source: AGHT+IGV3D05GpMjcUDZveHj32Ipelyuu2ZlgZy/Ij+WnI6QFmUV1NzMlZxoxm/GgvWp+r/Dl6tx4Q==
X-Received: by 2002:a17:902:da87:b0:1d9:2158:1308 with SMTP id j7-20020a170902da8700b001d921581308mr5212638plx.28.1708065823666;
        Thu, 15 Feb 2024 22:43:43 -0800 (PST)
Received: from localhost.localdomain ([122.235.155.188])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902ea9400b001db9c3d6506sm1227160plb.209.2024.02.15.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 22:43:42 -0800 (PST)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	johannes.schindelin@gmx.de
Subject: [PATCH] Always check the return value of `repo_read_object_file()`
Date: Fri, 16 Feb 2024 14:43:26 +0800
Message-ID: <20240216064326.89551-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0.rc1.4.g79da3975.dirty
In-Reply-To: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Johannes Schindelin <johannes.schindelin@gmx.de> wrote on Mon, 05 Feb 2024:

Hi, when I do zh_CN l10n work for 2.44, I found some check changes like:

    die(_("unable to read tree %s")

in patchset, some old code for this like work is similar but with parentheses
surrounded with the OID parameter:

   die(_("unable to read tree (%s)")

I think it's really a small nit, I don't think it's a requirement to immediately
optimize, they're just some small printing consistency formatting issues, so make
some small tips here.

Thanks.
