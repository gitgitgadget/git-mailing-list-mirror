Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EF8268C55
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 05:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866131; cv=none; b=kWHcGXoH2znr7TPamI4LQsRYA34veZD8rzQ7310Bzx6GPKCpdbvo7KAGfYkME5FzIP3c4hCC00qdMiJL+F0eFgdnR/wLOnc36k9YUhzkHC1ryMZWxUsLyJxpqDhSYf7QBUYW79MOKebEjjWIffycIAG04+rsXvXga9yjCA8+xi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866131; c=relaxed/simple;
	bh=66T5uZuZke75CEYCAIlpD2bj0UJicAY7R5+dQtgxXRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bORbcl9NJFtIvjdi9iLW2bUrzLo345OQRtxEoaCvxtRxHUPlkv/UiSKNKgiv/U2OC0a2HJ8QN1EdIJPDHgcHwoUAURvFWSdL359Y3C2kjYPZf+zCzCaFzqeqX1wiDnUVcvseLk2rQFwFE1i7go51tSlm1kHCW0eE3EJQAnxvPqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTg8Acd8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTg8Acd8"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7494999de5cso1555251b3a.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751866130; x=1752470930; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beszpMBEBfA8pXXxGW2L5oBVgVVgkyK0Ytc+Nu2gBvk=;
        b=RTg8Acd8CHWf6OwEODdZXKWQdHmu9HEsnwFm7ArNKTTZe4de2m8aRPf2jGXxZynARq
         f3XVgH3sEEsI9v+bLbJWoXKMbNz4dvF7UwaJpT8bhukNal/3SxXBNCPqXNcb2baQ+C+/
         FD0eY5+qYUsjWVA4mktv8xWBVhBNYozlp2HjqKP1XQlJY61PSokNqbJFgVAoAZuQDt9/
         g49bfkrf1eVUk1CvQHek5k0zHuLMK8PnOJwP9edOxaHy007i8VWj0hNja1jVNxRajvwm
         gBUERUgm8Ihl2rxie2ECQDv4dPAoLLrAC684BDPKCRkeidArk7TAlIoQ+jp59wjtHc/m
         bo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751866130; x=1752470930;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=beszpMBEBfA8pXXxGW2L5oBVgVVgkyK0Ytc+Nu2gBvk=;
        b=CCa6qZg72UuB7Ov6M8q5l1Pr5p0HacnWTgKQpcEEal1AUtKifCNL/xghVrp0keuV4B
         rXCqElr5w463r0kaTdBodeRBK/us2czQUmxhpljFnGz8d9md1ULY+pJrkpfu0mgFT6pw
         5neVlu2fGktwdD1rosA2zX91yXwVh+cQO934dVY/NHOunG+Ay3WV+3k/74iXo6XBpaIE
         IxnWimOGOmphIQcvKQr2vv0P5g1akslktQMeeHArSOwxgEyQ7bBIotdkf8qSTwNGQl0y
         +lx4UYVUiwY2y9dM6IuCOjE3USm1WLu23WNrNNDqc2gA/MdcWdu9MO/F4zUyPXZOxsG+
         eNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBqnHiNemB3A7YL8D/dlj4O1o/Zo6zxK5T/6TzheGMDha2rOUtPRZqN1dUqaLpSgLdoXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkqjj+MqvYYTbvtVF1ZKG3jT6wJXzTrZaWF+OHZTYPe8THr902
	i6qY1/C4UfpsGu8FoOb9GATxyC+Ztys1v4VlHsDCRsROd2oZvkonGV++eKtAIg==
X-Gm-Gg: ASbGncug3htZY2KvLcmSlCwfifeb9Idy1z+Q4/VN/zroJUpOUtIEVmQUAVpGmZzb1aG
	YrWxnEd5dUvpVxJMvDaB17muBqRwGsme+D8PYxjyMbeIEUzmkWsYYZ6VrerJTHFLZOv0vhi6dQe
	RQKsZMed58xI7hmQjuJegXJzDPQ4FGDEl8ZjM6eTfSXY5ZoswcFIfDpFzF8Lijge9w+MK6leOD8
	m7DXzEy5Ir8lPLqh6jWY6iWeUJ5EHPDGiO4XfYYE9rO7eI+nMFAj2eZZ/CqAYFQikYqQZoGUMfE
	pZCVuobwXexkBO0Aw35Uh3y7j4fjOpgyESgv0kJZiRwez2RoTe+LwVHAillOFrtkFrWNl4x6w1W
	gLq7pNXn5aUuM40s4UQOxybLjuvw=
X-Google-Smtp-Source: AGHT+IHmwYjX5E461ETFBxBcXMhMzcTLHEdx2g87cJikObi1+nzILawPa2hsOydqpJyd8mkNY2JLSQ==
X-Received: by 2002:a05:6a00:2d96:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-74cf700aa06mr9964922b3a.24.1751866129544;
        Sun, 06 Jul 2025 22:28:49 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74ce4180e47sm8234243b3a.103.2025.07.06.22.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 22:28:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  redoste <redoste@redoste.xyz>
Subject: Re: [PATCH] SubmittingPatches: allow non-real name contributions
In-Reply-To: <20250707030609.GA13852@mit.edu> (Theodore Ts'o's message of
	"Sun, 6 Jul 2025 23:06:09 -0400")
References: <20250706163009.335780-1-sandals@crustytoothpaste.net>
	<xmqqv7o4ajq1.fsf@gitster.g>
	<2DBEA13C-5E74-4314-9A39-E045A0BC221E@gmail.com>
	<20250707030609.GA13852@mit.edu>
Date: Sun, 06 Jul 2025 22:28:48 -0700
Message-ID: <xmqqbjpwa7sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Theodore Ts'o" <tytso@mit.edu> writes:

> ... advice and review of lawyers employed or contracted by the Linux
> Foundation.  (The Developers of Certification Origin had quite a lot
> of input for lawyers to make sure it would work in multiple legal
> jourisdictions.)
>
> So for example, it's not just about copyright concerns vis-a-vis
> anonymous contributions.  It's also about OFAC Sanctions[1], since an
> anonymous contributor might be someone working for a Sanctioned Entity
> trying to bypass them.

These are excellent points.  All the more reasons why not just we
cannot but we do not want to take anonymous contributions to protect
ourselves.

Thanks.
