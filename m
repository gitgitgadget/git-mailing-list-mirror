Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422432C60
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167782; cv=none; b=TDLNqugBnuqYcFdEyMsAaIZlR0MCYlQaxUdBhzqiy+Y6o/NGmeIhwA19yMakGMni8JEfWXXhhoTCb/sj73Lc2oidx1b6NjfwTGV4zJFEyQP0a4LLPGZQQxVNEEo5NLelz7lXfQQWAdwwt7QS2JHnlocCo77Eal7niwKsDoAPjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167782; c=relaxed/simple;
	bh=fxNZaEbNi8t6KktD/ag+tzrINz0yhlVGAYp0Zbawa2s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=H87obsANqugBHH5Fh1yUerlHFSaW3OBxiewqkUN1wwgpIuB9hFcLKVnlUsHNj2FF2LhLHtKM+Aa6s+Si1OlAMpeBHCmlqmOR93lgDl/5hbH2jhVllIofo2Ai2BnlKA4fQtH9J/+HpmYiFALuCgpZudWDKUNYBZV0C9ddCZ7IvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mdzrigsq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mdzrigsq"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45ecef71deso346659066b.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710167780; x=1710772580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H2dWJfXzjWx/Mv2ScYm5TTQuiFMT22l2v07oNkxES6I=;
        b=MdzrigsqRUJeh7z4r70Tnsg84BQl6g/VlwL+ZANcpTlEeNk7o01/B5Yj4mvFxcelXC
         PYQN9hoj9Qa8PI18l5LQte66GD7SL/YO6VOQmtuk6vOrzD58elA6C8CEicawQlk8gRpS
         GZn6CrteWIdGY4wHhaDqRjj9rTItRbnopeV30ZKaL+KvkxsoeEO08Q2BmYOMAFlP/Ogy
         0iTEwBs1GQ9oZR8RFo9ITPJlyXD/D1v3qbdIS1xzQf3SYQM5eNVBzDM1NTuwPXRZsC+b
         pYQF4lmV5I8U628DcSkoNecxn2vvR7k8bTtlaCI3SaMncfoYjbnnFWy9hxEvK6TqhmQK
         R5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167780; x=1710772580;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2dWJfXzjWx/Mv2ScYm5TTQuiFMT22l2v07oNkxES6I=;
        b=gTea2ZPbIieeimJE+XOfWsKhBmSmjXV79cmUXR60Ke2SsQlfw3CDqS5Wgg/eEOZ/L8
         uJrBqgQ5DPlqWb/zLJbiPc0UmEDU08a15snW7rDuu3wUmJ+7htFyzb93d7ZXMvitU/K2
         cTi3RradvKQ1ZPcz/WJyAw1Hqe2Kltp5L76pRr7crcnMxw7cCnm/TG/9lcya8TkJKfc6
         IDfEtpKts6sKN0BsrQ0A9iFbGEEFZqLl58tWoDOkUQkRFUNXyamXulFWtlsmXKJIkWgM
         ZqJlHB8AiA2qtvNR0XHxeKXwobmZOg0wN01Z6qrMx1vN7zimew+FbXPis+gML5DqEJ94
         H7zQ==
X-Gm-Message-State: AOJu0YxQnyC2P2iIRJDQbnCXN3L7WLKAHI5fQ1vOKrja05RsH7HHGdgx
	++iE3zeZxYkTVBBCfA67JedGS71uDA0p2hibz8kGWzd/7H5t40SW4ixE84Rq
X-Google-Smtp-Source: AGHT+IEe+ZOESlQWOioz8bQAJjrEOlp/U7GalXrjrMi+LUlPG2xZupeT1k97U2T3h88q+KuFYwIiKg==
X-Received: by 2002:a17:906:c34b:b0:a46:2ba9:da10 with SMTP id ci11-20020a170906c34b00b00a462ba9da10mr1098076ejb.25.1710167779434;
        Mon, 11 Mar 2024 07:36:19 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id lv9-20020a170906bc8900b00a45abeb7d12sm2906999ejb.109.2024.03.11.07.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 07:36:19 -0700 (PDT)
Message-ID: <f0c88900-63d3-46ed-9cb8-fc7c3fc07c28@gmail.com>
Date: Mon, 11 Mar 2024 14:36:16 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/4] checkout: cleanup --conflict=<style> parsing
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <317bb7a70d023278087f4370b843d7f28f9ee2f6.1709907271.git.gitgitgadget@gmail.com>
 <xmqq1q8khf8t.fsf@gitster.g>
In-Reply-To: <xmqq1q8khf8t.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/03/2024 16:15, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> parse_conflict_style_name() that takes a name and returns
> conflict_style enumeration constant would not risk such a confusion,
> I guess.

Can I just check if you mean that we should convert XDL_MERGE_DIFF3 and 
friends to be an enum, or are you happy to leave them as pre-processor 
constants and have parse_conflict_style_name() return an int? I don't 
mind changing them to be an enum but I'm not sure it buys any type 
safety as C is happy to implicitly convert enums and integers. It would 
also raise the question of whether we should be converting the merge 
flavor and diff algorithm constants to enums as well.

Thanks

Phillip
