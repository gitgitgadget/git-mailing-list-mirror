From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sat, 06 Oct 2012 17:18:16 +0200
Message-ID: <50704BB8.1020603@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <7vzke4ve
 bl.fsf@alter.siamese.dyndns.org> <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 17:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKWQr-0004Px-W2
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 17:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab2JFPgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 11:36:37 -0400
Received: from mailrelay1.rz.tu-clausthal.de ([139.174.2.42]:55550 "EHLO
	mailrelay1.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755013Ab2JFPgD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Oct 2012 11:36:03 -0400
X-Greylist: delayed 1064 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Oct 2012 11:36:03 EDT
Received: from hades.rz.tu-clausthal.de (mailrelay1.rz.tu-clausthal.de [139.174.2.42])
	by mailrelay1.rz.tu-clausthal.de (Postfix) with ESMTP id A500442D9EE;
	Sat,  6 Oct 2012 17:18:16 +0200 (CEST)
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 78154422118;
	Sat,  6 Oct 2012 17:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=0i2qnNclk7juS9TEUXAPEylxp9U=; b=dl/6ymIhq7VKA9rjjLcJ4fc0iR2t
	Zxf3nhzT+kd4N18ywo4ChIw9BywME7IUBo5AC2r+gEUtDpm4Ju6yok35cYqJUSMd
	xL1x+FJOVM+gAYveI+6nTqenEXFgE7OiWm8VSHDZ4CmA6HtfcrycDPEXyQrLCNil
	rLmnsapWKvN3P4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=fL8b9wERgPiEipIo9iVBUaYci1M44sApZIvmtA1zC5bV5KsZB1Ju3LQ
	qNgLOgUPSdvxx4ryro4kQBQRe/6w4T90BJ9vfcEGoQjjyRvi0rAhvj6TAZbUfmAe
	r10UExULacKT3J1fMWse9mTpiAz4uiSorW3XtQ1ft7P74p963CS8=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id DB2F3422051;
	Sat,  6 Oct 2012 17:18:15 +0200 (CEST)
Received: from [139.174.5.71] (account sstri@tu-clausthal.de [139.174.5.71] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.7)
  with ESMTPSA id 38541985; Sat, 06 Oct 2012 17:18:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vy5toqqab.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_400_499 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_FROM 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_PATH 0, __URI_NO_WWW 0, __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207149>

Am 04.01.2012 01:12 schrieb Junio C Hamano:
> Now "prompt" is no longer a method but is merely a helper function, so
> I've queued this (and 1/2 rewrite we discussed in a separate thread) to
> 'pu' after rewording the commit log message.
> 
> Thanks.

Is there a reason why these changes did not get merged? The issues are
still there.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
