From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to update a cloned git repository
Date: Tue, 11 Sep 2012 09:00:37 -0700
Message-ID: <7v627kk0re.fsf@alter.siamese.dyndns.org>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr>
 <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>,
	<git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:00:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBStN-00033N-0O
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2IKQAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:00:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42590 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab2IKQAj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:00:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E77B69B5;
	Tue, 11 Sep 2012 12:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rhWBsgjAP413IhLmjpJgOfRMmXM=; b=u2UaLA
	YdHGbrCjolPCrd2xrpKryn6S1PZnmUxz88Ovem2Bavp95WVLfQ4SzVXpW6q3EUNY
	Rg1lBnVfsgF4Z2Nh7Uyft988XCGhNDcx7aT02l+w4A1OyYhc74aaI9XaBH21vIcL
	fFGyDn7maxf/soBRB8u+cC8P2Nn2qlO6BLyZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UbjkAEqxOI8W45yr74sWE8RiFCuTxI0m
	mV3JoT1yoGYcVIRD1W4NVql525Z4ZqC4Q9UZdhbdkRhCKtTQriAcXO3oOk9J5/XO
	cF994O7+gNHuVyLXvYhoNQ8R6reEFJ9VsIvCsBe4KMGWHgmylvrDoapko4+fXhbH
	RXA33ehtBLU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A91E69B4;
	Tue, 11 Sep 2012 12:00:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A517569B3; Tue, 11 Sep 2012
 12:00:38 -0400 (EDT)
In-Reply-To: <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de> (Joachim
 Schmitz's message of "Tue, 11 Sep 2012 13:17:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D47FE7C4-FC29-11E1-8F65-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205242>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

>> From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]
>> ..
>> Short answer: don't work on pu. Work on master unless you have a good
>> reason not to.
>
> There are some changes in pu, that I need as the basis, namely my
> setitimer patch and my 2nd mkdir patch, which haven't yet made it
> into the master branch (and in the setitimer case not out of pu)

And that is not a good reason, either.

In general, it is a good habit to get into to base your changes on
the oldest point release they may want to be used with.  For
example, if you really wanted to, you could make sure your Tandem
changes can be back-merged all the way down to v1.7.6 by forking
your own branch from there, queuing your changes like mkdir, itimer
on top.  And you develop and test your changes on that branch,
without pulling from or rebasing it on top of my tree where random
other things happen that won't affect you an iota.  A recent change
to add the new "--set-upstream-to" option to "branch" command does
not have any platform-specific bits, and for the purpose of the
"port to Tandem" topic, keeping up to date with such a change in my
tree is pointless, for example.  To make sure that the result is
still usable with recent releases, you can create a throw-away merge
between your work (that is forked from a stable base) and my tip
every once in a while, test the result, and discard the throw-away
merge when you are done.  Any breakage in your series you find in
such an integration test is to be fixed on your branch, not on top
of such a throw-away merge.

It might be the case that nobody cares if the resulting patches will
not apply to and usable with 'master' or older integration branches,
so in the particular case of "Tandem", choosing a stable fork point
that is older than 'master' may not make much sense, though.
