From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list docs: clarify --topo-order description
Date: Mon, 13 Aug 2012 16:05:43 -0700
Message-ID: <7vobmebdfc.fsf@alter.siamese.dyndns.org>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGoNvgpbQ9iM0xHpSD1Z4XyC-J8VNVW0bVw3p9qOeijjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:05:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T13hr-0003pd-5e
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab2HMXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 19:05:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab2HMXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 19:05:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E197E83CE;
	Mon, 13 Aug 2012 19:05:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b3n/8uWbjaPZqA7W0K7Dh6shAXw=; b=FLOCd8
	l4G+v8+YsAPMY0EHb3WEE7o1PXDnsRw/GkJI4SDkvripNDNpFTRC1X/CXUuiNPLV
	rhOQbNAHsk+Tn46bDqWNkmaY8/xCElkXz9DNsY8ixlmqfQBOUWTve2QPC4xki3dc
	wJ9aVBmswcwNxVcaDlxN1F6d8DGh7mclB7+OU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KkDlHaFIeywn2feP0JLamuCHWl+aIG+Q
	aNQyMHNHapVVIehAZVt4jzI6d7fIleyAteParHKllTW4qNjnu5OtVMQN6vQ9Uwy6
	kCymWRLA78MXULeUc+OSArv+ctxE0QhTzg37nBV9lVH64D3RksE7oytCi1rta8sH
	i9NT9Q/Fpsg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE79C83CD;
	Mon, 13 Aug 2012 19:05:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43C5483CC; Mon, 13 Aug 2012
 19:05:46 -0400 (EDT)
In-Reply-To: <CAOeW2eGoNvgpbQ9iM0xHpSD1Z4XyC-J8VNVW0bVw3p9qOeijjg@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 13 Aug 2012 15:46:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A3C48AC-E59B-11E1-8A60-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203374>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
>> index 6a4b635..dc501ee 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -579,15 +579,32 @@ Commit Ordering
>>  By default, the commits are shown in reverse chronological order.
>
> It seems likely that those reading the above sentence will continue on
> to read about --topo-order, but still, do you think the "descendant
> commits are shown before parents" part belong here instead?

I do not think so.  When you are not limited (i.e. limit_list() is
not called), you could do something like "git rev-list 4 5" in a
history like this:

	--1---5---2---3---4

and get end up getting "5 4 3 2 1", and "2" certainly doesn't get
shown before "5" does.

In your series where cherry-pick runs prepare_revision_walk() and
makes the outcome sort in reverse, the list has to be limited, so
the above is a non-issue, but in the context of this document, we
cannot assume that.
