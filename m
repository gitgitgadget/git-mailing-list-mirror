From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Wed, 29 Aug 2012 14:18:02 -0700
Message-ID: <7vy5kxv1md.fsf@alter.siamese.dyndns.org>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 23:18:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6ped-0008Mc-AL
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 23:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606Ab2H2VSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 17:18:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab2H2VSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 17:18:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C22E8CDF;
	Wed, 29 Aug 2012 17:18:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rup2AqeHqWfy80wLNQrIwpYq1YU=; b=QgQ1Qh
	rh96HWed1n4QJOpTwyAENnbZZ4onSu0jJGjI9Nv10IIkwdwA9oMw2lJZ3RH4y1Wn
	glCfaslBTiMTdmeuezk0VD2JbVHKbZgf1tlmoET8uAEcSW38LT0XSwnmPegTJsCP
	269J345nBUV14HRQL5c4xiwICbRg2EUQoTtns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WxJ82lQiGw2qU66hpb9qZBr9CMWZqK6f
	2H092I9J+akmPCfoI92b+JyaOtkrbGixlISE3rPP3ctB+0P7YEAqIqcdRxYD+68X
	b4xuPMby5yVDjD1yAcn6g+BtAoeLrNqVhcIyQo4zkL/8V0m6GirPu6HvysKYdOqJ
	3IkUltGUIlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E3E8CDE;
	Wed, 29 Aug 2012 17:18:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F26258CDD; Wed, 29 Aug 2012
 17:18:03 -0400 (EDT)
In-Reply-To: <20120829210032.GA29179@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 29 Aug 2012 17:00:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0505D486-F21F-11E1-929C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204504>

Jeff King <peff@peff.net> writes:

>> +	while (result.nr)
>> +		commit_list_append(queue_pop(&result), &tail);
>> +	queue_clear(&result);
>> +	queue_clear(&list);
>> +	return ret;
>
> I forgot to to port the STALE flag handling here.

Figures..  Thanks.
