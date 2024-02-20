Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E3664B9
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429237; cv=none; b=gsxIeWRu+ueyZ6m3IwJYjr3X3k2QiV3zA208yZXkyeEKqEsluboVyoV2FXgXB8iTXp0zGoLXXViTiamEHRtNMmvd83xot3BMXmt0VZlwS0G6/rXy3AQmy49mFgFs9m3FVBJHuvWLDHKm7V5aFpxPiddi7z5r62RB+Bo2XNBRr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429237; c=relaxed/simple;
	bh=VgNOVNbmD2I81FsGJsJiQjKCkz23085J6+KX9buhjAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJae0gddJfJzmSsNpM5h/hhIwzW7ZckfvrArGWT4FI/SFDn53HjaoNOyIu44AuFDA6jaoYsStidvbm48iTO4jNiCwg7F2/j56JmfJee5Wox4/wOzUDU4m8anFoZy+6e27/2gNzv60qDQ0UkaeoTgCgaMyYFLQZSvImcZLlbZw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTkSiKwP; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTkSiKwP"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso5311216a12.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708429234; x=1709034034; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VgNOVNbmD2I81FsGJsJiQjKCkz23085J6+KX9buhjAI=;
        b=OTkSiKwPzbgp2Kt3vhNdcEL2DHCn8fqV7h7jIi6WHfiocNutdenzfW18kueZzsut3I
         LD8lRx9xmRolyGKGQrkH/kXBfGPRTfqF12DuBfdkSU+eYUd+wy06bUTx3gSFfErbOxsK
         KWMRAkcdMP9xGjpUTMFMMANNvaUQgI7F4c5PG3jVhabY4SYtbAFuyxKNSdyojUKbS6hX
         K3dqf65N1iv3TYCr36loadKJn9lgXsR4/VPvlNC9hsZz8TkJ+gSws7qm+/Ve7eEUPjT2
         C+skwliXUDDQ6uWIJJpK3CbS6vwV+TgZ/GDGJlSCyDDZeRShp/SV1XiAHYBoCbghNlFP
         O9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429234; x=1709034034;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgNOVNbmD2I81FsGJsJiQjKCkz23085J6+KX9buhjAI=;
        b=ApRSQRGNFEq2RmC5DCPpofmkqtJxHmdWzEoLcZ5VlygJx7xj5OswiAUybWpMsiNSRg
         jmT8rjtXfvv9CwZz82kGq19vjS2kAdCwby3txgXuiv+g0QPewy6XQO8DjLqHgfvQgTK4
         7AG92cstaGBN6ofxoXe369LZoBuKC9vfK9VqTMikINfYfEC4FfNIiRA8YtlOmKU2zmev
         vsU+pqh6tjjHvJoMOEC0raXDy4nLR2wYn2yU3VSuEg4AU65qcxBxsNmfNaykXd6nQiXG
         0qPsJLUjYLnP64ryFQHjt+jOg/QHksav0LXxjB6b/F6pa6sNYFgETlZ+zcygc9olGlqo
         oGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwNvgNakGK7DfZZfhsYcSXBZtEcu2E9+lWORgkiAVqeGTWTB11Zvo39QdMfYM9/4p6/4ZqzZo13BXoqhps+NCpRElH
X-Gm-Message-State: AOJu0YzzzpsEYJuA7OSsKIBHMCtMzqRqyvpWMGvKA/TsFFfN6mWNF7d3
	ioEEyY4mYy1BnzMJV0HfwpjbYWsyfzcRB7ecf95viEZSoPPkts3afruKEhcab4AeR6wJeGYfPLk
	o9x1yHHz4jNBD8mqIp3FRgF1SuR6zCIAp
X-Google-Smtp-Source: AGHT+IE97lf20kas2bT3JFWblC/yI3lJVby7zyDF9pSM2XQOC5h2QiTKjWPWi7JbdIoP0jMvlGL00BVFhTLGagyXoLk=
X-Received: by 2002:aa7:ca4a:0:b0:564:4ac2:c0a2 with SMTP id
 j10-20020aa7ca4a000000b005644ac2c0a2mr4445352edt.15.1708429234363; Tue, 20
 Feb 2024 03:40:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240218195938.6253-1-maarten.bosmans@vortech.nl> <20240218195938.6253-2-maarten.bosmans@vortech.nl>
 <xmqqjzn0x72z.fsf@gitster.g> <20240220015928.GB2713741@coredump.intra.peff.net>
In-Reply-To: <20240220015928.GB2713741@coredump.intra.peff.net>
From: Maarten Bosmans <mkbosmans@gmail.com>
Date: Tue, 20 Feb 2024 12:40:18 +0100
Message-ID: <CA+CvcKTFSyC-76=DYDdbLV8=cou0JwexS6iFOa0P0_r5NoBEQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] log: Move show_blob_object() to log.c
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Op di 20 feb 2024 om 02:59 schreef Jeff King <peff@peff.net>:
> All that said, I'm not sure based on our previous discussion why we
> can't just call stream_blob_to_fd(). Looking at show_blob_object(), most
> of the logic is about recording the tree-context of the given name and
> using it for textconv. But since we know we are feeding a bare oid,
> that would never kick in. So I don't know if there's any value in
> sharing this function more widely in the first place.

Indeed. My original analysis of what `git show` does when invoked by
`git notes show` led to the conclusion that the only thing worthwhile
to keep is the `setup_pager()` call. Thanks for confirming this.

I'll reroll in a couple of days with the V1 approach back.

Maarten
