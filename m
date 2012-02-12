From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 12 Feb 2012 17:26:43 +0100
Message-ID: <4F37E843.6070107@tu-clausthal.de>
References: <4EF9ED58.8080205@tu-clausthal.de> <20120103184022.GA20926@sigill.intra.peff.net> <4F37E2B0.9060007@tu-clausthal.de> <201202121711.45920.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 17:26:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwcGC-0004jr-CW
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 17:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab2BLQ0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 11:26:40 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:47013 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab2BLQ0j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 11:26:39 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 59562422048;
	Sun, 12 Feb 2012 17:26:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=r3am3E8ukZTiENpSli4FzKcYmlg=; b=jx4ZYQ9E3DF8KFJYGjebGAGQnPBD
	WMFeUynnuU1zf+LBCUfOoMfFhNGirU+T0lNNRicJcuYC1X8YXFUevGsrt2V15CIh
	MCUt81K6wMuIRS/nBcfe6hORFnuMQQkioQTJfAnPzBtyQ93q41azD7UYlq2AYT31
	2fRnSPeEIo9D51o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=cvRhdtqdylElhaYc91Ii4j9zbg5TZYNz4vCsT5hizb7QdIMOtJy35vt
	YFW/GiDp3XG9JXcRg0+NtMfEs0DY13x0wFUIQZDTEk1vxGXQjXFPQcMOHWAGrFZi
	T9TAui5F7sGBKAMSPeaQMUl1OUocqsNMlIwdG8XtdzHM9JQrUMNM=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 09840422041;
	Sun, 12 Feb 2012 17:26:38 +0100 (CET)
Received: from [139.174.6.11] (account sstri@tu-clausthal.de [139.174.6.11] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 27351381; Sun, 12 Feb 2012 17:26:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <201202121711.45920.jnareb@gmail.com>
X-Enigmail-Version: 1.3.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_300_399 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190580>

Am 12.02.2012 17:11 schrieb Jakub Narebski:
> Doesn't Subversion use SSH directly?  If it is so, the question is
> about how SSH itself supports SSH_ASKPASS.

Oh sorry, I mixed up SSH and SVN_ASKPASS. :( Of couse SSH_ASKPASS is
provided by the ssh-client itself.

-- 
Best regards,
 Sven Strickroth
