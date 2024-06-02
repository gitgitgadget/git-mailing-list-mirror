Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690653E2B
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342728; cv=none; b=b9yrdfkyXWjEHr8Im1f4nJBkOwiQg9wY5GrWknMFoEs3G+/KPnvc5A1YbzO4h7FwVu9FlYmJwdhNJO7Fo4AxPXWbKR/fFj4m0f3qkaawQlz//ViRF+fzyM4QRCpghEwfY0CEEIO27K6m5GzVf/FmcRP8wvklp34Ekz3KnU7fXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342728; c=relaxed/simple;
	bh=rEISvkh8Su9jb1vAQfVSFBq2O+65D7Hqgkc5Fk+EUUs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tqzJ2stGIu9x/tkIMRLBSa5HvpXXud4ePnfjYRDh+4l0ndH9x1G4oAuuiy62t3kOTxLZpCAFgJ7kW9Ffv8HGhd1vHgbP7YTGEjfVMzpN2u5AycjeCJrVTOQ4hlqq7XeupiP4ZEM/mdYQhdPcjNDqE4vmGzSFgScgdsBxqlqUl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVq+/xPV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVq+/xPV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4213be171f7so1627475e9.1
        for <git@vger.kernel.org>; Sun, 02 Jun 2024 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717342724; x=1717947524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oHBnq9+DyGaGkdEo/fgjA7Fztq8Onf+S5XNLTSN//z8=;
        b=eVq+/xPVOMn9pnKuAYMtu5xvRJUHybHub0oEP6I/nY/XIsmhU8yI2GgDpSp59Q5nQT
         0XajyaM++Q7vBayzdzaqMyigT/3fnEFVmRU6YLalIgBu3jdvhl5HUBrq3GAwwpFL8yPd
         yIawvszweJSPBMtbmC+UgIJSknBUWLrbLQEGBDU0MIsyP/w4j6qHgoPRVPoVMlnNy+Cj
         iLf66aldWRpmfb95HcfOkeC3lcO99jHBeWIP1zheY+oGqbXdgIbI1i8JbAhwZzW74gNV
         ScIrQJhNsjE4NpPkgn9OFSKiHUH3gd1LuMW193d59MmD+lkQSXXFKMFqbu7tfwSjemtm
         PDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342724; x=1717947524;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oHBnq9+DyGaGkdEo/fgjA7Fztq8Onf+S5XNLTSN//z8=;
        b=CBl0XxOB/BXIT7grL3UzoAyfV3BaqSizCZ2OMT0nTpz5QEd0VPo9gIsqw3NH6oXJ+z
         mjQLJ1hjRfhEsXOgAVd3WGVpX0NTDjV4k2BWdAA1mkzgWNLhP4DknwnL4+DOUTLtBnca
         cDM3VV5GkkK3pJrGNWOOXLhtIehLB0EJTp61lWyq2dVptx1Gkm8E7mqxSasIeNKXMDSM
         YlM/gcG8oKz0A96+cZZMq7FGIws9w7pfMtTAg2odWZUeIZyD5XIg+43HK9V6RRwNoUsw
         s4q8+7nLqCHrDOZzjIIGOLWxK+tD8EIrd0YDxevhFL15bKobWV+OWTBCB/8lgdEwlJbV
         868A==
X-Gm-Message-State: AOJu0YwHiLLQJXIh1CNSehp8XOKurf/bb8CebIzUP3HU1wmAEtcdxuRV
	DoGQtVJ8mvDoRTRDKqWDd25wIhLRyOyiY/97tAgcI55lL+E1DXZtwjtDEA==
X-Google-Smtp-Source: AGHT+IEg9Oux+jtwFDogOsZHDM9XXYXTBizIP24JuHu0QVygVVWNKKkFhOClHgpjCxbPQG7iOZUBaQ==
X-Received: by 2002:a05:600c:3145:b0:418:f826:58c3 with SMTP id 5b1f17b1804b1-4212e04a572mr48418185e9.15.1717342724212;
        Sun, 02 Jun 2024 08:38:44 -0700 (PDT)
Received: from gmail.com (12.red-88-14-51.dynamicip.rima-tde.net. [88.14.51.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133d745aasm65418815e9.38.2024.06.02.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 08:38:43 -0700 (PDT)
Message-ID: <b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
Date: Sun, 2 Jun 2024 17:38:42 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 0/6] use the pager in 'add -p'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
 <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Language: en-US
In-Reply-To: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The main goal in this series is to allow using the pager when displaying
hunks during "add -p" sessions, to make easier for users to review hunks
longer than one screen height.

This iteration, v3, introduces a new command: '|', suggested by Junio,
instead of the 'P' command proposed in the previous iteration.

This allows us to use the pager:

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? |

But also to use other programs, like:

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | head

Or:

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | grep term

Hopefully, we'll find a way to avoid sending ANSI codes, on demand,
without disabling it entirely with color.ui=never or any other global
option.  To make this usable:

  (1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,s,e,p,|,?]? | vim -

However, the current functionality meets my current needs, so I'm happy
with it.

This, a new 'interactive.pipeCommand' setting, or a new switch: 'add -P',
are left for discussing in, hopefully, a future series.

One final note;  I preferred to model the help text this way:

    y - stage this hunk
    n - do not stage this hunk
    q - quit; do not stage this hunk or any of the remaining ones
    a - stage this hunk and all later hunks in the file
    d - do not stage this hunk or any of the later hunks in the file
    j - leave this hunk undecided, see next undecided hunk
    J - leave this hunk undecided, see next hunk
    g - select a hunk to go to 
    / - search for a hunk matching the given regex
    s - split the current hunk into smaller hunks
    e - manually edit the current hunk
    p - print the current hunk
    | - pipe the current hunk to the pager, or |<program> to use a program'
    ? - print help

Instead of:

    y - stage this hunk
    n - do not stage this hunk
    q - quit; do not stage this hunk or any of the remaining ones
    a - stage this hunk and all later hunks in the file
    d - do not stage this hunk or any of the later hunks in the file
    j - leave this hunk undecided, see next undecided hunk
    J - leave this hunk undecided, see next hunk
    g - select a hunk to go to
    / - search for a hunk matching the given regex
    s - split the current hunk into smaller hunks
    e - manually edit the current hunk
    p - print the current hunk
    |[program] - pipe the current hunk to a program, the pager if none...
    ? - print help

Because I believe it reads better by maintaining a single character
before the dash.  But I am not opposed to the latter.

The series is now based on jc/add-patch-enforce-single-letter-input,
which has been recently merged to master.

Thanks.

Rubén Justo (6):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  pager: introduce setup_custom_pager
  test-terminal: introduce --no-stdin-pty
  add-patch: introduce the command '|'

 add-patch.c                | 17 ++++++++--
 pager.c                    | 55 ++++++++++++++++++++++++-------
 pager.h                    |  7 +++-
 t/t3701-add-interactive.sh | 67 +++++++++++++++++++++++++++++---------
 t/test-terminal.perl       | 32 ++++++++++--------
 5 files changed, 135 insertions(+), 43 deletions(-)

-- 
2.45.0.97.g9fa538478d
