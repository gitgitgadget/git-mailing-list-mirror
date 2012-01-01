From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 01 Jan 2012 20:57:26 +0100
Message-ID: <4F00BAA6.9050104@tu-clausthal.de>
References: <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de> <7vlipwz5xs.fsf@alter.siamese.dyndns.org> <4EFD40CF.8000801@tu-clausthal.de> <20111230135423.GA1684@sigill.intra.peff.net> <4EFDD06A.3010708@tu-clausthal.de> <7v8vlrwzw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 20:57:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhRXD-0005US-IB
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 20:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab2AAT53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 14:57:29 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:65473 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab2AAT52 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 14:57:28 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 77CFF4220B0;
	Sun,  1 Jan 2012 20:57:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=U7KhTUUlpdYT8a9X2z2Hl/BnA8c=; b=flWJUw9r1DxfbN+/TqVxttWeeDqI
	NZYfM36S9cIOQWcJQorIzEk8U1r/1gfo32zNHaRkTH+h5/e0r31933R8njoOF8NJ
	5BDCWa0ByJHvdy2QZf9zSUQSdcrvUalEfpT7pajZV3mOJPzYOTipmbLAvcBRMg1r
	8rfrjeMxf8D5GL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=X0zDdqJbfyH1OO2j2MEhBKFKEhsC8K5hFjG5l5JyVnn9gGmNFuu2nLo
	eTZpUDkClOxYp4+VFggC8veE8POwooCe44ymoJpbEPW8OcAoO9J+ZWU1dPjxj80J
	YvawEPWu3sGaYtgjdf2DJrEUJVZzXkQcInh8bfJ2YnAkR2bbvtbw=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 359EA4220AD;
	Sun,  1 Jan 2012 20:57:26 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25589732; Sun, 01 Jan 2012 20:57:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7v8vlrwzw9.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187830>

Am 01.01.2012 10:11 schrieb Junio C Hamano:
> I do not think Peff means the dialog must ask these three items at the
> same time. The point is that other codepaths know they need to ask them
> and would benefit if they can instruct the dialog external helper to ask
> them in a single interaction. So if your callsite does not ask them
> together, it is OK. You can keep asking them separately in two dialog
> interactions.

Sure. This is possible with my proposed interface.

Two parameters should be sufficient, since we get the path to the
repository from the CWD.

TYPE: 'text' (default), 'pass', 'userpass' (username + password in one
dialog), 'filename'
PROMPT

Am I missing something?

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
