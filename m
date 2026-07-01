Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942A34D397
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 15:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782918897; cv=none; b=mb/qgcxZ74r6sHOyZ0D0gK4xtPo5RxhgdG1QaYJfLnnneZUIbqgNHst6jJhPxp3FjhGlTA+u+0JRAQYPBP+KSh148MkVX1tQsbuKn+ZDaRH4ekcRSMS8TW7IYJBfM7bpDpKfTcmjo7BA4AP3Mj7XGc4eOc9UZCg2qG2NoCPLBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782918897; c=relaxed/simple;
	bh=HVWWzCGoFF2LUu0XElvmGukKGufgqjfKOLvnAAXyLhY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PojmD95DynmI3GEZPbDBM5yfbsjpineNk7eXTDsnOQQzhDaZ+65qBhcrbAO072X4o9GNZMkqz+qbhHH3TBoM8r0Q8SYXpp9bd1PFKW178VoF+f05uHz2/Fp5tpfIs+Sc04M+S1OuEBzbI8NnyHdlqDSLcsoUy+fSH2WUEMnC2es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWPSEgNo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWPSEgNo"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493bf73ec2aso4616005e9.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 08:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782918894; x=1783523694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dU5aJm2P804J4l363I6UbzZVye5X7NRBfY2zDojUSdM=;
        b=pWPSEgNooiEnB8NRrR+spobUgLa55gppnTotmW+eTJNkoRazqqzWy0JeI7y5qV4LXT
         Cwk8Oz6aHMjgeA7Rj5JMhglfZFEZMYhe3W70jRLFexVAZQc6Zryz2TqDyWU8x9t4H4SZ
         K5FhT96R1n8yiNLA6HKq1poo8VAoHgzM59lN+RFmC5pvwQOstMIby9J2KkSm1Z1O5BJq
         oumJtG+SZdQB0LymnYfma2TRWXY0VuxLmiYl66+IV5XIKQBNcLSK8rEvxGX85PPbJmIG
         c2PlDQ37NebwOQ1nJGkX9dfX7UdngcKkmssrZ9/y2KGSxyTLPuI1Q5mLNo9J2l1C9lPT
         i/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782918894; x=1783523694;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dU5aJm2P804J4l363I6UbzZVye5X7NRBfY2zDojUSdM=;
        b=VdFBdritWzBfphvtidnaWrIN2gC/S4rCOiUyDdPr0j+R/Q801AzFGjYde3IDX2t1jQ
         DA2KhnrpIirZhuHlj/F4Qd/CVfb2dYxe6lmQSZ6omxhKMsNTc6FE9FnhZBuECylaF6oe
         FKyp34uLBElgCAqT12GX8UMvANrhG7vjUWjgEkUUY+e1INxhCFZdsUyYUENAvC43nFVB
         9aAGk3WPyAxeLZiZO29XbNyidcAfaqWvwkkRul93R8UICWspsZ/puld4R9RKTAHvBS2n
         YKdfRbg9Yib4on+lp5x70cvRo93Q2bIWoh3Lw+RLFg9tBYXohwrHvmtN3RzbNCx1WIta
         uIRg==
X-Forwarded-Encrypted: i=1; AFNElJ+G426/kfohgFcG7u9uHWHvot6qrrmzgnmYMup6um+3Han5NDGvXrE6ieSmIfV+tIOpYWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+Yhh5Un7nGk7qRUg4hUA2P20y8sXKEr+lWLFoja2sSGSmL6Z
	mc//gPBlNIvgDNJPNxNYWzly5jEwpjQOUGQqzwWjlSuH3ZNj3fRC0UfxMkA5TA==
X-Gm-Gg: AfdE7cnOKTjM7Xa16XmtaBonjtcR7O03l3tMvVqrNEInvhvGtEwTgv9ye/VbBd4pnD7
	PvPr8ZCDgOOdY93WhZgQuqxB9kiS1OCexl0QSmbjFK20WsyQdGk8DEP9iA+w7lRx3dwmmV78box
	Cz3WIrt5NOynHLwpQD3SjoBGUHj2sK7LpWV1d2hsqJRdy6U59p/T0y9p2kjGETNmQW8+sLUSM8b
	c/TT0lszUpZUO8HoiVHeCaBohBQx6wh/yifQ4UrkmxbxMLYitblMPo+c328V8Vse2XnNidxwEby
	isBsFXj/5JV5FtrLfvkoB1o31pfn/4+KNM1vxGmh33DbGlJNN7qurxeesjPOCr2mOk/feepbJr4
	LCF7FY6oK3Dn0OyOR1I8HGHGDZfRPtzbW9b5olP8oeJIDEjnUwfYAYfnKN/s6TiUbIAxKIkpGn4
	ZzM6x5eKdUCqyJfqyYbBdI0n+h+ItosZ7r8VtPpdw8CLO+KfJoYyKz7q6SCQ6GvBZqSgg=
X-Received: by 2002:a05:600d:c:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-493c2b3d08cmr27013925e9.3.1782918894337;
        Wed, 01 Jul 2026 08:14:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c7f2csm97414115e9.3.2026.07.01.08.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:14:53 -0700 (PDT)
Message-ID: <c517bce2-9f39-46ec-8509-bb0893e26ae2@gmail.com>
Date: Wed, 1 Jul 2026 16:14:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk,
 Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
 <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
 <CAHwyqnXoqZYHodWXHtwnk0_PiZcCYSVL+WgL3h5nWiYx_cSZLw@mail.gmail.com>
 <f15456d2-d8b2-4edc-80b4-3a9d8fc77da9@gmail.com> <xmqq8q7urfe1.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqq8q7urfe1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 14:47, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> The reason we're introducing the history command is to experiment with
>> providing a better user interface for rewriting history without being
>> bound by the limitations of "git rebase". So I think it would entirely
>> appropriate to try a different format for the squash message here. If it
>> turns out to be a success then we can see if we want to use it in "git
>> rebase" as well.
> 
> Do we know concretely things that are bad in the current way "rebase
> -i" works, so that we can experiment deviation from? 

Yes - if you apply the way "rebase -i" works to multiple commits you can 
end up with a message template that has a screen full of commented lines 
between uncommitted parts of the message. See the example below from 
earlier in the thread. It is not so much of a problem in "rebase -i" 
because it only fixes up a single commit at a time so all the commented 
messages end up at the top of the buffer and at worst you have a few "# 
fixup! ..." or "# squash! ..." lines mixed in with the uncommitted text.

     # This is the combination of 4 commits
     # This is the first commit message
     Base subject

     Base body

     # This is the second commit message
     # Another subject

     # Another body

     # This is the third commit message
     # fixup! Base subject

     # This is the fourth commit message
     # amend! Another subject
     A better subject

     A better body

Thanks

Phillip

