From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/12] is_refname_available(): reimplement using
 do_for_each_ref_in_array()
Date: Wed, 19 Oct 2011 18:40:55 -0700
Message-ID: <7v4nz4bftk.fsf@alter.siamese.dyndns.org>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
 <1319060692-27216-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 20 03:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGhd2-0006NR-7V
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 03:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641Ab1JTBk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 21:40:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab1JTBk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 21:40:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E938596C;
	Wed, 19 Oct 2011 21:40:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8rZyNkiuSm7ET5OAoTLxfDL2Dnc=; b=X2NkE3
	/onz3ry7VJc+IKBL9bhFv2ihUGb+mzk4F7Ukhbc9qv6m/KP0bADXYJAntpL7w5d/
	OAf82jQj3Jm3cdBJxIt4G1000YLm6Xan8sCJLvaN5Cv9S1QZsXlUatpBS1yKfL8j
	1RpabYctwY50U8AZo6Oe47CQcyblWz7XkzkWU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cxqIGLVzJA+0gFjuc7HHp/Jh6bDB4+8i
	I/qQO9v4sz/VJ6QrYp10XZlsVbcSDpXsolfUEqVODMCQB3KJ8eOG9TTheDf0ztDQ
	CdJBOwZJhDrypM4biVyGwib9yM5MWxVROG34avj0DaFxgR2nu16Tf3gTfwf4eJPX
	ej4Atb4NCZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93C6D596B;
	Wed, 19 Oct 2011 21:40:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EC59596A; Wed, 19 Oct 2011
 21:40:57 -0400 (EDT)
In-Reply-To: <1319060692-27216-13-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Wed, 19 Oct 2011 23:44:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E70A148-FABC-11E0-80CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183998>

Hmm, why is this patch and only this one in the series full of whitespace
violations? Did you use a different settings or something?
