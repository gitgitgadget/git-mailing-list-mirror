Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8761C304B
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918039; cv=none; b=keEkyT8lS8iQFCdD/J1t9ckWrFy0zMwwdBwsoEXxiSbDhGULBUuTrjM8+RBWYK294QFMrG9g7q+fQpzR+9PvfvC/IIt2pID+YWs+/a5uAnyENEBMnZdVk3B0a5xzZ2foUkhIx70VlBJETuYGLBrZ72hOsjq6mh0cRjIL4Jp/Z/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918039; c=relaxed/simple;
	bh=HSJiNZff5AjJn7lJ0QZWz384ru55F2EcL3D0RA/2fBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AUa4R7Mclp/t/tSvnZkCLfTxnHhCMbu9IRLXl5g4xyB9GeGpM7gQFFlpvPPLPGwwnR/s8jKZkHVC7tTJPQBdU14R30FUVog/CPK9JGdCBNtKGLDvs3nAueFScfvYDe1THyKptMdB7dgCHtqBl514JTxH6cdHJ9DHTaOqnR4jsFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dn2Zcrev; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dn2Zcrev"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431286f50e1so23786125e9.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728918036; x=1729522836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QglTfWXCItgYrnZV8fNIpT5wjQB1VfYm0FEiHg5Qf4k=;
        b=Dn2Zcrevtz44Aj5pKIaIraVLIE40SLTigUPe5IIkQSYXC1tj5HgXtjliY0DDG9Yk1L
         YU7MJLRB4lBeVOfFCKWO85FOGRGIPEYLJPdOXO6zO+af+8POJlDm40tGfLhxT5Rbtlmo
         ssMm+44mkJ7Yds5AQYQZixXfcQtulopWpIVDMSQm6Racx5+qjbeF+/QByrMd5fTNI6HY
         ofdJ50JISa2ThPjJY3dVuD12K5YAMFHdZTCSgVZDj9ShjCHpu7w9hCMbzrWmRxP1x+ZU
         xDUCWHIvReKpfF5g8PCWQrRx+x7y3eNTcdmsR2woOv2siGL1Zose2fpKZZDzcZHgTLuu
         ETtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728918036; x=1729522836;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QglTfWXCItgYrnZV8fNIpT5wjQB1VfYm0FEiHg5Qf4k=;
        b=LOOFQnFi1GO3z6J/1v4bijhTm6Hhg6eaLTm9EioLtn6NvbliCKW4iy78VXp7gaTy+f
         bE09WzBm8GQZtlCwvAIIvsKdfP5kPWGwLkC2SL6Qdriq4D9Qc0GizpGbxjQ7Bv6zX67Y
         DGIEjPzx/2lSBXK68kTd5ke6wBl/lO4hoJTr0smG1iP/9vhp9pI/PEkbWr46YDz/iISe
         caoa3yY1a8nidJqLQvNto8F+U/GzDdBbHq+0BYvx1XXtlhuHrCoLT9T4fp1oHtA442Ju
         5K3BBsTtFQBYp/k9bbiP4eTutNVpnwrmpWVn0861KAWm92fdMaKYWYf6ymR4+6tm6cRd
         guHg==
X-Forwarded-Encrypted: i=1; AJvYcCVKvB+UQI2pmQ6J5f9zzjvzgVVOR9QWw9XvvlCcIC9MmoatcYBMV6d7seLQsQeBg1KEFuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHxjBUwmZIjY428VbPZas4WfbTQ8PgNjOBqh+bV+IKkNBSr82I
	gTARdqmVXrXcM9rUXwDTcECo1gOThkYg5nS0bR8kcHMdOdnm1hb8II9MKg==
X-Google-Smtp-Source: AGHT+IEcmFSWsAWfzkZkMFoY8kHG6bhpW7MIPzSt+P1uWlfS6kFRn6Fi3dLl38ECG07cUrXrMutnUw==
X-Received: by 2002:a05:600c:1d93:b0:430:4ed0:d5ce with SMTP id 5b1f17b1804b1-43125617316mr90259405e9.34.1728918035965;
        Mon, 14 Oct 2024 08:00:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f696sm154875985e9.5.2024.10.14.08.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:00:34 -0700 (PDT)
Message-ID: <6f6d6518-fa01-457f-a482-5e6ffbba3f2b@gmail.com>
Date: Mon, 14 Oct 2024 16:00:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: diff --color-moved={zebra,blocks,dimmed-zebra} fails to
 identify some individual moved line
To: lolligerhans@gmx.de, git@vger.kernel.org
References: <trinity-1a7c1cfa-3f79-4430-bf3d-776c526c242b-1728914461526@msvc-mesg-gmx102>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <trinity-1a7c1cfa-3f79-4430-bf3d-776c526c242b-1728914461526@msvc-mesg-gmx102>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 15:01, lolligerhans@gmx.de wrote:
> : ' What did you do before the bug happened? (Steps to reproduce your issue)
>      I diff-d after moving lines.
>      Reproduce:
>          This entire report can be run verbatim as a bash script. The executed
>          code is at the end.
>              - 1. Execute: Copy-paste the suggested command to hide ~/.gitconfig
>              - 2. Execute: Produces example diff
>              - 3. Execute: Copy-paste the suggested command(s) to unhide and
>                            clean up.

Thank you for taking the time to report this. Are you able to show a 
diff and point to the lines which you think should be marked as moved 
but aren't? With the block modes a block must contain 20 alphanumeric 
ascii characters for it to be considered moved so you maybe running up 
against that.

Best Wishes

Phillip

> What did you expect to happen? (Expected behavior)
>      All (!) moved-only lines are colour coded cyan-purple.
> 
> What happened instead? (Actual behavior)
>      Some (the first?) individual moved lines are colour coded (treated?) as if
>      the line changed (red-green).
>      In a commit with only one moved line, it is coloured as changed.
> 
> Whats different between what you expected and what actually happened?
>      The distinct colouration for moved lines is lacking in the actual
>      behaviour.
> 
> Anything else you want to add:
>      Running "script.sh show" will use "git show" instead of "git diff". Same
>      problem.
> 
>      Moved mode "plain" behaves as expected.
> 
>      Skimming "git log -p next" suggests that "--color-moved" did not change on
>      "next" nor recently.
> 
> [System Info]
>      git version 2.47.0
>      shell-path: /bin/sh
>      libc info: glibc: 2.39
> 
> [Enabled Hooks]
>      None
> 
> ----------------------------------------------------------------
> Script to reproduce
> ----------------------------------------------------------------';
> 
> #!/usr/bin/env bash
> 
> trap 'echo 1>&2 "Error: $BASH_SOURCE:$LINENO $BASH_COMMAND";' ERR
> 
> function diff_now() {
>    declare mode
>    echo -e "==================== [${1:-""}] ===================="
>    for mode in plain blocks zebra dimmed-zebra; do
>    echo -e "\t----- (${mode}) -----";
>      git "${2:-"diff"}" --color-moved="${mode}";
>    done
>    echo
> }
> 
> clear || true;
> if [[ -f ~/.gitconfig ]]; then
>    echo 'mv -v ~/.gitconfig ~/.gitconfig.save';
>    exit 0;
> else
>    echo 'mv -v ~/.gitconfig.save ~/.gitconfig';
> fi
> mkdir color_moved || { echo 'rm -rf color_moved'; exit 0; };
> cd color_moved &&
> git --version &&
> git init &&
> git config --local user.email "you@example.com" &&
> git config --local user.name "Your Name" &&
> cat <<-EOF >file.txt &&
> 	Is this even a line?
> 	The first line number 1
> 	The second line number 2
> 	The third line number 3
> 	The fourth line number 4
> 	The fifth line number 5
> 	The sixth line number 6
> 	The seventh line number 7
> 	The eighth line number 8
> 	The ninth line number 9
> 	The tenth line number 10
> 	The eleventh line number 11
> 	The twelfth line number 12
> 	The thirteenth line number 13
> 	The fourteenth line number 14
> 	The fifteenth line number 15
> EOF
> git add . &&
> git commit -m "Initial commit" &&
> 
> cat <<-EOF >file.txt &&
> 	The first line number 1
> 	The second line number 2
> 	The ninth line number 9
> 	The tenth line number 10
> 	The eleventh line number 11
> 	The sixth line number 6
> 	The seventh line number 7
> 	The eighth line number 8
> 	The third line number 3
> 	The fourth line number 4
> 	The fifth line number 5
> 	Is this even a line?
> 	The twelfth line number 12
> 	The thirteenth line number 13
> 	The fourteenth line number 14
> 	The fifteenth line number 15
> EOF
> diff_now "Can identify moved lines in blocks (but not the single line)" "${1}" &&
> git add . &&
> git commit -m "Moved multiple blocks and a single line" &&
> 
> cat <<-EOF >file.txt &&
> 	The first line number 1
> 	The second line number 2
> 	The ninth line number 9
> 	The tenth line number 10
> 	Is this even a line?
> 	The eleventh line number 11
> 	The sixth line number 6
> 	The seventh line number 7
> 	The fourteenth line number 14
> 	The eighth line number 8
> 	The third line number 3
> 	The fourth line number 4
> 	The fifth line number 5
> 	The twelfth line number 12
> 	The thirteenth line number 13
> 	The fifteenth line number 15
> EOF
> diff_now "Cannot identify a single moved line" "${1}" &&
> git add . &&
> git commit -m "Moved only a single line" &&
> 
> echo;
> echo "[OK]";
> echo;
> echo 'mv -v ~/.gitconfig.save ~/.gitconfig';
> exit 0;
> 

