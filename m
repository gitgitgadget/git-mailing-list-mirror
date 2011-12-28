From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 28 Dec 2011 11:41:05 +0100
Message-ID: <4EFAF241.9050806@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 11:41:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfqwv-0004le-V5
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 11:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1L1KlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 05:41:14 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:28207 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753504Ab1L1KlM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 05:41:12 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 627B829AA37;
	Wed, 28 Dec 2011 11:41:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=EwSfouXDjB8SIaumF9zCuXHvB5k=; b=nhBRjsoUvKeBGa0Ro/qtTQiOcZs+
	SpFd6hqB/NcAP/ymua7vEwF/rbXZVOvse2O2wFIA2QmwjUF67QU8hZnUKcS0J/P6
	1q4onyKA9FLfTFPsbsB07VfKfq1Owa4zfXPouhivRnAWZiYy/6b03cVXuW5Xumaw
	1IBKECBli/k2bZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=cFrbocmMP3n22HkyyQm2X/fmQ03BI/DUHoOG/5eBxdtk4TUdOk+NOUk
	TCrHJJACXMo16fxuBJWlmlygnTx5nVfvSmuaRe3kyoxY1Z9pfSb5knhiQEzrFSC2
	dsbb/H9ixL8b+RkwOhZaiuBcQW7KL87J6kf/t+bt2h0ODlp2Tx8g=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 8507D29A48C;
	Wed, 28 Dec 2011 11:41:04 +0100 (CET)
Received: from [84.132.183.113] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25256898; Wed, 28 Dec 2011 11:41:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vpqf91kqo.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187748>

Am 28.12.2011 03:41 schrieb Junio C Hamano:
> I am afraid the extra "Certificate unknown. " prefix may make the prompt
> way too long to fit on a line on the terminal or in the GUI. Would it be
> Ok to perhaps add LF to make it a multi-line prompt? Do GUI based helpers
> make that into a dialog box with multi-line prompt, or do they just barf?

LF is problematic. But we could do $prompt =~ s/\n/ /g; in _prompt()-method.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
