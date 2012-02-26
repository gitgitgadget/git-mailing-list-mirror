From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: do not print dangling objects by default
Date: Sun, 26 Feb 2012 14:46:46 -0800
Message-ID: <7vhayddxgp.fsf@alter.siamese.dyndns.org>
References: <20120226204357.GA26088@ecki>
 <7vty2ddzqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Feb 26 23:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1mrn-0000GL-3A
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 23:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753151Ab2BZWqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 17:46:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016Ab2BZWqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 17:46:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AEF7152;
	Sun, 26 Feb 2012 17:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M90p5P4U7Zhaf6D0MTGUh4S0/Vc=; b=fAJSpD
	HlQmdATOsthR3HlkP2uBaugX/fn3jitQtsCt5iWtvAbvrL3xt9++Mmd2P0m5h8sO
	Ew3BL8e8Lf7+p8LjrSAa+FbcVpDaMB1WK1y74rMHYby/h8fEHYfkvPt0s5N8CzCO
	4E0z1UVgjYeCVWaWneHffAu+bBfGJL61JyHos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ux9SPDUNSBSb96YIbltLsogSknTxMRRr
	iBY5zVCuZOQ+e2+NpeUhAIiZkM2lN8ylUALXAY9IVNuZ90C0nU+LUMjvaJrEeryA
	QaoNZTi9ZCQgREusCExNjF1ise60//YIUBtmeNpWWVniip/x2nWvnveP7doEDb6S
	0M32c9+b+eI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBBF57151;
	Sun, 26 Feb 2012 17:46:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 487EF7150; Sun, 26 Feb 2012
 17:46:48 -0500 (EST)
In-Reply-To: <7vty2ddzqj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 26 Feb 2012 13:57:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C422E16E-60CB-11E1-AE71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191580>

Junio C Hamano <gitster@pobox.com> writes:

> I think that both the ultimate goal explained above, and the direction in
> which the documentation updates tries to move us, are good.  I only gave a
> cursory look at the code changes, but what they implement seems to match
> the intention.
>
> Of course I may be missing something, so objections from others to argue
> why we shouldn't do this is very much welcomed to stop me and Clemens ;-).

Let's start with the obvious.

It is much easier for a user to use a new option on the command line when
he wants to use an improved behaviour when he runs the command manually.
Having to update scripts that run the command to act on its output, on the
other hand, is much more painful to the users.

And the intended audience for this change clearly is interactive users
that follow the user-manual to try things out.

Given that, isn't it not just sufficient but actually better to instead
add a new --no-dangling option and keep the default unchanged?
