Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD313CA9C
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395315; cv=none; b=Fcd0CZqdomrwMQRKms8alAHjHU+cjuVBQGY2VK1tFN8czdheqiQpxZ0F33uYX993jS4fnyR0FUWTITpK8E5ayIq4/46JQvJ8EOx2UzrbjHuXfkTKmdFRjfU9hTEwyDIxlqnU8jwR9ZsmYc9sEnrw0L29wApK7cL36/qFEyLSIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395315; c=relaxed/simple;
	bh=pRZMtt6IH3CflRgRdUX/xskS+rTs7SkQlmL8HikT7Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/wYVyiHWWU9TqBmX4y+/943bPgTJ6XS+IlabDhTBsQgtvzeTcszGCOQH9JaVDyihyrVIqJ20VT7IgNb/ZewRAwwrIAPZxekg7DikpQOffKC2HA//680zRXX0tuSZ29HPDkSqH03LgpE5eDt0CNSBP1iQWKfFeGSdrxKsRrNBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjTPQpFF; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjTPQpFF"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d93f9c793fso1054247b6e.0
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 06:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721395313; x=1722000113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ny+r3yRk//ML/m+6gKf+2tssYYBki+b9AeK40mwcVbk=;
        b=PjTPQpFF+yWuxm38uWdaUXznK1JJ4ahvsyyFKcKjvVXdZAEBxF4QAkwv5Ul6hxihsj
         9BY0mrXre3gdplaj85zE3p18l3vxxHV9/NIEnC8VlFgWNM4THrqV/NN4ofSyYc2WgXhX
         rwGevE24+yYbg+kEfMXdxMzL4IDblvoRmXu+XtLSNVhQJPUixiBd6PuNYoc5x1EMgwvZ
         /hpDCrguH7kaypxP/oCyTycoh3zatjVDQ6YmHayi0xdsAKoYJDdFjB1LORk6GY/5uSNz
         2sNr/ClAqgWHbfVZTgt1QVJ0Viml5qkhcJ8nXKaODUhyRhGJPJPQVbs+QBbgkkiTHIMn
         yuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721395313; x=1722000113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ny+r3yRk//ML/m+6gKf+2tssYYBki+b9AeK40mwcVbk=;
        b=mG5Muh3rwfsHGbqnmu5B3FhjOoDkWYuDrwBWhRsXnjApg5mNbYxruWS/h2KXtAIG6q
         zdmpRTRdQ4inipo9ihyTsJgY0lBrpILfegef/ffuM1yzhzgImZNrOXRM115VQhaj24Cu
         wFSZvc5ujbl7nFuY03OLqxo1nRaoZ6Cqa2rsw0EVpFH9n3IWn5FQQOdeGhEainYBwsCn
         kBmEcWJKMhWoxNp6WjIONLgxFIIPWWwJWZWxleTDRrToQZD1js0qhJ4WhuFWXUuGacgI
         zDpGIpI+LoLOLLfBMNKZDeUWCHr7v7/PphGEjsgiK0gVsR/Qmj7ekwBBwYhnTu9mwPWQ
         474w==
X-Gm-Message-State: AOJu0YxJY9gQfas7B/5ey3i90BizhczMP6HsUN1oeh7XaZ2atq/Dvkbt
	+jREiMqGOYOE0cg++j2GiDPz01g5ZykhaS+IwS6L3W7q/5ketTi8
X-Google-Smtp-Source: AGHT+IHnZmZOwFko6WskugnzKgJ7KZtUUGwV3xrbTcKE21JKZerh/EICUaKx9TyXhT3rLxWLbI0gdg==
X-Received: by 2002:a05:6808:bc1:b0:3d9:243a:7b02 with SMTP id 5614622812f47-3dad1f8bbcbmr9694478b6e.40.1721395312726;
        Fri, 19 Jul 2024 06:21:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:2173:6d19:3a2d:9c4d? ([2600:1700:60ba:9810:2173:6d19:3a2d:9c4d])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3dae09d5fa7sm272259b6e.48.2024.07.19.06.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 06:21:52 -0700 (PDT)
Message-ID: <118b164e-67c5-4dfc-b440-62b8986bf356@gmail.com>
Date: Fri, 19 Jul 2024 09:21:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
 <ZpmcK23coi5Qqm7E@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ZpmcK23coi5Qqm7E@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/24 6:50 PM, Taylor Blau wrote:
> On Thu, Jul 18, 2024 at 07:55:44PM +0000, Derrick Stolee via GitGitGadget wrote:
>> The issue is that 'git multi-pack-index repack' was taught to call 'git
>> pack-objects' with the new '--stdin-packs' option. However, this changes the
>> object selection algorithm. Instead of using the objects referenced by the
>> multi-pack-index, it compares pack-files using a list of "included" and
>> "excluded" pack-files. This loses some granularity of how the
>> multi-pack-index chooses among duplicate objects.
> 
> Thank you for looking at this so carefully! Let me double check my own
> understanding.
> 
> Suppose we have a MIDX with some pack 'P' and say, some commit object
> 'C' which appears in that pack. Let's also suppose we have another pack
> 'Q' in the same MIDX which also contains 'C', but the MIDX selected its
> copy from pack 'P'.
> 
> If we want to combine 'P' with some other packs (excluding 'Q'), then
> the input to --stdin-packs will look something like:
> 
>      P.pack
>      ^Q.pack
>      ...
> 
> And the resulting pack would not contain 'C', since we would reject it
> via: add_object_entry_from_pack() -> want_object_in_pack() ->
> want_found_object() -> has_object_kept_pack(). The final function there
> would find a copy of 'C' in 'Q', and since 'Q' is excluded, we would
> reject 'C' as unwanted.
> 
> So the resulting pack would not contain 'C', and the MIDX would hold
> onto its copy from pack 'P', resulting in 'P' being both (a) in the set
> of packs to repack together, but also (b) non-expireable, since it has
> at least one object selected from it in the MIDX.
> 
>> The end result is that some objects that would normally have been included
>> in the new pack-file are no longer included. The copy that the
>> multi-pack-index references is in the pack-file that was intended to be
>> repacked, so that pack-file cannot be expired in the next 'git
>> multi-pack-index expire' step and is included again in the batch of objects
>> to repack.
> 
> I think this matches my own understanding, but let me know if I'm
> missing something. Assuming I'm thinking about this the same way you
> are, the fix (stop using --stdin-packss) makes sense to me.

Your interpretation matches mine. Thanks for the careful read.

I think we can accomplish similar goals that match the reasoning for
--stdin-packs (better deltas while also limiting the object walk to the 
repacked objects) with some changes to read_object_list_from_stdin(),
but that's a more subtle kind of change.

Taking this change as-is will cause a regression in the quality of
delta choices, but recovers our ability to expire "repacked" pack-files
in all cases.

Thanks,
-Stolee
