From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 07 Dec 2010 12:25:24 -0800
Message-ID: <7vfwu9pbyj.fsf@alter.siamese.dyndns.org>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
 <20101207175418.GU355@fearengine.rdu.redhat.com>
 <20101207180236.GC21483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Casey Dahlin <cdahlin@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:25:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ46l-0001xL-PF
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab0LGUZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 15:25:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39915 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0LGUZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 15:25:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75E73393A;
	Tue,  7 Dec 2010 15:25:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5b5Zzm7CtH/RbJZX8N/5oYY0L0=; b=KwTXE2
	f1jat7PEZozKnvfLusBC/j2ZChoALCidN+UkcqGlkzbpMRgsZFkUcsxar9Zw73gJ
	FvRxXtypsZ/Ho3rWDFIdqmagwHYCq0OpnF3bfgtsRlDCiqJUIjlhJ5Gg25zvTC/X
	xcugksfuOVbkOoPXPJ5x2/Xh1N/YImPUVj5Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nHxl0foX4HUIjQQXkWWuj7KGDB3v3Ouu
	jmIOzk7YFvJBeIJP/kjB5qcpvurC+eqh+9p5NvAslxU/VFlagXSS35OAxjznNMcJ
	/AkTF5jPlV1juqEPV2yVCcZHNj04TUw+g499jT0mELtSSpMDHqsBVtVAAOank9jC
	MLUsCYtWgx8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42F32391A;
	Tue,  7 Dec 2010 15:25:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BE98A3903; Tue,  7 Dec 2010
 15:25:48 -0500 (EST)
In-Reply-To: <20101207180236.GC21483@burratino> (Jonathan Nieder's message of
 "Tue\, 7 Dec 2010 12\:02\:36 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30E13EB8-0240-11E0-9E78-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163124>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Casey Dahlin wrote:
>> On Tue, Dec 07, 2010 at 11:45:20AM -0600, Jonathan Nieder wrote:
>>> Casey Dahlin wrote:
>
>>>> Could commits made onto a detached head also show up here? Or is that
>>>> better thwarted with another mechanism?
>>>
>>> I think that's better thwarted with the HEAD reflog:
>>> 
>>> 	$ git log -g HEAD
>>
>> I was more worried about changes that were made onto a detached head,
>> and then the head was reattached, leaving the new commits dangling.
>
> But isn't that exactly what a detached HEAD is for?  If one wants
> the experiments one does on detached HEAD to be kept around "just
> in case", wouldn't it make more sense to give them a (branch) name so
> they can be separated from one another?

What are you arguing after giving a correct answer.  "git log -g HEAD"
keeps track of what was at the tip of HEAD, be it pointing at a branch or
pointing diretly at a commit in a detached state, no?
