Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518522561AC
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378297; cv=none; b=uAw0txz88d/rjU63IJLpqs6iLk6es+m9d5jAt6ikCdXlZmq3fQZ4Oy+ZMMP6TqrYOdL4VwYanJRwR6y73s03GwQX5gpscT7fTqggxi25WtFN3YnTCKpnF388c0JTZ9QKsCADD/UTE/yT5AnJqD9T0a5RBg3PzeV/MGcwZRY+Prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378297; c=relaxed/simple;
	bh=tDRglAIZw1qPAPtpHltAFWzo/hy7QoWKiHAVdZLO2/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XW7QiTcvkqMcD7LMH1Rxt2zsCv1Hag99yXdOK54hbi+m7BxQLSPnmDgSwvA5rOWQh9SY6aXZ3tcJmNPyE1oBztRN873qt4WBHnKeBEi4dCtcGK7yg8o3uppzndegY/UwFcmc5mVq5byUXU/DGcWDFlt128vaXs4R+HUvXRTFpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=2Bs37LXt; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=PLjOJN2r; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="2Bs37LXt";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="PLjOJN2r"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-223594b3c6dso42858745ad.2
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 12:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741378294; x=1741983094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fWvBcNP/pSniPYQk/EQ0fQeezLiWV6IKa1qaA3yYIU8=;
        b=xRd6RLc33m1CvRgYclx/lfyQI4NT5EssGmEV7HAEOIOmrpvJLX+3tDXimujgGTR55v
         PIsr+/xnr5td8hjQmKdpOmgKrAN5oYQ8wktkq08Bkm/qjq23w0hL2qoPMpLoN75/RhpW
         QPheeP239lqmYdKJKjtatpqsop4asjs8qJKeTfthyHSUtg0GAQRHfPC5jH8kYVzhh4nF
         lje/ul5wGDyMX4tUciurtYWdzNONKCSQ78Uw0HjMpixG69GKhEw2N3qFbN/qyNSjfAEY
         lvO70Dbg7iN9fSEckURoBDJW1Hyl9Cc7rbRb3y9A1kkCKMY8kx4CGEe6/N20OIW0nXYb
         jMKA==
X-Gm-Message-State: AOJu0Yx1icpeksahQPnNWx2Cfl6Bz8SWHeTh07kGNzWGYBtb4R3JzKg9
	D5qp1lzMtMOJnJkhAZpVVlGp7rVNWK3mmWbc01nEuLNASTs/mAt3a9pZkhcGI7B5sPWG3GFLEaU
	/nA75ouPwGrO1Duc9upgZvu0DG2YmPy/t1elYLf9xyXMvCLiR
X-Gm-Gg: ASbGnctxMp8HbPXWmbKLK9XInLkorTdSOW9PvQaOXmlvQ7iUHHGaut+AR8BZhPx38FK
	kvjZRpLXmvFfSekF6QneyTwmnyBzcqN/4k0Dy+MUKlwGIu0Qss4ZAmKO8MBJHJO1aakapYxh/++
	xxiw5RgzW4vSfPqcw7adNTZfEOaw9zzXj3Pc7mETu8Gevk93rus9qKQfZj0umC+1u533vNZtRLI
	+/KS/aXF8dnNDGGwQbz9bafhY9l7NxEIfFNYyiSiCelLOiTdOnzemp79+IhBwHd/Owp8K9mYhzF
	6T3Q1cgTUOwG3QoOHL7a24KVn+fzDxJawQEOmFvf
X-Google-Smtp-Source: AGHT+IEHEJi4BovNhn3yzN3Gf28t70jQ9nL9RFvzZJ5SoYVPsxJuGRD0IeciD1DBPmAGDmiYQht/3OI+IRrd
X-Received: by 2002:a17:902:d488:b0:224:e0f:4b5 with SMTP id d9443c01a7336-224288866a4mr63492645ad.7.1741378294399;
        Fri, 07 Mar 2025 12:11:34 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-224109e6f83sm1868985ad.43.2025.03.07.12.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:11:34 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741378292; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=tDRglAIZw1qPAPtpHltAFWzo/hy7QoWKiHAVdZLO2/U=;
 b=2Bs37LXt5yJD3HFB9wwjl5Gl5SxPZvFJU3DuZgNUNTs5TKMVOJVq1inEsI7Rs97ZG+GxD
 O6SjvP/rmHHnCVGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741378292; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=tDRglAIZw1qPAPtpHltAFWzo/hy7QoWKiHAVdZLO2/U=;
 b=PLjOJN2rH7ESOG86MHo1lpVBiEoxRss4/3a3qHIoNuGVfPc+smmEpDC+mEKgWCLuDrWnf
 twrrNfGRqh7HG1E8C6EaUW8GNVvppcv26R36+r+t8L5w5QTCyXeHzh2jAygDXCGSYSatcNs
 W92b3poCl68qvGtcGAZ4KqvI4/SGk//muMODwDCk3Pp4RLTV2rWD3zjsVhERefNfVslHoe+
 uASXkHVcFZxPLdVZjVZuAdpqM6usKq/8uXp6Pb5Jc2yaVYRcYMvscK20C5eCWbfH/BGbNE6
 kFzicErCOMukBb3GL25xdhRwB2CgAqCLygZK/VHW3xw3Ujv+9RxEdZ+ZyJTw==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z8cr47037z10df;
	Fri,  7 Mar 2025 20:11:32 +0000 (UTC)
Message-ID: <05bf397e-4bc2-4255-87b5-925c80667f4c@mandelberg.org>
Date: Fri, 7 Mar 2025 15:11:32 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: Junio C Hamano <gitster@pobox.com>,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <xmqqh645hopj.fsf@gitster.g>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <xmqqh645hopj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 2025-03-06 om 15:46 schreef Junio C Hamano:
> Apparently I am late to the party, but I have to wonder how
> prevalent it is to use such a name for remotes.

 From a quick search, it looks like I'm not the only one, but I don't 
know how common it is: https://github.com/desktop/desktop/issues/3618

I'm not sure if I'm remembering right, but I think I got the idea from 
seeing slashes in branch names to organize a hierarchy of branches, and 
realizing I could do the same with remotes. Was it intentional to allow 
slash in branch names, or is that a similar situation?

> As a remote name, we still do use "is that a
> file on the filesystem?" to see if it is a local file:// URL
> (i.e. "git fetch github/dseomn" may be fetching from a subdirectory
> two levels down);

That's a good reason not to use slashes in remotes that I didn't know 
about, thanks!

> Anyway, this is not something we'd do lightly, but we may want to
> see if we should tighten the naming rules for remote nicknames and
> the mapping from nicknames to remote-tracking hiearchy, at Git 3.0
> version boundary.

What does that mean for this patch now? Do you want to fix the 
completion for the currently (unintentionally) supported remote names, 
or leave it broken to discourage their use? Fixing the completion might 
also give anybody reading the completion script the idea that slashes in 
remote names are somewhat sanctioned.
