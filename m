Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510613C0A1A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785080502; cv=none; b=m3dzfIZ+T/hhJEcR4pq6ZuVFQLvQxyxTeKO/sdGNRj8WaCrut5OruEtTw7sR/P2wG4cG57+aYTu0dbPaTXvLIWQ8WEVsVViWc9wy8VhPAWxa0/ToOiE+PSDQrgDZmhP7szY/3otFD9AEAuFQaxbQbl5vCOTYcUIQOBfTWBe/As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785080502; c=relaxed/simple;
	bh=RIdhbBV3AnayutNRVZHpWK0LrBxP/r2wIZuBZ74u6R4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=T2Td9BWScjRcpGX39El2p4Nds4+STOvq0+E++KI5ePw498gT2Tkr8S/E+rk6hEoi8ubbb9oPuxvcOLKurNvX0Oo7aFnCpMW4h4q4fFsxzKiuR4Je8SAGadWRjKmXBFUc8cTlcy6+eIVt2M7Xcw8h0lcZcK8OxIvepPtDjnAzSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLYJUwcg; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLYJUwcg"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47de0093c42so1482251f8f.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785080499; x=1785685299; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HENYrE2erM7qk/OmBwrS3jcL4wjuf4CNkfxm4yH4H1o=;
        b=DLYJUwcgbPegYOb6V3tc1NSz5GozOFEhPkgN2WnfHXuXXL1+rJqdJwkVBFMgrwVhvh
         hfUiclAafP+vXUWIdBn4viMVM3wvFRAr1VyaWpxXjije3YOfWPXjod9/Fw4u8JaFeQBG
         6s9RDZ1d/DhXsPc5UoYUgdpvhgfr5vCHdYpd7LL8NLts3YpwmZRRPwjetXQMXo8esB/i
         y57Y7LO3dGhYDPMfeyWo/nOn5S1eqE92qVpU/AWa7IEOo1V0y7vkA7Y1te1cVwO51xtD
         9O8bRSnY+MaAF0JFWuZEBhK1HjcbfhO2C9cTVPBp0CW9Xc8UHQvtNmWfosp/ILoejVay
         aWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785080499; x=1785685299;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HENYrE2erM7qk/OmBwrS3jcL4wjuf4CNkfxm4yH4H1o=;
        b=CG1Yjw9GQFBZJeaRTx4LwESg63WzJ4VFDyyX/bevITFD+6tLgZt3MF/XzjNofJ5QK5
         k+/gs7BkyC7lGR5LqRU1NoERfzD7BGtJrDjpShZ48NE1kMsFs3D3LnLwf9HsIPMcL2G6
         IfIwbWOp2qRJ4R4Rog7spcV2ftzSFtkeBZS3NttlHGjhQOZmA2Z8OZEvoQmUMB9TQAY1
         Ot9MVPmbQCkF9pEyRyZZvRM0RsMXeJa8QCDd6xx3pTVsYn9c6E9K+Lb+3uL88NudesEK
         wtLUGKd3Kk/7XGh+SekDaTXWLJvUNwutKTJNcrTqjNNf7q9ZjuK9PKe7unHfyNATLkPv
         6E2A==
X-Gm-Message-State: AOJu0YwzaW0ZcF8v2yVg9DEZSx7Xn4GHDx1P8ElOuLP8zvLPl1rpMWtD
	EbQL2M+2U4+Qns2WXqTKJYYmlCe20StMv7Hd40AwKFJo23joN36q9JJk
X-Gm-Gg: AR+sD13b/V46o0mNBuG5RQZijQhZ5zz1lf3OeW79c3rWyl6vv1Wlrr/rncWbkhlhjmZ
	QHTLj25gbATXd1xvOfQgFnKhSgljOYRVUkOGMCNrxUt1DQZS9ESJWOx2NSjhAnGRyRPVg40LU8i
	vaAT/To9Bgzye++4vbSnOCTn38kZtldzPHlA5GOXUB8Sj5TXPzzgtscuaKloNptxDh5hBf/bKSe
	m1bj328x6OdwF+EZE/ttXNtsVbW9tpA/l1Yi7+58pku/uulyyySagtPwTjSAQmMHfnUllrxuIL0
	pwKV1f10QpCBwpEeCrKcJg5hAqfISx8ezGa2I5lNWTwLb6ddfOk+2kxB7v1iUvsj2rwhYrCDPGu
	7+JGMAIEkV3c2P0ZaP1V22V3eh7danskBA4KgKQpJSwtJLhT9OxYo/e4Ay4OIbMzXabcGISjIBp
	Ib5CLAY4urKiA2gRW9wQShE66aEtlVEiiUvbFLv1B9ROCBh2v11wR6AmDRfv2pbMD7ZoQ=
X-Received: by 2002:a05:6000:1aca:b0:47f:9096:3c57 with SMTP id ffacd0b85a97d-47f9feaa738mr7162980f8f.40.1785080499340;
        Sun, 26 Jul 2026 08:41:39 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bc62basm43310811f8f.13.2026.07.26.08.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2026 08:41:38 -0700 (PDT)
Message-ID: <c9631a42-ea7b-45bb-a153-0372784b8f24@gmail.com>
Date: Sun, 26 Jul 2026 16:41:37 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] rebase: remember fixup -c after skipping fixup/squash
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <cover.1784304378.git.phillip.wood@dunelm.org.uk>
 <7c8075ff2675976821a1ee979f86c7c46a35bd15.1784304378.git.phillip.wood@dunelm.org.uk>
 <xmqqtspo3x31.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqtspo3x31.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 24/07/2026 22:18, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>   	return starts_with(ctx->current_fixups.buf, "squash") ||
>>   		strstr(ctx->current_fixups.buf, "\nsquash");
>> +}
>> +
>> +/* Does the current fixup chain contain a "fixup -c" command? */
>> +static int seen_fixup_edit_msg(struct replay_ctx *ctx)
>> +{
>> +	return starts_with(ctx->current_fixups.buf, "fixup -c") ||
>> +		strstr(ctx->current_fixups.buf, "\nfixup -c");
>>   }
> 
> It is a bit annoying that "git diff" decided to consider the "}" at
> the end of the otherwise unmodified function to be the one that was
> added X-<.  But thanks to it, we can see this mirrors the previous
> function to check if we have "squash" anywhere.  I wonder what
> diff-algorithm was used to produce this result, but it is an
> unrelated tangent.

Patience diff without the diff slider. When I was reviewing some of 
Ezekiel's patches I noticed that the diff slider was munging some diffs 
generated by patience in a way I didn't like so I tried turning it off 
to see what happened. It seems I haven't rebuilt my local git in a while ...

>> @@ -5391,8 +5403,8 @@ static int commit_staged_changes(struct repository *r,
>>   				 * message, no need to bother the user with
>>   				 * opening the commit message in the editor.
>>   				 */
>> -				if (!starts_with(p, "squash ") &&
>> -				    !strstr(p, "\nsquash "))
>> +				if (!seen_squash(ctx) &&
>> +				    !seen_fixup_edit_msg(ctx))
>>   					flags = (flags & ~EDIT_MSG) | CLEANUP_MSG;
> 
> If 'fixup -c' is anywhere in the chain, we would need to offer the
> user a chance to edit (similar to having 'squash').
> 
> It is a bit surprising that the 'squash' detection, for which we
> already had a helper function, was open-coded here.  I also notice
> that the helpers (including the new 'fixup -c' one) do not insist on
> having a space immediately after the verb 'squash'.  Should we add
> one above?

I'm not sure the space thing makes much difference as this isn't the 
todo file that the user edits. We're reading a file that we've written 
and the lines can only start with "fixup" or "squash"

> Other than these minor nits, this looks good.
> 
> It is a bit disappointing that, with so many users who crucially
> depend on the proper operation of 'rebase -i', we have received no
> review comments on these two patches so far.  Perhaps summer is a
> truly quiet and slow season ;-)

Oswald mentioned in another thread that he'd read these and they seemed 
to make sense. In general I find it hard to attract reviewers for 
rebase/sequencer patches - it is one of those features that everyone 
uses but not many people on the list seem to be familiar with the code.

> I will wait for a few more days and then mark the topic for 'next'.

Thanks for your review, I've sent a re-roll fixing the newline detection 
in the previous patch.

Thanks

Phillip
