From: Junio C Hamano <gitster@pobox.com>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sun, 27 Nov 2011 00:56:22 -0800
Message-ID: <7v8vn2vt8p.fsf@alter.siamese.dyndns.org>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
 <20111126225519.GA29482@sigill.intra.peff.net>
 <7vr50uwk7x.fsf@alter.siamese.dyndns.org>
 <20111126233133.GA31129@sigill.intra.peff.net>
 <CAPc5daXY_4aimugj8Z4BFE8YvBSM1K+evPU69rLGH5ETo6PO=Q@mail.gmail.com>
 <20111126235135.GA7606@sigill.intra.peff.net>
 <CAPc5daUodry_=6pZxA=QOpuRUj9C2ed9Gzp6E1_G93iGfOOvOA@mail.gmail.com>
 <20111127000603.GA7687@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Sitaram Chamarty <sitaramc@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 09:56:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUaXG-00011Y-Uy
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 09:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757Ab1K0I40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Nov 2011 03:56:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab1K0I4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2011 03:56:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B61C7395B;
	Sun, 27 Nov 2011 03:56:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IZCgL4mlVKXi20WLj1UICQpu6ag=; b=hMx9pT
	DzWn1XsItUMh6RtlQ1ddA6/aKlBdHRd829xlItyeo+ytgJUsXVkp3xtJ54rhwOwN
	wh6oArjY9cSxXsFI/1/0FpHiqROKP8ua8EMbQd4SUiX7lwhi1rhH3R3KOVbvcauP
	78kAvCDlUn80BNt7DH0Vubjd5laSOFifpEepk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NpV02xyUVkhxik+62vQlWvaab3t7JcHw
	RXu463cJmN7T+WXjLn2uPpcYutVybxbnDaieQ6hXsiSei9pE/hUZdfiwIonBin12
	BE/avenyxbY+RJewjGZ9JsNfORuF0wy2qTBf49JwgEJRbHNfwX3MbqZHVbolmvw6
	0wdlHkIwy14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB2C4395A;
	Sun, 27 Nov 2011 03:56:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F8343959; Sun, 27 Nov 2011
 03:56:24 -0500 (EST)
In-Reply-To: <20111127000603.GA7687@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 26 Nov 2011 19:06:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF110B72-18D5-11E1-8140-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185977>

Jeff King <peff@peff.net> writes:

> Just because it is passed through the environment does not mean you need
> to have it set all the time. There is nothing wrong with:
>
>   GIT_ALLOW_UNTRUSTED_HOOKS=true git fetch ~bob/repo.git
>
> We can even spell it:
>
>   git --allow-untrusted-hooks fetch ~bob/repo.git
>
> but it should probably still end up as an environment variable to make
> it through to the remote side (you could also tack it on to the
> upload-pack command line; that wouldn't make it across git:// or http://
> connections, but those are irrelevant here anyway).

I actually like the idea of allowing pre-upload-pack hook on git:// and
possibly http:// only. git-daemon can tell the upload-pack that it is OK
to run the hook, and the hook can do the things that only the daemon can
do, never touching what the original requestor would but the repository
owner would not have an access to. Normal file:// and ssh:// transfer
should not be needed for GitHub's stats or Sitaram's proxy usage, and we
should be able to unconditionally disable the hook when transfer is going
over these protocols, no?

One scenario I do not want to see is this. Suppose there is a company that
runs more than one project, and one of the projects is so secret that only
engineers working on the project have access to its repository, while all
people, including the project-A engineers, in the company have access to
other repositories. Further suppose that people involved in some or many
of the general repositories want to do something before a fetch from them
happens. They will use the pre-upload-hook to implement it if we make it
available, and their new-hire training course will tell their engineers to
set the GIT_ALLOW_UNTRUSTED_HOOKS. Perhaps the /etc/skel/profile the
company gives the new-hires already defines it.

And somebody who controls one of the general repositories installs a
pre-upload-hook that borrows credential of a project-A engineer who
happens to fetch from it to access repositories of the project-A.

Imagine how the blame game that will ensue goes after materials from
project-A is exposed. Of course, the owner of the rogue hook will get the
first blame, but I do not think Git will come unscathed out of it. At
least we will be blamed for adding an inherently unsafe mechanism.
