Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3023A0
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509343; cv=none; b=I3N5sekb9uzNlYFqJQlGdqtMoNDxUJ7KGAZbfNOvdiZBX+pgvqhbKrV+ir+n/b9u8h76vnKGHLpXu2b/GGSY0AiC6xBOYdiSAWB66a2zuaagTIYyaoPD9qdAAzBg3tsgVbqTJUX1h1vABvnPmJpRDU8cXuOho2rmYl3D8XQmfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509343; c=relaxed/simple;
	bh=R97vuiJx+OpcRgMHCP890hgpUKmQVsT6tHzYknJTrhE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FZUGhJxxx0IVLna2qNOIZ+WDVnPtJO2GzXzWsj9cwBnc3C+dGn6cLXsxhgBJo2SQLPZXLoUPWGIjgdKnE2RZ+GjkPXmgoZjgMi/+ygYyaoXtTShWITIMxB3aEDlBuI0zfSi4mE7n+05yzpUKYrn0kq4rIskJYXOcmIYRMlvSkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa0k67O+; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa0k67O+"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43169902057so57294435e9.0
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731509340; x=1732114140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vijvj4xzqqPmaYXRQOBLKldIjcr5W+v2zFbLza3mGXE=;
        b=Aa0k67O+PEVv/xgDCldMtk9YNrivjO4hAGiSwe5GTwLCFH2jEfAx29sYfOJ4Hi1JWT
         3V6i5t8OIo3DXYtnQYRaBsRWiq+Hx8aBz9oN5cnYhYImS4BwxzE9Z3lfvboZdA50cfqC
         yiQJWiYR3L9MgduN8+zKPT0D8aA5aM1LJ7zjzZBgY9YwSlztblE3JK+T3Hj7wJ+cmwpx
         RO7wuOjNkafsABriRdZTtGQKjHMWdsImAP6ceGRV+hUuSLnAF6kDbpGjpcwm6aMDng4K
         Dc4pg3MuY8Kfm56Uu2P8N4HD6xXX6p1EpZIXfsqOzlgY2+8Ufi4+2Im2E7pBMp+M5m61
         MLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509340; x=1732114140;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:reply-to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vijvj4xzqqPmaYXRQOBLKldIjcr5W+v2zFbLza3mGXE=;
        b=KCOh3RJgFAOF9wH6mYB3XpqSH8Q09ilJqAHnqicVf1HrSTZS2xqg+ejPFVx2Gf7H5/
         7FfQmLXvRyFQjrY4XcMde9eLjntdf2VJMy1912mSRg/COetKWbHNyBhb+z5XgjIYuMWJ
         esQc7BhjFo4dlXPrvSqno4scfT/abGlEBuJfwCmlWUD5fLyCgs3zit7z0YqO2YdebgL1
         it0SlRbtDNE0fNJt2+ti2ED+lPGm6UaspY6xKXEbqL2BTmSyvCFb4pKSAzRaLSQUqNuw
         K2TCdxziHrNRrqO6RnJYVi4H/xe1Rj+EIOiJsyXAqUwx5i6HkPgfFeQd6gTH18yMWlyG
         aulw==
X-Gm-Message-State: AOJu0Yz4xuACJIb955NMZIGB1MFjx91esx2NSv9x7kcLSUgxORLBr1Rk
	N2TAC8ex0bAcVFB/KfmIKaEV8c1BO44OmDKQRO1apOS+3DvHI8Ov
X-Google-Smtp-Source: AGHT+IFxDd9WNBaLsYVwxkLCX+z0++L1zLX3OQl8l1stdlnaKeJapZOVHsYehsmlCJL8NdL0H6pImg==
X-Received: by 2002:a05:600c:3b87:b0:431:6060:8b22 with SMTP id 5b1f17b1804b1-432cce7203fmr63831085e9.10.1731509340104;
        Wed, 13 Nov 2024 06:49:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54f6fa0sm27715405e9.11.2024.11.13.06.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:48:59 -0800 (PST)
Message-ID: <4c623fcf-01dd-4056-80c1-b3c860ab7f87@gmail.com>
Date: Wed, 13 Nov 2024 14:48:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Subject: Re: [PATCH v2 2/3] sequencer: comment `--reference` subject line
 properly
Reply-To: phillip.wood@dunelm.org.uk
To: Junio C Hamano <gitster@pobox.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 stolee@gmail.com, me@ttaylorr.com
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <cover.1731406513.git.code@khaugsbakk.name>
 <710c5b1a3f6bf8dc112ff13f27a8b2165274488d.1731406513.git.code@khaugsbakk.name>
 <xmqqbjyk2b70.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbjyk2b70.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/11/2024 01:07, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
> 
>> +test_expect_success 'git revert --reference with core.commentChar' '
>> +	test_when_finished "git reset --hard to-ident" &&
>> +	git checkout --detach to-ident &&
>> +	git -c core.commentChar=% revert \
>> +		--edit --reference HEAD &&
>> +	git log -1 --format=%B HEAD >actual &&
>> +	printf "This reverts commit $(git show -s \
>> + 		--pretty=reference HEAD^).\n\n" \
>> +		>expect &&
>> +	test_cmp expect actual
>> +'
> 
> I guess this fails by leaving the "# *** SAY WHY" in the resulting
> message, because the stripspace wants to see '%' to start commented
> out lines to be stripped?  If we inspect with this test what the
> temporary file we give to the editor looks like to make sure that
> '%' is used for commenting, that would be a more direct test, but
> without going that far, at least can we have a comment describing
> how this is expected to fail without the fix?

For me something like

	GIT_EDITOR="cat >actual" git -c core.commentChar=% revert \
		--edit --reference HEAD &&
	test_grep "^% \*\*\* SAY WHY WE ARE REVERTING THE COMMIT \*\*\*" \
		  actual

Would be a more convincing test as it actually checks that the user sees
the line that we expect strbuf_stripspace() to remove from the final
message. If we want to check the commit message as well that's fine but
I'm not sure its necessary. (if we do we should use test_commit_message
like patch 3)

Best Wishes

Phillip

