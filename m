Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85D1F12E7
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953628; cv=none; b=tac1gJ7t+/63Lmci4o0CVIzr5h12Bo2BOSCklLSMxzNb1qVqlTAbG+cECVu8Ad1P55yULJC17htQ8SKIRHoNf7jIcdzzFC6J5Xfik9sFDsfXCzehl4tm0CG3HlnIAUVAVBX7HO68PcY4WJpQJQgvlOjpLkG63ZMjKeSaZViI6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953628; c=relaxed/simple;
	bh=Zu9NvF2mBTw/Wf4KHcDczhtpiEOFNCNKVLBs1uAJbL4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWakToq8pGSg4e7aosJ0PHFINo/2AR8PEBz/dQtbPQ8gvo/0TxGU43Ejrb2f2dfE9uAZnTBRFbq+dRj9UvN2DG1vaipOXXF07uLqgxdr4WTASGTG6ST8FfQY7uc7AKJhZRRRE34sKehNrczIVr/EXE3OYjcko7rhhzsu2nZhMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0OxX7p0; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0OxX7p0"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223a7065ff8so54164595ad.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741953626; x=1742558426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0xaU+qhu3w2z3y1l0C0zQmMhGoU7BzA1wxlSi0UG9uQ=;
        b=J0OxX7p06bjovZQAfjDZdXT/oTCesp+TwRa8ImDuNCYnhSO6Hvh+ZR04snf/LKKxcY
         7I56H2n3U6plDUq5MKPfhezmrqJFm65V1jgXdw/kIiOWSWmvCM02MDO+LJBov7FVJjhL
         BCBXW7w5WiR+HgyDwlr9XndikOClTwZnxsxH6NFHJg8+EUqToGYSetysjCHWstZISut9
         zDgz5B7gRH2hsj/FDFpPc3LbqVZhrKb9mbz/2ilLGOYtMrgTfqGoYG7kMjmddSkjpQc8
         ytsqn17FSxJeAE6ymiqGCh1VxvY1F9UcwF2c/5d+w2jDnf0vUociopUTqbRz7XiCY9ko
         lfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741953626; x=1742558426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xaU+qhu3w2z3y1l0C0zQmMhGoU7BzA1wxlSi0UG9uQ=;
        b=Q5v8WpYJKw8sWVpyVxDawGMjsiMDkbyM46eAgi3a7Pc/P3KIKne00KBWq9Ho/5L/gy
         yNI5nFwAolPq9kXv7XrouvQO4bexvPtvEhDNcayPsQMwE8OQoyhLPFDkQGJVvX8qXMdi
         5y+4SVMv7A49d+yaOHDl0DOOluPORsW13Zekmn0mfR/lhjcC5GH+0Hj3Qy6huctPHNz6
         Ix/rMh2wVopFF+v0MoiAHU+62MYxwYshjVd/i6s3jotYLUJ3cGwIRwfrOUzboLnq4NoY
         JYPVeDkrCEjLwMZOddD4VtEuqclcEX2MkFe1jA0zBI4Wusz2Ud1tiudKGkjhMpLP/INT
         FtJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOC10+eEvopu+QcdWEdV43lZh7Lc1siUn2v2iceNwP6ox88MsX/J+mIoG9BuFKmQ+EF4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNW6d2I9H2AJ6Dl7+Z3qlknKtTUiUyb6iKLIjfn+Lr1TTOkOQK
	RM12gL1ZodZkzh2z8Of/jQPVPXKHacOrvlAr1pwh3q9qzti5VfnPl7V7Fzimx9rp2w==
X-Gm-Gg: ASbGnctEHfd7N7WNLTiBI2erRljpW76fsclRJS9KMWqqkR0vhJM4ANzAhKL1584rdsp
	G+aA6AGgvyKoDda/Kk+v2m2BNdNG8H7KYGvW+49iops+dSaMcuTT2rZJTvrHlDQsk4evOzNn1uo
	3b9BotF+ZBhTZuFkGcALO/Dy1NK6qtEU2uBsLdcUWnn4QC/1Uw3DTZeHrc6Eq7XkHYoVcchfObx
	Z1hWFfvFPS035yN6W+h0iNjSNECnG33CngdTZSX6Z6VGs3tM75jHPhbwGfc5opfXHEq0GaZgM6A
	mO2jf6UPOmrazTahzL+Mt1ZuLpUGN14QofoCvW3Ph9Ew
X-Google-Smtp-Source: AGHT+IEKHfhRc0cen16gbyYRsRTSnPynATS+oO6DL9XvQKJgWlNR8GdMIZdkAI1AzfKm/FdHG2iE8g==
X-Received: by 2002:a17:903:1250:b0:223:f408:c3e2 with SMTP id d9443c01a7336-225e0a82e85mr32218585ad.14.1741953626249;
        Fri, 14 Mar 2025 05:00:26 -0700 (PDT)
Received: from arch ([2405:6580:9580:2e00:bfeb:1d53:4d27:1c15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm27254045ad.38.2025.03.14.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 05:00:25 -0700 (PDT)
From: Aryan Pathania <aryan.pathania2003@gmail.com>
X-Google-Original-From: Aryan Pathania <aryan.pathania2003@arch>
Date: Fri, 14 Mar 2025 21:00:22 +0900
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [GSoC PATCH] t9400: prefer test_path_* helper functions
Message-ID: <gm67nhqkoa5adxz5ifckpvecn5f5hewubmcm62nr4hejlwbhsg@pmo472wkj7of>
References: <20250308090358.25429-1-contact@aynp.dev>
 <Z86LrOEhH3CJOIey@pks.im>
 <r5572ospfh3d7nwniod36jcy5ikv5pkmiwtqj25ll7p5ts3zay@okbxrhy77iyv>
 <xmqqplimxgkb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqplimxgkb.fsf@gitster.g>

Hi Junio, thanks a lot for taking time to review my patch.

>That is exactly Patrick suggested (go back and read it).  I agree
>with him that the updated stronger check is an improvement and it
>deserves to be explained in the commit message.
I apologize for miscomunication. I was agreeing with the suggestion. It
was redundant on my part.

>    $ >this-is-file
>    $ ln -s this-is-file this-is-symlink
>    $ test -f this-is-symlink; echo $?
>    0
>    $ test -f this-is-file; echo $?
>    0
>
>And if you are not unsure, then learn to be unsure more often ;-)

Ah, thank you. Sorry I din't know symlink were regular files. I'll be
more careful with other things next time.

