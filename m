From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/4] "git reset --merge" related improvements
Date: Fri, 01 Jan 2010 12:42:10 -0800
Message-ID: <7vljghlfq5.fsf@alter.siamese.dyndns.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
 <alpine.LFD.2.00.0912311623210.3630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 01 21:44:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQoMU-00039Y-Gj
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 21:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0AAUmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 15:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127Ab0AAUmi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 15:42:38 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0AAUmh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 15:42:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73BF6ACC28;
	Fri,  1 Jan 2010 15:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9D9f0EvtGAe0j5P6fafVyKFLbfY=; b=fON4lg
	VRh5CUnetoW0VwPgufkvBW2P0XDTfTjM0b5i4Q/QPtc1rmZ7wt63eo8VriIp3teY
	Tsps5OH7t4ld7LQg6goiEACm7MsdMxcftYlJfIicLICv+lcq7SZY6Teac8MTkTOi
	szmbCX1h28S+stZAjgr98kxD0tLbPFYx2qbRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GsJaQrOHwj9edpVdYGC2oE05NnLA9nDk
	W2uK3D19ttp5sZDbJa7CxOjjELKmh6FtxqRrhK81Gkm4ntHvJf9ITZXMbvswRxg+
	iKxUZre57LGjiIgWFAdc2pO1R+vtpHSt8e373mU3jmxriY8Oz69wSFP2jFE2Vfr4
	hnHoRTjGeIg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D0F86ACC26;
	Fri,  1 Jan 2010 15:42:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09233ACC1C; Fri,  1 Jan 2010
 15:42:11 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0912311623210.3630@localhost.localdomain>
 (Linus Torvalds's message of "Thu\, 31 Dec 2009 16\:25\:33 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2ADD0AD2-F716-11DE-9415-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136011>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 30 Dec 2009, Christian Couder wrote:
>>
>> Another reroll with the following changes:
>> - patches to add --keep option have been removed for now
>> - documentation patch has been moved before the core code changes
>> - commit messages have been improved
>> - tests have been much improved thanks to Junio's suggestions
>> 
>> Christian Couder (3):
>>   reset: improve mixed reset error message when in a bare repo
>>   Documentation: reset: add some tables to describe the different
>>     options
>>   reset: add a few tests for "git reset --merge"
>> 
>> Stephan Beyer (1):
>>   reset: use "unpack_trees()" directly instead of "git read-tree"
>
> FWIW, Ack on this version of the whole series - I don't think there is 
> anything controversial here, and I think avoiding the execve of read-tree 
> for something we have a library function for is a good thing (and the 
> change in behavior looks like a bug-fix to me).

The "bug-fix" needs my follow-up patch [*1*] to be a real "bug-fix", I
think.

By the way, I've always felt it somewhat confusing that "reset --merge"
implementation uses one-tree form of "read-tree -m -u", especially given
that your 9e8ecea (Add 'merge' mode to 'git reset', 2008-12-01) that
describes the "bug" contrasts its behaviour with the behaviour of going to
a different branch with "checkout", that is inherently an operation that
depends on the two-tree "read-tree -m -u" semantics.

In the context of "reset", however, we don't want the check "checkout"
does between the tree that the index came from (the first tree argument,
typically HEAD) and the index before going to the target tree (the second
tree argument), so it is the right thing to do to use the one-tree form
semantics "go from the state in the index to the target tree".


[Refererence]

*1* http://article.gmane.org/gmane.comp.version-control.git/136004
