From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Mon, 15 Apr 2013 08:00:41 -0700
Message-ID: <7vwqs3zvmu.fsf@alter.siamese.dyndns.org>
References: <20130413152257.GB16040@pvv.ntnu.no>
 <20130415.063809.1055555229072260139.chriscool@tuxfamily.org>
 <20130415095339.GA28480@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URktl-0002Hp-CP
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab3DOPAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:00:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40404 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab3DOPAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:00:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A82F14EA0;
	Mon, 15 Apr 2013 15:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mvNTNHTE8QN8XL5vNieXpTqp+kM=; b=q6YGv2
	zBaS0tk6XNmWBOdqxkIyGwR9/mYWkOfo6mEUlg+g2NWn3ZC/TaBcR5AEWaV5+IkJ
	G7ZX0deyJPtIldwKWGLNDB1c3oTcY7Aoy+mnFqWBYvNwSmZGFBRICQyNyO7327DZ
	wRqKBDcUUdDMWNGOgRAEuicOuktKgBjpbeQoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VzplrPbls66pV8Loa18iDqc4zXJoSTK5
	rIeMX2BmUIHvdH4q03Klvpq7R7qr4FOFIAHq/n67apu8dpuHWc1OCl8pdcH4KGkT
	zm+a85g3TMDNobkAtJUj6GbRrvs8y/OqXLAIj5oGFsWaQeMB+MbPPI1IrM8/z5un
	4AhkvvRrOkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01AA914E9E;
	Mon, 15 Apr 2013 15:00:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D44914E9B; Mon, 15 Apr
 2013 15:00:43 +0000 (UTC)
In-Reply-To: <20130415095339.GA28480@pvv.ntnu.no> (Torstein Hegge's message
 of "Mon, 15 Apr 2013 11:53:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3ED77A80-A5DD-11E2-BE9E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221235>

Torstein Hegge <hegge@resisty.net> writes:

> I was wondering why "git grep show-ref *.sh" gave so few users. It looks
> like rev-parse is more common.

It is primarily because show-ref is slightly newer.  When you have a
full refname (e.g. refs/bisect/bad) and not an arbitrary object name
that is spelled in a random way (e.g. master~24):

       show-ref --verify refs/bisect/bad

is a perfectly valid way to make sure it _is_ an existing ref.

Cf. 358ddb62cfd0 (Add "git show-ref" builtin command, 2006-09-15)
