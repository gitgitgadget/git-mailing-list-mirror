From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
 git-status
Date: Thu, 28 Oct 2010 16:20:30 -0700
Message-ID: <7vsjzp9a69.fsf@alter.siamese.dyndns.org>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
 <20101028183513.GC14212@burratino> <7vaaly9eji.fsf@alter.siamese.dyndns.org>
 <20101028220956.GC16125@burratino> <vpqfwvqdjes.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:20:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBbm8-0003tH-1u
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759339Ab0J1XUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:20:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759127Ab0J1XUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:20:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DEA6313CD;
	Thu, 28 Oct 2010 19:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6yLKKIBkxxzSZS821jVE4x57oe0=; b=C/X8mK
	uzClN2WVERG50kfzRyWWr8wQ6tLQda/0FrROHDso14Zn2Wj8VknNUvCcjCsaLuUT
	JbrDMjvDjLXbI3bx4JO9epfTM+d33EOFTI524sNIPefCuHCjrJRxjJzJb0zC7L1O
	lnTWHK+gN3ERNDO+LO7aQKU1GDHQ1QJ/EuaOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VBckHxFQq6yWbA515qj1i0IgpM81+7uZ
	qIW27iB2DHpNPn0e6Adqu+q6TyilGF/kTcci2/CtQqIwDV6gRZM10RksEaWAUTcn
	xNkqK7z4Dn61Jj83mwW/VWNfGLAXtsCdj3uqUcEKkopQSYE8DnstH0JoVSi40ROu
	EUcaudliVm0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A86513C3;
	Thu, 28 Oct 2010 19:20:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4564713BA; Thu, 28 Oct
 2010 19:20:32 -0400 (EDT)
In-Reply-To: <vpqfwvqdjes.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri\, 29 Oct 2010 00\:47\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F9729BFE-E2E9-11DF-A884-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160247>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Actually, my formulation also has a subtle advantage: it somehow
> teaches the meaning of "staged". By reading "Changes not staged for
> commit" close to "Changes to be commited", it makes it rather clear
> what "staged for commit" means.

That is exactly why I mentioned "Changes staged for commit" in the first
part of my message.

> Perhaps changing the hint from "git add" to "git stage" right below
> would make that even clearer.

If we had "git reset HEAD -- <path>" as a synonym for "git unstage",
perhaps.  I always hesitate to suggest that, fearing if that synonym would
always work, especially when you are not just dealing with your own
changes (iow, doing something more than "I have clean checkout, and I
edited some files, and I may have run 'git add' on some of them").  I do
not think of a situation that the synonym wouldn't work offhand, but that
of course does not mean it would always work.

Provided if such "git unstage" can be given as a counterpart of "git
stage", it may be fine to advocate the verb "stage".  But otherwise, I'd
rather not to see the verb advocated in this way.

Notice that my rewording was crafted in such a way, rather carefully, so
that we do not have to say "stage" anywhere.

>>> I've been wondering ever since this thread started if we can phrase it
>>> better to make it even less confusing.  E.g.
>>> 
>>>     Files with changes to be committed:
>>>         new file: foo.c
>>>     Files with changes that won't be committed:
>>>         modified: foo.c
>>> 
>>> might help reduce the confusion.
>>
>> I fear that it can be misparsed as (Files with changes) to be committed.
>> More importantly, I think Matthieu was right earlier: it is not the
>> files but the changes that matter.

Well, I was aiming for the same.  It is not the "files" but the changes
that matter, but what we list are files.  What we want to say here is that
your changes are two kinds, and the ones to be committed appear in these
paths, and the ones to be left behind appear in these paths (that can be
overlapping with the former).

> I second that. Furthermore, keeping it short increase the changes that
> user will actually read the message.

You could do s/Files with/With/ to shorten them.  Or perhaps

    Changes to be committed are in:
        new file: foo.c
    Changes that will be left out are in:
        modified: foo.c
