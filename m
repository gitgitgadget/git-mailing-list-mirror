From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modernize fetch/merge/pull examples
Date: Wed, 21 Oct 2009 14:38:48 -0700
Message-ID: <7v3a5c2zrr.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021030608.GA18997@atjola.homenet>
 <7vk4ypb71j.fsf@alter.siamese.dyndns.org> <20091021172123.GB27495@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 21 23:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0itg-00089k-ED
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 23:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759AbZJUVi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZJUVi6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 17:38:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbZJUVi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 17:38:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE4A611DB;
	Wed, 21 Oct 2009 17:39:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6WMaRGdUu0V5EOUtQVt6ku+xhCQ=; b=alOCcK
	oNDZ+oEdNYmWfBSr1x/+wdsEqNx/+/rGwpPn8E1jclX+mGWiABEK19gHqxbie0wJ
	BMbCaW546RKifTRLMQfIwLHbvrwmrbqhmKqsYk3i+vkbs+UH83BbuYc2TjZmWD37
	yA+tPdaThf7fOkcNvjyPwsXJQapA09v9wUM+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AkDOPoB9GiptF7lL1l34lplwbnh4dIn3
	ZPINhgeDPUDDWebI8MpMxmxUS8JEWEcjVEros1x+++rMW/VKlbRFX+cCGL68ucFv
	CY27ESzdJzaaKFzNvnn4J60MNowN9/MRdx+S46WMotExpJRiA2MHdaMcv8cPbiV8
	b2T+8mJe25o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E72B5611D8;
	Wed, 21 Oct 2009 17:38:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00565611D7; Wed, 21 Oct
 2009 17:38:49 -0400 (EDT)
In-Reply-To: <20091021172123.GB27495@localhost> (Clemens Buchacher's message
 of "Wed\, 21 Oct 2009 19\:21\:23 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 225F9682-BE8A-11DE-9238-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130971>

Clemens Buchacher <drizzd@aon.at> writes:

> The "git pull" documentation has examples which follow an outdated
> style. Update the examples to use "git merge" where appropriate and
> move the examples to the corresponding manpages.

Makes sense, although I did some minor rewording.

I noticed something related while reading this (the issue does not affect
the validity of this patch).

> +* Merge branch `maint` into the current branch, but do not make
> +  a commit automatically:
> ++
> +------------------------------------------------
> +$ git merge --no-commit maint
> +------------------------------------------------
> ++
> +This can be used when you want to include further changes to the
> +merge, or want to write your own merge commit message.

When you are up to date with maint this would be a no-op, and when you are
strictly behind maint it will succeed without creating a new commit.

I have two possible approaches to fix this issue.
