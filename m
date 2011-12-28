From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 28 Dec 2011 14:29:03 -0800
Message-ID: <7vlipwz5xs.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Dec 28 23:29:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg1zr-00057R-QE
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 23:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635Ab1L1W3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 17:29:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab1L1W3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 17:29:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74C966A07;
	Wed, 28 Dec 2011 17:29:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D01lSHS6lBHcWkqDao817tCMbF0=; b=JeMZf2
	RBsA6pahLpaBkKrWvmwGx5Bz/2Z5eRZqKDxbvzxd6v2hqDlGADWVshHioR7IWBiA
	5e7BloEHi/ICJL3YQusW6o0v6miC76j6gBqLgoGphNT5Zw2EmRzdnnCLKVkwzhze
	wyy5dBjpR1Jym9FfoxEFMIU46C2EQEdEXV/WU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIlmDDN1vpEDbXS0FS7d6XLXL8ls84LY
	QM36i/TOJcnCDZnVNdEo8TV5vbWnt915WoKRZ9S4hswS/inpnjC5U8AKNvVNHY+Z
	GX5nNPrhHB4IIaOhM/y0UWpUKSGusHWfBRzQZJ/pchETPBB9/1zJ7L/dzPvAQrgq
	JLsXjUNcf10=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5366A06;
	Wed, 28 Dec 2011 17:29:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1A846A05; Wed, 28 Dec 2011
 17:29:04 -0500 (EST)
In-Reply-To: <4EFB8E78.4090205@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 28 Dec 2011 22:47:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59885A34-31A3-11E1-9ACC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187764>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

>> I suspect that we would need to enhance *_ASKPASS interface first, so that
>> we can ask things other than passwords. Until that happens, I do not think
>> we should apply the second patch to use *_ASKPASS for non-passwords.
>
> git-core also asks for username using *_ASKPASS, this is the reason why
> I implemented it this way. I noticed it when I tried to push to google
> code (using https).

I thought that was updated with Peff's series recently?

In any case, your username has a lot minor annoyance factor if we force
you to type in blind, but the second patch in your series ask things other
than that using the same mechanism, so it is not a good excuse for this
usability regression in git-svn, I would think.
