From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Mon, 15 Aug 2011 13:37:53 -0700
Message-ID: <7vy5yujtr2.fsf@alter.siamese.dyndns.org>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
 <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
 <20110811195955.GA21185@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 15 22:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt3vJ-0004UP-8o
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 22:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab1HOUh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 16:37:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab1HOUh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 16:37:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 489B94D92;
	Mon, 15 Aug 2011 16:37:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RX+JCj5ZxXPZGw2Ii2AXtrZwTIM=; b=Ym2VqE
	n8/MO8D3Yb2Budt+Fc6AnB5PPssiWVVDGf4Q6vh+siKGccgbk6LEjsQbaiLZDV5U
	mg9aqTLs0JK+oI6iUJZHfmCZTN/aYj+I9sfhjYVV+lPUY4EWJe4dvHmnz3mEQLsL
	SPmC2HXuCg1w1PeuWxfzpDQdtZN9NIsr9LceY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adFxSbCI1fMREzDPXuhBcZ8b2ZJdUrAb
	BGz4OzrQoP3hXwim9KQl6r5Fve2fIKrDoWimQyL8q+A3Xpdw44HLwq1MObt/04dw
	IVAxvqXdJt7LTX5G8/Xb4xNaLyc7gLXIL7PVJpMBCKsbRYsqyhFRHiS1/iQtjVxu
	RqMSB1sNkK4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 405694D91;
	Mon, 15 Aug 2011 16:37:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51D494D90; Mon, 15 Aug 2011
 16:37:55 -0400 (EDT)
In-Reply-To: <20110811195955.GA21185@book.hvoigt.net> (Heiko Voigt's message
 of "Thu, 11 Aug 2011 22:00:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74617280-C77E-11E0-AAB1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179386>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Aug 11, 2011 at 11:28:31AM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> 
>> > If a submodule is used to seperate some bigger parts of a project into
>> > an optional directory it is helpful to not clone/update them by default.
>> 
>> Sorry if I am slow, but I do not get this.
>> 
>> I thought unless you say "submodule init" once, a submodule you are not
>> interested in should not be cloned nor updated at all. If that is not the
>> case, isn't it a bug to be fixed without a new configuration variable that
>> fixes it only when it is set?
>
> What I usually do is say "submodule init" without any extra option once.
> That will register all submodules from .gitmodules in the config. Now
> when I say "submodule update" all submodules would be cloned. In the
> case of recursive submodules actually
>
> 	git submodule update --init --recursive
>
> is the only command which can get you really everything in one go.
>
> Do you think the "submodule init" behavior is wrong? If so I think its a
> bit late to change this since people using submodules (me included)
> already have got used to it.
>
> With this config variable all submodules will still be registered to
> .git/config on "submodule init" but "submodule update" will skip those
> submodules.

Ok, that sort-of makes sense, but we have been using "do we have the
submodule registered in the .git/config of the superproject?" to decide
"does the user interested in having a checkout of the submodule?" (I think
in the ancient days it was "do we have .git in that submodule directory?"
that decided it, but we dropped that because it won't work when switching
branches that has and does not have the submodule in superproject).

It is somewhat worrying that some parts of the system may still be using
that old criteria "do we have it in .git/config of the superproject?" to
decide if the user is interested in the submodule. If so they need to be
updated to take this new semantics "do we have it in .git/config without
its submodule.$name.update set to none" into account. We would probably
need to have a paragraph in the release notes to warn about the semantics
change (which I tend to agree with you that it is a good one).

>> > We have been talking about loose submodules for some time:
>> 
>> Also before introducing a new terminology "loose submodule", please define
>> it somewhere. It feels confusing to me that a normal submodule, which
>> shouldn't be auto-cloned nor auto-updated without "submodule init", needs
>> to be called by a name other than simply a "submodule" but with an
>> adjuctive "loose submodule".
>
> Thats why I avoided talking about it in the docs. For the commit message
> I thought it would be kind of intuitive but I can update the commit
> message so that it becomes more clear.

That sounds like a good thing to do.

Thanks.
