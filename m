From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 05:28:45 -0700
Message-ID: <7vmxhlrk3m.fsf@alter.siamese.dyndns.org>
References: <201106051311.00951.jnareb@gmail.com>
 <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de>
 <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de>
 <20110613034347.GA4222@elie> <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 14:29:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW6GZ-0000CR-1F
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 14:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1FMM3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 08:29:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab1FMM3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 08:29:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42FF84D96;
	Mon, 13 Jun 2011 08:31:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jQQ4Jr5U4UPkRlpmz1RaQzmOkaQ=; b=kjZedc
	DfQjC1ZT1RX0er45BKCtNS9pmYEwxF7hdT+ALOIA6AN8BOv8MtvgT5875UkaMzoK
	4GkFd77a2//SmQRo/Le1EsEHsVu2M/jugqUgKWz3IgADoqbxV3KVmtluo01THfhD
	3sczoAwAj8l4pAQ1S+IfC5FCf7zkpG4wocoko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k4wYnCBWzfjwa4XMowTG3miLf6w1tn3G
	oBcJgLSOpA+8nV98au+rZK8rEkGrNsxaRf6JUWZOtLRAHuzIyxEMQLI7ukY46ZS9
	vQkGjws6oWeC/UKisK88Li9rc+Iqtd0k0mYTgDqr52O9Dzz5kBnwV2GZbaw4foSK
	dS8/oSZ4it4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A84D14D95;
	Mon, 13 Jun 2011 08:31:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D8A64D94; Mon, 13 Jun 2011
 08:30:57 -0400 (EDT)
In-Reply-To: <buotybu2wx7.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Mon, 13 Jun 2011 13:11:00 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 032E90E4-95B9-11E0-9955-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175700>

Miles Bader <miles@gnu.org> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Do you think it would be valuable to introduce --added as a synonym
>> for --cached and slowly steer documentation to encourage the latter
>> in place of the former?
>
> "--added" sounds very awkward though; "--staged" is much more natural.

Actually I think _both_ are equally wrong.

I have to thank you and Jonathan for making me realize the real reason why
"staged" didn't sit well in my ears. The word used as adjective nauseated
me forever but I couldn't clearly explain why even to myself, but now I
have the explanation.

The index has data registered for paths. "add" (and "stage") are verbs
used to describe the act of taking data different from what is currently
registered in the index and replacing it. The phrase "added contents" thus
can be (mis)interpreted to refer to only the subset of the data that is
different from what you used to have in the index, typically meaning the
ones that are different from HEAD, i.e. you would see the change in the
output of "git diff HEAD". This is especially true because many people
think in terms of "recording difference from the previous version" when
they think about SCMs, and "--added" or "--staged" rhyme well with that
mindset.

This potential misinterpretation does not cause problems in some contenxt,
and one such context is the hidden synonym "git diff --staged", which _is_
all about the subset of the paths that are different from HEAD.

But as Jonathan in his message and you in your response brilliantly
illustrated, misinterpreted "added" and "staged" break down badly in other
contexts. When running "git grep" and "git rm" against the data sitting in
the index, you do _not_ want to limit your request to the subset of paths
in the index that are different from HEAD. "git rm --added" is not a
command that chooses paths that are added to the index, and remove these
paths from both the index and the working tree, but "added" would invite
such a misinterpretation from new people.

The adjective "cached" refers to the _state_ of the data for various paths
in the index as they exist, regardless of when or how these contents were
placed there. For the majority of the paths the "cached" data may have
come from the HEAD, and for other paths, "cached" data may be something
you have "added", but because "cached" is a state as it exists in the
index, there is no distinction between the two.

Because "cache" nor "index" are never used as verbs that mean the _act_ of
putting updated things in the index, we do not risk --cached nor --index
to get misinterpreted as limiting to the subset of the paths that are
different from HEAD. At least that is how these four words (added, staged,
cached and index) sound to my ears, and that is why I said the first two
are equally wrong in the beginning of this message.

It is an entirely different issue that "cached" is _not_ the best way to
spell "index-only", though.
