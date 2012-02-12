From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 12 Feb 2012 17:02:56 +0100
Message-ID: <4F37E2B0.9060007@tu-clausthal.de>
References: <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de> <7vzke4vebl.fsf@alter.siamese.dyndns.org> <20120103184022.GA20926@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 12 17:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwcA3-0000TN-NP
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 17:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab2BLQUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 11:20:17 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:28818 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333Ab2BLQUQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 11:20:16 -0500
X-Greylist: delayed 954 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Feb 2012 11:20:16 EST
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id B5980272EBB;
	Sun, 12 Feb 2012 17:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=U/9qVXK8XIHlCiCB4mNVtzocvbI=; b=mdTC+jyGuvLTMkX3kAQzUI+EAMNi
	tY2HqxOKQjA23zRSpsGN3UIkgjOUVPpbORbEGKdx8CoNO/3m2LAPwvqI6OUpTKAO
	Dk8JVOeYhmNLtT0YIDh8gBXhYzQuWRs4qnwphCrJdAu8IYSxHBfBMcB1NVXG1pK5
	cITQ2kSZvXY2j18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=L04rQPIZBdoJNKjiJ8I3nUuxYd0XHoqUXyOKr/OrpNJp1BrULnPc+13
	ShFDi7fZPYAPeVDCFm93Lz70RUvS61VG/1/UvZ9jFrfVsI2WsVNMbtItytP9Ejve
	BD1ys231IN7/6q8ZKzyUP6gVms993wdCk8w2sJMIpqxkEeD6H/Go=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 81813272EB9;
	Sun, 12 Feb 2012 17:02:50 +0100 (CET)
Received: from [139.174.6.11] (account sstri@tu-clausthal.de [139.174.6.11] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 27350792; Sun, 12 Feb 2012 17:02:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <20120103184022.GA20926@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.5
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
X-Spam-Level: (8%, '
 MULTIPLE_RCPTS 0.1, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1000_LESS 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_500_599 0, BODY_SIZE_7000_LESS 0, __ANY_URI 0, __BOUNCE_CHALLENGE_SUBJ 0, __BOUNCE_NDR_SUBJ_EXEMPT 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __MOZILLA_MSGID 0, __MULTIPLE_RCPTS_CC_X2 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __URI_NO_MAILTO 0, __URI_NO_WWW 0, __URI_NS , __USER_AGENT 0')
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190578>

Hi,

Am 03.01.2012 19:40 schrieb Jeff King:
> There is one difference between how git and ssh use the ASKPASS
> variable. In git, we try it _first_, and fall back to asking on the
> terminal.  For ssh, they first try the terminal, and fall back to
> askpass only when the terminal cannot be opened.

I checked out subversion (svn co
http://svn.apache.org/repos/asf/subversion/trunk subversion) and
performed a "grep ASKPASS * -R": Only match in
"contrib\client-side\emacs\psvn.el". So I doubt if subversion really
supports SSH_ASKPASS.

-- 
Best regards,
 Sven Strickroth
