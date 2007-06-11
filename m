From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid double-slash in path names that depend on $(sharedir).
Date: Mon, 11 Jun 2007 01:18:11 -0700
Message-ID: <7v645usy4c.fsf@assigned-by-dhcp.pobox.com>
References: <11815489372169-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxf6U-00033d-CN
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 10:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbXFKISN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 04:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbXFKISN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 04:18:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:49774 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbXFKISM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 04:18:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611081811.PEDB29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Jun 2007 04:18:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A8JB1X0031kojtg0000000; Mon, 11 Jun 2007 04:18:11 -0400
In-Reply-To: <11815489372169-git-send-email-johannes.sixt@telecom.at>
	(Johannes Sixt's message of "Mon, 11 Jun 2007 10:02:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49831>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> diff --git a/Makefile b/Makefile
> index af84af9..c23031c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -144,7 +144,7 @@ STRIP ?= strip
>  prefix = $(HOME)
>  bindir = $(prefix)/bin
>  gitexecdir = $(bindir)
> -sharedir = $(prefix)/share/
> +sharedir = $(prefix)/share
>  template_dir = $(sharedir)/git-core/templates/
>  ifeq ($(prefix),/usr)
>  sysconfdir = /etc

This suggests that we would also want to drop the trailing slash
from template_dir, doesn't it?

I took a brief look at builtin-init-db.c but it seems that the
code is safe with or without the trailing slash there.
