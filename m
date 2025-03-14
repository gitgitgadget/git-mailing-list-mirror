Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1A51547E2
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991877; cv=none; b=dwFYDBbRvV6ZHjX7U+QaLZ2UtpCfmHZ8CA/F/WDoVm5ghMyeJ+UCAXS8DZMg3NYwna3djfGwVgpTIlp9JXtwjie2Afd+8o//NzoBaUiWBAOici4u2jWLszdQJdPBUxB8jB46AayqPR1757sgmnrjv3kHeonXcMua9Tr4DG0VnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991877; c=relaxed/simple;
	bh=VvWQZ2yH//xole178SlSiv25uDlhdt7dHHPH3yN51gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRerAP5UN3T2iIO6MTxgXsskxLES0Gx7ohO7Im7TczZ9Uo/rGGRWMK6V1whzRI3oe6GDP8Qyxe4pEHqJEN8FolVD5m14PHirvG5m88/LzEERQVzqm14oDKsWx8KP44rrPFR21V0+fHCq38ild0wo0DXYx/3PvWKjpZ3FA2lkWjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=qQaJnDHB; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=S5Y7gjKJ; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="qQaJnDHB";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="S5Y7gjKJ"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d4436ba324so18974345ab.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 15:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741991875; x=1742596675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4EkHC+fwQ/ehzoxJWY6qNRVGeLiW366lFfaouuDOUMU=;
        b=JLVoIzatp8PUV3abNM7kg1Mn/Q2AtzIRFSvoKZLDemW0nPUEWLB+q0SUer5s89edlq
         zGAvKGElzQZETx2IbmS6qVhMsn71XRUmjYo9CWB8Kf61Bd0Mh2suJ0KEPzfv4Ub5juft
         UXtzsDb82XCLoaycbN23tNCoEU5tNetykmnu5SaHkpFUUlf8SErrbOcrKMvrwTeql+ND
         ueCWf9yU5nawvEeomO6OXB43NfY4KmKlvF9gT/WEm+4ykWyJgX/DoQky/EpaLN07Romj
         3P0uXx+Gs/agcF7t6HOHVF6PMR7WorKzxgk2KlLa5YsnKNhjUqm1lygpLh6xpgX6nl9W
         RLug==
X-Forwarded-Encrypted: i=1; AJvYcCVW+aXsiljLFBsORfOwREYzeE1SiVHJAKSxO+qG0Voq3q3ImeyObCNWqv7SBTGt1MZ2Kj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5tt0LNJGz9mQsEtrFMamTyAoaF21rzYzGM8qHkLxycvUgpJv4
	dXmLvsNPFURIV5gyLViLqk9cxtwgmZ6+ZdvpfblLXqotx6DMRhhepEvQh8lyILnkSxCKhqEa1JN
	G/CUODJOYrHGHauN6zMPnG5cgqwxcL+H3
X-Gm-Gg: ASbGncvaMNfhGj+zRa7N72nNSLvxYlNSjuTYgkoAsXjkC54pqSuAIuWJFwRrNQ8Pzoo
	L8w/l3qyFu3AFPmNhlveH1trzyd24AT+r2v5piIs2s0xiWtwLiKYBli9PS9nSRwkch3jatxgiUe
	hIPVJTyDpjp+O1UZkoVdv4g2kLrxfG4XuGvJTKagPF6Ko/EP+h09V7GlI9qlDrvqd+rGbcA8SRU
	hKiV4ixf61u+8LIUVgT+WqLn7OAptSLekUj8RitHoxprmrPVAOopUN6fYZmuQm7GR+SfG5JzLJg
	tGKj19DiGRWIC62h7kaCb9cxWcBzZUOqd+Cl4+d88npMFJykWf+8p15RKBnt1JNnfvkD5ljUe40
	lC4sN8kCCekETgJwkNZzKS+3H3U0DYQ==
X-Google-Smtp-Source: AGHT+IGhO2oAVDEna5O7JzwMQHRbSAgwZ1nC7mF+4dVhthtgV5M2hTu7IjBIGcERvIYu/J+M2JA6cElCLRfe
X-Received: by 2002:a05:6e02:3c02:b0:3d3:fdb8:1796 with SMTP id e9e14a558f8ab-3d4839f5f81mr43610085ab.2.1741991875035;
        Fri, 14 Mar 2025 15:37:55 -0700 (PDT)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org (pool-108-49-41-183.bstnma.fios.verizon.net. [108.49.41.183])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d47a64f763sm1999855ab.2.2025.03.14.15.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 15:37:55 -0700 (PDT)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741991874; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=VvWQZ2yH//xole178SlSiv25uDlhdt7dHHPH3yN51gc=;
 b=qQaJnDHBbUStrX7h2Xg5GpiwtCwehF++aTk7a/EMDEcqxtNxo3X6npM6mLw0b55bo/+7F
 YTWNjkXV+tokozrBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741991874; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=VvWQZ2yH//xole178SlSiv25uDlhdt7dHHPH3yN51gc=;
 b=S5Y7gjKJ5V3GW58ebAdqNHsMB5RNwwuc3DqM2S6MXZ2Uw1PJroMfFiryUu8wjJEsDvlls
 3jC7VfsJOuyeBjX6LIX76ctza0bSOfcxkCJDsOyhGaqFJxQwesY/QzaDy9uQEFk8dV4P/WF
 O/25AOpEpHoVG2NtUtK5d5RqHPgIwVf0YOrqxpN9y/NkX0UmMxYhvrSa3wbj/xYRrhIJ2gu
 eOWDVMb1A5vpOjOxyrjNfbD2yEYxdXct++cHFjJoaTdF8YXHsGpu7ShbJo+fhSYPS4v3+en
 vYS4HjzgAfs/BOCQPEEBD3YkhRdwxhnsxM/o0E2NTpjuzW1aHeFXmgoorBxQ==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4ZDzlk1CSkzySw;
	Fri, 14 Mar 2025 22:37:54 +0000 (UTC)
Message-ID: <015b89f8-63eb-4203-8d43-47c9a6d65cda@mandelberg.org>
Date: Fri, 14 Mar 2025 18:37:53 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
To: Junio C Hamano <gitster@pobox.com>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <1587533591c81d38977e62165784f8eb@mandelberg.org>
 <c80d20d93c92422437150084f402ac36@mandelberg.org>
 <xmqqo6y3dzno.fsf@gitster.g>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <xmqqo6y3dzno.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 2025-03-14 om 18:18 schreef Junio C Hamano:
> David Mandelberg <david@mandelberg.org> writes:
> 
>> +	__git for-each-ref --format='%(refname)' 'refs/remotes/**' |
> 
> Just a bit of curiosity, but how would this be different from using
> 
> 	__git for-each-ref --format='%(refname)' refs/remotes/
> 
> i.e. the prefix match, here?  Does the wildmatcher clever enough to
> optimize "**" away and make it just to iterate over refs/remotes/
> hierarchy without filtering anything?

Oh right, I lost track of that bit. When I wrote that, I didn't know 
that for-each-ref did prefix matching. Phillip Wood pointed it out:

> If there are no glob characters then "git for-each-ref" does a prefix match so strictly speaking you don't need the '**' but I don't think it matters in practice.

But I forgot about it when I sent v3.

Do you want me to change it? Should I send a v4 now, or just make a 
fixup commit locally so I don't forget it when I send a v4 in the future?
