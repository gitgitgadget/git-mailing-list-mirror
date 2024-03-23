Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D2959157
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711231181; cv=none; b=SbT3msnP/iJTJDhp2PDrEWquJMBLigl1GCyae5VBtUZ62WyINDvUKg/T3O/uVwXbZwznL3MTbTOEg3nWztIgTd5mDtDI7Eq4C/hffo+bIzio9/9fq6Tn2fx4oxb5Fa1+1nMMc6kKMZbwjfVICMgKHKP6VwhdI/MnMfxR8RtPr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711231181; c=relaxed/simple;
	bh=QVTKLDTKaGOjhEqXdizqaUPtvvQr80FkGPodoOheaoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq/eTJ2o6tzrt0NRx55ho4XT68CXlj2U8GKWiFa7Z7mAiVWLkHt1o8SG87MAGIOjxonjJ8HbSzo6pnu71B087UidVcdcVJEu0bCZOVCC0sPu86U6uv4hOMRR2t7ynWLprkaAF0izdQ6/rbMzkpo+9b9YJQyQSFFLt5M6IAZucQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+0DE2l1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+0DE2l1"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e036b76725so23880385ad.1
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711231179; x=1711835979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sa+PoKs9vpvP3rS02dZ2H7tq+1SsBoEiy+Gklrv7zTQ=;
        b=r+0DE2l1f6wo1dER/xnRhfGD1yjeZA716w9SFtCh+NXiGUuxcHmLQoClxcLLuXaG7Z
         cwaeRSoB5B68q+TpY8XF8i3/Xk6e17d2/Sl9k0DAx7XKvvtSUsNz4tV2ELIeQ+8GG7Qn
         liyFgBnmRb1NiRhnErc5d7Z5iA9WlGAv01BlpjeZKR9jUat86c7fNptTXWBiGIDfpaUs
         6JHGsDiYEhERvuaithkf8xd1VqSh4AGLX9Gkww70vskasziN8olT7I9Hn68I7YtkTm7l
         oUcukhJAMR5T0dO0HUa5HbbkBA0jafZMTPqVr84V6nltCKCukYOplR0Y2zCP7pPPtnVl
         rP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711231179; x=1711835979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sa+PoKs9vpvP3rS02dZ2H7tq+1SsBoEiy+Gklrv7zTQ=;
        b=h1of2HZfcsvutaX0LpyitBP7w75XYeYZjd8HBZy7GHrs6RXCt4wqoLndkeAPCVkmxZ
         32Tou90BVWTgoPU5oD636Ux7lombbH+CGoTGelY3JmSXg/qGGADm9GvrziGeYXrxgEwi
         b9+KzC4KCDX5hxTwQHW5+lGyFdzGr0W7/7z5X4/ibJIs6XnjDt8g23xA9i09SYilF/l5
         HyPa1I3W4Nvsq5bvQsliY3AUmY0SPkiZR1zjAo5vAtnHfBmXAQHykwDgtH+GnLSYN8Op
         Mzw1QBIClDnpap1eomBWDFSTG5V3B8H6/dBJ7vJ0Eiq5AhSx1DK9Q4nPgk+CVkRIel6D
         T9rw==
X-Gm-Message-State: AOJu0YzbK1PazkuvC73LHk2AxhohWKxdMOlBAuxCSGiiAyV53++N8ywG
	SuIKcz3LZ0K0foI/p5XUepiWZcYF8gC2w2Ya0CoTIX2ByGK2jju978ZtEdyvrTDSP52p9noJOQz
	SSg==
X-Google-Smtp-Source: AGHT+IE2HdA4rizeLs/QpmM/6hUgIUY4PqzwRFiVnFynHl+qem9U9TRgszYJJOtcHIrBmViw1tEzUg==
X-Received: by 2002:a17:903:120d:b0:1de:f95a:2677 with SMTP id l13-20020a170903120d00b001def95a2677mr4043622plh.52.1711231178904;
        Sat, 23 Mar 2024 14:59:38 -0700 (PDT)
Received: from google.com (144.44.83.34.bc.googleusercontent.com. [34.83.44.144])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001def1ad9321sm2016114plh.252.2024.03.23.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 14:59:38 -0700 (PDT)
Date: Sat, 23 Mar 2024 14:59:35 -0700
From: Kyle Lippincott <spectral@google.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
Message-ID: <jikdly5drampltlvxuex67iz77isgt7uqcnf45ocmrozgbhyaq@2g7kucs2ordg>
References: <cover.1710840596.git.dirk@gouders.net>
 <33a18458891259565e553ab39301108ce642d02f.1710840596.git.dirk@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33a18458891259565e553ab39301108ce642d02f.1710840596.git.dirk@gouders.net>

On Tue, Mar 19, 2024 at 12:23:14PM +0100, Dirk Gouders wrote:
> Before the changes to count omitted objects, the function
> traverse_commit_list() was used and its call cannot be changed to pass
> a pointer to an oidset to record omitted objects.
> 
> Fix the text to clarify that we now use another traversal function to
> be able to pass the pointer to the introduced oidset.
> 
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> index a06c712e46..981dbf917b 100644
> --- a/Documentation/MyFirstObjectWalk.txt
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
>  === Counting Omitted Objects
>  
>  We also have the capability to enumerate all objects which were omitted by a
> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
> -object walk does not perform any better than an unfiltered object walk; all
> -reachable objects are walked in order to populate the list.
> +filter, like with `git log --filter=<spec> --filter-print-omitted`. We
> +can ask `traverse_commit_list_filtered()` to populate the `omitted`
> +list which means that our object walk does not perform any better than
> +an unfiltered object walk; all reachable objects are walked in order
> +to populate the list.

The way the original was phrased makes it sound to me like "Doing <stuff> via
<mechanismA> is potentially slow.", and I expect a counter-proposal of using
mechanismB to resolve that. The rewrite partially avoids that, but I think could
take it further to really drive home that this is a consequence of using this
new function, and is not a failing we will be proposing a solution for:

 We can ask `traverse_commit_list_filtered()` to populate the `omitted` list.
+Note that this means that our object walk will not perform any better than
 an unfiltered object walk; all reachable objects are walked in order
 to populate the list.

Since that first sentence is now shorter, we could also add a bit more nuance to
it, calling out that we're going to switch which function we're using earlier
(and technically redundantly, but I think that's fine); something like the
following:

 We also have the capability to enumerate all objects which were omitted by a
-filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
+filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
+change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
+able to populate an `omitted` list. Note that this means that our object walk
+will not perform any better than an unfiltered object walk; all reachable
+objects are walked in order to populate the list.

Feel free to wordsmith any of my proposed text, and I apologize that these are
just me typing in something that looks "patch like" in my mail client, not
properly formatted patches. I think what you have is already an improvement,
though, so if you think my proposed text is too verbose, I'm fine with what you
have.

>  
>  First, add the `struct oidset` and related items we will use to iterate it:
>  
> @@ -778,8 +779,9 @@ static void walken_object_walk(
>  	...
>  ----
>  
> -Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
> -object:
> +You need to replace the call to `traverse_commit_list()` to

If my proposal to introduce the point that we're switching which function we use
in the earlier diff hunk is accepted, there's a small nit here: saying "You need
to" would feel (very slightly) awkward, since we already mentioned that it was
necessary to accomplish the goal. If we accept the previous proposal, we may
want to change this to remove the "You need to", and just state something like
"Replace the call..."

Regardless, I think saying "replace the call to A _with_ B" (instead of "A _to_
B") reads slightly better. I don't know if that's just a personal
preference/dialect though.

> +`traverse_commit_list_filtered()` to be able to pass a pointer to the

If we remove the "You need to", then we should probably rephrase this to more
of an instruction, changing "to be able to" to "and".

Something like this:

-Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
-object:
+Replace the call to `traverse_commit_list()` with
+`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
+defined and initialized above:

> +oidset defined and initialized above:
>  
>  ----
>  	...
> -- 
> 2.43.0
> 
> 
