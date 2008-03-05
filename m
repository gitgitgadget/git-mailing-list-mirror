From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on maxsize reached
Date: Wed, 5 Mar 2008 14:33:42 -0800
Message-ID: <20080305223342.GA9620@herod.dreamhost.com>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803051455.57148.michal.rokos@nextsoft.cz> <47CEAE20.1030707@viscovery.net> <200803051600.06605.michal.rokos@nextsoft.cz> <20080305155412.GA19295@herod.dreamhost.com> <47CEC47C.6060505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wayne Davison <wayne@opencoder.net>,
	Michal Rokos <michal.rokos@nextsoft.cz>,
	GIT <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 23:34:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX2CA-0007MU-Il
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 23:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbYCEWdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 17:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbYCEWdz
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 17:33:55 -0500
Received: from smarty.dreamhost.com ([208.113.175.8]:58001 "EHLO
	smarty.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYCEWdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 17:33:54 -0500
Received: from herod.dreamhost.com (herod.dreamhost.com [208.113.239.72])
	by smarty.dreamhost.com (Postfix) with ESMTP id 20F8CEE24A;
	Wed,  5 Mar 2008 14:33:53 -0800 (PST)
Received: by herod.dreamhost.com (Postfix, from userid 130321)
	id 5A4296049A; Wed,  5 Mar 2008 14:33:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <47CEC47C.6060505@viscovery.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76280>

On Wed, Mar 05, 2008 at 05:04:12PM +0100, Johannes Sixt wrote:
> If one *printf function is replaced, all of them must be replaced. The
> reason is that, eg. on Windows we don't have %llu, but we have %I64u.

Or the compatibility function would need to know which escapes to
emulate (or even emulate a super-set of escapes, as long as they don't
conflict).  If the calling code already has a way to know which escapes
to use, then the compatibility code could easily be customized to handle
the right ones in the same way.

If the decision is made to not use a compatibility snprintf library,
then configure will need a separate test for the limit being off by one,
and then a fixing function would need to pass through limit-1.

..wayne..
