From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] transport-helper: check if remote helper is alive
Date: Mon, 08 Apr 2013 14:21:23 -0700
Message-ID: <7vtxngvhv0.fsf@alter.siamese.dyndns.org>
References: <1365320706-13539-3-git-send-email-felipe.contreras@gmail.com>
 <20130408005155.GA24030@sigill.intra.peff.net>
 <CAMP44s0PYARrCQxyBOiGzCAKTXqGp5yrKyfVwLjE1CyuxVSU2A@mail.gmail.com>
 <20130408023351.GA32558@sigill.intra.peff.net>
 <CAMP44s1cphJ5wojt2OeZjWJVOi5AMQJR2jN_BCkQw0B0BxpUfA@mail.gmail.com>
 <7vtxngyl30.fsf@alter.siamese.dyndns.org>
 <CAMP44s2PJGJQBM86CGsA5BOn1RLi4mqNsq+d0oyY0jA=XHQGDA@mail.gmail.com>
 <7vwqscx3l5.fsf@alter.siamese.dyndns.org>
 <CAMP44s0DjJL44uavM44sxgSyrgbTLpUarEPB6=-imvw1rewOOA@mail.gmail.com>
 <7vy5csvih8.fsf@alter.siamese.dyndns.org>
 <20130408211154.GA10310@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:21:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJVK-0004xS-Qk
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936193Ab3DHVV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:21:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49714 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936120Ab3DHVV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:21:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D6E915B97;
	Mon,  8 Apr 2013 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1B5NN7KogovTEW0JFXdFt/ffxIQ=; b=IrZkwx
	nBepraoGswE9dhCM3Sj2Bmp1zOj+x8bRXuRis3ztYsjqpmtb+DbISPZcLYZukRsp
	4kE8lE9sVb+CZTxI7oUiTZ1Ytp8qdn/lR0FF0RLmPaNagGUC/BY+xkY+ZEQPX0FM
	hSCYDVqcydIE91CReic1Jh29BZVT4hBap/X3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JeFE5MRNBqLb+Iy8CuY9gtMIZkzFV6LH
	JmpQ6IT8NtcWzjUVL8asDdi1VQEeMwI8JJmIgxzxg+wssQ2RdIdpvIfO29Gi1syX
	fBH4ypKPtCWYAUd48XvXru8fkjdXE1Mbr5m0tGOfF0AE6UkolZB1jnKLEubBjUNd
	5RJRvZx8WWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 948A715B96;
	Mon,  8 Apr 2013 21:21:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEC6815B91; Mon,  8 Apr
 2013 21:21:24 +0000 (UTC)
In-Reply-To: <20130408211154.GA10310@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 8 Apr 2013 17:11:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4474D712-A092-11E2-934C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220519>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 08, 2013 at 02:08:03PM -0700, Junio C Hamano wrote:
>
>> OK, so you are envisioning that transport-helper would read from the
>> helper after importer is done?  If so, perhaps it is a prudent
>> solution to disconnect in this version (to fix), and then in a
>> separate patch that adds such an extension (I imagine it would
>> involve that the helper advertising a capability or being invoked
>> with an option to let transport-helper somehow know that it should
>> continue the conversation once fast-import is done) to disable the
>> disconnect here when that extension is in use?
>
> At this point, I am of the opinion that it's OK to just do nothing;
> modern helpers should be using the "done" flag, and if they aren't, then
> that is the right place for the fix. Then we don't have to worry about
> any side effects of disconnecting, or adding a new capability flag.

Sounds sane.  Thanks for unconfusing me ;-)
