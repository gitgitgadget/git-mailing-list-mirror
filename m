From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 21:11:20 -0700
Message-ID: <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
References: <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
 <20130411172424.GC1255@sigill.intra.peff.net>
 <20130411181103.GJ27070@google.com>
 <20130411181439.GA2820@sigill.intra.peff.net>
 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Apr 12 06:11:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQVKs-0008HR-1A
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 06:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854Ab3DLELY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 00:11:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab3DLELX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 00:11:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCD9810F8D;
	Fri, 12 Apr 2013 04:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MH2kTMIyvsFlcT5EFubDiTzkMds=; b=hwHeg4
	DDb9DuLfqIzrNt4OZrvcp5hECVwUG+uTT2jTCbq9sLjqOHYTgNCX3OlRo4GSrWrv
	NZXAkc2NobmCZQffqII//BTzFE4Zdh+WAJaqQNqVEEghEPQybyvw5jdPDfZQdinH
	1T9LYD4DZoYj3BcuCm8k/WYZXdw/FsFwYiqPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1uhZKOcQkRgYwt6GmLsfJJKbOK0qz+/
	Gg/yMM8Qs4+7ZhTkF+vXC7Br7qTfRyJmwbpzXYNjf17OwN5cLI6vIne9belESH3Y
	Eo3Vr/GTV5yCZaM1nBt9xTPaygNYdCRa7IEMPMiLGW2yhOgIC6Iu7rH2Iuc0v76u
	AUESjHGUbcQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C23FB10F8C;
	Fri, 12 Apr 2013 04:11:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24C7010F8B; Fri, 12 Apr
 2013 04:11:22 +0000 (UTC)
In-Reply-To: <20130412005748.GA17116@odin.tremily.us> (W. Trevor King's
 message of "Thu, 11 Apr 2013 20:57:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08D2EE50-A327-11E2-849A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220949>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Apr 11, 2013 at 06:23:01PM -0400, Jeff King wrote:
> ...
>> I think the point is that it could add
>> 
>>   ...and I was looking in /root, because that is where your HOME points.
>>   Shouldn't you be able to read your own HOME directory?
>> 
>> which should make it painfully obvious to the user what is going on.
>
> That's more or less what I had in mind.
> ... However, this is a lot of hand holding to be
> printed along side the error message… Since git-daemon (or gitweb) is
> the most likely place for this problem to crop up, maybe a note in its
> (their) man pages would be a good idea?

The --user option to git-daemon would be a good place to do that, I
think.  Depending on what other "setuid to less privileged before
running" programs do (I do not know offhand), we can say something
like this perhaps?

    --user::
	... current description ...
    +
    (Like|Unlike) many programs that let you run programs as
    specified user, the daemon does not reset environment variables
    such as $HOME when it runs git programs like upload-pack and
    receive-pack. Set and export HOME to point at the home directory
    of the user you specify with this option before you start the
    daemon, and make sure the Git configuration files in that
    directory is readable by that user.

If we have to say "Unlike" above, then we probably should bite the
bullet and use Peff's patch, perhaps with an addition to the manual
page, perhaps like this.

    --user::
	... current description ...
    +
    Like many programs that let you run programs as specified user,
    the daemon resets $HOME environment variable to that of the user
    you specify with this option when it runs git programs like
    upload-pack and receive-pack.  Make sure that the Git
    configuration files in that directory is readable by that user.
