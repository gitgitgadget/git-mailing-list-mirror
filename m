Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD822258E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466076; cv=none; b=ThmEHgVG8UBOe0UNW9IdAvrBOSrPPXTsgKZ7FRas1vrsqE8NenqXEP/ldTj9taPBdnQVnKzv+A9qq/Yxe/UgqkkAZwR3S/qEqqZFZD/CXn6dUDSFbG/+T4D1/5NrKQ1y53UU82yzFkcj+TzyfoPsSWjqyxlmtle6e/gOrNoUAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466076; c=relaxed/simple;
	bh=iEDx9/h0EWYMLc7xOvmVs19EfVJDlc29B+GE7Sue5CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqOaqr1l9sA9g4dilBpfKd1GW1SFB0zam1LIcxuwI52Yet58MJet4IBmI0zhmTWc3eN1cq/FM1Td3x/rbcABBlxfHt9lhp48mAgRRd2M6zVRaLxX5RTzbaaAjf42qFUrPgQFY/wkLCwOOK6l3UM20DfiiQ7aQwDfajUPj3EEaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHodCZI3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHodCZI3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3995ff6b066so292112f8f.3
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742466073; x=1743070873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jOJJ9DaUFlWlsGW6B9ehAhb8EKXDjSxCePQdd6r1TK0=;
        b=JHodCZI3C+xCRt/pNhpV14C5fgXhkP7urPZw7XxLpVclAJK/i0RleGu5Ax9yKLGzQC
         GYdLzjBSaWKzWXOwRKFUTvRMFaM3JsLc+Z8hhNZeKeQet52+HiIwqWFGSaGesnaiWYcN
         2D5cegx9u+BpwEmXSQxoActmZvbXMSFNg45A62laVfeoMcFePqFncPIKiZBJIIBsDKQx
         ALV7naTDOm0fYw07Fl4AwAYd3iGhViLBEqQMfAqPVO6Xa3V7jsrDqGMN66JwIKjmW2R0
         vbBZLu9Y/fW1ZSxS6GrV+6TkSgGhDoTf8ErCFUBl1AIaclOlO/qDWNJ5a16r4/dVgATI
         bcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466073; x=1743070873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOJJ9DaUFlWlsGW6B9ehAhb8EKXDjSxCePQdd6r1TK0=;
        b=C6aCHa3QFbVN2ZA+5bhFgxe/uw84Q/QxD8RrEq/eq7Df79TQmL5c6iQGuPNVdIb66w
         fpbwREZ02MCya2oL88vzjCQnRomvaveEFaA3GHtapTAlIF5CKfB9fao3qkp5ct1Lbz+g
         qrzpxz6OmdTD/gb45Ki7bT8EucyzutJj7omFUOO2dWMK4mIgLHHa3yJ8OLu2yXvEzUPY
         CdfwgN42WDepXsnsySmWgKuFumhB6UNfVrPxMWBYMzu0Y/BDhbGKhGV1cwh2IgRn0CMa
         wHRv30VYA3l1vwnNzQJqcMAjnnJQ7mbwNiNTG1QnkazdZBbsJFBS8DEI0H3q2c+SmpSg
         xzOA==
X-Forwarded-Encrypted: i=1; AJvYcCWj10i5uaPRIMlYj9t4ngZmQ5rTLvgtRzm++vpZLU2WMi3JhAjCT0niDkUhwxDipnef370=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxdmSkNpazLWcPaUABFuzP3H0S0kv9mmAMrUpR8xikzRwsqOsj
	U30iqhkZ5RtWPZL7uGgECkWhpZ0tQz4rijsBlhY5qUP3I9yCp969lS1Dvg==
X-Gm-Gg: ASbGnct5fWY9C+80todwKXaMCo/7pobsOo2ilpQSgjm5NAFqvikQah7vfHe8sDOt0i+
	nB+8U+QekXcG3XbSDZIHmnt1Vkhl6CVGKfgh4sKzl0ISUidRFQTKB2NVY843I17qs7BxdFe/pWX
	YFqN+HIutMS0WboEXwcVrE0cA7KdClxpw1a1Q+IY/5Hb5NveojJf2WZY+/gh+z6Hau2tsiVlHt7
	MqSxwnbx4pwxNJSiy22oFa9LlP4B+I9j8VdNPrGC7BPxdOvzgoWnB8EmVOUJGPuQnuoPppzdHUl
	nmbfFlr/hOvU3JYSiozvHN8JsDn0NgrFyal+8Qsd3eLn++ufjTLTrjDwrBUmIFCrwcdYH3nkV/4
	vWsEqnYHxfno/4lenF/vp
X-Google-Smtp-Source: AGHT+IFSs+kQosrxGan/i0ZPbXKDvshJLAbSfD+vm19VkvkgdDmuT3NiiIqhvoMMxFe8nLvxv6fDUQ==
X-Received: by 2002:a05:6000:1ace:b0:391:2d61:453f with SMTP id ffacd0b85a97d-399739c8c7amr4960295f8f.24.1742466072402;
        Thu, 20 Mar 2025 03:21:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975bdfsm23028145f8f.49.2025.03.20.03.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 03:21:11 -0700 (PDT)
Message-ID: <6a3154e0-e7bc-45ae-b554-67ccab18727a@gmail.com>
Date: Thu, 20 Mar 2025 10:21:10 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] docs: clarify meaning of core.commentString=auto
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <Z9lcXR6sL3UWlL33@ugly> <xmqqa59i45wc.fsf@gitster.g>
 <Z9sLAEbE9lAInBXz@ugly>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Z9sLAEbE9lAInBXz@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2025 18:20, Oswald Buddenhagen wrote:
> On Tue, Mar 18, 2025 at 10:15:15AM -0700, Junio C Hamano wrote:
>>> reading through the thread of the original submission, the feature is a
>>> workaround for `commit -m` and `commit --amend` being inconsistent wrt.
>>> message washing.
>>
>> Perhaps somebody can be talked into fixing it ;-)
>>
>> With a clear explanation, I am OK if somebody wants to advocate to
>> deprecate (and remove at Git 3.0 boundary) the "auto" support ;-)

I think that may be best. Looking at the sequencer I don't think 
append_conflicts_hint(), the "fixup" or "squash" commands of "rebase 
-i", or the "--reference" option of "git revert" are compatible with 
core.commentStr=auto. For rebase making it work would mean scanning the 
messages of all the commits to be squash before picking the first one 
which is a pain.

> how would we go about this in practice? just a notice in the docu, or
> some mechanism which would complain at runtime? under what circumstances
> (i.e., how to enable/squelch it)?

I think we'd want to start printing some advice when 
core.commentStr=auto explaining why it has been deprecated and that it 
will be removed when Git 3.0 is released. We should allow that advice to 
be suppressed setting advice.autoCommentStr (other name suggestions 
welcome). We would also want to add an item to BreakingChanges.adoc 
explaining why it is being removed and add "#ifndef 
WITH_BREAKING_CHANGES" around the code that handles core.commentStr=auto 
in builtin/commit.c and guard the documentation with 
"ifdef::with_breaking_changes[]". We may want to make 
core.commentStr=auto an error when breaking changes are enabled as well.

Best Wishes

Phillip
