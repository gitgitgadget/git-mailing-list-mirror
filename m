Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4878523C
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711233983; cv=none; b=kEj+GqyFd//1qcXC6ly62rjvGFmSvqBiaNsEH68AMkUk4N/9OC9NGORzyJV0BlFiTUGqPVTjwCjSf0g2UzMR+vb8GlAIFv4u3LbsEXPKWGXHaUttLYxHLZchykM8pmKRtOoIC1XQI3Rn0h8nXzAw3Fdlavt3DEq6Z75y7D3AZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711233983; c=relaxed/simple;
	bh=f8Vr2Rr3J2J9dOzrxaPOxLMlBIvoU0ZYTQcbQgpgRkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KRMu0+FGx7kc1Y7bf3AKhNvTeuZO8JjKKo1ooHInLItVgLhBJ3XrVihXUtNv1ScMfngJYTQJ+4PPSfglyjYCWpeWUb+JyBCicXNFj033k67RVX7ybg5hAlfNsTBugqRhgXudqcdAY1oVeB4V8QjNxkVAGh/Ys2bWdGNFaLhWCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=dwYHw6al; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="dwYHw6al"
Received: from localhost (ip-109-42-177-242.web.vodafone.de [109.42.177.242])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 42NMk75V023338
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 23 Mar 2024 23:46:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1711233968; bh=f8Vr2Rr3J2J9dOzrxaPOxLMlBIvoU0ZYTQcbQgpgRkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=dwYHw6alJvFg8NdFNLgaagE6J86ECYLkA0t80ipguh7whOlUOz/1l545CPmxYbjPh
	 ciRQFslVjcvGAfehWNRSxwHs7ajrsGPgWpL5LPyy2vz3737S23bt0Dykoe0gkvtYJ2
	 MDQbJaQrzSGZboizSCX9MOtvwAxiK/nmwVlznYtI=
From: Dirk Gouders <dirk@gouders.net>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer
 <emilyshaffer@google.com>
Subject: Re: [PATCH v2 4/5] MyFirstObjectWalk: fix description for counting
 omitted objects
In-Reply-To: <jikdly5drampltlvxuex67iz77isgt7uqcnf45ocmrozgbhyaq@2g7kucs2ordg>
	(Kyle Lippincott's message of "Sat, 23 Mar 2024 14:59:35 -0700")
References: <cover.1710840596.git.dirk@gouders.net>
	<33a18458891259565e553ab39301108ce642d02f.1710840596.git.dirk@gouders.net>
	<jikdly5drampltlvxuex67iz77isgt7uqcnf45ocmrozgbhyaq@2g7kucs2ordg>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 23 Mar 2024 23:46:02 +0100
Message-ID: <gh8r28zhw5.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kyle Lippincott <spectral@google.com> writes:

> On Tue, Mar 19, 2024 at 12:23:14PM +0100, Dirk Gouders wrote:
>> Before the changes to count omitted objects, the function
>> traverse_commit_list() was used and its call cannot be changed to pass
>> a pointer to an oidset to record omitted objects.
>> 
>> Fix the text to clarify that we now use another traversal function to
>> be able to pass the pointer to the introduced oidset.
>> 
>> Signed-off-by: Dirk Gouders <dirk@gouders.net>
>> ---
>>  Documentation/MyFirstObjectWalk.txt | 14 ++++++++------
>>  1 file changed, 8 insertions(+), 6 deletions(-)
>> 
>> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
>> index a06c712e46..981dbf917b 100644
>> --- a/Documentation/MyFirstObjectWalk.txt
>> +++ b/Documentation/MyFirstObjectWalk.txt
>> @@ -754,10 +754,11 @@ points to the same tree object as its grandparent.)
>>  === Counting Omitted Objects
>>  
>>  We also have the capability to enumerate all objects which were omitted by a
>> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
>> -`traverse_commit_list_filtered()` to populate the `omitted` list means that our
>> -object walk does not perform any better than an unfiltered object walk; all
>> -reachable objects are walked in order to populate the list.
>> +filter, like with `git log --filter=<spec> --filter-print-omitted`. We
>> +can ask `traverse_commit_list_filtered()` to populate the `omitted`
>> +list which means that our object walk does not perform any better than
>> +an unfiltered object walk; all reachable objects are walked in order
>> +to populate the list.
>
> The way the original was phrased makes it sound to me like "Doing <stuff> via
> <mechanismA> is potentially slow.", and I expect a counter-proposal of using
> mechanismB to resolve that. The rewrite partially avoids that, but I think could
> take it further to really drive home that this is a consequence of using this
> new function, and is not a failing we will be proposing a solution for:

Yes, I had similar thoughts.

>  We can ask `traverse_commit_list_filtered()` to populate the `omitted` list.
> +Note that this means that our object walk will not perform any better than
>  an unfiltered object walk; all reachable objects are walked in order
>  to populate the list.
>
> Since that first sentence is now shorter, we could also add a bit more nuance to
> it, calling out that we're going to switch which function we're using earlier
> (and technically redundantly, but I think that's fine); something like the
> following:
>
>  We also have the capability to enumerate all objects which were omitted by a
> -filter, like with `git log --filter=<spec> --filter-print-omitted`. Asking
> +filter, like with `git log --filter=<spec> --filter-print-omitted`. To do this,
> +change `traverse_commit_list()` to `traverse_commit_list_filtered()`, which is
> +able to populate an `omitted` list. Note that this means that our object walk
> +will not perform any better than an unfiltered object walk; all reachable
> +objects are walked in order to populate the list.
>
> Feel free to wordsmith any of my proposed text, and I apologize that these are
> just me typing in something that looks "patch like" in my mail client, not
> properly formatted patches. I think what you have is already an improvement,
> though, so if you think my proposed text is too verbose, I'm fine with what you
> have.

Thank you for your suggestion.  To me, this fits much better and I will
use it should no further improvements being asked for.

>>  
>>  First, add the `struct oidset` and related items we will use to iterate it:
>>  
>> @@ -778,8 +779,9 @@ static void walken_object_walk(
>>  	...
>>  ----
>>  
>> -Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
>> -object:
>> +You need to replace the call to `traverse_commit_list()` to
>
> If my proposal to introduce the point that we're switching which function we use
> in the earlier diff hunk is accepted, there's a small nit here: saying "You need
> to" would feel (very slightly) awkward, since we already mentioned that it was
> necessary to accomplish the goal. If we accept the previous proposal, we may
> want to change this to remove the "You need to", and just state something like
> "Replace the call..."
>
> Regardless, I think saying "replace the call to A _with_ B" (instead of "A _to_
> B") reads slightly better. I don't know if that's just a personal
> preference/dialect though.

When I wrote that "You need to" it felt semi-optimal even to me
non-native speaker, but I didn't exactly know what to do with it.  So,
I'm very glad you are helping me to do all that better.

>> +`traverse_commit_list_filtered()` to be able to pass a pointer to the
>
> If we remove the "You need to", then we should probably rephrase this to more
> of an instruction, changing "to be able to" to "and".
>
> Something like this:
>
> -Modify the call to `traverse_commit_list_filtered()` to include your `omitted`
> -object:
> +Replace the call to `traverse_commit_list()` with
> +`traverse_commit_list_filtered()` and pass a pointer to the `omitted` oidset
> +defined and initialized above:

Sounds way better and I'd use it.

Thanks again,

Dirk
