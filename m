Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC410E6
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238092; cv=none; b=AKou8jwhwus0/sDYn1sxa1KQJvrbICZmwec3gqKpgZC+eyutjYoszfD+z30siKxyEvqGaUPKnF7jf6uUZsZog1YM6keltlfRZN6dYMSUJECqOrJmKhpNqMULkg2n3PK9eLImC+IiJyKloUP3KFqhc2eftE0KPCCTNCQsIcItiSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238092; c=relaxed/simple;
	bh=QxFyFBJ/JCF1tCF+nc5yybGzI3Km5sBu1hf/i9nXUNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eNmb/uXKN4Gn+h1gPlSVf/OvXju87NM9R0kIdTL1jwkh85jsHecgpSo2X/H5h6AscwIOHINccaIhj4slKpwMu80t7Gc/YyPk5NsJNp+tX8LJZ8vD09s0adSVjfewTWCRDhwoyi18VlSMgrqGKh/rYbVkxhu05uRHIfIPoXDZoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=P7/DFsfA; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P7/DFsfA"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CA872118D;
	Sat, 27 Apr 2024 13:14:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QxFyFBJ/JCF1tCF+nc5yybGzI3Km5sBu1hf/i9
	nXUNk=; b=P7/DFsfAx9jpbMfHxi398kHVqM2ApDjeCY8dGcsc8f60amiw38t3nZ
	SeeqsSTHnMYClDNNH5rRbxuR1wpLHUDIUd4XfNIlDHiq+KyULq82pNTIifVg9UkB
	q1QzWM+8Zn6um7tYz4RNHkTLuEsJKLo1Vlgs2+SHmGuWV7uwfosHg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 83CA72118C;
	Sat, 27 Apr 2024 13:14:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDB962118B;
	Sat, 27 Apr 2024 13:14:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Beat Bolli <dev+git@drbeat.li>
Cc: Felipe Bustamante <fisadmaster@gmail.com>,  git@vger.kernel.org,
  'Karthik Nayak' <karthik.188@gmail.com>
Subject: Re: Use of Git with local folders
In-Reply-To: <30c5852e-c8db-433c-871b-1ae5c87034dc@drbeat.li> (Beat Bolli's
	message of "Sat, 27 Apr 2024 18:08:50 +0200")
References: <000901da972c$61efc670$25cf5350$@gmail.com>
	<CAOLa=ZQyCwJO3QhLF+_ZkFWWoQ77o+0Mdrvz8hL0j-x3fdt-5A@mail.gmail.com>
	<000201da97f2$579fa110$06dee330$@gmail.com>
	<30c5852e-c8db-433c-871b-1ae5c87034dc@drbeat.li>
Date: Sat, 27 Apr 2024 10:14:41 -0700
Message-ID: <xmqqv842683i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A3798630-04B9-11EF-9EC5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Beat Bolli <dev+git@drbeat.li> writes:

> What would work in my opinion is this, if I understand you correctly:
>
> 1. In the Git repo of day 1, remove all files except for the .git
> folder. This is to make sure ...
> 4. Continue from step 1 for each remaining day.
>
> This will result in one repository that has one commit per day. Going
> forward, you'd probably want to commit more often so that your commits
> comprise a meaningful unit of work instead of arbitrary day
> boundaries.

Hmph, perhaps I am misunderstanding things, but I didn't read in the
original or the follow-up from the OP any wish to "squash" a day's
worth of activities into a single commit each.

Let me make sure what I understood from the follow-up from the OP is
not too far away from the reality.  I thought the day's activity is

 * The whole "repository + working tree" from day (N-1) is copied
   into a new "repository + working tree" for day N, to let the user
   to play in. Then the user hacks away, creating commits on top of
   the HEAD.

So there may be a directory structure

 - FBustamante/
   - Day-01/
     - .git/
     - COPYING
     - ...
   - Day-02/
     - .git/
     - COPYING
   ...
   - Day-10/
     - .git/
     - COPYING
     - ...

but Day-10/.git has ALL the history for everything.  Day-10/.git
is a superset of Day-09/.git, which in turn is a superset of
Day-08/.git, etc. all the way down to Day-01/.git/.

If that is the case, and if the end state of each day needs to be
given a "label" so that it is easily discoverable, then what I would
do would be something like:

    $ cd FBustamante
    $ cp -a Day-10 ALL

to first prepare an exact copy of Day-10 in ALL, and then

    $ for d in Day-??
      do
	rev=$(git -C "$d" rev-parse HEAD)
	git -C ALL tag "$d" "$rev"
      done

to go in to each day's repository to grab its HEAD, and make a tag
for that commit in the ALL repository.

Then doing the usual things like

    $ cd ALL
    $ git log Day-01
    $ git log Day-02..Day-04

should give us what happend on the first day, what happened on the
third and fourth day, etc., as expected.


