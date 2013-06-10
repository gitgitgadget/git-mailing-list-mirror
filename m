From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/7] git send-email suppress-cc=self fixes
Date: Mon, 10 Jun 2013 00:52:44 -0700
Message-ID: <7vk3m2l7w3.fsf@alter.siamese.dyndns.org>
References: <1370455737-29986-1-git-send-email-mst@redhat.com>
	<7v8v2o1ho7.fsf@alter.siamese.dyndns.org>
	<20130605201423.GB31143@redhat.com>
	<7vy5ain9yg.fsf@alter.siamese.dyndns.org>
	<20130610065324.GA26501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 09:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlwuJ-00019I-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 09:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab3FJHws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 03:52:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54348 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab3FJHwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 03:52:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F1026084;
	Mon, 10 Jun 2013 07:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3KTfkU04P9yMYipK4d1B/dzCOac=; b=MfXHUL
	mRS3NP6Qas/T5Hdf37OHubhwvfFfdTikBmx3zmjNtCHH06NJYbyucGKjiyIU23Px
	h13cAFj9lJjwXMMSYPhWRoGBSjBS5AvoSehQBq05xYOiAcrlX7o6D9kPWChv2JQR
	LeiUcJQ9AEpqGq0s2FjdBA7ReCMkfKSAMedKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqWuY0xsbasaXgW3gqoE96FVeC8y+W6W
	/qsv0hvR8NlNo0rYYM22oWZvaVgHCikuUvGIGO3WqOq/UnxrNAETQ52MDHODe8Sq
	f7HR24TdZsFmE0Yq5iGQblf/mDZZgwqbaHnausk6w4+p7dqVXamw3J4NQmOr/7CV
	N0hM20iogEI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9957326083;
	Mon, 10 Jun 2013 07:52:46 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A794226081;
	Mon, 10 Jun 2013 07:52:45 +0000 (UTC)
In-Reply-To: <20130610065324.GA26501@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 10 Jun 2013 09:53:24 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCCC6824-D1A2-11E2-B246-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227254>

"Michael S. Tsirkin" <mst@redhat.com> writes:

>> Not needed with recent "git format-patch -v4" option.
>
> Unless I rerun with same vX :(
> Would it make sense for it to check for vX existance and fail?
> Same without -vX, when 000X exists ...
> Could be an option.

Oh, instead of exact -v$N, trigger it with "-v auto" or something?
Sounds like a good addition.

And instead of ***BLURBHERE*** placeholder, text from old round
could be copied as a new placeholder.  I do not offhand think that
needs much thought about compatibility but maybe there are people
who trained their editors or scripts to find the known placeholder
string and edit it?  I dunno.  It certainly sounds like a sensible
thing to do to carry as much information forward from the older
round if/when we know which one corresponds to which.

Discussions and patches welcome.

>> > 	git branch|fgrep '*'
>> > 	# Figure out on which branch I am, manually specify the correct upstream I'm tracking,
>> > 	# otherwise I get a ton of unrelated patches.
>> 
>> git-prompt with PS1 you do not need this either.
>
> grep serves just as well but
> I still need to copy it to the next line manually...
>
> I vaguely remember there was some way to say
> "head of the remote I am tracking" - but I could not find it.

Do you mean @{upstream}?

> Where are all the tricks like foo^{} documented?

Documentation/revisions.txt?

> Additionally, or alternatively, would it make sense for git format-patch
> to format the diff against the tracking branch by default?

Meaning "git format-patch @{u}" without saying anything about @{u}?
I am not sure if we want to go that far, but it certainly is worth a
thought.
