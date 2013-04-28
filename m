From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/3] simplify-merges: never remove all TREESAME parents
Date: Sun, 28 Apr 2013 11:09:27 -0700
Message-ID: <7va9oisf1k.fsf@alter.siamese.dyndns.org>
References: <517AD304.6020807@bracey.fi>
	<1367004718-30048-1-git-send-email-kevin@bracey.fi>
	<1367004718-30048-2-git-send-email-kevin@bracey.fi>
	<7vli83shk0.fsf@alter.siamese.dyndns.org> <517CCB57.3060807@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Apr 28 20:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWW2i-0007HQ-R0
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385Ab3D1SJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 14:09:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39364 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141Ab3D1SJa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 14:09:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E2A18163;
	Sun, 28 Apr 2013 18:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iixdi7qrMRFO8xTX21PktW+p+uE=; b=sOl93H
	PxvYlBjYQ62RfQb0J3eP/Dg1rf8kkBgYHVUetHOrm9Wqpel9D/9pIMR6HZtKfuF0
	G9LLuxC+nT8ixU3OAhMMin0LZRVQ2U+APHMj5yTGApI8kVLCXBTS53VtbZ8N4iTK
	9CYLO13thTc9RfmV9sqfeg0nJAumEJCj5GA0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vTFstXijBMUuGdpqyRtv0pIzchGcWatz
	AUgtp3Uhtyx68TpepF4zekwoSiMj7n1RlcmbEHilzBWfe/1z6Ktm3uUWx+0MobOl
	yDz6pHEVLsZ//7rOxNdeiak+t/xvQb3ZgxG33AUZvk5+UJgDxf9+9t6CBRkH1QCv
	NpDQQYpZWts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBD6618162;
	Sun, 28 Apr 2013 18:09:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B0D018158;
	Sun, 28 Apr 2013 18:09:29 +0000 (UTC)
In-Reply-To: <517CCB57.3060807@bracey.fi> (Kevin Bracey's message of "Sun, 28
	Apr 2013 10:10:15 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4DF4350-B02E-11E2-B69E-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222738>

Kevin Bracey <kevin@bracey.fi> writes:

>> Could you explain here a bit more the reason why we do not want to
>> remove them and why "-s ours" is so significant that it deserves to
>> be singled out?  And why randomly picking one that is redundant
>> (because it is an ancestor of some other parent) is an improvement?
>
> I feel it's consistent with the default non-full-history
> behaviour. The parent that we choose not to remove is the  same one
> that the default log with "simplify_history==1" would have followed:
> the first parent we are TREESAME to. Or at least that's the intent. So
> this parent would normally be singled out, and it's not an arbitrary
> (or "random") choice.
>
> It feels wrong to me that --full-history --simplify-merges could
> produce a disjoint history from the default.

Finally ;-)  That "avoid creating a disjoint history" is the "why we
do not want to remove them" I wanted to see in the same comment.

> But this patch as it stands was an "easy" change to make with clearly
> limited scope and relatively little risk - I specifically wanted just
> to include our default "simple" parent.

Yeah, I think it all makes sense.
