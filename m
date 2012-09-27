From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: add --reflog-message to grep reflog messages
Date: Thu, 27 Sep 2012 11:16:58 -0700
Message-ID: <7vbogrqqjp.fsf@alter.siamese.dyndns.org>
References: <7va9wctwg4.fsf@alter.siamese.dyndns.org>
 <1348745786-27197-1-git-send-email-pclouds@gmail.com>
 <7v4nmjs88n.fsf@alter.siamese.dyndns.org>
 <20120927172844.GC1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:17:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THIe8-0003zm-25
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab2I0SRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:17:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868Ab2I0SRB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:17:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A5C886AD;
	Thu, 27 Sep 2012 14:17:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dLjYLx6NiTA3ylghmL1VfiqtwvA=; b=Y1NZj2
	HPlVn/pOmVCpCtOzgYCxezySEp4M1hMVZZF/1flyZsVDTy3ngEV+82od3YQNAngy
	rt8HvnXDNEbalcXXhWl8x6Je6AqfCFEVzSorAxk4qkEQqxrhn6JHIWnAtwYThS5E
	KhcwSciceqyzwlCYKAhSs8r91yw1sbLAfMKMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AWOLmHC5Y0Wth8m4of4qE6+mnSgcUaKk
	CCbwJtnxSHFEFZr+1h4CXeDJnsxhyS0HRHTGschQZZhg4F9Rn0ZohuOhj+gKEe9B
	A3hpexzOPgc8CsxKv5bj6hIN5xqeqdfQEVpXAv9qD7q2UUt5LIodimJ90CVgSnAd
	w2WuFrmEhKs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E4B86AC;
	Thu, 27 Sep 2012 14:17:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3BEB86A9; Thu, 27 Sep 2012
 14:16:59 -0400 (EDT)
In-Reply-To: <20120927172844.GC1547@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Sep 2012 13:28:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 878EA8C6-08CF-11E2-BD45-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206502>

Jeff King <peff@peff.net> writes:

> I actually think just checking the reflog when we call "--grep" would
> the most common workflow, and requires no extra work from the user.  My
> only hesitation is that if somebody _does_ want to distinguish, there's
> no escape hatch. Of course, the reflog walker is already full of such
> weird conflations (e.g., the rewriting of parent and date information).

Yes, that reasoning more-or-less matches the reason why I said we do
not necessarily want to go "fancier".  But "log -g" output already
makes it fairly clear that the additional information is not part of
the regular log and is a some header-like thingy, so I actually am
OK with --reflog-grep and --grep being different.

The output from "log --show-notes", on the other hand, is even more
conflated and a casual user would view it as part of the message, so
I would imagine that if we ever do the extention to cover notes
data, the normal "--grep" should apply to it.
