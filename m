From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] commit: shrink "indegree" field
Date: Mon, 8 Apr 2013 23:52:50 -0400
Message-ID: <20130409035250.GB17319@sigill.intra.peff.net>
References: <20130408210903.GC9649@sigill.intra.peff.net>
 <1365462114-8630-1-git-send-email-gitster@pobox.com>
 <1365462114-8630-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 05:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPPcB-0003Vz-1j
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 05:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935704Ab3DIDwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 23:52:55 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34675 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760401Ab3DIDwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 23:52:54 -0400
Received: (qmail 19296 invoked by uid 107); 9 Apr 2013 03:54:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 08 Apr 2013 23:54:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Apr 2013 23:52:50 -0400
Content-Disposition: inline
In-Reply-To: <1365462114-8630-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220546>

On Mon, Apr 08, 2013 at 04:01:52PM -0700, Junio C Hamano wrote:

> +static inline intptr_t get_indegree(struct decoration *indegree,
> +				    struct commit *commit)
> +{
> +	if (commit->indegree < QUICK_INDEGREE_LIMIT)
> +		return commit->indegree;
> +	else {
> +		void *count = lookup_decoration(indegree, &commit->object);
> +		return (int) count;
> +	}
> +}

Should that cast be to intptr_t?

-Peff
