Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA63314DB
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401007; cv=none; b=tzWuU/bVevQFnlWkZp3/w1L34uEn7CRmpc5MFohh/vh5+caClCzzor56r1+49TPfaJtGlmYQfniU7L6ljlV+ICglejRXBLEfSoM2w061nh/PFevxuceONc1yY9MnGu42uRA/yAVbheoYhT2FNnHfH1NUkL9EtcYzA3ZzcWBWFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401007; c=relaxed/simple;
	bh=PYsH9wqxEzhDb8Csk66LiI6/xWTnB1vNfqR+NYq172U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUStv4hHOf3ROJDcYXlBzz/8ZuD6aGGgK9ccBuoMCKYW4l6Gn25NyQvtKN4PdXWFUUngG0FZjB0TcKO4ah0IIB4OmfaJPjZYBSRhR5smdurQNDj7ipWaB1bs+Ph+QOR/E6arFtCgInPt8ifEea6HN8loqA6hpiwXmpWuu8uUwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbNC1342; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbNC1342"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3ee6485e7d7so11696915ab.3
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756401005; x=1757005805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7gVfK/YJZxAsBVLWd1vgitIk0gau1j+Jg6oIb5n4SvU=;
        b=BbNC1342o42ta1RmoNeFOsBmBJKq2/a+DHG2WvrPAvz4UR2GBGyQMIlpAF5hOX3Z70
         EpRygmao0ZwwgYYcW5Y13Y7O1yZhCr8N/dYXDg/aruPugKkuRwuQKeTEBM3ET4gZU4rS
         T1aNQIoNcI6xiICDj8DD3Q6Rrh/S1hfniNiOcShfGuDPHqVC2E1sXJGiyb7h97HiNMSq
         4lgtLmjV6DaH08X/713A/xyt3q/NOJ0D7X0xcR4yg2sUHgfcov7q/BAPNIM4UACHIyKE
         hTOB+ble62KUYD/vsJgq5edliLYWfRe7BBStjlJ8sDmzr3EZic4XPMvGiK174c35BFLi
         wNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756401005; x=1757005805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gVfK/YJZxAsBVLWd1vgitIk0gau1j+Jg6oIb5n4SvU=;
        b=lQgB8gbwAlv9aXZ2d7mulTiHkMkchxOgTNKBQIx5Fe0tDH+wgqW5E+OMNpm/7pBJqE
         RuoD70zlJxRWxAz7W0V/wgPpGTJ/SRsT8eg8vej2c0k0hPVh+3ClO1KpMy08N1yzwr/y
         /E7RN/aonlVQzlgeKUjwMMDPSEetcEXg8tDmQnTL6m8nJyayQljC+5D6XQi/wAFST8tj
         yYxnBmqVVlwHc16J21wQCoJ+MQL6O44uHWBd/sj7cT9vqNO9Jbckcg2/zoWQtv6GxStt
         34YkHcXC4B6Rb8K8cdHhx5P02neBv+lj4UbyTN9VL06Ta8UDJyDT1vqUeFc1EMh3Em1u
         xyMA==
X-Gm-Message-State: AOJu0YwqYviZvQrmiM9wPGhcykh3az6sJW45AE6/JYSZ0eR/1H/IMMya
	BHgqkeWrNVaErw2NOHR3jcB4DXOThQPSFn4VqVF5zHRWGgJONAqGhHMMas6/VxHkr18AiB/OqII
	orI1XrVKYv5ODPmfKOAFW2PNszPUkWtWZ8YmF2y0oWzrq
X-Gm-Gg: ASbGncsvxSlsr6v/pquEFChR7FIfFoLlnh04cS/XR2+STsFVf0R0CSg4IvwE9CTwYR3
	6itTob36mIqCeUPkQ1mF3TmdRo2vCznob7rNyrIO+gLuw27vlj95pf5XBrq9/KOfYwpYL6MHxV8
	zk5b6XZhfx0JWo4yC/KX0IkXNJqu+5mXHN+GxqZVQ5BxV6AKp4DKGj55uSoegXsOvoQWxPb5tr1
	qwQFd8Uhq8wo6G4PYbn+sY3tlD7wvKyrDpUGJosc8xcLhe4hQ==
X-Google-Smtp-Source: AGHT+IHdeiouvdYBBevt+FwXiL8YL6GZ+54bEGjFtP8D3FX3vJarFKqaMo9QD6IvClKeRK1T5uv3NErq2GU0yVdG+a4=
X-Received: by 2002:a05:6e02:2184:b0:3eb:2708:3b8 with SMTP id
 e9e14a558f8ab-3eb27080780mr305886995ab.19.1756401004643; Thu, 28 Aug 2025
 10:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADR1ei4LFVoLhMyya+wx8dXBmrRNSNy6L5Ye_MJgL4kzgtVR_A@mail.gmail.com>
 <xmqqy0r3v0jz.fsf@gitster.g>
In-Reply-To: <xmqqy0r3v0jz.fsf@gitster.g>
From: Daniele Sassoli <danielesassoli@gmail.com>
Date: Thu, 28 Aug 2025 19:09:53 +0200
X-Gm-Features: Ac12FXxCWc31_EnVAg6bOhsVblcedD5JDP5_6O6MvbpPSEs0ZbVhkN2TGeoBUnY
Message-ID: <CADR1ei41b6oNONF1GPiWMm+LdwbV7_2K=vBy1b30OrqpyfMbvQ@mail.gmail.com>
Subject: Re: question: what does "garbage" field in "git count-objects -v"
 represent? Is it broken?
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 19:05, Junio C Hamano <gitster@pobox.com> wrote:
>
> Daniele Sassoli <danielesassoli@gmail.com> writes:
>
> > When reading the output `git count-objects -v` there is a `garbage` field. At
> > first I thought this would highlight objects that are considered "garbage", i.e.
> > could be garbage collected. However, I kept noticing that this wasn't the case,
> > despite my repository having plenty of dangling objects (that where removed once
> > I run `git gc --prune=now`), garbage kept being 0.
>
> count-objects is about quick housekeeping stats and does not (and
> should never) analyze reachability like fsck does, which is required
> to tell which objects are dangling.

Totally agree with this.

>
> > I then turned to reading the docs, which state:
> > garbage: the number of files in the object database that are neither
> > valid loose objects nor valid packs
> >
> > I don't think I've ever seen a definition of an invalid object?
> > I tried adding random chars to an object, effectively corrupting
> > the repository(which `git fsck` correctly picked up), but
> > count-objects kept returning 0 at the garbage field.
>
> count-objects is about quick housekeeping stats and does not (and
> should never) analyze object contents like fsck does, which is
> required to tell which objects are corrupt.
>
> > The only way I've been able to get count-objects to report some garbage is by
> > creating files in the packs directory (or in any of the sub-directories of
> > `objects` folder) with random names, like "test", or sometimes I've seen it
> > report the existence of lock files or even preserved files.
> >
> > So my question is, am I fundamentally misunderstanding what garbage means, are
> > the docs simply unclear or is the functionality not working as expected?
> >
> > Thanks for taking the time to read this and respond.
> > Dani
>
> You are fundamentally understanding correctly.  The command tells
> you it found a garbage when you do this:
>
>     $ mkdir -p .git/objects/00 && >.git/objects/00/tmp-garbage
>     $ git count-objects -v
>     warning: garbage found: .git/objects/00/tmp-garbage
>
Do you both agree that the term garbage is somewhat misleading? I've spoken
about this both on Discord[1] and in person at the recent Git Mini Summit, and
both times people expected to see garbage-collectable objects being reported by
this field (which, as Junio says, wouldn't be correct, but that's what people
think of).
Other users also seem to be confused by this as shown by [2].

At the very least, I believe the documentation could do with some clarification
and maybe we should even look at changing the wording of the field.
I wanted to triple check my understand was correct before submitting a patch.

Thanks for your feedback.

[1]https://discord.com/channels/1042895022950994071/1156706741875130499/1408738703156973640
[2]https://stackoverflow.com/questions/30999879/git-garbage-size-out-of-control-need-understanding
