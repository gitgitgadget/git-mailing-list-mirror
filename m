From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] config-include fixes
Date: Thu, 16 Feb 2012 12:11:52 -0800
Message-ID: <7v1upuzgfr.fsf@alter.siamese.dyndns.org>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
 <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
 <20120214220953.GC24802@sigill.intra.peff.net>
 <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:12:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry7gO-0004oL-MG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab2BPULz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:11:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753842Ab2BPULy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:11:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FA747EF5;
	Thu, 16 Feb 2012 15:11:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=txNPvk2Uy2ZuqrAEEjIu88NOm8o=; b=ZAnNAtY6U/S90sfm11Xm
	J/folQ4uGdBAHmKCLRyqTS1rtQ8WaMANu+Z1PMwVBcRR2qkF+VwQ3N4yYFj1spms
	98lvsMKzbeyE/Cvs9NF+L34DGS6/wo0cCjkwmurG9gU5g9A8pnc3CoDzTgMX80Uw
	ihXfKGnf7hELLB3TR14YVtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=O3YsBXxCYM8lIbAr/vZC2gCbIJUzGKc76V44jO3lu463BL
	HMGIY/WNKGuD74MJRFEr42PNClEO6S0ntABVZ8ye++HxPtZqB7len7ikCp/AqfRO
	Ufk2NB82frZpmBzACfIiFF7suCItTuMnqo3/Pn03SxuXA3FY73G5BYYyPDUdU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 467C77EF4;
	Thu, 16 Feb 2012 15:11:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5B797EF3; Thu, 16 Feb 2012
 15:11:53 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 78192D30-58DA-11E1-B356-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190905>

Jeff King <peff@peff.net> writes:

> I prepared this on top of what you have queued in jk/config-include.
> However, all of the cleanup is semantically independent of the topic
> (though there are a few minor textual conflicts). If I were re-rolling,
> I would put it all at the front, then squash patch 8 into my prior
> "implement config includes" patch.

Sorry for being late in answering the "revert or build on top" question; I
was mostly offline yesterday afternoon.

>   [7/8]: config: eliminate config_exclusive_filename
>
> This is all cleanup which makes config_exclusive_filename go away. It's
> not strictly necessary for this series, but it's something I've been
> wanting to clean up for a while. And it does fix a few minor bugs (see
> patch 6/8). And the refactoring in 5/8 lays the groundwork for 8/8.
>
>   [8/8]: config: do not respect includes for single-file --list
>
> The actual fix for the regression in my config-include patch.

Thanks.

Looking at the rebased result, it strikes me that with_options version

    Furthermore, by providing a more "advanced" interface, we
    now have a a natural place to add new options for callers
    like git-config, which care about tweaking the specifics of
    config lookup, without disturbing the large number of
    "simple" users (i.e., every other part of git).

perhaps wants to get a pointer to struct config_lookup_options, instead of
us having to add a new parameter to all callsites every time a new need
is discovered.
