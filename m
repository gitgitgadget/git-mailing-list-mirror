From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem signing a tag
Date: Thu, 05 Nov 2009 12:09:59 -0800
Message-ID: <7vy6mk91ig.fsf@alter.siamese.dyndns.org>
References: <200911021558.17550.joshua@eeinternet.com>
 <200911030911.47030.joshua@eeinternet.com>
 <4AF18F7A.2000904@drmicha.warpmail.net>
 <200911040947.50226.joshua@eeinternet.com>
 <4AF28CE4.5000906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Joshua J. Kugler" <joshua@eeinternet.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N68ez-0001k8-8U
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757813AbZKEUKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757657AbZKEUKH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:10:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756975AbZKEUKG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:10:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DD1C093297;
	Thu,  5 Nov 2009 15:10:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o7AzptIdjH1YOyTN4nVzQJEaX8E=; b=bGiQiO
	uYqTwWEi+5otZdsdc/RDaHVFTIuma7daKAg9h+XkQF608GWWbJRIGr27LfmbJn4R
	RlEQlaW024pj9TicN5ig2LQNnNFyvOEoKfggvLhNwpU7ldp6atMdwWMoVmgNFsYe
	k/FKr5Xxmb5Z9+QdpTAPjMOGYtRNGpLHO48ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LafPF0rYpieudQr0c6cqmQg1u4HhM4x7
	oFtqlq0zHrlffCqh+s7kbzPfVAwMyrax1Dxn5hAmzNVl4Qk7zVZqYnVtKj2TMbUU
	cTHEDRH5+u0OG3GK21fExUnHABu0eCBWy3flbymxPCmYeKs8Zcx6CCVh9Yc3r6+B
	Gle0WtVHCbc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3DEA93294;
	Thu,  5 Nov 2009 15:10:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 183E89328E; Thu,  5 Nov 2009
 15:10:00 -0500 (EST)
In-Reply-To: <4AF28CE4.5000906@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 05 Nov 2009 09\:29\:24 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3610E06E-CA47-11DE-9B02-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132242>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Dig dig dig... gpg exits with 2 in a lot of cases, one would need to
> parse fd-error to find out more. But it also looks as if gpg exits
> normally with a good passphrase. So I tried, and at least with gpg 1.4.9
> and git 1.6.5.2 I can sign tags with "use-agent" and without a running
> agent: I get asked for the passphrase (after reporting the agent MIA),
> and everything's fine.
>
> My gpg returns 0 in this case; it returns 2 only if I don't enter the
> passphrase. So, this seems to depend on the version of gpg. Or on
> entering the correct passphrase ;)

If the problematic gpg that gives 2 is older than yours, the situation
looks to me that "exiting 2 when failed to contact agent but got a good
passphrase some other way and successfully signed" was diagnosed as a bug
and then fixed in gpg.  If that is the case can we find out which version
that fix is in, and add an entry to FAQ to help next person who will be
hit by this when using "tag -s"?
