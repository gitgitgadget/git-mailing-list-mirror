Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082533EF
	for <git@vger.kernel.org>; Sat, 23 May 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779550387; cv=none; b=fVVXx7jUAcxQnYyeuBdyr4HBwbHSbZQo2/zhQAKHk7yuTByi+iEdQmZxC1IquWE4EQtpvCVAI7bMcesipibx7acxIKbF/kbChcZjb97cJa7gyDpnhppespoOeH/TCu9sCwywaf2f3EL3NXWE+iAZHp8dmlLqHGvyH5DhoR9O84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779550387; c=relaxed/simple;
	bh=VF/96bfL5U+aXZF3X/uFJUMgi3n2fmWEzZd7fGdcq9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwUPwG+CR+X38zciw4f0iyadCANDJqmgaiuwINLyC8sBCWbvqm2LAJ6IRihA7/n8JU2XCPJ6Of5Kic7wGkgTax0obxWaRqQkQa+SS2Yht58qB0lhUzjDIjFXc5fEIGkjwWfRb5/ryV/FgYx8EuUrHRZmJbRLLSyyWKO0N5ap+g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJzoXl5h; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJzoXl5h"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-914bd98faafso109679885a.0
        for <git@vger.kernel.org>; Sat, 23 May 2026 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779550385; x=1780155185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VF/96bfL5U+aXZF3X/uFJUMgi3n2fmWEzZd7fGdcq9g=;
        b=aJzoXl5hcduCST1Bf+8d3/GpimubjEoZiNAJzi7wx9MqFGfGwCSA+b8PyA6ToWS3hJ
         OeV+4goMgsoketQga6q7zpIBmIs8OpKmEicvKPkAwx/6Ib+Qb5ho1Wtjg8Jy4inylUpQ
         yUsvAJuB7+eM+M1jct8xws5AoD9CS+3eMTU3yxicfRAPpZU4lD1PeCDUo6Xff0NHVzRC
         0DFXNhJDCOoIWrhYTu65XE9ClrfJNuLvBVEIey0Q+ZA0UCmbyqCNDBoLWT0mkR9YhRKl
         dD2tZOcMflIraS+M6Qzsj5bGVJuaHDTS27t+ct3PIJOdHQHyldvsOBUJ1rLdO7786eKY
         M+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779550385; x=1780155185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VF/96bfL5U+aXZF3X/uFJUMgi3n2fmWEzZd7fGdcq9g=;
        b=oDzI5pDWxjXkNw39uBC159zlPDsM4iCNmbJV9upiZl5Fn/8rgu+z/41xK1ZJtmp3rc
         64yJnOgO6KQAALzpG8fU14dfZomNKeW9bXvxYYsWdfw9V5kpZYJVHdqCaFDKygqVgoO3
         URFryB/OTFq6+IN/u48rD1TAu5aW6j1j/pi/c+cEfmLOPZNj4bXKMGoIdrfZvw0Zz9uE
         ArOrCVuADMaN6Y0qEG89zO2pwbmfZePMiucXcaCN/fHg+bKCgf5JY/FvS0SgNIDMdukd
         wyIsxd1+/TdCme97xfF4sqWn3v7Su5nKbVMJKTRZzJHrzno7YYitDl4IwiFs7R8wDDmY
         dGkA==
X-Forwarded-Encrypted: i=1; AFNElJ9k1+y9p8+Zx1olyfwnnkYwyNZbCqZf7wy30BpzRkXZZ/eTS0PSon3dizOBDkVtH7vIiQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz27TA+/mo+Kyd8EkyBA3xN79CIcj00TTIhcQ+wr3dsB/A2/pk2
	cqAIkLK3CyaB/P1jBo8uqhotnLTgLo7yRinP+IsNqzxV1djXLAsOmQ6E
X-Gm-Gg: Acq92OHlOCjFBfhHzrzf4XhygzyoLZD9SOQGPxYY6AezwXLNPbNHIuhRmhIQJEVYWil
	X8UrdPO/a65PBaQdi6vTLVI0tkr8EDFl7Q0Ze2DYXA4sbufQ+l0VSn1Y9EZn+lWDxU2vA5u/rO2
	SGy4UgA7f0JDmVXrorfkRhFh/xl1rwgP13qqXwhsKlkDOd1t7z891DKRcS8o262ZREcpuRsQ4Hy
	3I81Gtt0grXdGwsyT6OIHMqAsGIhnxBkK7bBFFLcZnBaWALzwJh6LV5wZd4EEPSl3+9O62eWFfk
	+c8w0fW6McqVqDwwGKO4oP1IgCkHbMkSRU93WkSEvNZOAnV52+oKmLR9ouJkud8xFN/UZGttzO5
	+gtjcy3PGqKGZGTBlu6VOXq31jmDq1v3L8Qmz4pf7Vehk2c2IGSD74bxFPviYmByM+WUgBUQOv/
	GYeH3CrxKz8J9AhyTg3e32Vxc9h5tECdOtBlc+i4dCum63JLxfskB0bWOabF822kTjaZJv0OI=
X-Received: by 2002:a05:620a:2989:b0:90f:5229:c755 with SMTP id af79cd13be357-914b48e85f1mr1184672085a.20.1779550385195;
        Sat, 23 May 2026 08:33:05 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb90376csm452144785a.16.2026.05.23.08.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 08:33:04 -0700 (PDT)
Message-ID: <27452460-e709-45c6-b411-10118ab9bf95@gmail.com>
Date: Sat, 23 May 2026 11:33:03 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] git-gui: try harder to find worktree from gitdir
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260520202411.108764-8-mlevedahl@gmail.com>
 <a1e9da65-f8dd-4544-bbc9-d3b01328cebe@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <a1e9da65-f8dd-4544-bbc9-d3b01328cebe@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/23/26 10:06 AM, Johannes Sixt wrote:
> I tried to come up with a situation where we end up here, but couldn't.
> When would this happen? If it actually can't happen, I would prefer to
> spawn fewer git processes and just take the result of 'file dirname'.
>
> If the code must remain, can we please rename one of gitdir_parent or
> parent_gitdir?
There are some odd cases I've seen, mostly driven by network file systems (using Samba or
NFS or ...) that don't behave as POSIX. Perhaps that is reasonably out of scope. The more
I think about this, I'll delete that part.

Symlinks can create odd cases:

Consider /tmp/main  and  /tmp/worktree. The latter has a .git entry that is a symlink to
/tmp/main.git. git rev-parse --absolute-git-dir shows
    in dir /tmp/worktree/.git           /tmp/main.git
So, git-gui would start in /tmp/main, and not in /tmp/worktree.

If using git new-workdir (which is still in the wild), this creates a .git dir with
symlinks to all the subdirs. Now git rev-parse reports
   in dir /tmp/worktree.git          /tmp/worktree/.git
   in dir /tmp/worktree/.git/logs   /tmp/main/.git
So, as long as this is started in the top level of .git, it's ok.

While the shell understands we descended into a symlink and reports pwd does not
de-referencing the symlink, tcl always dereferences the symlinks. So, any ability to
contain this behavior is very likely system and shell dependent.

So, in summary, I'll probably simplify the check to just --show-toplevel run in the dir
above .git.


Mark

