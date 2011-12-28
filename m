From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 28 Dec 2011 22:47:36 +0100
Message-ID: <4EFB8E78.4090205@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 22:48:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg1Lr-0001qr-8f
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 22:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab1L1Vri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 16:47:38 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:27011 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754244Ab1L1Vrh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 16:47:37 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 1B79829A2C2;
	Wed, 28 Dec 2011 22:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=cgGTOcLuuA5K3YQoxTlfZqv4oJI=; b=8MhK6poGuLJHQzfvZWUICzMciUE6
	+pF124tdhTzfaBjn0iIyv87d02qqU2D1DO/85hSVZTIybJAXhnli/VWDTJBAWHFz
	IK5gYL5yBE2mNRZtx2IOIM2kuccmYMgnmB/mZ7rGQ9GJTuS07D7DOM3FafWYUN3y
	5CelMHGkQM7v0dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=CY+w/CAn+gXhgwbSqv58UA70U326pAyIRyHnnHzcazALSqjBUcEOuaW
	4iU2nSHX270RnZcBCTkojeBS7bcyqCgxWexwSi1mNjKD1sEXtJRvehlQ2nBEodlY
	3VOmV7qsyuNEWOElLTgk/T0NpoVwfB+XMHAjkQ9HFOjNvYl58O/U=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id EEE9829A2BA;
	Wed, 28 Dec 2011 22:47:34 +0100 (CET)
Received: from [91.4.119.89] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25269186; Wed, 28 Dec 2011 22:47:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vpqf8z8a6.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187761>

Am 28.12.2011 22:38 schrieb Junio C Hamano:
> I am however not sure if the second patch in this series is a good thing
> in the current shape. For GUI users who do not have a terminal, earlier
> they couldn't respond to these questions but now they can, so in that
> narrow sense we are not going backwards.
> 
> But for people who use *_ASKPASS and are working from the terminal, it is
> a regression to ask these non-password questions using *_ASKPASS. Most
> likely, these helpers that are designed for password entry will hide what
> is typed, and I also wouldn't be surprised if some of them have fairly low
> input-length restriction that may be shorter than a long-ish pathname that
> users might want to give as an answer, which they could do in the terminal
> based interaction but will become impossible with this patch.
> 
> I suspect that we would need to enhance *_ASKPASS interface first, so that
> we can ask things other than passwords. Until that happens, I do not think
> we should apply the second patch to use *_ASKPASS for non-passwords.

git-core also asks for username using *_ASKPASS, this is the reason why
I implemented it this way. I noticed it when I tried to push to google
code (using https).

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
