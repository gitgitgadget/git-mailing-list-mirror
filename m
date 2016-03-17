From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Thu, 17 Mar 2016 09:15:44 -0700
Message-ID: <xmqqio0l13nz.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
	<CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
	<56E97CA8.8070400@drmicha.warpmail.net>
	<xmqqmvpy5qru.fsf@gitster.mtv.corp.google.com>
	<56EAC47F.6000708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 17:15:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agaaY-0007Ek-0r
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966264AbcCQQPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:15:50 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964832AbcCQQPs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:15:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4EED14B531;
	Thu, 17 Mar 2016 12:15:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2BXWB8iP1uaSQbs7asqwrJRN2IY=; b=cnpBYp
	zBncnZis2FnfMqtE6Wuv9GcgHwRCDulCfXBnVsucmYjA5Z5eK3PeLLLKE7EJlzbZ
	eHHRsphvPa1fFrevNe3/Vh6hEo2vSwRtsW4qkujpgPR44OWY+W6DZPtv0zSHfkfJ
	bGSkF/kUQ8p0ohrNvFIFiNxWU6vRTqX88/oC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tTLoxCZxoJNOuqtZybsddORr5xI8FC3A
	enWNfay2jNYiwJ3G2/liIl06/dgZBSg9Cvft7BhIVgdm82YBGX0uWx9imfU6QfHk
	4b6VZbv/acHWoKX8CUMenn5i/aZk7FE1B/hvvV/btE7mz3+cXSUeNA86h+HAyo8g
	PYoWBWyZEv0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45DDD4B530;
	Thu, 17 Mar 2016 12:15:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A89974B52F;
	Thu, 17 Mar 2016 12:15:45 -0400 (EDT)
In-Reply-To: <56EAC47F.6000708@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 17 Mar 2016 15:51:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 811E05D6-EC5B-11E5-8007-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289121>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> So, in short, I do believe there is a good reason for the "out of sync"
> git.pot. That doesn't make the negative side effect that I describe any
> less true, and I'm looking for ways to ammeliorate that. Something as
> easy as "make check" or "make test-lint".

Yes, I agree fully with the last sentence.  I think the task
probably needs two building blocks:

 - A tool to generate up-to-date git.pot contents and store into a
   given filename.

 - A tool that can be used to compare two versions of a .pot file,
   stored as two separate files in the filesystem, without the noise
   that comes from auto-generator (e.g. line numbers, the difference
   of line-wrapping the same messge).

With that, a user can (1) run the former and save the result in
git.pot-before-change before making any change (2) do her work, (3)
run the former again and save the result in git.pot-after-change,
and (4) run the latter between these two.

This is a bit hard to drive from the Makefile, though, as our
Makefile cannot assume people are using Git (they may be working off
of a tarball extract to produce a one-liner patch), and there is the
issue of "then how do we ensure that the user runs the former first
on prestine before starting to hack so that later the result can be
compared?"

But just like the version number generation, it is OK for some
targets to be optional, so perhaps it is OK for this "view pot
changes" task is limited to those who work on their own clone of
Git.  If we add that assumption, then the Makefile target for
"view-pot-changes" would

 - see if untracked file git.pot-$(git rev-parse HEAD) exists (treat
   this as a build artifact, like *.o files).  If it does not exist:

  - check out HEAD to a temporary location elsewhere on the
    filesystem;

  - run the first tool and store the result in the above file.

 - run the first tool in the working tree and store the result in
   another file git.pot-now (treat this file as a build artifact,
   too).

 - run the second tool on these two git.pot files.

Add "git.pot-*" to our .gitignore file, and make sure "make clean"
removes them.
