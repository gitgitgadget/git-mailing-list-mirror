Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F68F62
	for <git@vger.kernel.org>; Sun, 28 Jul 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722157893; cv=none; b=aQq1AOjUWWeyzJV9gmrJsgFc9OCIjeGytKA+rvZRFBWFoGw0VIjam/W+V57Z6nYXNHvYQNaA4vpyQoFPG0NGJ5+Z8S/AJy7Wi4rs1oJVO5zzz6kluoLxUqwQvlZ8wJfA94Ygo/ct3JHNQapLTwcg3Uv/jQdKcToQU0rV4vnZDzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722157893; c=relaxed/simple;
	bh=y9BxD6pxWAYZD4I3VNIAdO+/ESdWM0K61y8hFB2tA84=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VfDnr6y6fzze2Jtx9Hvew1uRFLm/YrzR/TcK06lu6OASbUifhJq+7emFwbPnv22LMxuTHcqOItPoe+ifY8IbWvgz89K1VeP7aAbrV4W4ul6J3p4JtRvB1V7dQ+aPd+JozfmBSlYv+sr3YDPVg3E/aBwaQdAPoR64vAqLg0XUHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APWnJLY+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APWnJLY+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso7400895e9.0
        for <git@vger.kernel.org>; Sun, 28 Jul 2024 02:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722157889; x=1722762689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y7+M525dKYIMBGrC/ny3mUATXhI8H0n6NzK31b+4mfs=;
        b=APWnJLY+xmjFdhV7XZRFPRc9VSIWUTsnVrJGzXZIno59lWKx6YckUQ32Q2Tb0CBrdh
         aPqZzi+IPScTVoeWzMvqaTBqXguJTR6nCxctd+Csl+q/D7ms5/51v7oTrr63CcEuQnO2
         U8GrpI2JXuzlsQHQQeUXXD5RHnc16J9Hlm4YvBzLLAg4AxKa0WhlLN1BvYFLVe/S9dU1
         5YLOdCWR+aW+eSg+4t/826JS4n7+Ep8RpRseWR7aX9k1Gl5NqsGTv0vNbCR0sv/NVTTc
         bfgtrt6Rt/9YfGiM4+ymOyao9nWGNTnS55MTP4y0oDo3zWRp6Zs51WqB+PEloexLd2ZN
         5bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722157889; x=1722762689;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7+M525dKYIMBGrC/ny3mUATXhI8H0n6NzK31b+4mfs=;
        b=vrCC/4qG1se39qLu7gQcYq4PUW9trjqFY3kEdKZ0WsXz8zQTrZ+jWnk+EpMv7RgbCS
         1YKfz8EuBHbuyxWrJUooEwNKuTjdxOAT+L0PHJOu1s5OtkseeW74GZ4mz79Uxp0kHfyX
         TbAGZWMD4WcPfz7h5K/xksqTe5mKo7ztjd1SGLxPccWxcCAODXpiAHNWbyxHxK9l48Qh
         hgsnBZPnkmIb7UZfLVruocQWs9bqjBWS++2a05pQ1uaexJpOSpSDnp0DgSIdx08IqFtG
         Lk7CYIoWzrNrh+fAxfyVmgzbbAc1mc7XtwoaOF0IVY01a/BJaM7/Rfd4BwwfTmjZcGOI
         KUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMGL0NZKoMi8NKmy9+dTERFo+h7eJf7t2aKhRvCfREMWjlA530O+Jw0S9kQRxpyScgATxwY+KYaqd4dZc3zctO2+lW
X-Gm-Message-State: AOJu0YyK560FKVARIX4ekT1xkKEn9l4NYuGAVpELjUZ9q31Y8JI2OL4u
	+r5+PPBAlHyKAkoVSY4PW2MNfD3mWcIO6YNs1d+sYJicJgiwRI5m
X-Google-Smtp-Source: AGHT+IE3u9EP6jYsK5EUaSeTu0f1rubpJ81z2tXJSQLhzO7omOxRhYVLF82cryxARu3KkB6GgZtgIg==
X-Received: by 2002:a05:600c:3b1f:b0:426:5416:67de with SMTP id 5b1f17b1804b1-42811dd4862mr25577035e9.30.1722157889095;
        Sun, 28 Jul 2024 02:11:29 -0700 (PDT)
Received: from gmail.com (144.red-88-14-42.dynamicip.rima-tde.net. [88.14.42.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862549sm9327398f8f.106.2024.07.28.02.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 02:11:28 -0700 (PDT)
Message-ID: <9e9bbff4-e2e1-4867-8f17-ebc366c7bec5@gmail.com>
Date: Sun, 28 Jul 2024 11:11:27 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
 <62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
 <2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
 <5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
 <a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
 <97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com> <xmqqcyn1lcjo.fsf@gitster.g>
 <24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com> <xmqqsevwui31.fsf@gitster.g>
 <1dc4cb5d-966a-402f-a880-42280750b949@gmail.com> <xmqqle1oszn1.fsf@gitster.g>
 <9f4c596b-cd6c-4f0c-bed4-dd6febb5e697@gmail.com>
Content-Language: en-US
In-Reply-To: <9f4c596b-cd6c-4f0c-bed4-dd6febb5e697@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jul 27, 2024 at 04:33:11PM +0200, Rubén Justo wrote:

> Fixing a problematic change with a new commit isn't the best idea if
> we have the opportunity to prevent the problem in the first place, as
> Phillip pointed out.  Since rj/add-p-pager is still open, it's
> worthwhile to amend the problematic commit.
> 
> Of course, we've now updated the documentation [*1*] and reinforced
> [*2*] the mechanisms to prevent this from happening again.
> 
> However, I think adding a comment about the issue to the amended
> commit, which I think it has been suggested at some point, seems to me
> like a good addition.  I do not believe that a future reading of the
> change will lead to confusion for this reason.  The added comment does
> not document a fix, I think, but rather it is an explanation of what
> we're doing in the commit.
> 
> Furthermore, we capture in the history, IMHO, notes of how things have
> happened, which is also why I intend to apply this series on
> 506f457e489b2097e2d4fc5ceffd6e242502b2bd, to only amend the last two
> commits.
>
>  1.- jc/doc-one-shot-export-with-shell-func
> 
>  2.- es/shell-check-updates

After re-reading the series today, I still believe the change in the
message for [2/2] or rebasing on 506f457e48, add value to the series,
but I also see that it's not a significant improvement.  Besides that
minor detail, IMHO, I think we have consensus on the changes.

I'm not going to send a new iteration, not because I'm against
changing the message, but because I think we are entering, if we
aren't already, the realm of bikeshedding.  

Once the changes settle, I'll send a new series to address the new
"|[cmd]" command.

For reference, this was the first message about the 'P' command:
1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com.  After all, I was only
interested in reviewing hunks longer that one screen height ;)

Thanks, all.
