From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge with staged and unstaged changes
Date: Wed, 20 Feb 2013 14:17:25 -0800
Message-ID: <7vk3q2y6iy.fsf@alter.siamese.dyndns.org>
References: <7vobfeybwt.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F85740396C4F8@TK5EX14MBXC254.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 23:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Hz7-0004OB-NF
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab3BTWR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 17:17:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab3BTWR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 17:17:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9F0BEB9;
	Wed, 20 Feb 2013 17:17:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MfhZsG057m/NBSZxpq3zAkC4mCc=; b=Gxs/MP
	XITPaBeF4eMxWy0wjEMyVJFnxb9EUV20ukr5RNlEBISBJ7vFDzsURltmEVKIW4ks
	yeLsKYwcxEiOteRWYv17juM209HnNXgdVUIIYRnWyfnDdYx5ElVZlm0jRR+3hcLP
	raPtB3XPZ4TrGu88fve1ghhp8KUpNKDHNEzL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcGuGibpiLFcs8Ebn8//FUal5+Iqp553
	MMgqKwTjwXJrhe7vSxUvadiF8BD3tnUd7FLGw4RjuUgodDEKEm2TdxVnDwY2W09W
	xXODt+ctqGiPX/Y4VQNgbq6ihGwkeyI7LM45aeA4cqOftEYBxgUQgHxsLPWiRmky
	KEBdA8pOJqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12A34BEB7;
	Wed, 20 Feb 2013 17:17:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86AB3BEB4; Wed, 20 Feb 2013
 17:17:27 -0500 (EST)
In-Reply-To: <A54CE3E330039942B33B670D971F85740396C4F8@TK5EX14MBXC254.redmond.corp.microsoft.com> (Edward Thomson's message of "Wed, 20 Feb 2013 21:46:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F5C00EE-7BAB-11E2-ADD8-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216743>

Edward Thomson <ethomson@microsoft.com> writes:

> I also appreciate your explanation of the affect of the workdir,
> and that makes sense.  I would have expected that the default was
> to presume the workdir files were existent, rather than the
> other way around, but we can agree that is an implementation detail.
>
> My biggest concern, of course, was having the unstaged files in my
> workdir overwritten or deleted.

Oh, no question about that part.  You concluded your original
message with:

>> I trust the last two cases, where data is lost, are bugs to
>> report, but could I get clarification on the other situations?

and I was responding to the part after the "but could I get...".

I am fairly familiar with the "read-tree -m -u O A B" three-way
merge codepath (after all I designed that with Linus in the very
early days of Git), but I am not as familar with the merge-recursive
backend as merge-resolve, and I was hoping to see the "bug" part
triaged by other people.
