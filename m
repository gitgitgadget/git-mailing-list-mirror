From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: improve description of --glob=pattern and
 friends
Date: Thu, 21 Jan 2010 16:51:06 -0800
Message-ID: <7v1vhjj72d.fsf@alter.siamese.dyndns.org>
References: <7vbpgnp6d5.fsf@alter.siamese.dyndns.org>
 <e2e992cfb93335b400fd9ec67c6d38cb0157b006.1264119524.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:51:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7kG-0003AB-8E
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:51:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab0AVAvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023Ab0AVAvY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:51:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0AVAvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:51:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 17B6F936A8;
	Thu, 21 Jan 2010 19:51:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yj9QPlrLayHtiYVWrlGgTfwEkbw=; b=yioH/2
	M0ydqqIdlKARQAFHz82o+9COvOrxV4qVV6eFkFSsMNw8K77/tHEh4EAkPQNJNalf
	OcD+nwO5K20PPwTq9XWVpyRjMwak165sx0aDTATdyZASfHArMAX92xEzGo2xorEs
	bg8css2psR+imjh8h6Okd3J40mjhKi6WfjvAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tUcPUtauBv1uBy4zIVH5cGtRGtCVvNHb
	qzkMzE/w9IjO7Ijfw36LBwEspgR+kQ4HUTdnKU9hD52QWeaoqGXld/NfO1vC7vQI
	4py2LyWQqH/giGsmR86PCU/wvF0bnYDoeRD1eCTdFz4wu+EUPtI4zQiqPhrRsSr9
	y3IRdbj1BmI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B644A936A6;
	Thu, 21 Jan 2010 19:51:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8400F936A5; Thu, 21 Jan
 2010 19:51:07 -0500 (EST)
In-Reply-To: <e2e992cfb93335b400fd9ec67c6d38cb0157b006.1264119524.git.trast@student.ethz.ch> (Thomas Rast's message of "Fri\, 22 Jan 2010 01\:21\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3E0A4572-06F0-11DF-ABEF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137709>

Thomas Rast <trast@student.ethz.ch> writes:

> Consolidate the descriptions of --branches, --tags and --remotes a
> bit, to make it less repetitive.  Improve the grammar a bit, and spell
> out the meaning of the 'append /*' rule.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> Compared to the earlier draft, I changed "it is anchored" (by
> appending '/*') to "it is turned into a prefix match", since this is
> not anchoring in the ^regex$ sense.  (I guess 'leading-component
> match' would be even more accurate, but that makes the sentence
> unwieldy in my ears.)

By the way, we may someday want to change that to do FNM_PATHNAME instead
of just a flat glob.

Incidentally, that is why I prefer the earlier suggestion to do "check
with memcmp() if it is a path-prefix, and if it fails, then give
fnmatch(FNM_PATHNAME) a chance".  That way, we don't have to say "by
appending '/*'" (which is an implementation detail we can change).

It seems that the suggestion was ignored, though.
