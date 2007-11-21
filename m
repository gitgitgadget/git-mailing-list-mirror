From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] send-pack: cluster ref status reporting
Date: Tue, 20 Nov 2007 23:24:55 -0800
Message-ID: <7v1wakhxh4.fsf@gitster.siamese.dyndns.org>
References: <20071120111317.GA4120@sigill.intra.peff.net>
	<20071120111801.GA7814@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:25:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iujxh-0004UQ-Mh
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbXKUHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbXKUHZE
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:25:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45704 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938AbXKUHZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:25:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8CEF52F0;
	Wed, 21 Nov 2007 02:25:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B7DE96351;
	Wed, 21 Nov 2007 02:25:18 -0500 (EST)
In-Reply-To: <20071120111801.GA7814@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 20 Nov 2007 06:18:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65608>

Jeff King <peff@peff.net> writes:

> +static int print_one_push_status(struct ref *ref, const char *dest, int count)
> +{
> ...
> +	case REF_STATUS_REMOTE_REJECT:
> +		print_ref_status('!', "[remote rejected]", ref,
> +				ref->deletion ? ref->peer_ref : NULL,
> +				ref->remote_status);
> +		break;
> +	case REF_STATUS_EXPECTING_REPORT:
> +		print_ref_status('!', "[remote failure]", ref,
> +				ref->deletion ? ref->peer_ref : NULL,
> +				"remote failed to report status");
> +		break;

Eh,... in ref->deletion mode, the peer_ref is...
