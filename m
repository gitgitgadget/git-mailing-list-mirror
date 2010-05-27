From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 2/2] decode file:// and ssh:// URLs
Date: Thu, 27 May 2010 13:50:15 +0300
Message-ID: <20100527105014.GA7865@LK-Perkele-V2.elisa-laajakaista.fi>
References: <20100523091612.GB26123@coredump.intra.peff.net>
 <20100523091944.GB16520@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Abrahams <dave@boostpro.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 27 12:51:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHagw-0003hg-7O
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 12:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab0E0Kvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 06:51:53 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:56287 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0E0Kvw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 06:51:52 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id CA54AEF7E0;
	Thu, 27 May 2010 13:51:50 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A003D7CAA46; Thu, 27 May 2010 13:51:50 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 48AF22BD4A;
	Thu, 27 May 2010 13:51:45 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100523091944.GB16520@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147843>

On Sun, May 23, 2010 at 05:19:44AM -0400, Jeff King wrote:
> We generally treat these as equivalent to "/path/to/repo"
> and "host:path_to_repo" respectively. However, they are URLs
> and as such may be percent-encoded. The current code simply
> uses them as-is without any decoding.
> 
> With this patch, we will now percent-decode any file:// or
> ssh:// url (or ssh+git, git+ssh, etc) at the transport
> layer. We continue to treat plain paths and "host:path"
> syntax literally.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think this also impacts git:// URLs. Which I is probably a good thing,
> but I haven't looked extensively for unexpected fallouts.

One possible fallout: IPv6 scope syntax uses literal '%' in host
part. The relevant RFC indicates it should be escaped, but in the past
connect would fail if it was... But then, who uses that syntax...

-Ilari
