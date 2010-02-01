From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] configure: Allow GIT_ARG_SET_PATH to handle
 --without-PROGRAM
Date: Mon, 01 Feb 2010 13:14:40 -0800
Message-ID: <7vwrywu08v.fsf@alter.siamese.dyndns.org>
References: <1264990505-29578-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:14:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc3bj-00076n-QC
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 22:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899Ab0BAVOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 16:14:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab0BAVOt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 16:14:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51C1F96796;
	Mon,  1 Feb 2010 16:14:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HA1FDISDFLK2Bv67wBSKjOUslds=; b=VWAKtz
	/LfjIzxMdKlRXT0rZPWME/lhUR0RejUmxLMUt/1/p/9vJcYYgRCw2c/VjdF+lBPB
	SR4MUu7EYm/uZuajrp5MNPhN6lHozW4cQu6c1DakG32+rIIRRtEs1ANLu9D8rsyW
	XmSEJbCy5tVt8SehHuUhWlVVrT6USUkB5fra8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JGsNSo+K6vQMGxREBipDmHgV6Jl4v3JO
	c01o1guqPPx7e4uSNBVHhSBrQds4BL3HTZamJuek4upp9YuUtTf4pqDjMv0hLp4T
	WXP69di6SBMApGyhmbRStdklTG3Q+XwmbkEqkQp93hIyGJUqYJx6Q+UwjCxLTc54
	Mtp/i/UA/s4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DD7B96794;
	Mon,  1 Feb 2010 16:14:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DBCC9678D; Mon,  1 Feb
 2010 16:14:42 -0500 (EST)
In-Reply-To: <1264990505-29578-2-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sun\, 31 Jan 2010 21\:15\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D2CA7B62-0F76-11DF-84A0-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138648>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Add an optional second argument to both GIT_ARG_SET_PATH and
> GIT_CONF_APPEND_PATH such that any value of the second argument will
> enable configure to set NO_$PROGRAM in addition to an empty
> $PROGRAM_PATH.  This is initially useful for allowing configure to
> disable the use of python, as the remote helper code has nothing
> leveraging it yet.
>
> The Makefile already recognizes NO_PYTHON, but configure provided no
> way to set it appropriately.
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---

Interesting.

I noticed that even without this patch we seem to honor --without-tcltk
just fine and wondered why.  It turns out that we already do the right
thing when TCLTK_PATH is empty to set NO_TCLTK in our Makefile, but we at
the same time have a long custom code in configure.ac to support tcltk.

Perhaps we can clean-up with-/without-tcltk part in configure.ac using
this?
