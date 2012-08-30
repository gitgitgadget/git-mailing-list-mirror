From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] "git name-rev --weight"
Date: Thu, 30 Aug 2012 08:06:33 +0100
Organization: OPDS
Message-ID: <068F712399864538B59054590881E19C@PhilipOakley>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org> <1346275044-10171-1-git-send-email-gitster@pobox.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Greg KH" <gregkh@linuxfoundation.org>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 09:06:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6ypr-0007DN-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 09:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab2H3HGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 03:06:33 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:45655 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751912Ab2H3HGc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2012 03:06:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4NAKkPP1BZ8rU+/2dsb2JhbABFi0OuOAQBAQJ3gQiCGwUBAQQBCAEBLh4BASELAgMFAgEDFQELJRQBBBoGBxcGARIIAgECAwGHdgq8RosIMBNNC0sag3lgA4gahUKYD4Jk
X-IronPort-AV: E=Sophos;i="4.80,338,1344207600"; 
   d="scan'208";a="401941213"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 30 Aug 2012 08:06:30 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204525>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, August 29, 2012 10:17 PM
> So here is an attempt to teach "name-rev" a mode that tries to base
> its name on oldest tag that can reach the commit.  It needs the
> reset_revision_walk() call recently added to the revision traversal
> API, and applies to bcc0a3e (v1.7.11-rc0~111^2~2) or newer.
>
> Note that this can benefit from caching, as the "weight" of the tag
> (rather, the commit that is tagged) will never change once a history
> is made, but that part is left as an exercise to the reader.

Is "--weight" the right term to use for the user (cli) interface? 
Wouldn't '--oldest' (or similar) be a better statement of what is 
desired (absent clock skew).

While 'weight' may be a good internal technical description it didn't 
convey to me what was being sought (maybe -- deepest'?).

>
> It correctly names 0136db586c in the kernel history as based on
> v3.5-rc1 as tags/v3.5-rc1~83^2~81^2~76, not on v3.6-rc1, as we saw
> on the list recently.
>
> Once it is verified to operate correctly and updated to perform
> properly, we can start passing --weight when "describe --contains"
> runs the command.
>
> Junio C Hamano (3):
>  name-rev: lose unnecessary typedef
>  name_rev: clarify when a new tip-name is assigned to a commit
>  name-rev: --weight option (WIP)
>
> builtin/name-rev.c | 142 
> ++++++++++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 120 insertions(+), 22 deletions(-)
>
> -- 
> 1.7.12.285.ga3d5fc0
>
