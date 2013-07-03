From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] format-patch handling in-body From headers
Date: Wed, 03 Jul 2013 01:58:22 -0700
Message-ID: <7vd2r0ggup.fsf@alter.siamese.dyndns.org>
References: <20130703070719.GA17638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 03 10:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuItS-0007Cw-3z
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 10:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403Ab3GCI60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 04:58:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932284Ab3GCI6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 04:58:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A7052B102;
	Wed,  3 Jul 2013 08:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ItNPYNyem6Dh6E5Tjqojtii5J/w=; b=CEyhJI
	iatBoYHGljOmnPOcm4qdxuocNQ3itRMxcqU/LQJbdMw+AfATZq+AD4ZaZ8BUQgG6
	jwk+xCtdNzpGo3GzjPOX6SnV3wFtW67IVlCtz8NMbxGoV54apZIflFnQhdzTL34X
	j1OovLqgKty0s731uXoz4xpDlLXkbXE60o6nA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMhsSocE/cZetP+ao2jK4XtC9ZsBdEXU
	5J0OcFOJHt0DCDIlibGM/hOMCbOixFIsE7tL1HSa8E8PP5k9heCD5Pq8jPikXGzL
	kug7+WSp5TH2v/F33iwgfib7K9n66JGModxc7TJi0/zsJ/AVZExHTZJQG/1QXPcc
	cABRN0d3YO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F13E2B101;
	Wed,  3 Jul 2013 08:58:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B5672B0FC;
	Wed,  3 Jul 2013 08:58:23 +0000 (UTC)
In-Reply-To: <20130703070719.GA17638@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 3 Jul 2013 03:07:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B77FFA92-E3BE-11E2-9C0B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229471>

Jeff King <peff@peff.net> writes:

> However, doing it right is kind of tricky due to rfc822 quoting, rfc2047
> encoding, and handling non-ascii names correctly. Instead, this patch
> series takes a different approach: it teaches format-patch to do the
> transformation itself, so that it can be used by my script along with
> any other non-send-email workflows that exist (e.g., git-imap-send
> suffers from the same problem).

I think the original expectation when format-patch was done was to
use Sender: to identify you while keeping the author on From:, but
with the current world order to use in-body header, this addition
makes sense.

I wonder if we can lose some code from send-email then?
