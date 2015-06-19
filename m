From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Using clean/smudge filters with difftool
Date: Fri, 19 Jun 2015 10:57:55 +0200
Message-ID: <5583D993.4090305@drmicha.warpmail.net>
References: <5582BA1F.1030409@drmicha.warpmail.net>	<CAGA3++LrVSs3rMkg=S2Og48pz1yEBxwpcRsPt7sNLENRh1ooAg@mail.gmail.com>	<20150618132622.GJ18226@serenity.lan>	<CAGA3+++_mx=O=Un0pip8Q41X5PZBLmES=Hd=U=aSowryx5r=8w@mail.gmail.com>	<20150618141116.GK18226@serenity.lan>	<CAGA3+++ibw=8Q1LtM6yJrZ7Q4eVs_MEHmPAzctSVSREXMmBiMQ@mail.gmail.com>	<20150618142852.GL18226@serenity.lan>	<CAGA3+++LqZ8Qv6tpuoqQwi37kO5LLODwcbFQtvneorjiV4KARw@mail.gmail.com>	<20150618160133.GO18226@serenity.lan>	<xmqqsi9oeqhn.fsf@gitster.dls.corp.google.com>	<20150618223927.GP18226@serenity.lan> <xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Florian Aspart <florian.aspart@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 19 10:58:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5s7i-0004bj-HH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 10:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbFSI6C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 04:58:02 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51058 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753246AbbFSI56 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 04:57:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 5CFC220B35
	for <git@vger.kernel.org>; Fri, 19 Jun 2015 04:57:57 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 19 Jun 2015 04:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=Ckas2w3QTrEzyIK75Wqk84E8rgg=; b=hu18on
	tFtSMfbdwldwpDzwENI9H4naF8Yet87ar2C1O2L+q6vT5mfltISoJJA/6rgZ9gBk
	Vga5jn9he/xcAeqR7d+Jeys0k2iyk6iPt3Wx1UVhC34DC/NkNHzjZA4MRSykwLgw
	fNxpvQBa80ybjCyxlVqaZ95VG4xezGpuNa3Xo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=Ckas2w3QTrEzyIK
	75Wqk84E8rgg=; b=gpaik611CQYxOu1OvlR3TuhrzvSuQ6o2bYWsPs1lsA6n5Ew
	C+cSCDDb/RsZGkt0P7H97wS10zL3ajeQJxB1EalibUA8BQ7RczHOouAEpazUznn+
	a8jvL94vSf1NW1TSChP+i3NSnd5TtQi4isTvJYGTb8Q5SKc6Ou1Gd1rJaBoI=
X-Sasl-enc: fjyy1UfrjcDOYwB0Xwa9fNqQenDa3HjCQE1ashaj2vUu 1434704277
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AC349C0028A;
	Fri, 19 Jun 2015 04:57:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqr3p8bp8l.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272110>

Junio C Hamano venit, vidit, dixit 19.06.2015 00:55:
> John Keeping <john@keeping.me.uk> writes:
> 
>> I think the summary is that there are some scenarios where the external
>> diff tool should see the smudged version and others where the clean
>> version is more appropriate and Git should support both options.  It
>> seems this is a property of the filter, so I wonder if the best solution
>> is a new "filter.<name>.extdiff = [clean|smudge]" configuration
>> variable (there's probably a better name for the variable than
>> "extdiff").
> 
> Not just the external diff, but the textconv filter obeys the same
> rule.  The setting should be done the same way for both, if we are
> going to go in that direction.
> 

textconv is a "one-way" filter from "blob" to "readable blob". External
diffs may prefer to work on "blob" rather than "readable blob", but the
currect setup does not seem to produce surprises.

clean and smudge are two-way filters: clean from "worktree blob" (aka
file) to "repo blob", smudge the other way round.

Typically, the user perceives these as inverse to each other. But we
only require clean to be a left-inverse of smudge, i.e. "(cat-file then)
smudge then clean" should give the same "repo blob" (as "cat-file").

We don't require that the other way round, i.e. we don't require smudge
to be a left-inverse of clean, and in most setups (like the current one)
it is not: smudge does not recreate what clean has cleaned out. It is a
no-op (the "identity", while clean is a "projection").

Now, since external diff runs on smudged blobs, it appears as if we
mixed cleaned and smudged blobs when feeding external diffs; whereas
really, we mix "worktree blobs" and "smudged repo blobs", which is okay
as per our definition of clean/smudge: the difference is irrelevant by
definition.

I still think that feeding cleaned blobs to external diff would be less
surprising (and should be the default, but maybe can't be changed any
more) and feeding smudged blobs should be the special case requiring a
special config. Because otherwise, the external diff would have to know
which parts of the diff are irrelevant - if it display the complete
("uncleaned") diff, it shows differences ("what will be committed") that
will not end up in the commit (because they will get cleaned out before).

As a guiding principle, a worktree-HEAD diff and an index-HEAD diff
should be previews of the result of "commit -a" resp. "commit", and
therefore should diff cleaned versions. textconv, on the other hand, is
a setting by which you tell git: "Don't show me the 'proper'
diff/commit-preview but a readable version."

Michael
