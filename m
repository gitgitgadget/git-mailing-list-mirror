From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] check_expirations: don't copy over same element
Date: Fri, 16 Sep 2011 11:47:18 -0400
Message-ID: <20110916154718.GA13740@sigill.intra.peff.net>
References: <a6397f7f28a5adcd34aeac98cca6500e336698aa.1316173346.git.trast@student.ethz.ch>
 <29010bf6134beb20efca498e7b4f7a9d9bdb21a6.1316173346.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 16 17:47:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4adV-0006eZ-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 17:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab1IPPrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 11:47:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46010
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811Ab1IPPrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 11:47:24 -0400
Received: (qmail 364 invoked by uid 107); 16 Sep 2011 15:48:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Sep 2011 11:48:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Sep 2011 11:47:18 -0400
Content-Disposition: inline
In-Reply-To: <29010bf6134beb20efca498e7b4f7a9d9bdb21a6.1316173346.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181535>

On Fri, Sep 16, 2011 at 01:51:35PM +0200, Thomas Rast wrote:

> diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
> index d6769b1..128c5ce 100644
> --- a/credential-cache--daemon.c
> +++ b/credential-cache--daemon.c
> @@ -77,7 +77,8 @@ static int check_expirations(void)
>  			free(entries[i].item.unique);
>  			free(entries[i].item.username);
>  			free(entries[i].item.password);
> -			memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
> +			if (i != entries_nr)
> +				memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));

Thanks. I even remember while writing this loop considering the case of
(i == entries_nr), but decided it didn't need special-casing. But I
obviously forgot about memcpy.

Both this and the prior patch are:

Acked-by: Jeff King <peff@peff.net>

-Peff
