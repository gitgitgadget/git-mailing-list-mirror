From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] limit_list: avoid quadratic behavior from still_interesting
Date: Fri, 17 Apr 2015 15:21:30 -0700
Message-ID: <xmqqoammo0ph.fsf@gitster.dls.corp.google.com>
References: <20150417221104.GA8806@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:21:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjEdl-0000Kv-Tv
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 00:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbbDQWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 18:21:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751280AbbDQWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 18:21:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 021F948DF7;
	Fri, 17 Apr 2015 18:21:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mBEL7UkuLilulPrggpRYiO8b8Is=; b=OYtNB8
	HrrwpIXeSK3DdB/9HDdVRNa18dEtaDDB9gkeytkYGn0krDyrKIwxqYuYH1U15eAP
	ACMhnWGpCrGDCUam6JKuE+30hGgpzS7ihLKRq2PjRAxfhcOGyBVVIavcHfQJgoBT
	mxCz9EOWOu6Aye8MPNtXPjSH+925I5z8f9NHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ccqmp5sBbo9MbwNzoFyI+BiymUTrU473
	I4XLbzsI5CmyD/svBhuFHJBVujSmfeHty/TpCSr15Iw3AxgwuQQbFnKvAU275DuY
	ZQRhwuUE4n5JyzVEbTd8j9PZZZebH7pOjT/mynoxPPzsiJfvXtcdAmskBF1vvjvC
	uCPijp2CqXc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EDFC348DF6;
	Fri, 17 Apr 2015 18:21:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 663A048DF4;
	Fri, 17 Apr 2015 18:21:31 -0400 (EDT)
In-Reply-To: <20150417221104.GA8806@peff.net> (Jeff King's message of "Fri, 17
	Apr 2015 18:11:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1967589C-E550-11E4-8C7F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267398>

Jeff King <peff@peff.net> writes:

> The implementation is fairly straightforward. Whenever we do
> the linear search, we cache the interesting commit we find,
> and next time check it before doing another linear search.
> If that commit is removed from the list or becomes
> UNINTERESTING itself, then we fall back to the linear
> search.

Nicely done, clever, simple and effective.

Thanks.
