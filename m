Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE639A7EA
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426486; cv=none; b=QLSzHAFR3/BGrhsiivUCDXslzEWDDg2JAdfRYaq8bMONs67dVwpvhaVmhrY7Qy4NGPTrVF0rnk+Ahwe7OTlvIsw5z4BSqiSSFla2jvAjmiYabzwAYK/CYNiWYyIcnkqF8g7mx6awT9rbMstMTUI7DYP8fD8WuluV0TDoC00q4c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426486; c=relaxed/simple;
	bh=Bw9llSThxda3ZKjvLISKrswww9IsN6F8Sa2Q8Yx9GkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l19AtQE2j0sp55vXkgsj0kuQfnQ36TmHIwS6hC4DR6PCThCZx2ZzGGdNlC8QwX8y6GBReHNuuFaDkJ3ovmfbfAyfkGUlb482ohKkK91v38PjnUTp4PJpeUzHuEA+7v3yFZQT0/mu/QtWhCtc7oVN23gLewws1xFEb28wVXBXOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHx5Gmgx; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHx5Gmgx"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91550d518c0so291687785a.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780426481; x=1781031281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBEGOytwqYRn41w5d1gYpkqoi3kljWsGf9vDbWuvWC4=;
        b=oHx5GmgxutQpGZfDI+t2qLfdGbJ11yC8AxAFwX037ad5mxY/pQsiLpEYTx1pi7HGik
         IvfoMuAX8NbYHye0r5PWoFwm/ZmxSSvNIb2bcgLZBLQjarB4SXgZJr+Sz/v9DoHpyJc+
         tSS1usd38Ix/4SrIajYQwzru1Ws8TSFSEW2sDfAnuecFArllXcKdpmvjdz9BMI47rUky
         bTESyf60r7DfU5Dv1mK5OBIWtArYRyH1PC2G34qa2bMBVQK0XUJzCFDDXXph+g8VoUIp
         XxNm8NIUkQzl0zhoX7k2NqIj8PC4qWFz1x0GwDVl5ka5wnc7fPSVXvQH1FdwAayJqZyq
         fpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426481; x=1781031281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBEGOytwqYRn41w5d1gYpkqoi3kljWsGf9vDbWuvWC4=;
        b=bJlKaSuBwt6AyplzDWcjLNgRwVbi8WGzIa7t+FhsCPidQ7zr5U3tb3DUhNmEomxUtS
         sDzpfu2perBEHWjRQyPJinWSVFfABXw9d7/TnYJjMwXiHbXuHBQfBbmxFreFbxja3LHK
         GvBYLxzOxSZJxGZHIOWag/eiko11svdKEWCyTdRcAdxGEH4hKNGJllaMlpNRWHIjzmMO
         Qd35yM7emW1gviF+MWhy6xgVCrTOPvQTmKhFncAjWnDIR7YKITl0b87/9fKfWczc2nto
         Gg3SJem5oKGTCRfVjMMw4Kk47G7QpVe4g6hHyjoC+GsewCND+i9u2z49KRWHEfo8rw0T
         aGlA==
X-Forwarded-Encrypted: i=1; AFNElJ9CJGY+Lz+1jz82EDePVci7JjnUN1jR/2sLiLwdk1bj58ZXw6TsCt8Gsu05IF5EoY6g6uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNof48XT3ewA/2xu8c3AKATOAXsBEwSkhGzvK0q/4et7BbgNEJ
	TEdly6QK5Y/UoD/h2K1NWw/ViSjEpKd8N6L/xklaLOgzdgg+/ott/22H
X-Gm-Gg: Acq92OH3jFElgtDDXlZW3GLKqKUBk0Con4VLR5Q2mLdqQZ2uuSLbFFBtE+Gtb3C8t7s
	ahuxcqfNq9jnjX5XoG35Bl55i0/TzP+Notm0HCfd+nLXAsvEcoWSc9BZ/VgjfHo65MIJeVHodqE
	W7rsCW/iF97onNfoz/pNLoaIiMuRIU81VnNH/aohL1hO2SSJCrDdF5ZNepvxGKNkUU4EhjbiTmp
	lNY4Lmt2XgwitG2ukbPPdtgiN2phhJ1NPRcQFS7iMw39Api7joGfFwFpaKpNdTXoC+oE0aTe3mr
	fHpcDW32QHtOSEMzmB0GDpVhGQnnmcyBGbn1Eul3YjcIS0h0BLcSW0DrJBgkwY/S6OouXh/wyf5
	3dWTsGKPPyufRbJ/eG6tOiepfLnuPRDYFwEHdnnr+SCZIUEdZK8EVnowV3b2pMtKcQLDfSMLZ8o
	OGQVJe81gOVxlPSRcK6M7gMWo2xsBkxtKiFWiqjAjqPXp0P+0fhnzL9mPt6K9gnHYAHOkcy2ivn
	MkpVCgNYQ==
X-Received: by 2002:a05:620a:880b:b0:914:c0ab:f1ee with SMTP id af79cd13be357-9158a7dfd9cmr50446385a.44.1780426481512;
        Tue, 02 Jun 2026 11:54:41 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243f24sm26421285a.20.2026.06.02.11.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 11:54:40 -0700 (PDT)
Message-ID: <6f4276f9-cf0e-4840-88ce-9e0009c669a9@gmail.com>
Date: Tue, 2 Jun 2026 14:54:40 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] Improve git gui operation without a worktree
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
 <8515a482-9a08-4b0a-bd7c-385e1bda1a20@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <8515a482-9a08-4b0a-bd7c-385e1bda1a20@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/26 1:34 PM, Johannes Sixt wrote:
>>  2 files changed, 223 insertions(+), 175 deletions(-)
> This round looks excellent! Thank you very much!
>
> While queuing, I applied the small fixup below to 03/12.
>
> -- Hannes
>
> diff --git a/git-gui.sh b/git-gui.sh
> index 933e72c9b255..15dd2b3a84cc 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -2064,7 +2064,6 @@ proc incr_font_size {font {amt 1}} {
>  
>  proc do_gitk {revs {is_submodule false}} {
>  	global current_diff_path file_states current_diff_side ui_index
> -	global _gitworktree
>  
>  	# -- Always start gitk through whatever we were loaded with.  This
>  	#    lets us bypass using shell process on Windows systems.
>

Oops, missed that. Thanks for catching.

You have duplicate signoffs on 02/12 in your repo.

Mark
