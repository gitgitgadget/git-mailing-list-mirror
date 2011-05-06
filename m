From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] tests: eliminate unnecessary setup test assertions
Date: Fri, 06 May 2011 15:27:08 -0700
Message-ID: <7voc3fxy6b.fsf@alter.siamese.dyndns.org>
References: <20110503090351.GA27862@elie> <4DC1CE16.5030808@dailyvoid.com>
 <7vsjsuc704.fsf@alter.siamese.dyndns.org> <20110506205441.GA20182@elie>
 <20110506205851.GB20182@elie> <20110506214801.GA17848@sigill.intra.peff.net>
 <20110506221300.GB17848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 00:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QITUc-000870-2F
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 00:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab1EFW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 18:27:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab1EFW1V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 18:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE80C41A9;
	Fri,  6 May 2011 18:29:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jBJ2WWziMU1AKgAZGj8u1ijuZDw=; b=Rmzj84
	zVZdtthMIyKcGNJ//k+aOR9AUABopDKb9WQvYd7BVyEHUki3DeYQ/Ch5QbUO/6Fu
	zsaIkg4u2d+zyR3GI531jhwHXf5hkE8NiMABzoKeI3DZDGpNb5dAvQCvbNnodGJU
	cK3A+nzhfUt0mBrAT5XkSQV5K7XH3XJOfyLsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sdVR5poUuKCGo3JcRdTtSl/kF+FnnLS3
	wtTubmzlM3kcOC3eMii68QV9U7Rez7OG/ScPDx+n6fYURVQh7F+UTs9VFuKO5/LI
	qxJlthmUq+nrVAd3SHmvc3cGkNpnjrZOvSQCgzNiYzrimZrdhnHTAAmE83LPeHS5
	u2v+ieVVyOk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C30C41A8;
	Fri,  6 May 2011 18:29:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5928E41A7; Fri,  6 May 2011
 18:29:13 -0400 (EDT)
In-Reply-To: <20110506221300.GB17848@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 May 2011 18:13:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48270600-7830-11E0-8755-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173022>

Jeff King <peff@peff.net> writes:

> Two minor complaints on git-blame; maybe somebody can point out
> something clever I've missed.

>   1. blame's "-L" understands patterns already.

Teaching blame to take multiple -L options has been one of many
longstanding todo item for me.  Someday.

>   2. Parsing the human-readable output blame output sucks. But parsing
>      --porcelain is annoyingly complex for quick-and-dirty things like
>      this. It doesn't repeat the commit information per-line.

Non-repetition was quite deliberate, as the reader was expected to have
memory proportional to the number of lines in the range, but I agree it is
not friendly for quick and dirty hack.

You should be able to add a command line option that disables the early
return at the beginning of emit_one_suspect_detail() with a 5-6 lines of
patch.
