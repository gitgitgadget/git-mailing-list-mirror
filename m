From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 09:58:38 -0700
Message-ID: <7vvc3d1o01.fsf@alter.siamese.dyndns.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
	<20130809194214.GV14690@google.com>
	<20130809223758.GB7160@sigill.intra.peff.net>
	<20130809231928.GY14690@google.com>
	<20130810064717.GB30185@sigill.intra.peff.net>
	<52060EF9.2040504@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Aug 10 18:58:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8CV5-00074f-Bd
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 18:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab3HJQ6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 12:58:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49272 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756677Ab3HJQ6m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 12:58:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B69C37721;
	Sat, 10 Aug 2013 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oUwSvIgmBMRGH+4YaI5t8VHiyEw=; b=oNfwIo
	SaMhRvtyvIMQ8Q5CRr49FI6WEy96L27tO/Okc3l+FViQyOUNG4z07QybZX3JS2MF
	dsunWX49PjkXNIkB0Sk8JAF0SX0ZQ9YOgvNLv2/uui9R33UmvqTxCnjTPy/aJAOz
	w0nq7LFoDBAzUpGcKYndOc0c9+bNDciZU+N4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LE+lx9O94Uld4WkUHm1lO5iT8d8OazSh
	kC9f+N2cfz5xeLSdu0N3M28r8d8qyIlv0YMPVUgC2hj5eU+F7k6/i6CIltMLB2db
	7NA5FuB5Bb6FlLJCbjitXYW1Y8y9pfVgQA15AJn5HMvxin0HjDt59kqBtK9uR28r
	Ge9VFJJzPOg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C65537720;
	Sat, 10 Aug 2013 16:58:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C51F3771F;
	Sat, 10 Aug 2013 16:58:40 +0000 (UTC)
In-Reply-To: <52060EF9.2040504@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 10 Aug 2013 11:59:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B788D60-01DE-11E3-A1C0-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232107>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/10/2013 08:47 AM, Jeff King wrote:
>> But I think MX records and deliverability is beside the point. Even in a
>> case where we come up with a valid, deliverable address, is that what
>> the user wants to have in their commit history for all time?
>
> I intentionally don't set user.email in my ~/.gitconfig because I use
> different identities (on the same machine) depending on what project I
> am committing to (open-source vs. work).  After I clone a repo, I *rely*
> on Git reminding me to set user.email on my first commit, because I
> invariably forget to set it myself.  And for me, *any* universal,
> heuristically-determined email address would be wrong for me for at
> least some repos.

Interesting.

If we tweaked the "template" mechanism used by the init_db() more
accessible, because both "git init" and "git clone" know to honor
the templates, you could prepare ~/.git-profile/{work,open}/config
files that define user.email/user.name in there.  The existing way
to use "template" mechanism is a bit too heavy-handed in the sense
that if you want to tweak the "config" using it, you also have to
have everything else in the templates, which makes it unwieldy to
use.  Perhaps we need a lighter-weight mechanism

	git init --profile=open
        git clone --profile=open git://git.kernel.org/git.git

that does:

 (1) exactly the same as what the current code do without the new
     option, then

 (2) configure "include.path" to point at "~/.git-profile/open" at
     the very end

or something?  Then the "profile" files can have a shared setting
for the kinds of projects (the above examples are "open" projects,
and you would have another kind, "work" projects) that will apply to
all the projects of that nature. You update ~/.git-profile/open and
then that update applys to all repositories on your open projects.

The above is a tangent and independent from allowing the site owner
to set "user.requireExplicit = true" in /etc/gitconfig.
