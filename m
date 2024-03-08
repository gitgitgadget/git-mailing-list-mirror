Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32961E515
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935931; cv=none; b=U+1r5XbJxM3yY//KhjOcY/JakL24RQm5nUd/sUNfU5eRe1uiQgESWscFX9v7NLaJtKOF72vYwlZl6cghywOIoDPqfmSNmxS1EwGy/+dcIVvcWs1GvxbXoWb3Yer9wILdgjqbSLl36UBhVUhR+EqSVXsCQp5J87Nd5ophgi2z9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935931; c=relaxed/simple;
	bh=Qru64YNSeFUTTIJvdQh0jpbWgD6XVi4oayQQ3GrZ9u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCP07crEbyypD/+D9qiOo2OP1EZjijlpaTbVwrcl3wZRNaaK9eVb+2qGthvJ7FTSeJ8xTdlzgjflT1B2d74olJgoGV5jAdTMjJoF2WcFL9sM8vE3CUaGJM5BVoCkg+87jXMH2l8TBKa1ohaq1qP0a3U94QMEj3RyoPSQ+9tu9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=h8aQSFL7; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="h8aQSFL7"
Received: from localhost (ip-109-42-178-228.web.vodafone.de [109.42.178.228])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 428MC23r005495
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 8 Mar 2024 23:12:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1709935922; bh=Qru64YNSeFUTTIJvdQh0jpbWgD6XVi4oayQQ3GrZ9u0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=h8aQSFL7B5qB8tLez7BGB39E/L4921sK1VNuHMjy0zNRqpYcEtHMbTmQLOWrASMyC
	 rNOwhJ/tZjFrzIXe3vS0MJMejFgHnhob1U7xwb+hcn2n0fvGkloNXn4qSLss9jKtrS
	 vtMFg80ISrh1hMSw8GP8UV2SQlJrrM+eQqgbs05o=
From: Dirk Gouders <dirk@gouders.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation/user-manual.txt: example for
 generating object hashes
In-Reply-To: <xmqqil1wiw5l.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	08 Mar 2024 07:24:38 -0800")
References: <cover.1709240261.git.dirk@gouders.net>
	<a3902dad424983a4f0dfcda68e0b8bf64a0b2113.1709240261.git.dirk@gouders.net>
	<xmqqil27c5p1.fsf@gitster.g> <ghbk7p43xq.fsf@gouders.net>
	<xmqqil1wiw5l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 08 Mar 2024 23:11:56 +0100
Message-ID: <gho7bo1ihf.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Dirk Gouders <dirk@gouders.net> writes:
>
>> May I ask what you meant by "modulo coding style", e.g. where I should
>> look at to make the code of similar style?
>
> Documentation/CodingGuidelines would be a good start, but
>
>  * A here-doc for a single liner is probably an overkill.  Why not
>
>     echo "Hello, world" >file
>
>    In either way, in our codebase a redirection operator '>' (or
>    '<') has one whitespace before it, and no whitespace after it
>    before the file.
>
>  * printf piped to "cat - file" whose output feeds another pipe
>    looked unusual.  More usual way novices write may be
>
>     { printf ... ; cat file; } | sha1sum
>
> were the two things I noticed.
>
>> I would also add that git-hash-object(1) could be used to verify the
>> result if you think that is OK.
>
> git hash-object can be used to replace that whole thing ;-)
>
>> In addition to a suggestion in another mail, the commit would
>> consist of substantial content you suggested and perhaps, you could tell
>> me how to express this; would a Helped-By be correct?
>
> I think many may prefer to downcase B in By, but if it is
> "substantial", probably.  I do not think I gave much in this
> discussion to become a substantial addition to the original, though.

Thank you for the explanation (some of which I should have found by
myself).

I will send the prepared v2 when I solved my struggling with range-diffs;
that concept is new to me and I have a slow brain -- if one at all.

Dirk
