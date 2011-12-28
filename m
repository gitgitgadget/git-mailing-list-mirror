From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Wed, 28 Dec 2011 13:00:31 -0800
Message-ID: <7v39c41keo.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Wed Dec 28 22:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg0c4-0002LT-ET
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 22:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab1L1VAf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 16:00:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51561 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754325Ab1L1VAe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 16:00:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D16E550F;
	Wed, 28 Dec 2011 16:00:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JndEXJ2t/C0nJxKoEbXakU+cw+s=; b=I/BqrP
	GKQ5echZ01G+A9VnKxa7EoeKW+kU8jWPUUDo9sEvihgCujCB/vQ/B/zZid0CrF9r
	vL/1IIUdgcK+CxX0G04BKvt9titASOzI3+KkE+P3lUXWVW1QKSHxpBHplWbkgXBc
	hWQh6IbtzijHAerEQIORlI7phOXHr4syL9vAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M0yNMLCYnboAOX6C+m3J2CMMESgVMr4g
	6iL51ugZm79CDHfweImnquzJh2cbODwKRt++nHVOhwYMoXbkpMIw9z3Msnn/1uLf
	fxCg5jRW6OKWPGTezjfc7JMOdeucoH9qyK2E8F8Xim3+uUby9FwhlS8I7lliExaZ
	ijsDpryTUjE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84EB5550E;
	Wed, 28 Dec 2011 16:00:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C296550D; Wed, 28 Dec 2011
 16:00:33 -0500 (EST)
In-Reply-To: <4EFAF241.9050806@tu-clausthal.de> (Sven Strickroth's message of
 "Wed, 28 Dec 2011 11:41:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB726BEE-3196-11E1-BDAF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187758>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 28.12.2011 03:41 schrieb Junio C Hamano:
>> I am afraid the extra "Certificate unknown. " prefix may make the prompt
>> way too long to fit on a line on the terminal or in the GUI. Would it be
>> Ok to perhaps add LF to make it a multi-line prompt? Do GUI based helpers
>> make that into a dialog box with multi-line prompt, or do they just barf?
>
> LF is problematic. But we could do $prompt =~ s/\n/ /g; in _prompt()-method.

I actually was hoping that the answer is "it depends on the helper
specified by *_ASKPASS".

In any case, let's not add that extra "Certificate unknown. " prefix at
all to avoid regressions and queue this patch series for real.

After somebody comes up with a way to deal with overlong prompt, building
on top of this series, we can work on making this particular prompt longer
and more descriptive.
