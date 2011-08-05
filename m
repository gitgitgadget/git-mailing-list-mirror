From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/5] macro-based key/value maps
Date: Fri, 5 Aug 2011 05:03:02 -0600
Message-ID: <20110805110302.GA23619@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
 <20110713065700.GA18566@sigill.intra.peff.net>
 <20110713175250.GA1448@elie>
 <20110713200814.GD31965@sigill.intra.peff.net>
 <20110714173454.GA21657@sigill.intra.peff.net>
 <7vipr4373f.fsf@alter.siamese.dyndns.org>
 <20110804224354.GA27476@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 13:03:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpIBP-00069m-85
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 13:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab1HELDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 07:03:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58303
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753006Ab1HELDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 07:03:06 -0400
Received: (qmail 29484 invoked by uid 107); 5 Aug 2011 11:03:40 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Aug 2011 07:03:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2011 05:03:02 -0600
Content-Disposition: inline
In-Reply-To: <20110804224354.GA27476@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178787>

On Thu, Aug 04, 2011 at 04:43:54PM -0600, Jeff King wrote:

> Well, if you like that, then here is the end-result of what the
> persistent version would look like. It's quite convenient to use, but an
> awful pain to debug.  It's done entirely in the preprocessor; I suspect
> if I wrote the code generation externally, that would be easier and more
> readable (and there are one or two places where we could be slightly
> more efficient, that are just difficult to implement via the
> preprocessor).
> 
>   [1/5]: implement generic key/value map
>   [2/5]: fast-export: use object to uint32 map instead of "decorate"
>   [3/5]: decorate: use "map" for the underlying implementation
>   [4/5]: map: implement persistent maps
>   [5/5]: implement metadata cache subsystem

Side note:

  Commits 1, 4, and 5 introduce infrastructure in the form of static
  functions and macros that contain functions that call the statics. But
  they don't actually instantiate the macro functions themselves, so
  they won't compile with -Werror (due to the "unused static" warning)
  until there is some calling code.

  That hurts bisectability a little if you compile with -Werror (you
  need to add -Wno-error=unused-function). I don't know how much we
  care.

-Peff
