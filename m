From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch documentation problem or bug
Date: Mon, 08 Oct 2012 16:33:05 -0700
Message-ID: <7vpq4silou.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
 <7vfw5olqp9.fsf@alter.siamese.dyndns.org>
 <7vbogclqm6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 01:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLMpQ-0002lR-DB
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 01:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab2JHXdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 19:33:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2JHXdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 19:33:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33EB38B07;
	Mon,  8 Oct 2012 19:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j0n9OHfUFbPx2Ipuj/E2fIRRvnE=; b=EOJJue
	V3SbOS02AmPfnUc2t+nfu1QDu9D5fHRGPAqIQrtDRG87kUCq0JjFOvToiHUs51gB
	GIA4ijPDgKkuZvFDXD/Rh3WxnDNncsqyeBIvqfe0JkA9BiQ6iVl0Sqd1dF5Bclju
	ZfFzQ0mwB+4CvZIIislo1cdDqHvoFUfs7B7Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KUqreRc/jU4iXB8ErD9SdKyYgmmXeuno
	XGYqaCZXeYgmK2bx0lxyosVaHeW3fcgnx4qdVC9GTuPqgiR15LK0fRJF0vWPiJ3c
	ABI77ux3kUFJF9EaB/yXVmm1fUVeA3dE/d8qmOpa7jwz6OBiEy0JeGSNa2h4v+9a
	Cf1u8wPt9D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217878B06;
	Mon,  8 Oct 2012 19:33:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 743838B05; Mon,  8 Oct 2012
 19:33:07 -0400 (EDT)
In-Reply-To: <7vbogclqm6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 12:18:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 839968F8-11A0-11E2-83FF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207280>

Junio C Hamano <gitster@pobox.com> writes:

> In other words, you can do this from the command line if you want
> to do the update.
>
>   $ git fetch origin master:refs/remotes/origin/master

Now having said all that, we should probably revisit this and
possibly other issues and for the ones we can reach concensus, start
coding after 1.8.0 final.

A good place to start may be $gmane/167149, where I listed (among
other things that turned out to be undesirable, which are omitted in
this copy):

 * "git branch --set-upstream <name>" should not be about setting the
   upstream of <name> to the current branch.

   This has happened during 1.8.0 cycle [CMN].

 * "git push" default semantics will be "upstream" (renamed from
   "tracking"), not "matching".

   1.8.0 has the first step toward this [MM].

 * "git merge" without "what to merge" default to @{upstream}

   This is not acceptable for the default, but the users can ask for
   it with merge.defaultToUpstream since 1.7.5 era [JC]

 * Unify pathspec semantics

   This has happened and commands that used to take only path prefix
   style pathspecs now take globs as well [ND]

 * "git fetch $from $branch..." to update tracking branches

   This is the topic in this thread.

I personally do not think the downside of breaking backward
compatibility is too bad.  If we do this only when we already are
configured to keep remote tracking branch for branch $branch from
remote $from (it has to be given as a nickname, not URL that happens
to have an entry in the configuration), then a promiscuous fetch
that grabs from a URL (or a nickname that is configured not to keep
tracking branches) will not change any behaviour, and when you want
to keep your remote tracking branch intact while doing one-shot
fetch for whatever reason, you can say "git fetch $from $branch:" to
explicitly decline copying.
