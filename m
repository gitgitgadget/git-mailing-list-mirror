From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Three dot notion used inconsitent?
Date: Fri, 20 Nov 2015 10:53:09 +0100
Message-ID: <564EED85.3080706@drmicha.warpmail.net>
References: <1CDF2D38-B73A-4C49-BC10-1F3BA1873733@gmail.com>
 <87lh9vp59u.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZziNh-00088P-L0
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 10:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162383AbbKTJxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 04:53:17 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57754 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752682AbbKTJxL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 04:53:11 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 9E0B42046D
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 04:53:10 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 20 Nov 2015 04:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Hm69UvNdz4S2oc6DOC9KKkhrpOo=; b=cjVN/V
	6gEGpY/bEhRsyslfKIQmbNCH5ERJPUIYln2k6gsZM3kHqoFZBczPt0/bCZD9lEvU
	bCiTN0iL10nFyhP0IoKqKCW57uwbckzxYWWFYjm/4wS8xDCbeQ3iQWdVtByuqZA9
	nXnC55mgBkgD4BFqaH7+v7ffDqJ/hJYvpb9gM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Hm69UvNdz4S2oc6
	DOC9KKkhrpOo=; b=mWyNGT2wh9T/0KVHWsUezHumJOsLYbDxdcHFtewn1Lgu11L
	af/80H9cI14BLY6eg/K3f96ScNjlClZaBldurolUbuQeztX7DmbIDN2flj5UKcPN
	0YUisYLVykNev8s+PBeyi+i5eFdySkNZ6Zc10VTo+8AZvAvpeA8tVWdtHkTQ=
X-Sasl-enc: aqxL4EaFHw4FkThxFtA53v0Ov4zldtPmKjmJlEMmfdgH 1448013190
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 09113C016EE;
	Fri, 20 Nov 2015 04:53:09 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <87lh9vp59u.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281503>

Andreas Schwab venit, vidit, dixit 18.11.2015 18:49:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> git diff branchA...branchB
>> --> gives me the diff between (the common ancestor of A and B) and B. That means I never see changes on branchA.
>>
>> git log branchA...branchB
>> --> gives me the commits reachable from A and B. That includes changes from branchA.
>>
>> Is this because of a design decision that I do not (yet) understand or is this inconsistent for historical reasons?
> 
> git diff operates on two revisions.  That is inherently incompatible
> with the usual meaning of A...B and A..B, which are set operations on
> the revision history.  That git diff accepts this syntax is only for
> convenience.

That convenience can be a bit misleading, though, as the OP points out.
Just to spell this out because the other response (not the one I'm
replying to) could be misunderstood:

git diff A..B is the diff between (the trees in commits) A and B. It
will show you the "changes" that are only in A with "-", the changes
that are only in B with "+" - that is, if you want to think about diffs
as "positive changes" to a "virtual common base tree".

[ If p are the plus lines and m the minus lines, the diff says
    B = A + p - m = (A-m) + p
<=> A = B - p + m = (B-p) + m
<=> B-p = A-m (virtual common base tree) ]

git log A..B will show you all commits that are in (=reachable from) B
but not in A. That is, it will show you all commits between the "most
recent" common ancestor (let's call it C) and B (including B), but not
those between C and A (and not A either).

git log A...B will show you all commits "specific to A and B", i.e.
those between C and B and those between C and A (including A and B,
excluding C).

git diff A...B will show you the diff between C and B.

So, both "diff A..B" and "log A...B" show changes/commits introduced by
A only or B only.

"diff A...B" and "log A..B" show changes/commits introduced by B only.

Maybe there's a way to think about these that makes them actually look
consistent - the only one that I can think of is the actual
implementation (we need to compute the merge base for both "..."
commands), but that's a really bad argument for a user facing notation.

Michael
