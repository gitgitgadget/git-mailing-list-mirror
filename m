From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 04 Apr 2013 16:12:01 -0700
Message-ID: <7vhajlgabi.fsf@alter.siamese.dyndns.org>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
 <20130404195554.GA20823@sigill.intra.peff.net>
 <7v1uaqhwb4.fsf@alter.siamese.dyndns.org>
 <20130404210304.GA25811@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 05 01:12:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNtKc-0007Fe-TT
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 01:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764957Ab3DDXMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 19:12:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764918Ab3DDXME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 19:12:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94A101386A;
	Thu,  4 Apr 2013 23:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AF3PK8HnS7spGniqE6SZMogyrN4=; b=DFEJJf
	yCqAlH51A2sAT5U9EENk6L1n75yij/txCtzt88faQoh7M1UqEV0i89cZK0wxWXp1
	vjHrApEnBp3NR6wyfNSksS/Ht0p88SfRtFDeJDWPqB2ub+1yrcRhsbEUW9rJGdOx
	WvkrQ89CZRmIMUL8DvhW0HRhc3/HF3iH0ZMQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e3f+ljF1KAQFhWuS5UykQ97wmy5Ozcc4
	Gx0BoZDo8Bppq/aol5CanoICUREyQj7FSX6cRbwQaRPFM2JKkQtJ+OLMDmh46CpU
	i9RS/96CSfJWOTtfiHoYz9T/4Gn4PU1KqKee40TbgMcfLTPKHtkP7Ij/D3n8zoVc
	igSXbVWOqVc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 882FE13868;
	Thu,  4 Apr 2013 23:12:03 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED1AA13867; Thu,  4 Apr
 2013 23:12:02 +0000 (UTC)
In-Reply-To: <20130404210304.GA25811@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 4 Apr 2013 17:03:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F6D4D00-9D7D-11E2-AE79-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220123>

Jeff King <peff@peff.net> writes:

> Deleting across symlinks inside the repo can be brushed aside with "eh,
> well, it is just another way to mention the same name in the
> filesystem". But deleting anything outside of the repo seems actively
> wrong.

Yup, you finally caught up ;-) IIRC, such an outside repository
target was the case people realized that "git add" shouldn't see
across symlinks.

> Hmm. I think you have convinced me (or perhaps I have convinced myself)
> that we should generally not be crossing symlink boundaries in
> translating names between the filesystem and index. I still don't want
> to work on it, though. :)

That is OK.  Just let's not etch a wrong behaviour in stone with
that test.
