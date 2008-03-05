From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Wed, 05 Mar 2008 17:04:12 +0100
Message-ID: <47CEC47C.6060505@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <200803051455.57148.michal.rokos@nextsoft.cz> <47CEAE20.1030707@viscovery.net> <200803051600.06605.michal.rokos@nextsoft.cz> <20080305155412.GA19295@herod.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michal Rokos <michal.rokos@nextsoft.cz>, GIT <git@vger.kernel.org>
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 17:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWw7s-0003PM-EZ
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862AbYCEQES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbYCEQES
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:04:18 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11681 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758795AbYCEQEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:04:16 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWw5d-0002oT-R2; Wed, 05 Mar 2008 17:03:35 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C9FEC6EF; Wed,  5 Mar 2008 17:04:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080305155412.GA19295@herod.dreamhost.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76238>

Wayne Davison schrieb:
> Then, set a define that snprintf is bogus and use a version of
> snprintf() based on this instead:
> 
> http://rsync.samba.org/ftp/unpacked/rsync/lib/snprintf.c
> 
> That defines rsync_snprintf() and rsync_vsnprintf() functions (which
> could be renamed for git). 

No.

If one *printf function is replaced, all of them must be replaced. The
reason is that, eg. on Windows we don't have %llu, but we have %I64u. So
depending on which flavor of *printf is called, we would have to supply
the one format (rsync_printf: %llu) or the other format (fprintf et al:
%I64u).

-- Hannes
