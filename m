From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG?] How to make a shared/restricted repo?
Date: Thu, 26 Mar 2009 10:58:58 +0100
Message-ID: <49CB51E2.9010903@viscovery.net>
References: <200903250105.05808.johan@herland.net> <200903260929.58321.johan@herland.net> <49CB3FA0.8030408@viscovery.net> <200903261044.58140.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 11:00:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmO4-0003z8-DH
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 11:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbZCZJ7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbZCZJ7G
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:59:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8504 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZCZJ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:59:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LmmMV-0001hd-C6; Thu, 26 Mar 2009 10:58:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 227B14E4; Thu, 26 Mar 2009 10:58:59 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200903261044.58140.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114765>

Johan Herland schrieb:
> In the above patch, I've passed mode == -1 to finalize_temp_file() from all
> callsites where there was no corresponding (f)chmod(foo, 0444). However,
> after looking at the context (these are all either packs or loose objects),
> I'm wondering if we shouldn't pass mode == 0444 for all of these. At which
> point we could replace the above patch with this much simpler version:

Indeed!

> (We could also add an optional "mode" argument to adjust_shared_perm(), to
> get rid of the double chmod().)

And I think you should do that, otherwise you have a short time window
where the permissions of a pack or loose object is less restrictive than
you want.

-- Hannes
