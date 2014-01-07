From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 07 Jan 2014 10:27:36 -0800
Message-ID: <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
	<d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
	<20140105194850.GA2994@book.hvoigt.net>
	<20140105212458.GG3156@odin.tremily.us>
	<20140105225733.GB4660@book.hvoigt.net>
	<20140105233943.GJ3156@odin.tremily.us>
	<20140106003314.GL3156@odin.tremily.us>
	<20140106011255.GM3156@odin.tremily.us>
	<20140106160202.GE27265@t2784.greatnet.de>
	<CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
	<CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 19:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0bNP-0003O5-T9
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 19:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbaAGS1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 13:27:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbaAGS1j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 13:27:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE9D25FBA5;
	Tue,  7 Jan 2014 13:27:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SOX/rDoX117FBowseDoTwyM6DhQ=; b=Has+B3
	zNSKv+ejjIt5Tc2oy1RSVskHwB7INj8ou9ZmHw1vih+jZap5SK//vG87OOMVam2J
	zfeQ3lIaNASumoLMP8a+4Awhzsp3LzblbtpJ/UoWZxOOYNT7+E25O7ZShESVKwUW
	5yonY1WdZcz9ZFZgPZjJYrbkBif4FLobI9HlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aoTVST9BQrg4y2eGCTM45x+OmbYPru4k
	4Z3JPsqV1vdtPzqpQ7Yy6xAo+pqjLiBCQIH8krJ86dArdblLYn1S6NLt/TF3CDCB
	HmNFfEVqfwEWxuHY8Q+bz9GB0I1HDiQANOSFqALLA8oNS6HnxKNmVGicpVG06s3S
	YcNOjeS3V5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3CC05FBA4;
	Tue,  7 Jan 2014 13:27:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF3E55FBA3;
	Tue,  7 Jan 2014 13:27:37 -0500 (EST)
In-Reply-To: <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
	(Francesco Pretto's message of "Tue, 7 Jan 2014 00:32:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 62945614-77C9-11E3-9419-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240125>

Francesco Pretto <ceztko@gmail.com> writes:

> 2014/1/7 Francesco Pretto <ceztko@gmail.com>:
>> To not break the existing behavior what it's really needed here, IMO,
>> is a "submodule.<name>.attached" property that says two things:
>> - at the first clone on "git submodule update" stay attached to
>> "submodule.<name>.branch";
>> - implies "--remote", as it's the only thing that makes sense when the
>> submodules are attached.
>>
>
> Unless you decide to go with the proposed approach of Trevor, where
> "submodule.<name>.branch" set means attached (if it's not changed:
> this thread is quite hard to follow...). To this end, Junio could sync
> with more "long-timers" (Heiko?) submodule users/devs to understand if
> this breaks too much or not.

It is not immediately obvious to me why anybody who specifies the
submodule.*.branch variable to say "I want _that_ branch" not to
want to be on that branch but in a detached state, so from that
perspective, submodule.*.attach feels superfluous.

But I'd mostly defer the design discussion to Heiko (and Jens), WTK
and you.
