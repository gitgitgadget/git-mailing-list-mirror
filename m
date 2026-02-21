Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EA2257825
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771661454; cv=none; b=inzKv6hEbmIbQ87tKn/Q+I9tth5CXOjPctKQNW2Hd0k/cH71lw0oq1tn1sdqVzj+ApqupiaiExmDw9oaWMA1FiO7C/dm2Pu5ggNuq0fYfeiC6VbiU3nkEela7c708u3NFEg6xvQBKwhDwBcc8F5tUKZuHELeGREFm58RDyeWf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771661454; c=relaxed/simple;
	bh=dXnRPMiTrDex3cRF2jJWZcRoAONWotF9h35aYdD+TVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjpTuqmyWWQDJqZCrobD5AgYX8dN9Wtu88gfQOZkyx98mJiVZnwjyeRzAyxsVQ4hekBCA4tg8huDKbNaMpM3AV8qJACbYoA+wAURp1qVMCXqkOmDq6BRjRoDOSQxNoE17DqmkwZ4tDzkByqMxD/WktXz+UX+q1YAt06vImq/nI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEScGTfc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEScGTfc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c2a00109fd8so340806a12.3
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 00:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771661452; x=1772266252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4T72TEQcs8DqL9KStfdRnnv7eqdbKy24qoTGhGUJ7o=;
        b=QEScGTfcENIu7zZbGG9Q+tU+dktyhZsPtjM7eLfhC/t+KYtiNeM2EajWHBW54dV7VS
         2VX64lAfBxpv0/j5ht8qf1fpBPQdHxEcC4R+33dN15KO+0WKS8Fv2sux+i36QMU6RLnt
         NzqzBD4RsdG7biE0dlzrLWbhYdtGENSQhLHav8MJqV+1T/7mESRie/AqvWLsmPHMsSXm
         eoNEGHZywcAc4QzkBZNWyphyU4SeGGSt3zjtLbbIwFQ+nBNdPmmlremmVmune7e2ZhkE
         h5fCPkPFhte3FCjIB/DatHdffDwbzCMCf0P2iMyvI42hNvGRfpz9II8GhNH1gVW+SSqm
         iSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771661452; x=1772266252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4T72TEQcs8DqL9KStfdRnnv7eqdbKy24qoTGhGUJ7o=;
        b=M46xdLKpLE31ZxDJUsFAAlxV/MwpcLRz49ovYvDe7ZmJ1g9Ob/fk9gO7v6nAnbVpKr
         XyIxpMpp3y+DiCUhfIIbpko42nEpXyJy40uhNAqBuIMZ7rj6zVbeeuROjGvsZOGGl4eR
         JnU1ZcF8q4LiIzUdgOr5l2v9EmdEqRNFvQB5stoYlok6F0ABmz3z4Jv9nZF6GRS8dBNM
         gqyaBcA2sywR4L3OPk2VEjEpi8QYcRVV0o/L3R4fe/Auh7lGCvozvXS0zE2R+bIk4OEB
         iUI95cypoAKyRJTsLkQkxwbA/J2epJ93uDr+z8wTR4WnDGCH9qcaqxdBSMTJTUnFeCE4
         ib0Q==
X-Gm-Message-State: AOJu0Yx0M9WSdFxIbdgiInZCycZMh10Ywfg+l0DQm8ZA/4DcnkF0UqRd
	7gQj6TnZlpZAuyDCoZZWsJHBB1kVGrNSkGj3IZ/FkVMSMVqrEd+ular3
X-Gm-Gg: AZuq6aIt6mGjddsHm/67FJ8X78BzhBKttmUHWmIBwkMsg6W3atNLn3cBsFGDuUXLuCE
	M+8fJEq742ISPdLQkBHmOdKD0noWcXXlURGaXN06D84ZxUJnbLu8wNev+4c6PzHWvaQCWiDNpcI
	dJHskGD/EbKMkLI3QkMMIahCh8ddpgt+dN4mqsP/EdzxhodUJqCxArbtdrHH0mwBXhwQJqGfJnp
	rgM7SIcekdjgfXBXBXZiZmwdGPHtEwj2PWR8uLJoYNcYTeGWjO9rbOhZR9du7DPazBoSQtdCUTm
	e3BTQUTyIG3W0qrbgx6TBx3cjEsZ04bY/XzgYut6mcqp4msmOPWh+DVgXeNvppKEaNV9vGy1IIx
	ZWoa6vqPY3zCoyFyHiw7MYhIFbsNC5UaZssgCaLWYrPmz/OP5j7Kmnh9Juc3oK5as+ljHE74Fsh
	Ppo8eYKzVW4apTomqInkp+dQhguJFF0LH1TkGP5g==
X-Received: by 2002:a05:6a20:728d:b0:342:1aab:4c79 with SMTP id adf61e73a8af0-39545f7ce78mr1421156637.3.1771661452494;
        Sat, 21 Feb 2026 00:10:52 -0800 (PST)
Received: from [10.16.17.83] ([111.223.90.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd68c0b8sm1679827b3a.17.2026.02.21.00.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 00:10:52 -0800 (PST)
Message-ID: <60e4cbcd-6dfe-4e1a-9c63-be905c815bed@gmail.com>
Date: Sat, 21 Feb 2026 16:10:49 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] setup: allow cwd/.git to be a symlink to a directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260218124638.176936-1-a3205153416@gmail.com>
 <20260220164512.216901-1-a3205153416@gmail.com> <xmqqfr6vxpkn.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqfr6vxpkn.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi junio,

> So, "Fix this" written here does not resonate with my understanding
> of what we have been discussing so far.  Puzzled.

You are completely right to be puzzled.

In an earlier iteration of this patch, another reviewer brought up a 
case regarding symlinks. I adjusted the logic and wrote the commit 
message around that "symlinks" narrative.

Through the subsequent refactors up to v8, the code evolved to tackle 
the much deeper issue-addressing the two decade-old 'NEEDSWORK' 
comments. The code structure was completely rewritten but I forgot that 
the symlinks stuff was not relevant anymore.

You are right. The actual value of this patch is the error code 
refactoring, not fixing symlinks.

> All of the above are exactly what I expected to see.  Nice.

I'm glad I finally got it right ;)

> This design decision may be debatable, but not tightening everything
> at once may be a prudent thing to do to avoid accidental regression.
> 
> Having said that.
>
> If you have a directory ".git/" somewhere in your working tree, and
> the directory is somehow corrupt that is_git_directory() says "nope,
> that is not a valid Git directory", wouldn't you rather want to know
> about it as a potential problem?

Great point. A corrupt '.git' dir is definitely a red flag. However, 
silently ignoring it and moving on has been the historical behavior, 
hasn't it?

Still, if we decide to tighten this in the future, it will be very 
simple change within this new 'switch' structure. Nothing much to worry 
about IMO.

Will send v9 soon, with commit message rewritten.

Regards,

Yuchen

