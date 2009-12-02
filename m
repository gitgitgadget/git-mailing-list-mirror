From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 02 Dec 2009 09:26:44 -0800
Message-ID: <7vy6llgucr.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:28:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFsyf-0007MQ-TY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZLBR0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZLBR0q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:26:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754363AbZLBR0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 929E6A3C7C;
	Wed,  2 Dec 2009 12:26:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/D07GT2TRipiFxD0cIY6fsazhc=; b=VKtXAH
	6hq2wjPTRGSLVQ/gZJLIMkqbT20vSoI5kO0Ku6ZIImKWAXeAUBlxxfAIZwiYe6AH
	nnnObmeombLPApbmc6s8IkFUHAU8Wu29jwueOvF3IvvASM1v67BLf+iXAF8jCii6
	eeIbNLDZd8nFdHOcPSbv9PO1J93ix0D2K8ekI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sWZI+PinIV6Fzf5W2D2koNg01LNA5VqH
	OrfqGuREg4OXAV4y4ZSXp71gFnZMQmolfz2A+XGe0ewcB9zHawoDqLVp0kp0Ipos
	uKeiHCDUIaZXu77Sp1p/8Ir/t7hFAcjhInBemVusb9PR5ZitHPS0zMOUEwjKQe4X
	E6xZakWZINE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 734E6A3C7B;
	Wed,  2 Dec 2009 12:26:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5168DA3C7A; Wed,  2 Dec 2009
 12:26:45 -0500 (EST)
In-Reply-To: <20091202160446.GA32667@Knoppix> (Ilari Liusvaara's message of
 "Wed\, 2 Dec 2009 18\:04\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFA1DEAA-DF67-11DE-9C07-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134357>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Tue, Dec 01, 2009 at 10:35:58PM -0800, Junio C Hamano wrote:
>> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
>> 
>> I didn't mean the line count by "large".  I was referring to the size of
>> change at the conceptual level.  As Daniel already explained, it has been
>> one of the design assumption so far that there are built-in mappings from
>> some common <scheme>:// to backend "helpers".
>
> No implicit mappings from <scheme>:// to helpers existed before this series
> (except for forcing in URL, which are different). Thus, any mapping had to
> be explicit and built-in.
> ...
> So instead of mapping explicitly, those are effectively mapped by filesystem
> (that's after the fixes for next round that make helpers hardlinked instead
> of copied).

Sure, it may be a good change; didn't I say that in the part you omitted
from your quote?  But it is conceptually a big change nevertheless, and it
is to be debated --- that makes the parts leading to 6/8 rather a large
change, which was my primary point in the message you are responding to,
so I think we are in agreement that it would have been nicer if the other
bits that are independently useful (like the debug one) were earlier in
the series.

The other minor point in my message was that this is to be debated (which
I think you are doing now), but I am not the best person to debate the
design of this part with.  Daniel and Shawn are the guys who have
primarily worked on the helper interface and relationship between the
helpers and the transport layer, and will have much better insights.

By the way, are you the helpful git expert we often see on #git IRC
channel who goes by the same name?  Welcome to the list; I don't remember
seeing you here, and let me thank you for having helped many new to
intermediate git users over there for a long time.
