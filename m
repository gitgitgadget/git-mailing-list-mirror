From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug: --ext-diff ignored with --cc in git log
Date: Fri, 11 Mar 2016 11:08:32 -0800
Message-ID: <xmqqr3fgal3j.fsf@gitster.mtv.corp.google.com>
References: <E1adi8q-0005NJ-4G@smtp.tt-solutions.com>
	<xmqqlh5qc698.fsf@gitster.mtv.corp.google.com>
	<E1aeCRp-0005Jn-C1@smtp.tt-solutions.com>
	<xmqqziu4anb9.fsf@gitster.mtv.corp.google.com>
	<20160311185828.GA31750@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 20:09:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeSQu-0008PO-UA
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 20:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcCKTIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 14:08:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752477AbcCKTIf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 14:08:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCAC94AFB4;
	Fri, 11 Mar 2016 14:08:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ScUS+TGMSQukGRNAd243SwMgMtc=; b=nJrYA9
	bhCVIXdBFafWZGd66LBX527hKQAU1tQ25X0LSqiVU2VURmw3cynkLhn87554y1kU
	zSbGOb28sMnYMfzNJRTjP7/tVRNI/a1hk6tgmOb0S8UegqLu1NBFuacf/sHKuUbI
	y8JRdk7osQUFfuznIQejKm/n575g7gAdzItuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xc06rSiWB3j6DqhGDNlOb/BgOI8CcBMG
	/ufFsbqJsgEIuiHsjXHTcEcfHpglp/24NBFftR2MOgUsUsVnVK1/kuBrk9OnH3UA
	Yug7RANSiOwPooQDnp5bmktkWNy8f2CDfOj8AjaPnE5w13VZPN1wVsvseMIDeTOz
	9WxraZm0TbI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3A4C4AFB3;
	Fri, 11 Mar 2016 14:08:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 426294AFB2;
	Fri, 11 Mar 2016 14:08:33 -0500 (EST)
In-Reply-To: <20160311185828.GA31750@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Mar 2016 13:58:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A632857A-E7BC-11E5-9AD5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288700>

Jeff King <peff@peff.net> writes:

>> It happens that the above is fairly easily doable with today's Git
>> without any modification.  Here is how.
>> [...]
>
> I think an even easier way is:
>
>   git log --cc --raw
>
> I know that is somewhat beside the point you are making, which is how we
> should handle "--cc" with ext-diff. But I would much rather have us
> show nothing for that case, and let the user turn on "--raw", than to
> invent a diff-looking format that does not actually represent the file
> contents.

Sorry, but I am not sure where you are trying to go with this.

I understand that the original issue was that Vadim wants to
suppress reams of differences for _some_ paths but still wants to
benefit from the textual summarized diff for all the other paths.
Giving "--raw" would be global, and would affect other paths, no?
