Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22D41C69
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627524; cv=none; b=L2YmfJoGFg5Fmey0qU71pfxpJNsH8sc1+JOdcf5TE90rhiWmxfd1sIcBdFAoU8SA5jJ3T5C6lk6ShmQP3KnZSM31PMdRmzhAqWAKKh2W5Whvs4U+BnrcKrUV0ch8Rh/MW3JhqTFLBrHrYC8OzadSHHmzHqK4otMYQyl5thdC6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627524; c=relaxed/simple;
	bh=jP8pYqRk8geu/GQt9XccIXK+PmlD+hJsaImW8rtFrGg=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=K2TikwMsuoRWASbkt91dlYgdIPBuvQ44Qu8lzhycimVCtSD2eA7iGPS+P/r3ad8so9GSyNfX3fl2kAZ7V6FQT1Z/+yxhw9cxWGxO0uAY/dwPSDIni1dUjweoG7JmEpgomANs4BEMpj+5yR/bw65ibbE2yy/d+pe05XOpil3tvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NucjuKsk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NucjuKsk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ed0abbf706so34913025ad.2
        for <git@vger.kernel.org>; Mon, 13 May 2024 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715627521; x=1716232321; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m+QR6gdygwBe2oQQVRq672aCkvwA4Ls+N8U0F10VgZA=;
        b=NucjuKskqWAJDh08vELEgnG0kN9lNXZxmNAbzB5/5OcoQZeh8NbPRU0pXw52I3pcQ/
         Y+dC9o3inl2dom2gmnS7519tIaNXQk0tQj8N/vm2sQyav/rkjG31i1BgPGQzdUDdaM1Z
         ecTIGx+Lc+h2wSP9KU0Ml7cUH73KtkB6gVEAnKX3s82aVjBqatXo6QdjUNQklGsuhlbk
         oI/x+UZd81plXvMsXm4biLEWe6Grh7B1ovwGDqW7fClAMV9Og+KuZY6SMYEzk18Js/d/
         k+LLucQDfjAaDcVhlz2paArnAvf7Tdw/8KHqUo4AOtsdWiHnHWMEwdH6YOpQNYjcar1g
         +XCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715627521; x=1716232321;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+QR6gdygwBe2oQQVRq672aCkvwA4Ls+N8U0F10VgZA=;
        b=UfDAjngNhb5P0mkHIRG89IHyBMcY6YX8NhVhaBhOaluHb5PcuulIciRHyfCBcJfkj2
         tCwelaGKKbL2J5UeXrgfzTgBOLCu1M2e2mpg7PDco4M91hAnpxw5UwK+OrNH71rzFvMr
         /ezdm3zml009y3DGV/uqgfR0bhC8dkE7r9Kp9pEuRdb3qjtz9hNiTli7HyvkVu+afFzn
         2n9gmezokueXzCIN5rETBNw6SwoQvx9R/bz7LiAdhufjyzOMjbbThKFsEWOCVgafk5ny
         3w/mcOmqucPkmWtQhHgo93ifVCQYqVpyQaYZtXjmU3GzljJiiNaidhLna7Bls6ydxrhg
         zSzw==
X-Gm-Message-State: AOJu0YwBSq3330J6wXgRdW6E4DnCRwCApqM/ySajVOhQPHj+3xpw6Dq2
	GS3BylK+FT8C5tYQBgDGt9lZ0EfGiLwx0UW89oAsm+VR6AuKRqhuintdwHQp
X-Google-Smtp-Source: AGHT+IEsoH7eETa54Zjm/Ah7CzwqMS/zH+/+T5EuqTQmgeDZUTk2PIATAL/33RPxEjvvAVXmljH9Jg==
X-Received: by 2002:a17:902:8686:b0:1e3:f6dd:b04b with SMTP id d9443c01a7336-1ef43d2ea96mr104681585ad.26.1715627521339;
        Mon, 13 May 2024 12:12:01 -0700 (PDT)
Received: from DESKTOPI2S1NGB (99-58-59-125.lightspeed.austtx.sbcglobal.net. [99.58.59.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm83222505ad.68.2024.05.13.12.11.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 12:12:00 -0700 (PDT)
From: <lbdyck@gmail.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
References: <02f201daa547$503df630$f0b9e290$@gmail.com> <m0pltptx3h.fsf@epic96565.epic.com> <019201daa569$0ae28f20$20a7ad60$@nexbridge.com>
In-Reply-To: <019201daa569$0ae28f20$20a7ad60$@nexbridge.com>
Subject: RE: git client enhancement request
Date: Mon, 13 May 2024 14:11:58 -0500
Message-ID: <053a01daa569$6df23570$49d6a050$@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAerfcO1waJyo8uA6nqAp40soFFQIOt0DaAggzg7WyKSXRsA==
Content-Language: en-us

I understand that there is currently no function such as I'm requesting =
- but perhaps there could be.


Lionel B. Dyck <><=20
Github: https://github.com/lbdyck
System Z Enthusiasts Discord: https://discord.gg/sze

=E2=80=9CWorry more about your character than your reputation. Character =
is what you are, reputation merely what others think you are.=E2=80=9D   =
- - - John Wooden

-----Original Message-----
From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>=20
Sent: Monday, May 13, 2024 2:09 PM
To: 'Sean Allred' <allred.sean@gmail.com>; lbdyck@gmail.com
Cc: git@vger.kernel.org
Subject: RE: git client enhancement request

On Monday, May 13, 2024 1:56 PM, Sean Allred wrote:
><lbdyck@gmail.com> writes:
>> I would like to see the option to allow the git client to request the =

>> creation of a new empty git repository on the git server without=20
>> having to open the web interface to the git server to define a new=20
>> repository.
>>
>> Perhaps something like:  git server-repo public/private name
>
>Is this even technically feasible? My understanding is that storage=20
>implementations of each forge vary *wildly*. I don't believe this would =

>be under Git's ability to implement as a project.
>
>You might look into combining your preferred forge's CLI with git
>aliases:
>
>  - GitHub has 'gh': https://cli.github.com
>  - GitLab has 'glab'=20
> https://docs.gitlab.com/ee/editor_extensions/gitlab_cli
>
>so you could alias
>
>    git config alias.server-repo '!gh repo create'
>
>to get something of what you want.
>
>I believe GitLab also has a feature where you can create repositories=20
>just by pushing an existing repository to an empty project path.

Please have a look at the github/bitbucket/gitlab/azuregit REST API for =
doing what you are trying to do. There is no specific "git client" =
function as git is symmetrical.
--Randall


