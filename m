From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Fri, 30 Dec 2011 05:40:47 +0100
Message-ID: <4EFD40CF.8000801@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de> <7vlipwz5
 xs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 05:41:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgUHG-0007Ck-PW
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 05:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095Ab1L3Ekt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 23:40:49 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:60106 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060Ab1L3Ekr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 23:40:47 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4C68242205D;
	Fri, 30 Dec 2011 05:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=5YRMiTIQ17bCgHJrzVilMZVDrQk=; b=Xn/8lhCzBjwldYK5AKooVGGX1lvL
	hfOduHXQSWW4w0c/bJ9qay9QOYCPa1r6IUjSAMBGU1D8MpKoh3S4GR7oI9fySnyF
	2pYRrTOPC/RS83hb1RwEbgAdXB3+aL6NBixoo2ByGs4aPYMTvK8GAX9sXwojCoFP
	1gcNbQo2+QOUAsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=xgBH8wZQrjJ8YZwy1gF5fG/aRDODHwR08Yn8BsEqvgDgb+acag+dVp4
	8eEYgkR3HAl23bIiy4c2iJuYRcQhEJLRPVyNOXgkDDKO9n+19d/ZJ6JbOpPY/vm+
	rWfpcs18SLlVnGOHaGoU9Gdmm87JeN/sZcOFha0SBFOIdrq6UylY=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 0F14A422043;
	Fri, 30 Dec 2011 05:40:45 +0100 (CET)
Received: from [91.4.113.45] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25558241; Fri, 30 Dec 2011 05:40:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vlipwz5xs.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187795>

Am 28.12.2011 23:29 schrieb Junio C Hamano:
>>> I suspect that we would need to enhance *_ASKPASS interface first, so that
>>> we can ask things other than passwords. Until that happens, I do not think
>>> we should apply the second patch to use *_ASKPASS for non-passwords.
>>
>> git-core also asks for username using *_ASKPASS, this is the reason why
>> I implemented it this way. I noticed it when I tried to push to google
>> code (using https).
> 
> I thought that was updated with Peff's series recently?

So, was this changed? git-core doesn't ask for a username using
*_ASKPASS helpers anymore?

> In any case, your username has a lot minor annoyance factor if we force
> you to type in blind, but the second patch in your series ask things other
> than that using the same mechanism, so it is not a good excuse for this
> usability regression in git-svn, I would think.

Yeah, typing a whole path is more annoying. But not being able to clone
(push, ...) w/o being able to type in a username or accept an unknown
certificate is also problematic.

I talked off-list with Junio and he proposed to use another environment
variable (e.g. GIT_DIALOG for a different tool) to solve these issues.

A good way could be to define the GIT_DIALOG-tools to have two
parameters. First (pass|text|filename|...) with fallback to text, this
way one can implement a password field, a text field, a file chooser (on
type filename) and it is still extendable for e.g. directory choosers
(if we might need that)...

To make it even more complicated one could also say that we propose more
parameters (e.g. two additional parameters for working copy directory
and repository), so that answers can be stored by the dialog-helper in
the .git-directory.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
