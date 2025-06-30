Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B8244688
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751292672; cv=none; b=cYXGl/lDinXSGXgHHJcz8fdS+XjHa1KUmTEHA5Mw5hXIRrSgaBbP6Xq4Nb24jZq2uoAKWL4SZSJzukdnWRP6cf1014bk12cHgqYJrGyp0gV8Wjan3HQTJdhxnKjYKTSf74ZZq0YQUVYL4xzL84pF/KkrLpK3+T5St/nOJw8EAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751292672; c=relaxed/simple;
	bh=4J312Bd6QeI+5DSZUCvLXKTN1yb5H0cMhM90WVDSEtc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gqJhKmmFMZe0byHc3fcWmSz78ciOoteCe5G1EDN+mcO9ufUVZsLbeDG6/ZnzGzuM9YDKnxK5V5FyhRIcNI/6QWqSLjI9rrrt95X3CpheZfAM3fKhv267FR+gOUKk5OO62JT2Uo226mqR7O85h5z4UGrqYGXwKPIpj9flx1ABVt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjT8Ai9t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjT8Ai9t"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235ef62066eso53012945ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 07:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751292670; x=1751897470; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9g2BSbwhYic+Ynujhf1cb4pvJdWH90tjgcwAqHqvzw=;
        b=JjT8Ai9tnlFxCDf5IAv2l5Y2cUB/L0Q0WTA5aaU0iT+D5nIVPYRtXL+AhqMAEbM9JT
         TT36VdWgWY34v3Iykzd6Sn3ZrEp0svK8uB6JHb5jXJPuTlFUl8V+LXmlAEFlh/iQuzgI
         H4kNu/j9ro2HPo/YkjzbQrHgHZixxVkQrHsfP9wXyB40GKmCWeau3Al3Cjfv0ihRXJLl
         Eb6t6Wvr8n5TlF8ZjI7Z4C4FZeJ6TapekRmbLy5DDmnsqx0+pyJbT0L0WldcaF7DMpoV
         NrW2tBh9WZIKFJP7v2Zu3GrZIe9qlmB8DkVX1oLnEF0f5T8vOIlYTxTJfx9yM7sxHnOx
         fgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751292670; x=1751897470;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9g2BSbwhYic+Ynujhf1cb4pvJdWH90tjgcwAqHqvzw=;
        b=uP2ZeaT7SFMBzBBYCjxTcuv0hvZG/kUXlfG3ko8z9oecYofwomuRDUUBjNfMaHeL0K
         anLqN0KJd721Qvf4/KAcygdLptLvKo/8+h0j/1kurua8SE/Pa/MFsZQCl7Ygp/CmtGo2
         wU5T0yYiFBC6suVz7+9BNB4E2IWYgQDUpZTzL0oYTyMwHFcAgqjMiFJSh6HlkRrl3o7S
         otVBdgo5QsasOCrwOz47P9SY/VoyDoQhApVNfMqk51tYA2OOTJogngyxQPSCr3bYVfvn
         hA0mhf9Z7RHuG3vBhz389ngVXj8AnztqTI4f5ci2KoFXnTgKUdUKc/erF1aJzwlagJ7F
         GlXg==
X-Forwarded-Encrypted: i=1; AJvYcCWzu5m6+G8RZyvo20Od3NsyoaNnpZqZyzUDIrTgrPiaMKQJc1/WeJjsGCkC5SE4p1sJxso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0+jgDsgwuxuWXyXWH3W1egO/Wlh7UdA43VLCsKbmRW2DS5qr
	HgAV7RG0MhpdE34K7PpHyk8pViQ8PodaaeXF9iD+O8V+AUVFcczE9E7J
X-Gm-Gg: ASbGnctLOddRF2/OrEhZSDGY+WKke8NPdkmREsDSQaGvOBJNNAY3jp9Bpa8TcFr1HFi
	4o9Xglnkc+VywXIcGedoRP5lrGh6iznfWfMKVKFj2lNYlP3SfmBIfGKvlP4QNhtH7DCUDbi1WCe
	8rNWW/Sw88ET4WeiJrLJNBrFEQVfaeL4x4CrgV1+pub+vmIKLHQ8XKPL5JlRUQnPZ4epag1PlY5
	NkVh+mn4FikGo+282hxlvtrtv+0ix1bL6lcYMZ2iLP2t7WOq48K4bQmcs+zrZDKbZA2NYK64yDq
	Q0NtYKxGfKKZCalKkM2kI6jdAHh6SWD7IzCDlp36zDKY+izirm4sZZTtooaqGo3nIvATbhqebjG
	ViKpzmLvT5vnl9fMx9ssublKxf/w=
X-Google-Smtp-Source: AGHT+IFO2bZ2CtMjEW4lntB1mRHROwotovSL4qHSpHhAgfzbhYCf0IJ2gk6GlzHJAAACMfWIMuMk6A==
X-Received: by 2002:a17:902:f611:b0:234:ed31:fc99 with SMTP id d9443c01a7336-23ac45c1d73mr203530805ad.21.1751292669674;
        Mon, 30 Jun 2025 07:11:09 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3d35e2sm82430155ad.258.2025.06.30.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:11:09 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com,
  kristofferhaugsbakk@fastmail.com
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
In-Reply-To: <f39a3285-574a-45c6-9646-04eb175f4770@gmail.com> (Phillip Wood's
	message of "Sat, 28 Jun 2025 14:38:01 +0100")
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
	<20250626221631.457725-1-ayu.chandekar@gmail.com>
	<91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
	<xmqqms9t8cfd.fsf@gitster.g>
	<f39a3285-574a-45c6-9646-04eb175f4770@gmail.com>
Date: Mon, 30 Jun 2025 07:11:08 -0700
Message-ID: <xmqqjz4t5ngj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Should we be resetting comment_line_str to '#' when core.commentString
> is set to "auto"? That wont help if the commit message contains a '#'
> but at least it would be consistently broken.

Yeah, while I was re-reading the code to parse the configuration file,
that was exactly what came to my mind.  I offhand did not think of any
downside of doing so, but I cannot claim that I have spent enough brain
cycles to make sure it is free of bad unintended consequences.

Thanks.
