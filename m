From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 17:13:32 -0800
Message-ID: <7vmx8v4f9f.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vwr7z653f.fsf@alter.siamese.dyndns.org>
 <CACsJy8C5=JKHsjyaSFsxxyScb1CCQZmh4gXSAgsyJ8DFkjfQ0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 02:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZcq-0005mR-VD
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 02:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab2BGBNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 20:13:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756548Ab2BGBNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 20:13:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC504753A;
	Mon,  6 Feb 2012 20:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KHM5If+tIdR2OrBEGPlXOxiOEvU=; b=s+n7Z5
	zQ53mUyLCFLa1tG0K9YLvnkhJkbP1hLO8AcOotoBnlWRPRoTV9ip5uXXMtUsFY5W
	Jmb2FHRCMu2talndTKAFynwhFpS7x+MDqF+FE+LpJUEd+iqe+zXDG0YsaqeYRGEw
	zU5CwNng6Dk+rzsINvSgyR1v3Un25CUzPUGzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vmsd2o0zhx1AXzQcb5rvlzD+LSzA3yJQ
	0fsmZstcwIY8ubjVMMErPbMCTbkg8L3jM83kZ7QjWWlRbG+eMe6LJZINN0Kb9G9L
	8ObbrncWnzSmRvO81dE3t8xXJq2MwiKtCSLzgj/Hge8pZmi8tlqpFxPAsWfCHQoS
	y24v82SEo88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C37AB7539;
	Mon,  6 Feb 2012 20:13:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45DA37537; Mon,  6 Feb 2012
 20:13:34 -0500 (EST)
In-Reply-To: <CACsJy8C5=JKHsjyaSFsxxyScb1CCQZmh4gXSAgsyJ8DFkjfQ0g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 7 Feb 2012 07:58:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4A73F9A-5128-11E1-83DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190129>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/2/7 Junio C Hamano <gitster@pobox.com>:
>
>> I suspect that some among 1 million Git users would want the "please
>> remind me", so a solution with configuration variable without command line
>> override is not ideal (command line without any configurability is fine as
>> long as we have a good default).
>
> Which is why I prefer adding a new configuration variable (and
> optionally a command line option) instead of deprecating current
> behavior, because (being lazy) I never be able to find "some among 1
> million" so I'm fine with assuming there are some among 1 million that
> favors safety over convenience.

If there is one thing I want to absolutely avoid, it is to split the
userbase into many pieces by giving sticky configuration variables, so
the above argument is not a good starting point.

>> The third one is a bit funny, as it is a way to bring back safety when the
>> ....  And having to add a funny
>> option just for the sake of completeness is often an indication that there
>> is something fundamentally wrong in the system that the option tries to
>> express an interface into it.
>
> Well, that --honor-intent-to-add could be renamed as
> --no-ignore-intent-to-add.

I wasn't talking about the name at all.  What is _funny_ is the semantics.

A "by default unsafe" configuration introduces a need for an option to be
extra careful only when matters, but "an option" to be extra careful by
definition is easy to forget, so it is no longer a safety at all, iow,
people who want "by default unsafe" will get "always unsafe".  And it
probably is perfectly fine because to them, forgetting to add 'add -N'
entries is not a mistake at all, but always is a deliberate act.

Another thing I am somewhat worried about is if there are existing scripts
that create commits and relies on the current "we cannot commit because
the final contents is not known yet".  I didn't check but for example how
well does "git stash" work when the default is flipped to "just ignore"?
