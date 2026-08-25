Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AC3E47B
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787673268; cv=none; b=T+4uRdDQUPaavbZzY0XDGPa/c4E5bSVV5IewZbciaNnF1rg7ltDvO4Qrw6TaspxeMps4t12loIsJ317xfgurw+W9QyQsitc49yRS722XWJ5/UnO7ShjnuB8NATLaTYejdX6hmDBLs3KlVAIlvt5d5Mg+h9YI4mZ6IT+JhWbOFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787673268; c=relaxed/simple;
	bh=8GDE+UkgTrJGZ9s+1t0vWz5mXCFRi5MMPgiLPmjUGJU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B42Ot/mF+739+Z3CuGTAGO/wm4wNxZYarEY/rjmKsyXpO1uGkGhd1eutHSpRXK9HPaGzxJ9iuRvW2tZRPU0TwKVI1d7v45O7zokRT4f2bEu+ikG9gLvlw2dloXxIvuRLrr3j3X/twRdDj2LXiDPUVSz/fd50FM/rcRKeO54BoLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMaSTN6w; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMaSTN6w"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47fd66a094eso1443836f8f.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787673265; x=1788278065; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VYC0CCgo7UgSgz9G+qtzeKthJLQJKKgGlmDl1VnLe0=;
        b=UMaSTN6wVBJsjpkSbCy0q9O8Zi1ZhfTCcXOr4yDZ8/RInJP/2H/2M+/KAtSpxaR4sZ
         IUbUaO1AbiyP3rimMxy8h8AHdLGLJNsRwopy7uTBNBa6XvdtTh2xbhNmXR8eq9ODbgra
         YHsSikWdpvUpVKdVerlA7HN7zcg+2ZfFfdvNdle/qJaiBIWao2M+gdmwx0PIatcAOLJR
         gP8sHFIBYHMLQwyQo5knKc/gAnrdPhAeIkXpl/VnoytT1+UaCSY7Q/xXiZAOALF7SVhM
         ypRmqWipgzVxeBqKcMsms3/+zgg3pRUJTm2eErgMckvBnRNSAQZ5LlqFOD5K36AWGlIX
         8z0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787673265; x=1788278065;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VYC0CCgo7UgSgz9G+qtzeKthJLQJKKgGlmDl1VnLe0=;
        b=jTlaqEAZ5hsOl5F2h2pAXooSUcj2ACmR9c5Hp/vsM/ZRjWZ1CzAUUjZ68dlsiy6fEo
         GyPkou6XCkIAnWYTnb68WcujsXJ3du1EBSMTfNSGIM83AAuBj1vm1Mw+pqxNec7OMpON
         chLRg+7rFZetaTF37VJMhu16DKMlF4227XKRw6MRiYtxFKQcPODUVMIR56df+eUys7I5
         PQ0LiAMIBXQfVIQdBOL6qgxl6zPKcXXQAUBKBGa9VyuC3cj0iEc1NizlimYk1h4hMSsK
         LrSfa+UnJzjPEevChzwnKavk7wcdGJv0/LICTfLG05oAKcrqa7wBCvn3aTXtIMTh3jxC
         wsJg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7D7WH8DTVmH/XvZ0Nd0NPscLJAx1jiAxpAdxLjIB9tfldgX9baCjGfI84/p1e7Kjz6mE=@vger.kernel.org
X-Gm-Message-State: AFuF++mnpW9Bt6aCRlkhBb97N7NpAA6qwpXyrhw1vvxKdmoNbFJ/Myff
	9SxkhAdnNtH/3huY3HJmt1IOMX47rGKwVNbqNfTzkeaaNH1tuPeTX356
X-Gm-Gg: AR+sD13+d2ejDSTJfCMpu1/juDQs7DL7SFVjfe+lizRFqXz73+mm3LIj7OeSXlHpTF5
	FTXXk4R25RXkKVGskqq62TlcyM3LjRAwK9I9JjwXmdlHz1maQ1I5O5gaHUcfm8ByXF5Tdy6yiZA
	Xsj18ZYNW2ud7P+XusYj8NbjWiqugqgZh7hYipG5dyfVqWz0NWVFfB7KYnr0Vhis7vZqesScEpO
	eUQYuRAzYfpSbfbQk942xeJQrVHObWLO+JTcuxi3lzcN8c1PTBEIU3xOZ0JtwhLEbJz9inT83E/
	HW70wOB46T5NRBVZn1H9p0bJfzVZIj/9iZ1SKd9OF5zZpsGplLMNcj4BgKLN+Cq3o+ezIIEsqvh
	qsjwkgDCs9KphICogp8J+uYTiohuUe2HLrHP4sqHd9iCpxS2qVyK9r7/0PeXarUL8hpTZ9AJOsN
	nsAzIDU03fsFT+trlPGHiXrMq5rMoFogAE7j2uI4xjZUvPQ2he9AKNjEKeA6KE36KOaV0pUOiu/
	GFMR1i9+C5qNu5/1bmNNNRKwY2mY/bVGz4utT6XYUA=
X-Received: by 2002:a05:6000:4681:b0:481:4fa4:f9e5 with SMTP id ffacd0b85a97d-482e26adb2dmr134590f8f.14.1787673264934;
        Tue, 25 Aug 2026 08:54:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482d4710ac5sm6480203f8f.32.2026.08.25.08.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 08:54:23 -0700 (PDT)
Message-ID: <472164ed-7707-4842-a275-0356cb0e7c71@gmail.com>
Date: Tue, 25 Aug 2026 16:54:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] sequencer: release the ODB before spawning git commit
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2198.git.1786388689444.gitgitgadget@gmail.com>
 <pull.2198.v2.git.1786528498689.gitgitgadget@gmail.com>
 <a786e6c0-1c17-4121-8623-b4541478a88f@gmail.com> <xmqqo6ersi07.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqo6ersi07.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/08/2026 15:36, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This looks fine as an immediate fix for the bug but I wonder if we
>> should pass "-c gc.auto=false" when we fork "git commit" from the
>> sequencer. We call run_auto_maintenance() at the end of the rebase and
>> its not clear to me that repacking during the rebase is helpful.
> 
> This is a bit amusing as I was reading old discussion the other day
> around the constant 6700 [*] and saw it discused that because
> "commit" triggers auto-gc, there was no point in doing so in
> "rebase", which does series of "commit" invocations [*].  With small
> projects and short rebases I tend to agree with you that gc at the
> end of a rebase session should be plenty, but given the widespread
> use of Git, itt may not apply to everybody.

That's a coincidence. These days we avoid running "git commit" for 
simple picks, but we do run it when rebasing a merge and I suspect large 
rebases probably include merges. So we will probably do trigger gc 
during large rebases even if there are no conflicts or commits being 
reworded (which I think are the only two other cases where we fork "git 
commit").

Thanks

Phillip

>> Another
>> thought I had was whether we should automatically close the object
>> database when forking another git command. I'm not sure how easy that is
>> to implement but it would prevent future regressions and I assuming
>> re-opening the object store is cheap compared to forking another git
>> command.
> 
> I think it is a great approach to study how feasible it is, as we
> will not have to sprinkle fixes like the one proposed to many code
> paths.  Thanks for raising it.
> 
> 
> [References]
> 
>   * https://lore.kernel.org/git/?q=6700+d:..20071231
>   * https://lore.kernel.org/git/20070906023934.GI18160@spearce.org/

