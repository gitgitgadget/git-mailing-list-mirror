From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Mon, 14 Oct 2013 15:45:42 -0700
Message-ID: <xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
References: <20131014202734.GA7007@sigill.intra.peff.net>
	<xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
	<20131014223137.GA12744@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 00:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVqtZ-0004cC-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 00:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab3JNWpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 18:45:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757523Ab3JNWpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 18:45:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C604ACD1;
	Mon, 14 Oct 2013 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5X2LTMrcyenxY6KZ95aJ4c3jW14=; b=gCsQNP
	F5mQUOVOAJrbS+cbIzIcIcWxJmn9o++2TdkRvkw9kbPXoLax8KPH6vBDJ5kLEFH8
	9JVdTeVauNwkTSM9Dj5godcUbHpHHaI9V9WbccH5a8TB/b4/bzojT2YXZeMeEjwG
	XP/2BdI+HXekxH/5OFVKCYcJU22PE07zTnAs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iShN7AiQEuuJF46FERNy3LUIEWGz1RYc
	czQyFlxkJJgL2x9dxzQSCoapGket8pYX8FYdhbtQQ4Ld6jAF2snOGwFcPUIjMlPe
	YH1FJz+/1OyaBQNMCu6TkB1022iHrY0y9HvA91a8YnHhf4q/s8F5IMVgEOCpe5ad
	43LfSJN+3V4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6ACC4ACD0;
	Mon, 14 Oct 2013 22:45:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 541FE4ACCE;
	Mon, 14 Oct 2013 22:45:44 +0000 (UTC)
In-Reply-To: <20131014223137.GA12744@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Oct 2013 18:31:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C36F64E-3522-11E3-92E5-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236144>

Jeff King <peff@peff.net> writes:

> Yeah, you are right[1]. I'm happy to re-roll. I wonder if we even need
> to worry about a compatibility wrapper. We are already doing pointer
> manipulations, and it is probably just as readable to roll the loop by
> hand.

Yeah, unrolling the loop is probably better.  You may even be able
to do so in a single pass with an extra "last > seen" pointer
variable without too much additional code complexity, I would think.
