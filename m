From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sun, 01 Jan 2012 20:45:55 +0100
Message-ID: <4F00B7F3.1060105@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 01 20:46:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhRMN-0005x8-8D
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 20:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab2AATp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 14:45:58 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:23618 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895Ab2AATp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2012 14:45:57 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id DE9A323ABC;
	Sun,  1 Jan 2012 20:45:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=IQBZ6w1mCcon1iNRd6ys0KvynXM=; b=cE4EP3w1AJeNvWlCwUH6bYEp0HjZ
	ZDlXohiYCOOEXlhtye7qv7bl7WeGEyUvS3WSAny8f3W5uCSIxgjjeLCJXbaz5S+J
	4zKBK2dh6hh6TkqWcyWuCTwFDTLNp45b7o/lmZIwnlMoCTog2j5gFEu4Ihgt/uNR
	36tDjLO+q890fpY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=ZC5goQZtrcdEIv8O5WOmWS7UoB7WCZg4r8A4wz4WIdoMnQFLPTfvWHA
	AQng/sQI3tT8lw3X6sh5TNaM2XimbgnBDh0XNnBSdu9IylmIZjjh+8cAY6mNA+xG
	iM0QS1zHdavdcJMnR8l0Y3n2kdxX3Lzv7Yv+5jAfHh1MME58lEuw=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id BAA3F23AB6;
	Sun,  1 Jan 2012 20:45:54 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25589715; Sun, 01 Jan 2012 20:45:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187829>

Am 28.12.2011 22:38 schrieb Junio C Hamano:
> I am however not sure if the second patch in this series is a good thing
> in the current shape. For GUI users who do not have a terminal, earlier
> they couldn't respond to these questions but now they can, so in that
> narrow sense we are not going backwards.

> But for people who use *_ASKPASS and are working from the terminal, it is
> a regression to ask these non-password questions using *_ASKPASS. Most
> likely, these helpers that are designed for password entry will hide what
> is typed, and I also wouldn't be surprised if some of them have fairly low
> input-length restriction that may be shorter than a long-ish pathname that
> users might want to give as an answer, which they could do in the terminal
> based interaction but will become impossible with this patch.

I'm still for the second patch to be applied (maybe w/o the certificate
filename prompt), too, because this makes git-svn behave the save way as
git-core does (especially asking for username).

Do you think that ppl. mainly using the terminal have *_ASKPASS set?
Most GUIs I know do set it automatically.

I agree that a new interface is needed (working on a patch), but before
we hurry, we should make git-core and git-svn behave the same way.

Btw. git-svn also does not honour git-credentials.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
