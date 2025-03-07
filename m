Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596C1AA1D9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383536; cv=none; b=Fpe4VU1qRqVfvL+kX1DELLeYThpa6DouQbUr7CJr1UryM6biB8d6g/55WV8j54K1dKDHq2vv/NyHtgrjLoPRpa5e0Hfu1qzUpoHs2YF0yQjqM8rZWeyQPcONtVEYmRl1sWThJzp0Z9LF8hSHY3Zi15gxK2hWQy8F0QUP7airF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383536; c=relaxed/simple;
	bh=RVLXIpqfvfQd1paXAq31y3srafPTpyZoij4P5zbF8fM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=id6Odr6ZPqf+h+0ORIlVWmZWXuf9zVPyYblxbGwHb42ryy/lhjJbHatBBkcUX8o+/7ycz03eEEKyjSPtQqAKvwo4UNvyYNGbhPCXH3JJt7IibD4vtDTIvBxGJdGwXMv35CRwO12hYhQ85phWA5krRuw7303B6c55bXHDuHB/UUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=Sjt1+Ugs; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=bG/dPhaG; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="Sjt1+Ugs";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="bG/dPhaG"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so18227166d6.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 13:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741383533; x=1741988333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxbVRgl+xhfo5wo9N9/w1llKWgG0wLh0GZiejQVTYc8=;
        b=keofhy+lU0esY58QkUgs3s8aOFAbZzCWsZ60zl5Arg86ILMyzJiGjzjasG2EP62/ZP
         g+T1gjiuX9BD09qwFavXcNEcs5ZsPpJGxcc89aEuPU2mNQNCVLxLqrgIAyCexGk72SgK
         6oc5iDZ+kR3I/O02CbVrHBHlwVLDxyqk3xPcS0skU8GaihJ8abQ2dUUQfsVIjkeKJXIt
         q1HogZRy4DyLDToHizD7mTES6KKeIiECbxKwKghOEX6uGihLlVerQNgpajbvxwbqiLmn
         AOa+vwiAKkrAzDkil7vefRHqWTdGkRXp1pEuaGnKsJ/TmV7BXBMCOK+UmEC+0DR71Y77
         VFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8RseLlIbFE+zo188Z4IvI6165wEs7zwIOMcHf0CONQFD9IvOAAm/JNQ2kT1raj6LrmlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzej25Q3aezmhVkR1lL9uZFlRpobMa3fIh0CsdSYWttRPnzlIQj
	u7tyiWDnUgV5vqq6dxhA3XbiSKdiY+uyMUbU6FiKlDh4KgHK4CdKaCFaWsa1au3z8KzLOeBVUXH
	z/zRTx56oWUd/Oo/bt+smF1zjlCIwhzDwgamXRtlPikK0fU8J
X-Gm-Gg: ASbGncv0eTrqqE3Czhlgb8Y1QMDj+J4YSPvxGW93pXhvQcxVPcfouiVySB5rdMyXc2n
	y7Tn8ETU88KI0L9jQ4jPYgdC+B0eI2O6Pgrc2NCaMPqV1dVh0ACjTrBgyvjTd6tLkUUMQy5NsH9
	mT05kQi4gf+5yMekf8F566S8ymPYtqjL3ImkpAfTpsIc837eC7CVv+vOEWeFL1TEoxbPE9c36P3
	MaHGGk5f4+r5sFJtoMPGFLucaZHR6TC8+KkSKfaD6hqx3OC9Ln08I31KrpaHVbRl8IPFIyDKk9p
	smaoBOxsxjhkWuyjwZnZfm1MU6DC/yXmgcowG3zM
X-Google-Smtp-Source: AGHT+IEjh/tUenpiQDh69bDnk+1NWJD/fz5qK5TsmvZNTaBGWNls/uLEMfiayREFjspm260i2gsiDXblKqA4
X-Received: by 2002:a05:6214:19c3:b0:6e6:6252:ad1a with SMTP id 6a1803df08f44-6e90067731amr62494236d6.28.1741383532962;
        Fri, 07 Mar 2025 13:38:52 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8f70a4faasm1468316d6.31.2025.03.07.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 13:38:52 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741383532; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=RVLXIpqfvfQd1paXAq31y3srafPTpyZoij4P5zbF8fM=;
 b=Sjt1+UgsB+Iotu8xgh6lX+gPkIIaJ0lCYKyHbGXvpnMX9U/Q2VpA/vn+O3wY88QoGyovZ
 7oxwulOt230o6fVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741383532; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=RVLXIpqfvfQd1paXAq31y3srafPTpyZoij4P5zbF8fM=;
 b=bG/dPhaGVjTGmk0TcuGFpzsofnKnbdNOfwsOtRANZfQ6gvUki8uJjCR7eAUHfYQQFSvU9
 YcsoaPnkA7UY8JqY6YES/bb8zjfU3F68i8r2q0GXzgrTI3H+51QzMBtMCVaiNfXJzWFJHtT
 7gxeXhtPOjJhz0A5q0BU0y8vofUa027qRhRA50kGt6FyWyGF5LEcx3D4tQLGYstF+LjnTRt
 kWZxDGR/5xdYDnMAlob/dDKRYnMbJmqZwPQ4/rLwPgpo07YsoZGVp9NGc5f/OrkYYXUzq+6
 bdKa4mMmV48KAHhwXju9w/LigYfwiR76C+48ztrAv/4dQAcmlhhsvn0TP26A==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z8fmr2QWrz10df;
	Fri,  7 Mar 2025 21:38:52 +0000 (UTC)
Message-ID: <1192682c-b68d-429d-9852-15ab627d711f@mandelberg.org>
Date: Fri, 7 Mar 2025 16:38:51 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: Junio C Hamano <gitster@pobox.com>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <xmqqh645hopj.fsf@gitster.g>
 <05bf397e-4bc2-4255-87b5-925c80667f4c@mandelberg.org>
 <xmqqtt84d0dz.fsf@gitster.g>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <xmqqtt84d0dz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 2025-03-07 om 15:57 schreef Junio C Hamano:
> It probably would not mean much either way, and certainly not
> something we should worry about during pre-release feature freeze.
> 
> The "fix" may take quite different shapes.  Remote nick/name may
> still be allowed but the default fetch refspec left by "git clone"
> would start using the refs/remotes/nick-name/ hierarchy instead of
> the refs/remotes/nick/name hierarchy, for example, but as long as
> this round of completion fixes properly read the configuration to
> learn the remote-tracking hierarchy by reading the configured value
> of "remote.nick/name.fetch", such a change would not break the code
> in the completion script at all.  Or remote nick/name may outright
> banned and people are encouraged to use nick-name instead, in which
> case even if the completion code is prepared to accept remote names
> with slashes in it, as long as it still works correctly with remote
> names with no slashes in it, it will keep working in such a future.
> 
> Or the "fix" may be to declare "there is nothing to fix, if people
> want to use
> 
>      [remote "nick/name"] fetch = +refs/heads/*:refs/remotes/nickname/*
>      [remote "nocknyme"] fetch = +refs/heads/*:refs/remotes/nock/nyme/*
> 
> that's their choice, and the completion code would do the right thing
> anyway".
> 
> I didn't read your patches, so the situation may be different and
> with any shape of "fix", or without any "fix", there might still be
> need for further polishing.  But hopefully you got the idea.  For
> this particular patch, there is nothing urgently needed.  Well, we
> are right now in the pre-release feature freeze anyway ;-).
> 
> Thanks.

Thanks for the explanation!

> As a remote name, we still do use "is that a
> file on the filesystem?" to see if it is a local file:// URL
> (i.e. "git fetch github/dseomn" may be fetching from a subdirectory
> two levels down)

Btw, I just tested it, and I think this is an issue for remote names 
without slashes too:

/tmp/tmp.sVAhhZuEzA$ git init foo
Initialized empty Git repository in /tmp/tmp.sVAhhZuEzA/foo/.git/
/tmp/tmp.sVAhhZuEzA$ cd foo
/tmp/tmp.sVAhhZuEzA/foo$ git init --bare origin
Initialized empty Git repository in /tmp/tmp.sVAhhZuEzA/foo/origin/
/tmp/tmp.sVAhhZuEzA/foo$ git commit --allow-empty -m 'test'
[main (root-commit) 24c92a9] test
/tmp/tmp.sVAhhZuEzA/foo$ git push origin main
Enumerating objects: 2, done.
Counting objects: 100% (2/2), done.
Writing objects: 100% (2/2), 162 bytes | 162.00 KiB/s, done.
Total 2 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
To origin
  * [new branch]      main -> main
