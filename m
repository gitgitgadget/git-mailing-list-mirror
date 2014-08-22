From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 11:21:47 -0700
Message-ID: <xmqqwqa0o05g.fsf@gitster.dls.corp.google.com>
References: <20140822151911.GA8531@debian> <20140822154445.GA19135@peff.net>
	<xmqq1ts8peud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:22:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtTO-0002q6-H0
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbaHVSV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:21:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59800 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbaHVSV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:21:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD86A32B03;
	Fri, 22 Aug 2014 14:21:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+BY1fRDJF7HZaY5NfzhDHSZLqdk=; b=l8AjLj
	2XJKRGwBfGeCV5VNCveXCSSHBqBTO9ELfUcl+i7lUg3QDs1sw0IhPy2n4bamTSjk
	KYs9IKnHeEO0+oplkwtqsQmbqB+Vg1onSiYjuzbJuKSIize2sLjAEuQFWj8R+9yC
	0FtCIgnV9m2Sg0XyYWxe7lKHxVopQkbBoyyto=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUpxeUjqoloXlpIuKSW2q2uq5w0Any8o
	+5NRTntfOeIa/yolU8E8D/k7gL+GL1jbSBWidjmzHSlZp5yURcVBu7c8iG0zWX6Y
	rce/tMetC87vG8pMALGf82njYBlVR13PAlZdOJLm066Mhi27PAdyP8v1NxqV886P
	jy+epRDbSvw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FF5F32B02;
	Fri, 22 Aug 2014 14:21:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0017732AF2;
	Fri, 22 Aug 2014 14:21:48 -0400 (EDT)
In-Reply-To: <xmqq1ts8peud.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 22 Aug 2014 11:19:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2E7FDE9E-2A29-11E4-A760-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255689>

Junio C Hamano <gitster@pobox.com> writes:

> There is 1000 * wakeup in credential-cache--daemon.c, by the way.

Ah, nevermind.  That uses an expiration computed, not some "we can
choose to block indefinitely" configuration.
