From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Wed, 05 Mar 2014 11:18:17 -0800
Message-ID: <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
References: <20140304174806.GA11561@sigill.intra.peff.net>
	<xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
	<20140305005649.GB11509@sigill.intra.peff.net>
	<xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
	<20140305185212.GA23907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:18:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHKk-0001Ii-JW
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbaCETSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:18:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59442 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbaCETSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:18:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9100D70537;
	Wed,  5 Mar 2014 14:18:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JIfGxxLP3Md/eIjadVOIccIITA4=; b=n+vgvZ
	bzPcfMBuSVYoYgP1SnRjPt6eznHzGPGQnRUa5c/b6OGFJMuRVrTL4IWj2p5JwUSA
	PrHVGkMZcifBKhuG/6M8qjApRZk4gSY7f0pG4sw9WpPMrImuNUhzZZqMYM1lbHxt
	yxhaM2izUOgQ+WCqdKX5tKBhUMX0/iG7p6ZOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qpv5Jxi3+WdQWfpSozq68xZEUzARLgdV
	eblWd5heniOlg5AsG2JWm6zNX6UiIAt1j9PsJF+wtTUA84lLXlxuZuSx+xYnlefs
	IJFXoEszfKkhaafVdGPdEMepV0XW4rh/D0/H5wcJnLxuU1zpRjdhSA2xkNidJA1O
	tQ5SeoJAsxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D61570536;
	Wed,  5 Mar 2014 14:18:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAF7670535;
	Wed,  5 Mar 2014 14:18:19 -0500 (EST)
In-Reply-To: <20140305185212.GA23907@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 5 Mar 2014 13:52:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9499068-A49A-11E3-AC49-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243469>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 05, 2014 at 10:49:24AM -0800, Junio C Hamano wrote:
>
>> ... the plan, at least in my mind, has always been exactly that: grafts
>> were a nice little attempt but is broken---if you really wanted to
>> muck with the history without rewriting (which is still discouraged,
>> by the way), do not use "graft", but use "replace".
>
> I certainly had in the back of my mind that grafts were a lesser form of
> "replace", and that eventually we could get rid of the former. Perhaps
> my question should have been: "why haven't we deprecated grafts yet?".

Given that we discourage "grafts" strongly and "replace" less so
(but still discourage it), telling the users that biting the bullet
and rewriting the history is _the_ permanent solution, I think it is
understandable why nobody has bothered to.
