Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4741BD03C
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231864; cv=none; b=SNfGgAu+9yIlQo3bgCcJnK0YP67wVL6I2s+3uxmRS878xGL6dEp96gB/J6YoJjHmpYKLsvzFlxYGpUi6ohmbatRQ++EW5CP0gffaNQJ5DJjClZHDfTapgzQ5f4gf7DUG0NGzNbNFhXg4noQKt2elTt2TvO8xRGkFl73OSPu85Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231864; c=relaxed/simple;
	bh=tBrG7YKpAlKH5RXgQdFfEVtZ3HpZKrbM8yOhIflgmGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCh1brW/HlpQHAXYOlWo3yXalJluDrGuxxc4DHd9ipg7Rsp3aJGYEtDcizniG181VHZa0XKEKyXMrYkG4JuHdnqXOmWeZYnlelUDBasBa2WZuROYZVoBSz2ref3thZoO4n2srvk/nSFAJI/1yA9gX0CMpaR/CaXYHQ8CJIdc4b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXAUrJ5u; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXAUrJ5u"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso1514912b3a.1
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732231862; x=1732836662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=guD3UN2O1NS9aFHq+UTCu4QnjtHwc1Wx314I5G1WZHs=;
        b=UXAUrJ5uOfCHWlT+alZM6ZtoKSn6GV+yHqJsO3A6Ll4bHkVa28AdR5TbV7YIv8Xvy4
         b45m3ihf7zyo8FUzfC94385SEQ76j/8q8tPKExHgwnbKPEZMwWNqpjJNIEld5q55uApn
         BmwcFugBc+w8UJ68DJfAj2n1NhFLT62k1rRWhwZTikPKhDUHJKnNwxepwJC58fIht2Gk
         kf4jBWfRTMdBH53H5Q+HwYQGHvkVw0zD850PvUbalV1BSPyEHteyFCaP9n99HZQ3wI1v
         0Np8rwobbzKw/0miQwwD6B0hyBljaOnF3bw51Idj6CsLaZRDYjQ7sTifp2bGDeCFIeQv
         CK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231862; x=1732836662;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=guD3UN2O1NS9aFHq+UTCu4QnjtHwc1Wx314I5G1WZHs=;
        b=Pet6hIMGZtcmSP54ZYX/Lo+udYf2eFCxJH7apEd7bnE7siEXtCi8p/eoWwgSomKGeP
         dIc24X8yQ1DlRO4Nr5+O1zvWw+xo3qC/Vy8BDYHFo8U7GQCwh7icNtydat+SPc2mxmHc
         Aygv/pjZWqJKlThBvA3QyVs38sz1xdoWNT/myQxb1QHSKHlQ3fC0Xi2mSQRaIvTlu4Lz
         n1+lEwzdxptWZ0lRVd5zgZ3vHvd4B+p3CTbXsIZwszHEV34wtslLNCIpTjBvKFkgslr6
         cWbju11G1nvq9MPIQ7bNk/s1DvD6Lgup5uRSqQot89sf7ulpZ5SkW8yt6HmL3cW/08/a
         mjbA==
X-Gm-Message-State: AOJu0YyCPUq/XjslOG/hJHbCg0ZhBMmmVibGQ1eUSLIovx40x64YNeLS
	4BJmxtWbLCBOswkPoamsizHruxnyr5MQ8hzCnts9cIy/WikTXfTE
X-Gm-Gg: ASbGnctARlDw97X8uu0IQ4qyDz+2ytD+dr8CL46FxMnuX4BLPpkWDboUjQ4IZMliSWn
	fqrXZiEbkgXM0d2+Xx/DfiwCSuqt9TdqGPCsSe1ObIdL59VGk3pgwO2EzOPw7iL8MxNj+UQyBIp
	wYRcpMGG7M+HIs7bYesz2slOlVaNcf3nP6ITpohnYIO5WWPblkVfF4vKUn/+VVI4FAIZNw4QGaK
	vQ8kL3shzP/vHZhKxWDBdfRyLBogPwfoXPZKzEGtxy1J4xJjX7tbCn8JbwdP24Cp0wP7oIJWAq5
	Zqd3NXaSUuzsDz4jL92b8w3S
X-Google-Smtp-Source: AGHT+IHzp9pcWAc8JIVhjIu2LG08wERGUdmtAXELtjBjDn9XnG9HTUGbo5qODKKJJ4YlJvqGqoaa3w==
X-Received: by 2002:a05:6a00:181f:b0:71e:5150:61d6 with SMTP id d2e1a72fcca58-724df6f8b9amr1254777b3a.21.1732231862211;
        Thu, 21 Nov 2024 15:31:02 -0800 (PST)
Received: from ?IPV6:2601:647:5580:5760:6abc:dd4c:e68f:b83a? ([2601:647:5580:5760:6abc:dd4c:e68f:b83a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532d19sm321241b3a.117.2024.11.21.15.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:31:01 -0800 (PST)
Message-ID: <470fe577-b26d-4393-8fa6-8f73ca4302de@gmail.com>
Date: Thu, 21 Nov 2024 15:31:00 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: Long names for `git log -S` and `git log -G`
Content-Language: en-US
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <24458598-ebbe-41fc-8517-457fa65ed481@gmail.com>
 <xmqqo72bev71.fsf@gitster.g> <20241119185817.GC15723@coredump.intra.peff.net>
From: Illia Bobyr <illia.bobyr@gmail.com>
In-Reply-To: <20241119185817.GC15723@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/24 19:52, Junio C Hamano wrote:
>> `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
> That is probably OK (even though "-G" is not exactly what the
> pickaxe machinery wants to do; "--grep-in-patch" might be closer to
> the intent).
Imagining, that I am starting from scratch for this functionality, I think I
would also consider "patch".  Though, as we have 4 related argument names, I
wonder if using it as a prefix would create a more consistent UX.

Something like:

"--patch-grep" for "-G"
"--patch-modifies" for "-S"
"--patch-search-show-all"/"--patch-show-all" for "--pickaxe-all"
"--patch-search-regex"/"--patch-regex" for "--pickaxe-regex"

I'm not too sure about the later two, and also they already have long names.
But it seems quite easy to understand what this command would do:

   git log --patch-grep sometext ...

Or this

   git log --patch-modifies function_call --patch-search-regex ...

>> Not sure what would be a reasonably short alternative for `-S`.
>> `--pickaxe-occurance-change` seems too long, and might not be as clear.
>> `--pickaxe-occurance-count-change` is just way too long.
> Giving a tool a meaningful name is an excellent idea.  If the
> meaningful name guides users to the right way to use the tool,
> it would be ideal.  Which means that to name it right, you'd need to
> know what it exactly is for.

Glad we are on the same page here :)
I would really appreciate yours and Jeff input.
I wrote a simple patch to see how much work is it to add long names [1].
But I would change it based on whatever names are agreed upon.

[1]: 
https://lore.kernel.org/git/20241119032755.3360365-1-illia.bobyr@gmail.com/

> The -S feature was written to become one of the building blocks of
> Linus's "clearly superior algorithm", described in [1].  Linus talks
> about "where did this _line_ come from?", but the algorithm is more
> generally about a block of code.  The expected use case is for -S to
> be fed sufficiently unique block of text so that we can efficiently
> detect the transition of occurence count from 1 (because wee start
> from sufficiently unique block of code) down to 0 (which is the
> boundary in history where the block of code was first introduced in
> its current form).  It detects any occurence count change, but its
> primary focus is to find a transition from 1 to 0 (when going
> backwards in history).  Its spirit is more about "finding where it
> appeared in its current shape".
>
>
> [Footnote]
>
> *1* https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/

This is pretty interesting.  Thank you for pointing it out.  I guess, it 
means
that the "counting" in the porposed long name of "-S" arguments is more 
of an
implementation detail than the actually intended functionality.  Do you 
think
there is a word that better reflects the intent here? "--patch-modifies" is
probably also not really hitting it 100%.

On 11/19/24 10:58, Jeff King wrote:
> On Tue, Nov 19, 2024 at 12:52:50PM +0900, Junio C Hamano wrote:
>>> `--pickaxe-grep` for `-G` seems like a reasonable alternative name for `-G`.
>> That is probably OK (even though "-G" is not exactly what the
>> pickaxe machinery wants to do; "--grep-in-patch" might be closer to
>> the intent).
> FWIW, I like --grep-in-patch. Saying just "--pickaxe-grep" does not
> highlight that it is about looking in the patch. I.e., it is not clear
> from the name that is different from "-Sfoo --pickaxe-regex".

I agree.  Do you think "--patch-grep" is a better name?  Or do you think 
that
the grep and the occurrence counting functionality should not share a common
prefix, as they are somewhat different in nature?

"git log" docs talk about both "-S" and "-G" as if they are pretty 
close.  There
is a note in "git diffcore" doc, "diff-pickaxe" section that says that 
grep is
actually quite different.  I wonder if this is important for the users 
to think
about.  I often use "-G" followed by "-S" or the other way around, just 
to see
which view is better for my particular problem.

