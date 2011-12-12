From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Breakage (?) in configure and git_vsnprintf()
Date: Mon, 12 Dec 2011 00:23:28 -0800
Message-ID: <7vr50a6vwf.fsf@alter.siamese.dyndns.org>
References: <4EE4F97B.9000202@alum.mit.edu>
 <20111212064305.GA16511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:23:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1Ai-0001oM-Us
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab1LLIXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:23:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52048 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323Ab1LLIXa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:23:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C82AD2724;
	Mon, 12 Dec 2011 03:23:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r10N4RIEkwaBVY5vSYJdu36DPaY=; b=US5o1i
	AUd5YIk9hEkgsnaaj+Xs3p0t/iC7v9/Xw1zGKvNiM4jPuxhuQHSdwJDTsGmQ+qC2
	HJ+8K0fz0lO80lVEgBZFjO05ZjDUgipzS7rGcdiMcsyyDvGL9d1HY5UWgF80mLD2
	KifzcXzWz0MLbHXXCS72Y6nduVe3bjx/If8F4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WyTmdhE52yfG0jriIG6ORRbH+wVcWOaA
	g+iSoTay1fnSi/rkTJIFRtovi3LQ22srFeVk8K+n8Bz4JypALg5SHjyFAK3akGf9
	V5MoyWW1WRkQnVNNU9WgYWc0sjaHmyKHttR9sJXngGZIZqoXO2ataUSGmKEl2CJP
	0vnzCKZbd0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0AE32723;
	Mon, 12 Dec 2011 03:23:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59E642721; Mon, 12 Dec 2011
 03:23:29 -0500 (EST)
In-Reply-To: <20111212064305.GA16511@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 01:43:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 922CD812-249A-11E1-89A6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186888>

Good analysis; thanks.

Back when c4582f9 (Add compat/snprintf.c for systems that return bogus,
2008-03-05) was done we didn't have va_copy emulation available in
git-compat-util.h but now we do, so I agree that this is an Obviously
Correct thing to do.
