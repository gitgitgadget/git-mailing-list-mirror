From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-index: fix segfault with missing --cacheinfo argument
Date: Wed, 04 Jun 2014 11:03:13 -0700
Message-ID: <xmqqioogv9ge.fsf@gitster.dls.corp.google.com>
References: <20140604071110.GA22158@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:03:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsFX3-0001BK-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 20:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbaFDSDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2014 14:03:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54562 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbaFDSDU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2014 14:03:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D12F11CAFF;
	Wed,  4 Jun 2014 14:03:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mbkkWr3AXegkv+GvxOjQ3i0dOoY=; b=f8Xxif
	C62T33a7Y7+4458YoUM+LS2TItLetYrNVRemgj3Yscj9/Kg4qjaRix0AvB261JO+
	32Impe4a51xPJ9+vMgKynYMY61GSRA6QYnLkNiH8qEvg6qWa2WBQrxI5aKBV+gPJ
	wFzABLz5t+2iA2tD6HQu4urdHAxFapO+7ctqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I737sdrM4hmcuCT1er5bUh3lJ0A1QAL0
	ILO7px3D8bUYnT4O1OPEX3jBwz3b9Qb4oNWlXB4BB5kBH2UJQmQ9ZHh8F1l9TtK7
	6J3mLfR52p/KIc/iv87FBjhwyS35Z6pBoKR1Gh8ZvqnmqCC2uyiwjZ9f4ke03bgJ
	dZwU6AuyBCg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C40591CAFE;
	Wed,  4 Jun 2014 14:03:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D1B591CAF8;
	Wed,  4 Jun 2014 14:03:15 -0400 (EDT)
In-Reply-To: <20140604071110.GA22158@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 4 Jun 2014 03:11:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 806249AE-EC12-11E3-8FDF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250751>

Jeff King <peff@peff.net> writes:

> Running "git update-index --cacheinfo" without any further
> arguments results in a segfault rather than an error
> message. Commit ec160ae (update-index: teach --cacheinfo a
> new syntax "mode,sha1,path", 2014-03-23) added code to
> examine the format of the argument, but forgot to handle the
> NULL case.
>
> Returning an error from the parser is enough, since we then
> treat it as an old-style "--cacheinfo <mode> <sha1> <path>",
> and complain that we have less than 3 arguments to read.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Thanks.
