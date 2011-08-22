From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Mon, 22 Aug 2011 15:42:55 -0700
Message-ID: <7v62lpuky8.fsf@alter.siamese.dyndns.org>
References: <cover.1312923673.git.hvoigt@hvoigt.net>
 <7v8vqzreeo.fsf@alter.siamese.dyndns.org>
 <20110811195955.GA21185@book.hvoigt.net>
 <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:43:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvdCy-0002rg-9V
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab1HVWnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 18:43:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48915 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753957Ab1HVWm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 18:42:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F1E4060;
	Mon, 22 Aug 2011 18:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jFbXRrgAVI5d6MH1h2kap2AG0UE=; b=Bf93zL
	T/z+g7KiT8iBJHqFeYhtpi7uOAV178Fy38D1IP5hGHiEgtxYiRo47/Tq/mRoWr0Q
	i9l6JbYk8mDjH48nafiapMapEUiS6HEmbgF8wtvnmq8I/rky7HGQ4LbInJeN0dgo
	UbAn9as0YqH6Ycqqz4c3ZtWWbIbDjMJ0qohQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MbjRAGiaMZXKozyU0ubTKvJQLw0BkJQp
	cuWgKya3AUhhRJGv7cEn7Gzb+N6VVmb1+nKxCF2tlYESTgVMSYy+bA9D0yI3VMZ8
	2fg4OzJ8faNt0imG349gyjnoMnTgR9APy3Vvl/ev1oYXxlATCBWyZ51c6GmBC/Rt
	Sqjp5nkGZUU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8DD0405F;
	Mon, 22 Aug 2011 18:42:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77010405E; Mon, 22 Aug 2011
 18:42:57 -0400 (EDT)
In-Reply-To: <20110822200052.GC11745@sandbox-rc> (Heiko Voigt's message of
 "Mon, 22 Aug 2011 22:00:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14E73A28-CD10-11E0-9706-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179899>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Aug 15, 2011 at 01:37:53PM -0700, Junio C Hamano wrote:
>> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> 
>> > On Thu, Aug 11, 2011 at 11:28:31AM -0700, Junio C Hamano wrote:
>> >> Heiko Voigt <hvoigt@hvoigt.net> writes:
>> >> > We have been talking about loose submodules for some time:
>> >> 
>> >> Also before introducing a new terminology "loose submodule", please define
>> ... 
>> That sounds like a good thing to do.
> 
> I discovered that I only talked in the cover letter about the term
> 'loose'. Since that will not go into any commit I guess we can keep the
> series this way?

Yes, except that I do not have a clear answer to my other half of the
question in the same message you omitted from your quote.

>> What I usually do is say "submodule init" without any extra option once.
>> That will register all submodules from .gitmodules in the config. Now
>> when I say "submodule update" all submodules would be cloned. In the
>> case of recursive submodules actually
>>
>> 	git submodule update --init --recursive
>>
>> is the only command which can get you really everything in one go.
>>
>> Do you think the "submodule init" behavior is wrong? If so I think its a
>> bit late to change this since people using submodules (me included)
>> already have got used to it.
>>
>> With this config variable all submodules will still be registered to
>> .git/config on "submodule init" but "submodule update" will skip those
>> submodules.
>
> Ok, that sort-of makes sense, but we have been using "do we have the
> submodule registered in the .git/config of the superproject?" to decide
> "does the user interested in having a checkout of the submodule?" (I think
> in the ancient days it was "do we have .git in that submodule directory?"
> that decided it, but we dropped that because it won't work when switching
> branches that has and does not have the submodule in superproject).
>
> It is somewhat worrying that some parts of the system may still be using
> that old criteria "do we have it in .git/config of the superproject?" to
> decide if the user is interested in the submodule. If so they need to be
> updated to take this new semantics "do we have it in .git/config without
> its submodule.$name.update set to none" into account. We would probably
> need to have a paragraph in the release notes to warn about the semantics
> change (which I tend to agree with you that it is a good one).
