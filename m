Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FA1D54FE
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754906392; cv=none; b=YytrI0FJaoXHMWk686hk4j6H3EWcZ6yCS+uVtmNfjezN+5pmQTO+yV1ViteRQVpeYnpcjjbqnyBDCcsgD9doMF48G8WnESIY1P2A+R4cWGDfPZ0DLgctwUgy7Irb61MtoPfKoHLPv/mlerm9wOhMJg/NOBt7EydMMLFTfkZvTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754906392; c=relaxed/simple;
	bh=bY4iD4EP3Mh83n3TrMW0z0JnpOuk1os9iiLZ2h1lvsY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p0oMMm+m1XJiCgzekTQ2Gsz8rzPmeXZkfOijh2B+5tUQea2DonNePRFgBylijEZZMihOiSEjzPUSsGtCdRfLLXoTsdcXEbKklx7bBeaEG6YMpaL4le2Md15U3gTCDhEi97FOOJIcyadziA0Wb2OKhhxhqkepE/zw0Ev0IEhvpPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H70TsO/h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H70TsO/h"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a0d5e4c45so2270895e9.3
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754906388; x=1755511188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xv1NWKKlH+nBqtGPhipEm8HGhDzJuxXjNmqxbCOCFZo=;
        b=H70TsO/hX3t1IHSK/5EpiZUkyh0zqKnmU1qSXh/eE63hhAyipMAVghET3Nxnb7EGeE
         gvEZn+uGIiFsTW1N78bOmaSWeWpBQ81q4RsWCYGFDMjNWfwBDnBDmUp0tmTUu3aHCra3
         sR63hI4NkIRwbdIxpiXOGFSRkgF9pA15ajZuAGT9ZhKlDpX5k2PX9M1NM0upWlatFfGO
         93Usw8fxPU97ltMBRHSN08v8VSvx+abtui5DHT3d8N6FAjUF3HjxFHvgzdnu4cNBoJoo
         W/xFG8wEYM/XqzClJQyuUPMnP1vG7Bkq82Z1Znb1rvxsdJnlNYAU1vf9xkJ3rKnH6epF
         ANCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754906388; x=1755511188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :reply-to:cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv1NWKKlH+nBqtGPhipEm8HGhDzJuxXjNmqxbCOCFZo=;
        b=HM5YI8+n09rwv6oQzLb1/aZKFbFZmef+OCYqee07LKa/dpMkE3mEDZ5jq08+eMeMpT
         cEPs7oHNae7wT4L+AkiQquSH/XD4wW76QJ4aNSwH5+kmfECkPgjZlddjSVPmu2D581h+
         vCLAdu2EwveweQSYqfDKDmBKAAt6+pPI3lqD53nhsz+vk5L4L6dCduB/WniLcJH+k8LZ
         JQmi+jxbg0uAWho0Mh3ToCqr0Yh076MYixo//X3nhw57Vsi1VQrDXr2JEQSLGrMWE6h6
         i+DmecXfxDrsGoDrUgs28X7IoS52nJFNfOhnftbTiz5HCXAFI+0lUvPvUzPxmqcByoe1
         1pBg==
X-Forwarded-Encrypted: i=1; AJvYcCWqL0cl1+NWQ8KYiC9PlT49cCu6rCFj3RJ9Jvz7skvCrxV6ozfUv/IdCXB/RiOU450fOTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwPLHQVgALC/aJI6xz9vQwm9Jm/61aW4sy9xhy+WXW/MbM4k4
	RtiZR3EMTBUMigzsoID3UQjnBXsOSu7we9Z4MJJO745RRURauV1GGSqe
X-Gm-Gg: ASbGnctkueyz7GJj5/5mRSEk4Gg2PVe3YPjTH7HS/2FL6Y3RPloHugZfniO3wWr7fxt
	7K/tnLH8nMQZD6HjpMIATjrC1nCWwWkHNvu+xWzV2fysvLpuvibAThwJXPDxsXEFaH4ftxy22A1
	GNK9xxcdqP7R8N8yJuMztcIbL9PpQmjRSROqyWrtXt/VhUf+YweoZu6k8wwzMBPObRg/Ah+zS91
	kVv+7N31cSW4vGaZ6YKBzMw2yPZl20SzVmCs1BnQLnYECL8QeNnGhDm3RlyGllpcwrFQj3Se971
	VC50xVZFPf5Vl/XZ7SmRhTbY06sncfRcG6RVfpgmLdImZ/aWB++ytDJAU+1X29mrUcJ3QYXry/Y
	W5S7ZpaVwHtHpW7HjIHeAN+5g0RcwSJpMQtHWrHtnLcSAPhFeTlOl72C3kQ==
X-Google-Smtp-Source: AGHT+IGK+fpo0jX716bvr60VumX4Y/bpwJsjjMSH0vkJfq9VFnahVTxpXmy0hThXhx83jDvOuYKJBQ==
X-Received: by 2002:a05:600c:3596:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-459f4ea1f7amr111347735e9.4.1754906388159;
        Mon, 11 Aug 2025 02:59:48 -0700 (PDT)
Received: from [192.168.1.194] ([90.254.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c46ee84sm39027205f8f.57.2025.08.11.02.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 02:59:47 -0700 (PDT)
Message-ID: <7491b9af-adcd-431a-89e7-ff54708beca6@gmail.com>
Date: Mon, 11 Aug 2025 10:59:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t7005: sanitize test environment for subsequent tests
From: Phillip Wood <phillip.wood123@gmail.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Reply-To: phillip.wood@dunelm.org.uk
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
 <20250810160323.49372-3-ben.knoble+github@gmail.com>
 <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com>
Content-Language: en-US
In-Reply-To: <144b6ee4-d4b4-4843-841c-93a109e71aa9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/08/2025 20:44, Phillip Wood wrote:
> On 10/08/2025 17:03, D. Ben Knoble wrote:
>>   '
>> -TERM=vt100
>> -export TERM
>> -for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>> -do
>> -    echo "Edited by $i" >expect
>> -    unset EDITOR VISUAL GIT_EDITOR
>> -    git config --unset-all core.editor
>> -    case "$i" in
>> -    core_editor)
>> -        git config core.editor ./e-core_editor.sh
>> -        ;;
>> -    [A-Z]*)
>> -        eval "$i=./e-$i.sh"
>> -        export $i
>> -        ;;
>> -    esac
>> -    test_expect_success "Using $i" '
>> -        git --exec-path=. commit --amend &&
>> -        git show -s --pretty=oneline >show &&
>> -        <show sed -e "s/^[0-9a-f]* //" >actual &&
>> -        test_cmp expect actual
>> -    '
>> -done

Thinking about it some more, for this test we can put the loop outside 
of the subshell and test_expect_success so that we don't have to worry 
about explicitly clearing the variables set from previous iterations.

for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
do
	test_expect_success "Using $i" '
		if test "$1" = core.editor
		then
			test_config core.editor ./e-core_editor.sh
		fi &&
		(
			case "$i" in
			[A-Z]*)
				eval "$i=./e-$i.sh" &&
				export $i
				;;
			esac &&
			PATH="$(pwd):$PATH" \
			    TERM=vt100 git commit --amend &&
		) &&
		test_commit_message HEAD -m "Edited by $i"
	'
done

Thanks

Phillip

>> +test_expect_success 'Using individual editors' '
>> +    test_when_finished "test_unconfig --unset-all core.editor" &&
>> +    (
>> +        TERM=vt100 &&
>> +        export TERM &&
>> +        for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>> +        do
>> +            sane_unset EDITOR VISUAL GIT_EDITOR &&
>> +            test_might_fail git config --unset-all core.editor &&
>> +            echo "Edited by $i" >expect &&
>> +            case "$i" in
>> +            core_editor)
>> +                git config core.editor ./e-core_editor.sh
>> +                ;;
>> +            [A-Z]*)
>> +                eval "$i=./e-$i.sh" &&
>> +                export $i
>> +                ;;
>> +            esac &&
>> +            git --exec-path=. commit --amend &&
> 
> It would be nice to stop abusing --exec-path here and in the next test 
> by adding the current directory to $PATH with
> 
>      PATH="$(pwd):$PATH" git commit --amend
> 
>> +            git show -s --pretty=oneline >show &&
>> +            <show sed -e "s/^[0-9a-f]* //" >actual &&
>> +            test_cmp expect actual
> 
> We need to add "|| return 1" to the last line here and in the test below 
> to reliably error out when test_cmp fails. I'd have thought that our 
> test linting should hove picked this up but maybe it is confused by the 
> subshell.
> 
> Thanks
> 
> Phillip
>> +        done
>> +    )
>> +'
>> -unset EDITOR VISUAL GIT_EDITOR
>> -git config --unset-all core.editor
>> -for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>> -do
>> -    echo "Edited by $i" >expect
>> -    case "$i" in
>> -    core_editor)
>> -        git config core.editor ./e-core_editor.sh
>> -        ;;
>> -    [A-Z]*)
>> -        eval "$i=./e-$i.sh"
>> -        export $i
>> -        ;;
>> -    esac
>> -    test_expect_success "Using $i (override)" '
>> -        git --exec-path=. commit --amend &&
>> -        git show -s --pretty=oneline >show &&
>> -        <show sed -e "s/^[0-9a-f]* //" >actual &&
>> -        test_cmp expect actual
>> -    '
>> -done
>> +test_expect_success 'Using editors with overrides' '
>> +    (
>> +        TERM=vt100 &&
>> +        export TERM &&
>> +        for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
>> +        do
>> +            echo "Edited by $i" >expect &&
>> +            case "$i" in
>> +            core_editor)
>> +                git config core.editor ./e-core_editor.sh
>> +                ;;
>> +            [A-Z]*)
>> +                eval "$i=./e-$i.sh" &&
>> +                export $i
>> +                ;;
>> +            esac &&
>> +            git --exec-path=. commit --amend &&
>> +            git show -s --pretty=oneline >show &&
>> +            <show sed -e "s/^[0-9a-f]* //" >actual &&
>> +            test_cmp expect actual
>> +        done
>> +    )
>> +'
>>   test_expect_success 'editor with a space' '
>>       echo "echo space >\"\$1\"" >"e space.sh" &&
>> @@ -115,9 +126,8 @@
>>       test_cmp expect actual
>>   '
>> -unset GIT_EDITOR
>>   test_expect_success 'core.editor with a space' '
>> -    git config core.editor \"./e\ space.sh\" &&
>> +    test_config core.editor \"./e\ space.sh\" &&
>>       git commit --amend &&
>>       echo space >expect &&
>>       git show -s --pretty=tformat:%s >actual &&
> 

