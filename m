From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] make askpass_prompt a global prompt method for
 asking users
Date: Tue, 27 Dec 2011 13:41:15 -0800
Message-ID: <7vty4l4rr8.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 22:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfemD-0001BN-Jf
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 22:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab1L0Vla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 16:41:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab1L0VlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 16:41:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED5B5FC6;
	Tue, 27 Dec 2011 16:41:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ic1m+gxYhr5bkxO8ksk2YL4EByE=; b=mZuRSG
	DwdT6pGnUxvdVsT1EWLFJ1B/I1wkjz6UCJHTyjgOw/9tL7RBQFPSrgAshrgTclyn
	R+e1lsF75wZsHK1MLAiIR6jYrCGhVl0pTjObXtT81UPMUbabySjOYM6OrMjEAtsz
	QJEHZtGDx44bNqi64wq9ZCdDcGDHzemh/L2GI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fTiJQM1Posc+llr9NRbKAR3UNkqLBRJS
	OqVNwlWjhapgJgWl+plOCQXwvS/9OTWG0i+WvIg+dkoViVKZqnTEwFlwJ6Ulvt9z
	rgpkkJNy7TVKo9LZUae4Pso9CEuhnLHcIl87J4ZaQh4ZDDXObUOVakhTt3uY9Q9K
	CaM7YB/86YY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 364F45FC5;
	Tue, 27 Dec 2011 16:41:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1F555FBF; Tue, 27 Dec 2011
 16:41:16 -0500 (EST)
In-Reply-To: <7vd3b967ql.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Dec 2011 13:10:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 818A968A-30D3-11E1-84D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187732>

Junio C Hamano <gitster@pobox.com> writes:

> I *suspect* the difference is that you discarded that "return false at the
> end to let the caller do whatever they want" found in patch 1/5 and have
> the fallback inside the prompt() funtion now. And if that is the primary
> difference between the old "askpass_prompt()" and the new "prompt()", I
> tend to think that the series should be restructured to use the "prompt()"
> semantics from the beginning. No reason to start with a known-to-be-wrong
> way to do a thing and then fix it in a series that is new to the codebase.

After reading the series again, I think the right structure of this patch
series should be more like this:

 (1/3) Add Git->prompt($prompt) and make _read_password in git-svn.perl to
       use it. The prompt method should implement the Term::ReadKey based
       fallback, so that _read_password do not have to roll its own. IOW,
       a squash of your 1/5, 2/5, and a part of 5/5, plus possibly 4/5.

 (2/3) Enhance Git->prompt($prompt, $is_password), and convert the various
       existing terminal interacters to use it. The fallback in the prompt
       method, when it is not reading in a noecho mode, should read a
       single line from the standard input in cooked mode like your 5/5
       does. IOW, a squash of your 3/5 and a part of 5/5.

 (3/3) Possibly tests and docs.

Thanks.
