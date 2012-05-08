From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Mon, 07 May 2012 20:51:17 -0700
Message-ID: <7vbolz1gay.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <201205061221.29592.jnareb@gmail.com> <vpqtxztlhjd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 08 05:51:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRbSQ-0006fj-Dr
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 05:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758203Ab2EHDvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 23:51:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab2EHDvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 23:51:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 312F68CD9;
	Mon,  7 May 2012 23:51:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1JgKUnmFJfh4VK/GsdI0yje0nOk=; b=a98g9f
	zhFpiwiRJR3JsZpfiv6xlEIT6y22b4LUfQ9tBJ6z6FkMPd8O9TlPq0+1EXko2Gpy
	2xQouYGcqnLA0pcC7/3YuqS3i2seVBeiOR1WquRn2BbEKa2epwfCtwrd8DoXpNNm
	aoMg1kQOnQ1pAKAiPyT+HnMmsDcVzy32n4pP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FIi3cgBxfd8TRUXFWpXVZ0x102Pozc4A
	OT5kNgbCr+06d56uuQlcZLEtjJXVTGXl3meAx1sNxqMoR3LF+g5X9I/OpzMsf7cC
	qywHEAv5QoHHJmlly8gU6hqwXuyFvFQ95A8RHB6phARwN+zrSila+12rWCzjNXx1
	XKBnDU3jln4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 258628CD8;
	Mon,  7 May 2012 23:51:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0C188CD6; Mon,  7 May 2012
 23:51:18 -0400 (EDT)
In-Reply-To: <vpqtxztlhjd.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sun, 06 May 2012 12:39:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11A095A8-98C1-11E1-A0C1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197336>

Just a few factoid corrections.

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> Actually Git porcelain does use 'the index' as a cache (computing),
>> i.e. as a place to store redundant information (stat data, sha-1
>> for trees with DIRC dircache extension) for faster access.
>
> This is an implementation optimization, that is not supposed to be
> visible for the user. Commands refering to the "cache" are not about
> stat data cache (e.g. "git diff --cached" is really about the content,
> not the stat cache).

Yes. It has been pointed out number of times that "--cached" option is
misnamed and deserves a better name, perhaps "--index-only", with the
current name kept as a backward compatibility synonym.

>> Actually 'the index' is index in that sense; it stores _references_
>> from filename to file contents,...

Correct. It is the table-of-contents for whatever tree the next
"write-tree" would write out.  But it also was named "cache" originally
because that it is not a huge loss if you lose it; you can repopulate it
from the working tree. Over time, the operation you can do to the "index"
became richer and finer grained, mostly thanks to "add -p" family of
features, so it no longer is "not a big deal" to lose the distinction
between what has and has not yet been added to the index (iow, "git reset"
without any options), and the reason to consider it "cache" has diminished.

Contrary to the popular belief by outsiders, i.e. what you wrote at the
end of the message I left below, the "stat cache" part was not the primary
origin of the name "dircache".

> ...
> Because we sometimes call it "cache", they think it is basically a
> stat-cache, and wonder why it is shown to the user. I've even seen
> Git users think that others VCS didn't have a stat-cache because they
> had read that the "cache" was a unique Git feature.
