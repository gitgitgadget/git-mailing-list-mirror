Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982332F657F
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323704; cv=none; b=lDApaCLT31VX1zDGuvLQ2Fz3yPP49S13K40iiYNJjYJvFIQRuUAghA5dVrUfU7uAQGOtuzxLWnZ4YR5pYbV+0T8q1hMtvxS+cARsv4rUTQyNZVM8DQ6cYFdrZYkn640PwObi5K8KR/IVetUDQYUjTyZ4gONhrrqQypAcg03wNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323704; c=relaxed/simple;
	bh=hUAa2lfyp5c58Va1RSccyi3bitaQPDOPNHLgWmZ2IBA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ax3kLFzeJ+sVYrHPgLDd99hnp+00T+A6iHfrCja6Ikm5uIhTNK1QZyBRqpzlcaH/5VJBX7wQlxydRFF91kxWwl3u39aHCLeHC7Qnuq+52TEohM0l7M7Uy6dmycFIDUAfZUKZwYtp6TSOCWQK1CeNdbx1EBzF54t+Tm3hm+kCZ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvVJwAHg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvVJwAHg"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so1720052f8f.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 02:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323699; x=1757928499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUAa2lfyp5c58Va1RSccyi3bitaQPDOPNHLgWmZ2IBA=;
        b=SvVJwAHgPjumEAZ9cUWNkwOnvzlXLmfiG6QZ667Mutlcif5Yn/e1ZfUSKj4BizqZD9
         e2thh/ntfwYBoqYlrLXnDy9NjMC0ijN/zzkicdlcavpib4LaiJN99nrNv77razhaN3ig
         sVUOBVzEoBeEpJ7/8LX6Q+R/L6UrErCC9XRCQ1d8r9yFOBQLU47wY22VI3Vk3G9VoHBr
         J3G0qAqd+gyMrlEm6A9LKON3zHRWaRx2WTRGt17gWc2mTK/j17maW4zyf5iZ9UOWNTdV
         5JeGBFhAeWD64vlwC0mtJjq64FdH9BUIuM5gDH0n/3va0DM0r/nqKh8i6ByokDUj3Rj8
         VOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323699; x=1757928499;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUAa2lfyp5c58Va1RSccyi3bitaQPDOPNHLgWmZ2IBA=;
        b=NWMuqbPiKsA9UBdZtHXhKJ58zCMe85NtctWbkjmcvTP1/o66LvFwaMdrkYO681lnsQ
         Jds7a2poU40hNY2z/MF/FehzseOqLql3zoWnSYYsAZ+euCGKCOUs4rGilGn1BGUaM2ea
         DXMmYmlx2733giGPYtN/cuqlNAF8FnCpROMNVdZXrsUMv+5AA6AcpxNBHOAuiGLVSpv1
         CpJl3WqxHGf9cfQePgCtLN0tkF0eSehlVz7rPMFcDIKVUZ6VfN6Rx/orhJhAT/kmZAbZ
         elZojdeL2iFd5ESsfkH8dnRAK2O9pmx0KQAgvTgTRm0UBB1Ta7azFcUTqW8aC71Wrz1G
         ofdA==
X-Forwarded-Encrypted: i=1; AJvYcCV28TAonytmTedVRvOv3tQwnrwrcnXEYbOIeN/GJDmATnd0Ax52TXPk2+KM5lZJChxtaiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcptR0n2MZq3KRBUT+V3j67zOPwi7SpdJbiyOL2SxtNJa3SlFG
	Mt7TeboT6wjsJsTjcDOwDShD/sj1lUN6mi6gwk5DcjU9uDjGafWFGbPL
X-Gm-Gg: ASbGncvyVez1qp8JCPxbZWfJ4jXxXCAeNlyML3i+7UmsuYa5PqT0NOffYLEfWzAmXGN
	ciB7nvH33P3ge++rMdITCNw1YzID8EVfPIje559YKenPAiiTm4+wsednPBwynEzdrbhL11uThUf
	aW6dG+mj7BSBmQavDDHp1XM58tHS5YEREsu/BN871zJbB1BbsbCs2mMVGea1bZj2xDylAsPD7Jt
	cr4fe9qPOoBgNfNIuK6XtyqED1ymfBhc86tjidjffc/gwdc7z+rCszlXgIpOFW65QBWTaDwvpoK
	MXtREHJWuum6oFORtAs4mJGQwUW/IBRdeNN70q1om5F5fkyUKS+HUazd24rX2FKeKKpDL3PVDfW
	0b/+qtpY7c4ZOuVwVmnIe0Gjx+HprUMRvyFSbzwqTi+qgTO467NeC4rKNnX7X29H4OB1oKQjr4/
	KO6QanMZ/lZNCsbjNGJga5rIPfA90Y200=
X-Google-Smtp-Source: AGHT+IFuzfcxmexZImyTSy/wYM2NnCKCcp94PIA1OWdRFjDLNAtlRyt7aIi5+xnS24NgkV04LjkOEg==
X-Received: by 2002:a05:6000:220f:b0:3da:e7d7:f1e0 with SMTP id ffacd0b85a97d-3e642bb80e0mr5777535f8f.27.1757323699177;
        Mon, 08 Sep 2025 02:28:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:226:25e0:1d51:1977:518b:89cc? ([2a01:e0a:226:25e0:1d51:1977:518b:89cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e12444de96sm16051451f8f.19.2025.09.08.02.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:28:18 -0700 (PDT)
Message-ID: <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
Date: Mon, 8 Sep 2025 11:28:15 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ps@pks.im
Cc: git@matthieu-moy.fr, git@vger.kernel.org, gitster@pobox.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, sunshine@sunshineco.com,
 tmz@pobox.com
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
Content-Language: en-US
From: Gabriel Scherer <gabriel.scherer@gmail.com>
In-Reply-To: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear git developers,

I find myself affected by the removal of the `git-new-workdir` script
which is a relatively common part of my workflow. I am writing to ask
if it might be possible to reinstate the script in `contrib`, and also
possibly create a discussion with other users affected.

(The removal of the script was released in git 2.51, three weeks ago.)


Thanks for your work on git!


## Details/comments

 > The command thus predates git-worktree(1), which is what people use
 > nowadays to create any such working directory. As such, the script
 > doesn't really have much of a reason to exist nowadays anymore.

`git worktree` suffers from the substantial restriction that it is not
allowed for two worktrees to checkout the same branch. I understand
why its designers felt that this would provide better guarantees (it
is not a good idea to mutate branch names that are checked out
somewhere else), but checking out various branches to test them and
inspect their code (before returning to the feature branch I am
actively working on) is a common part of my workflow. Getting a 'fatal
error' because some other, independent worktree also checked this
branch out is a hindrance.

Note: I don't know about the `worktree` implementation and whether the
no-double-checkout restriction is fundamental to its correctness or
just a user-interface feature to avoid sharp edges. I would be happy
to migrate to `worktree` if it was possible to disable it (presumably
via a repository-global parameter, or maybe something
finer-grained). It sounds like more work than just keeping
`git-new-workdir` alive -- but I am sure there are niceties with
`worktree` that migrating users would benefit from.

 > It also doesn't seem like the script is still in use: the last time
 > it has received an update was in e32afab7b03 (git-new-workdir: don't
 > fail if the target directory is empty, 2014-11-26), more than a
 > decade ago.

I use `git-new-workdir` actively, and have never suffered from an
issue worth fixing or reporting upstream. The fact that it was last
changed a decade ago also suggests that the maintenance cost for git
upstream is minimal.

