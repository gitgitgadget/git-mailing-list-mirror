From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH]: reverse bisect v 2.0
Date: Tue, 04 Oct 2011 16:27:24 -0700
Message-ID: <7v62k4ban7.fsf@alter.siamese.dyndns.org>
References: <20110929142027.GA4936@zelva.suse.cz>
 <20111004103056.GB11236@sigill.intra.peff.net>
 <7vfwj8dbn0.fsf@alter.siamese.dyndns.org>
 <201110050034.46334.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Michal Vyskocil <mvyskocil@suse.cz>,
	git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 01:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBEOe-0001nV-ES
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 01:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933818Ab1JDX1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 19:27:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933678Ab1JDX13 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 19:27:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C934464EB;
	Tue,  4 Oct 2011 19:27:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MIjzVz5ptaCCOL9rLyDAQcMb/Xg=; b=LPmElz
	hNkReDNQ5clIH8zGjhjLc7oHSYmhEdCF+kbLSIUs7vQWS5hB5KOgsL/8m72b39oO
	UfwZpVsFdSFydPorQFB7lqBRldqBbQJSL7/ifWRl2qw0ASE9CSkY0xZoiEYr7Hte
	ae8sv1s3UUPkXt9X6XXByvspmESjM1H6NBHOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X6brGcFq29oEQcbWOQwJFJDLzaxDQTZT
	RJWfzXZCZoNqGC1Jo2E5HeLwyH1U1X19JueLcC7SS7zhiqnv78OqKA8MpAygSaqM
	BjK8XMOgySo5rPcHcD63dm+6oSUoe8jHC+fwVLJf1uXxCyQr4SL+LYqhGHCLjwXW
	z1Nbrbz86Og=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDFE364EA;
	Tue,  4 Oct 2011 19:27:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CCB964E8; Tue,  4 Oct 2011
 19:27:26 -0400 (EDT)
In-Reply-To: <201110050034.46334.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed, 5 Oct 2011 00:34:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B695B00-EEE0-11E0-8E22-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182816>

Christian Couder <chriscool@tuxfamily.org> writes:

> If we decide to go with yes/no, an option like:
>
> --yes-means=<it behaves like this>
>
> seems to me easier to understand. Though I recognize that it doesn't tell that 
> the behavior changed.

What problem are you trying to solve?

As I already said while discussing --has-property vs --used-to, I think
that --yes-means shares the exact same downside as --has-property.

The --used-to proposal was to make sure that people who are bisecting to
find fixes would not by mistake say

	git bisect start --used-to='work fine'

as it is very clear that bisecting in a history with something that used
to work fine is _not_ hunting for a fix.

When the users say

	git bisect start --yes-means='frotz is broken'

is it clear to them that they are supposed to define what used to be the
case (in which case "yes" is always mapped to "good")?  If you are trying
to allow them to say either old or new behaviour with --yes-means, how
does your "bisect" know if it needs to map "yes" to "good" (regression
hunting), or "yes" to "bad" (looking for a fix)?
