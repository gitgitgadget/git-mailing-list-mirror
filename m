From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Archiving off old branches
Date: Wed, 23 Apr 2014 10:43:07 -0700
Message-ID: <xmqqzjjcymac.fsf@gitster.dls.corp.google.com>
References: <20140423120850.3f6fb535@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:44:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd1DO-0002wX-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757276AbaDWRoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:44:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58121 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757263AbaDWRoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:44:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C39887EF9D;
	Wed, 23 Apr 2014 13:43:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7QyP4RchIfjzTVD/M9BfQ2kY+YM=; b=gTzkOc
	ahUSTCLrtIJuAgwCgZ/FEhELmPkWX9N+0QiBxWI8SUL1fXK3nCdYVvtH3XgLW74U
	Cv/2ylDQR3e/mrxZ2F9peGmr/llAQpYP0b1szV8xt5D+mu31C0lacWg1CR7zWLsY
	F/UlRe73BhRznxOH1oIgrSl8cQUug+ec7c4OI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yiPWyDTOGKmU90sRfeAhMboM9lAnW37v
	dZjP5ROLy7ugJlskAfA+cdxZMxPFsUwEZjrSey9dKmLsjNelK6/vDF48DY5LiCPr
	cudlEo6VmkWRr8DsSPAkRGIp+hC8Z0X/6pn1IAKfY19VKm53NeIpMsNeAWWh6K9p
	OjsV6j9zEQM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABA8F7EF9B;
	Wed, 23 Apr 2014 13:43:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E939A7EF6A;
	Wed, 23 Apr 2014 13:43:08 -0400 (EDT)
In-Reply-To: <20140423120850.3f6fb535@bigbox.christie.dr> (Tim Chase's message
	of "Wed, 23 Apr 2014 12:08:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BBABD25C-CB0E-11E3-B876-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246857>

Tim Chase <git@tim.thechases.com> writes:

> Reading up on "git help update-ref", it states that it updates the
> name "safely".

I think that description is well intended but is misleading.  There
are many potential sources of risk, and the "safely" refers to
protection against a particular kind of risk: updating from a value
that you did not intend to (i.e. you examined and decided the update
is good, time passes while somebody else might have mucked with the
ref, and then you execute the update you decided to do).  And the
safety afforded to you is with "git update-ref ref newvalue oldvalue"
that makes sure the ref still points at the oldvalue and refuses to
update it to newvalue if it doesn't.
