Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9651F5435
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906652; cv=none; b=oyZL1begSXI1fs9PWDtBgJ2NALuA/yxM8ohdc2+nAKLZfz6ZDCsrmQu+LBe8WSWAFybL8m2UwwLR8/zOTpvteEhXhlzXYDHAN0AwQ6js7Tq7bsm7BI9vIH6uc1VnI+7f3eW85XtKDQanhVsyEnp7dOeUfDkddewL5e3vffYby5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906652; c=relaxed/simple;
	bh=Tm6F5SexRRG/HdQ1spRnGkBVQoOKfxswhBiRUE4StBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFcTEh8c/ctIFhRcNXi9R4gdZoNFfQO2eb0JAFlSsFWF4AC7zKrpOL9bM4w6QhTNrLb71SlgVsRD0XhCMPEnkWqjbniDOjmSCFdixNVq4PiNRbLNwTKIZJTilToD/XnOQhQGs5QqaozD5TX2BDLp+u98bRLpqaVlMSN+Amj5zTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II4e9paS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II4e9paS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783ea5014so2184690f8f.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 03:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754906649; x=1755511449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfbYXp4HqmgBKT53wGnkcddowO9LeB3F0oLTOAtcrz4=;
        b=II4e9paSmvKdQCHviXSs5jatuQ0eoHJZY2qtLMy7DXvIf3qhCCBCJtD/Da7a1kqLDk
         YH33lZG33C0qA6c5U9MRK3zMO9e+ZouKunmrnw0SWTzUU79O9lEVlOaj+jmI4J10KO4l
         EkwPTjIw7FZT3TsQ/JC/zbsyJsf5aL/ZYDoUbIfnxOezz+H0Vfhx5hJ9Cx/3yKuH5eed
         Xvc6pRAph9f8I2CACceQlU6WQZ9YDWdcdxS/d/hYyQvaLNUREN1Um4uRJ/9mFIIsCYIf
         uvLN+yhu1ed4OOB4uAeHoSD65Feu3k2zvMK21eR21mk3vOkkuHbbjE/iCtzl6RoYZgL+
         Zx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906649; x=1755511449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfbYXp4HqmgBKT53wGnkcddowO9LeB3F0oLTOAtcrz4=;
        b=fg3aZ9n7NhkJwp1B/tkEW5ON2gAhLUSjvhoE56y7LzCDVNpu1eES5Q6dLhurxiLOp2
         B6mR8JaaXTfu3LePYDZhev0TOx6vES5vHs2cukBuyzb38oO+Io9jfqFyDjv4xkyO/QBI
         IfyQbie267jWwpxerMpmjgYgb8RyzChTUC/39TO8sO3+42+KObNn4ZoDojYXUub3Aqzv
         PCy/DmM6gbJly1irE0+uMQCHE3K/2obavTgVCwt3XjO97of9teR06DGC6vgWqbZrxFFO
         CJsAtGv6c4BQ6JNhpcpGiFnWU1lymAFRd7ft++uhy+XiC8RIrT/C5febh51iz8adyq1Q
         ndgw==
X-Forwarded-Encrypted: i=1; AJvYcCV05B11d0kxdtk9akyIoK02PUbYL3Eurffw8Ev3r9nD7XwCPL6dNWsQ87qHQCtW96TktTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwepMqxjurLHg9q2c+ws1nGgcwKiO3QOpLQubhktAlZPEozxwr5
	OXk1WF7JTxr+l3sD3GFn9dyBNYRA0Z9a2l9V4EJnthxe+gMO0b0I6UOj
X-Gm-Gg: ASbGnctzexSs2fqEaO2jnjfmovc1q0YFpTwB2RZ75OE3wwxXCpqk3ph82KNm8qNHvBM
	z14GAFVozowrFwj54nJFf9Og99aG6e3DzqT7vbNKckWdGRogsOuUPE3h9Nz4lTmNL4ztIX7l3k0
	SlKDd20H2tAOH+5+57Si+cIo/W1Sjb6gI2CTPmsnesAqR54ONlohbxxCe4LRcubF1TqkLgRqnol
	JpIb3Fj3lPGpcvz0NY42UDccyODfmcNNv9sKVisTwNuoRMFxwTwbsjOVoQKqJi1fnoy7bYSOagp
	LSh0JJD5ajjv0ekCCHKuebWDxrLwesVXLb+M0ur2I1vnH5uQ+IeOeYVL0TyBzGPqBkpkA2FkKm/
	Bywg+zZ1fm1IP86xctlzVDQuhthxi/tci9D+MAX95d15gJys=
X-Google-Smtp-Source: AGHT+IGmdv42c2rUDCSqjMLbB05d1qhHd7EbBNznGZxvwm9FpGwbs0qtWom0jOSht9Bi4t1C9nXX3Q==
X-Received: by 2002:a5d:5f82:0:b0:3b5:e714:9c1e with SMTP id ffacd0b85a97d-3b90092ca4bmr8607716f8f.12.1754906649197;
        Mon, 11 Aug 2025 03:04:09 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c470102sm39758429f8f.53.2025.08.11.03.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:04:08 -0700 (PDT)
Message-ID: <9cccf70a-26f2-424d-8d44-3b87dab97d65@gmail.com>
Date: Mon, 11 Aug 2025 11:04:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] t7005: use modern test style
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250810160323.49372-2-ben.knoble+github@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250810160323.49372-2-ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 10/08/2025 17:03, D. Ben Knoble wrote:
> 
> diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
> index 5fcf281dfb..2f59fc0549 100755
> --- a/t/t7005-editor.sh
> +++ b/t/t7005-editor.sh
> @@ -7,10 +7,8 @@
>   unset EDITOR VISUAL GIT_EDITOR
>   
>   test_expect_success 'determine default editor' '
> -
>   	vi=$(TERM=vt100 git var GIT_EDITOR) &&
>   	test -n "$vi"
> -
>   '
>   
>   if ! expr "$vi" : '[a-z]*$' >/dev/null

All of the code starting here that is outside of a test could usefully 
be moved inside the "setup" test below it. It could also be cleaned up 
to use write_script() to create the editor scripts as well.

Thanks

Phillip

> @@ -33,19 +31,16 @@
>   fi
>   
>   test_expect_success setup '
> -
>   	msg="Hand-edited" &&
>   	test_commit "$msg" &&
>   	echo "$msg" >expect &&
> -	git show -s --format=%s > actual &&
> +	git show -s --format=%s >actual &&
>   	test_cmp expect actual
> -
>   '
>   
>   TERM=dumb
>   export TERM
>   test_expect_success 'dumb should error out when falling back on vi' '
> -
>   	if git commit --amend
>   	then
>   		echo "Oops?"
> @@ -56,13 +51,13 @@
>   '
>   
>   test_expect_success 'dumb should prefer EDITOR to VISUAL' '
> -
>   	EDITOR=./e-EDITOR.sh &&
>   	VISUAL=./e-VISUAL.sh &&
>   	export EDITOR VISUAL &&
>   	git commit --amend &&
> -	test "$(git show -s --format=%s)" = "Edited by EDITOR"
> -
> +	echo "Edited by EDITOR" >expect &&
> +	git show -s --format=%s >actual &&
> +	test_cmp expect actual
>   '
>   
>   TERM=vt100
> @@ -83,8 +78,8 @@
>   	esac
>   	test_expect_success "Using $i" '
>   		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline |
> -		sed -e "s/^[0-9a-f]* //" >actual &&
> +		git show -s --pretty=oneline >show &&
> +		<show sed -e "s/^[0-9a-f]* //" >actual &&
>   		test_cmp expect actual
>   	'
>   done
> @@ -105,8 +100,8 @@
>   	esac
>   	test_expect_success "Using $i (override)" '
>   		git --exec-path=. commit --amend &&
> -		git show -s --pretty=oneline |
> -		sed -e "s/^[0-9a-f]* //" >actual &&
> +		git show -s --pretty=oneline >show &&
> +		<show sed -e "s/^[0-9a-f]* //" >actual &&
>   		test_cmp expect actual
>   	'
>   done
> @@ -115,17 +110,18 @@
>   	echo "echo space >\"\$1\"" >"e space.sh" &&
>   	chmod a+x "e space.sh" &&
>   	GIT_EDITOR="./e\ space.sh" git commit --amend &&
> -	test space = "$(git show -s --pretty=format:%s)"
> -
> +	echo space >expect &&
> +	git show -s --pretty=tformat:%s >actual &&
> +	test_cmp expect actual
>   '
>   
>   unset GIT_EDITOR
>   test_expect_success 'core.editor with a space' '
> -
>   	git config core.editor \"./e\ space.sh\" &&
>   	git commit --amend &&
> -	test space = "$(git show -s --pretty=format:%s)"
> -
> +	echo space >expect &&
> +	git show -s --pretty=tformat:%s >actual &&
> +	test_cmp expect actual
>   '
>   
>   test_done

