Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9781FFC60
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031367; cv=none; b=YkMmnPa3AgWJTzq2Zh3UUpwf5iftzEZUPAjAhk/hvWrTZO89JH/Wnnkp9gJjbNjiW4nlG2Phz8zn3HEieJEcaINC34JhWlOdMZK7uaqroNOrVqh8XPIcu2VjItIrRM0uZaDsjKSDIDEj5RuClZ7kWWTr/2cPWPNvZ9FxgXpN5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031367; c=relaxed/simple;
	bh=NZhctqzw934zUQOnAifPB2x/JgN4JzV6B6rNuvPRD4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxW9/Cv0kVkG2bnKpCndOFUeQZN3JXMgvtXdyo8awBgSmCQuiYxc3JYv6Xu+f0DdOb0e2nDS/ZUlGVLu1lTtjdV/721HoAJ4euyM5aOgm1BcOZaL+usFpgGhSgwuNwdrk6bT/VWQWh9EVfjNYnJbqXAy58dFlQdxn+WITLNzrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org; spf=pass smtp.mailfrom=mandelberg.org; dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=8g4P89/H; dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b=PDL4POkc; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="8g4P89/H";
	dkim=pass (2048-bit key) header.d=mandelberg.org header.i=@mandelberg.org header.b="PDL4POkc"
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-6e41e17645dso48847246d6.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 11:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031365; x=1741636165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:dkim-signature:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPzmz9izsjHefb3/wHj+ebwXWEhsO6r0O1TjIhvYgQc=;
        b=c7WN4N+6JY03AmK8HkZBmkSKWFIDKdRuGPNqhavqLG8d/wVYgyp/fTgUOFc9WO/SSg
         cBhVe0s3SDcQl0eoCY4t5dtmmubmsfjHu9rovfiB9Fsuv6/Ii1vn1lhUQYdV68QD16Xk
         BtX1zJ5bXKpgewbtqavPcCivX8Y44cW84Jq2lLN/DctkqNo6K+dB1OGkJGIJYgG4XhF/
         AbCnL5Q2SWfuV+rajwqO33TSXWE3sdKQciY6qudty+t45GZ6Zcovq/k+GsZu6i0JeLtc
         /lJLEcK26QaSpvJ9W0oI1fy8UhyodZefcMAKROhRulX5ZEOFi3bUXPqYYeOLTaUp7MKJ
         WkHA==
X-Forwarded-Encrypted: i=1; AJvYcCVEBQTcE1AcTj3okgmnGX45z7SpcV/p6NQeZ3OzCR/Ar68oXWYqUSdVBjbPvnXPL5M5FoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8g7RSo7VKjbqT7RiK7Zs17pxR2rc8IBw2ZG60gD1lWfL4QLp4
	47SOCgVZjExpcgS+matC8y9KlraCE6CoHAc6GiNcLozhSUkRNSqKjk476z5jCA7RsJz2sLs3D/8
	N/mY1aXf6tg6fdTpra+HcMcYYi676H9DFlTZmtJEMgoKmGAtE
X-Gm-Gg: ASbGncsa5Gw1nQ/eP0okHNEOyILd+Io3NOfmy5vk/IPmur4ihUWdKDfgLSnch2pNyW1
	jBPIKKo1kDn7yslHpArxS9UIbpSzuf+BcsfF8TvjVWVovTHzuVsWgsfnC60E5BNWs6SYpFkNlP2
	gd/sJWHKhWcHEAJOCDn7mYApcXTHmjz+JF2y3B/JBpmuRsCh+eOqOW8TlTlTtBmef2XWFxi59wY
	5Upcnj/SNUWftJDLuMhUAOpbMUD+3Om85u9XVJC7tmS31JFDSs4wiCLU41QQ2fgJtn+qThQBCk6
	6DFH3DRcM/b7trdW5OCutHLf0zwS25L15pezMQet
X-Google-Smtp-Source: AGHT+IGUAJ5SuZhMoEqgTOuFLfw1VSmYBlafwL782YsxC9Rn5TfDiAOIAv7y/dMAkxmT0oktVSHTQkDrTBOq
X-Received: by 2002:a05:6214:1c4e:b0:6e6:5bda:a47b with SMTP id 6a1803df08f44-6e8a0c7d652mr204589246d6.9.1741031365045;
        Mon, 03 Mar 2025 11:49:25 -0800 (PST)
Received: from mail-outbound-e14cf917.virgo.mandelberg.org ([2600:4040:52f1:f606::8])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6e8b0f85d4bsm2840606d6.5.2025.03.03.11.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:49:25 -0800 (PST)
X-Relaying-Domain: mandelberg.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=mandelberg.org; i=@mandelberg.org; q=dns/txt;
 s=mail-outbound-e14cf917-597d7abb; t=1741031364; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding : from;
 bh=NZhctqzw934zUQOnAifPB2x/JgN4JzV6B6rNuvPRD4Y=;
 b=8g4P89/H4ZSL2Gs7u2bRDaQzzy0arGHlvdLgGEtmeuizCWeUTZvsceOtdild6xdp8a5gU
 2iKk1rIfQF5ea9oBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mandelberg.org;
 i=@mandelberg.org; q=dns/txt; s=mail-outbound-e14cf917-e56dad1c;
 t=1741031364; h=message-id : date : mime-version : subject : to : cc :
 references : from : in-reply-to : content-type :
 content-transfer-encoding : from;
 bh=NZhctqzw934zUQOnAifPB2x/JgN4JzV6B6rNuvPRD4Y=;
 b=PDL4POkchWx5BjZN7a0bscFFEQhln8uUIJHvHhpFlBDfc13OmMd82ax6GJPJdRsJxXPR5
 R35OYlJpfrrJLjqXgQMRQ+/d4SG8vmdacc3CL6kMfIDg5D/2/ZChHnlMa2ROXkY/qWNRKMZ
 5bd26p6GLDjQa6UPnEaIy5687F1apMjO7gPh3/j2DVrtg1Nb+QKSPTUhyP1xa5aubmeu/bp
 +ZdG7+fNiTvE9V58aSkqZdhgdw8BYkh3qjLKOw6jLaON/oWmNxQfEy6WrFGhhjtKaCuYlbr
 cXMnU78VAGL25H1qM4xx/6RpeGCa6YAai+xTcm1ANCV6eNxFU3KOSNp4QGFQ==
Received: from [IPV6:fde5:2b79:35f0:2::166] (unknown [IPv6:fde5:2b79:35f0:2::166])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(No client certificate requested)
	by mail-outbound-e14cf917.virgo.mandelberg.org (Postfix) with ESMTPSA id 4Z68XN3D2MzyTK;
	Mon,  3 Mar 2025 19:49:24 +0000 (UTC)
Message-ID: <ef5bbdad-2e40-4101-ad48-487019028d45@mandelberg.org>
Date: Mon, 3 Mar 2025 14:49:24 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
 <Z8YEIo28bLS+t+20@szeder.dev>
Content-Language: en-US
From: David Mandelberg <david@mandelberg.org>
In-Reply-To: <Z8YEIo28bLS+t+20@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 2025-03-03 om 14:33 schreef SZEDER Gábor:
> On Sun, Mar 02, 2025 at 03:34:07PM -0500, David Mandelberg wrote:
>> Good point, I hadn't thought of that. Do you have a rough estimate of what
>> "a lot of remotes" is? 100ish, maybe?
> 
> 5.
> 
> In Git for Windows fork()-ing subshells and fork()+exec()-ing
> processes is rather costly, about an order of magnitude slower than on
> Linux.  The rough equivalent of the body of your loop, with two
> subshells and a git process:
> 
>    time { a=$(echo 1) ; b=$(echo 2) ; git for-each-ref >/dev/null ; }
> 
> takes on average 0.17s on a windows box I have access to (with fully
> packed refs, and merely 4 refs in total).  So guess at about 4-5
> remotes it would take over a second to react to my TABs...

Oh wow, that's much slower than I expected, thanks for the numbers!

> I would rather try to go in the opposite direction to see whether 'git
> for-each-ref' could be taught to strip the "refs/remote/$remote/"
> prefix with a format specifier option like '%(refname:strip=remote)'.
> 
> That would surely be faster than any shell filtering we might come up
> with, and would also save us from the trouble of escaping glob and/or
> regex metacharacters for shell/sed pattern matching.

That doesn't fix the issue of needing to anchor the $cur_ part of the 
pattern after each refs/remote/$remote/ prefix. It might be possible to 
use something like %(refname:strip=remote) to find all remote branches 
with the remote stripped, then filter them for $cur_ in the shell or 
with sed though.

What are the expectations around mixing versions of git itself and files 
in contrib? Can a single patch series add a feature to for-each-ref and 
use it in git-completion.bash, or does the feature in for-each-ref need 
to exist for some time before git-completion.bash can use it?
