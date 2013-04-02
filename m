From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Tue, 02 Apr 2013 14:20:58 -0700
Message-ID: <7vr4isaath.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> <7va9q72n1u.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vboa6t14w.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com> <7vk3osn3vs.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com> <7v38vgmxty.fsf@alter.siamese.dyndns.org> <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com> <A54CE3E330039942B33B670D971F857403A0F540@TK5EX14MBXC253.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:21:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8e5-0006qa-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761626Ab3DBVVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:21:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761576Ab3DBVVC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 17:21:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9153A12C73;
	Tue,  2 Apr 2013 21:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8eO7LXvy9kDLQpLFVCSqT1c8ZrA=; b=k+UAe4
	LBWxGdYdqDC+H7k5+UisQH/F/ox1JpAkmjMRINDC7es5dWUYEgxWTmJQC3vxbBUU
	gkW0TlNIbs8VcMG1wLV9qBhVwcOCQg8mRJK0It1Iu8bga2RiJfPXOFXOw/gg+H4v
	QCSV0CJV7V8QxvV8ECmjhFoUhNT/4jnLEm1fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AIMWSbmEgLgDklO/dvqUPqVochvfhogI
	hMaljPNsg9TlIB6LFa3ok6LltmwL3YUXXoE9sQjV5U19FhPpblYjMYDzthx+GMqZ
	tXV/VoRsdErUCnQD1a+RZ+h89jr26PoHoibv0qgcPx9J+LLRlDxmPKG4EGicV64J
	bLQKD3RqUMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 83F5812C72;
	Tue,  2 Apr 2013 21:21:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82D3912C71; Tue,  2 Apr
 2013 21:21:00 +0000 (UTC)
In-Reply-To: <A54CE3E330039942B33B670D971F857403A0F540@TK5EX14MBXC253.redmond.corp.microsoft.com> (Edward Thomson's message of "Tue, 2 Apr 2013 20:55:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 377A9418-9BDB-11E2-A776-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219888>

Edward Thomson <ethomson@microsoft.com> writes:

> Edward Thomson [ethomson@microsoft.com] wrote:
>> Junio C Hamano [mailto:gister@pobox.com] wrote:
>> >  * Path A may have only stage #1, while path B and C has only stage
>> >    #2 and stage #3 (the user would have to notice these three
>> >    correspond to each other, and resolve manually).
>> >
>> >    You would want to annotate "B at stage #2 seems to have been at A
>> >    in the original" (similarly for C#3) if you choose to do so.
>> 
>> If we're going to make changes to the way conflicts are recorded in the main
>> index, then I would prefer this approach.  It is unambiguous and all data about
>> all sides are recorded, including the names that items had in their respective
>> branches.
>
> Junio, did you have additional thoughts on this?

Not at this moment.

I think we have covered the principles (do not unnecessarily
duplicate information, do not break existing implementations
unnecessarily, etc.) already, and we know how we want to record "one
side renamed A to B, the other side renamed A to C" case, but I do
not think the discussion covered all cases yet.
