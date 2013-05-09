From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC PATCH 3/3] Makefile: avoid deprecation warnings on OS X 10.8
Date: Thu, 9 May 2013 16:14:36 +0100
Message-ID: <20130509151436.GJ25912@serenity.lan>
References: <1368090810-40596-1-git-send-email-davvid@gmail.com>
 <1368090810-40596-2-git-send-email-davvid@gmail.com>
 <1368090810-40596-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>,
	Theodore Ts'o <tytso@mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 17:15:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaSYl-0000Hd-F9
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 17:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab3EIPOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 11:14:52 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:46439 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab3EIPOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 11:14:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 97F56CDA649;
	Thu,  9 May 2013 16:14:50 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBWiTVbYmcyG; Thu,  9 May 2013 16:14:49 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 44ED1CDA5F8;
	Thu,  9 May 2013 16:14:48 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 130D8161E513;
	Thu,  9 May 2013 16:14:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1RU-GE5ddSSH; Thu,  9 May 2013 16:14:45 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id A451F161E2F4;
	Thu,  9 May 2013 16:14:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1368090810-40596-3-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223737>

On Thu, May 09, 2013 at 02:13:30AM -0700, David Aguilar wrote:
> Mac OS X Mountain Lion prints warnings when building git:
> 
> 	warning: 'SHA1_Init' is deprecated
> 	(declared at /usr/include/openssl/sha.h:121)
> 
> Silence the warnings by disabling OpenSSH in favor of BLK_SHA1.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> I know I can create config.mak, but do we prefer to have the default
> settings be warning-free?  I do not see any other platforms that tweak
> NO_OPENSSL themselves, hence "RFC".  Is there a better way to do this?
> Are there any Darwin/PPC users that would be harmed by this patch?

Disabling OpenSSL also has the effect of disabling SSL support in
git-imap-send.  Does enabling BLK_SHA1 instead also remove the warnings?

Alternatively, it seems that the recommended update is to use Apple's
CommonCrypto library, as in this patch:
https://gist.github.com/anonymous/4466305
