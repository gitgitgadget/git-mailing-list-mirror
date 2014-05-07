From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: move out of contrib
Date: Tue, 06 May 2014 17:28:28 -0700
Message-ID: <xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
References: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:28:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whpiv-0002Sq-9g
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 02:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbaEGA2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 20:28:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53799 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458AbaEGA2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 20:28:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 650D615F08;
	Tue,  6 May 2014 20:28:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ed/Tc1ztHArdWmEuvtmTF+ZX8K8=; b=A2hexw
	LGZgmNRMfgEB0Jic5gvsfTpthsDRMXLsf84upKfvkOaHyu9uishf7FoV82pOs7gl
	FdRCuO/Hrauz4f3wYBpmOihdnvCT2eiDRHzXa87E4s5CgUEEOUwjfdjzkVAHWmbS
	NgbSthnNt2N4wCXqk7GLmx9vh07HzRUMN2CFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMshON/KP18Tsv1EL6uKHR4HgHrXceZM
	kLuC0dI6zE47M3Ex3sOoxUly2cOk/gFBELJA7yjK1uWwcVtQqn2UyJn2FG641tH4
	eOUOx8RDhqE2aGuyCTaMoMJaCjKYPyYTq/zu3xN7kk77nG9Dv3uAeK4MT+MzCZAp
	HyRUIpRFCNU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58D0E15F07;
	Tue,  6 May 2014 20:28:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B922B15F01;
	Tue,  6 May 2014 20:28:29 -0400 (EDT)
In-Reply-To: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Fri, 2 May 2014 19:36:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 835C6004-D57E-11E3-AB53-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248275>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These have been stable and widely used for quite a long time, they even
> have tests outside of the contrib area, and most distributions ship
> them, so they can be considered part of the core already.
>
> Let's move them out of contrib and install them by default.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Makefile                                           | 5 ++++-
>  {contrib/completion => shared}/git-completion.bash | 0
>  {contrib/completion => shared}/git-completion.zsh  | 0
>  {contrib/completion => shared}/git-prompt.sh       | 0
>  t/t9902-completion.sh                              | 2 +-
>  t/t9903-bash-prompt.sh                             | 2 +-
>  6 files changed, 6 insertions(+), 3 deletions(-)
>  rename {contrib/completion => shared}/git-completion.bash (100%)
>  rename {contrib/completion => shared}/git-completion.zsh (100%)
>  rename {contrib/completion => shared}/git-prompt.sh (100%)

I am not sure whom this change is meant to help.

 - Those who build from source *and* care about having the latest
   completion must already have a way they have been using to
   install them.  They will have to change their procedure to adjust
   for the change of the path, *and* disable the part of "install"
   that installs it to $(sharedir) which is unlikely to match where
   they have been installing completion scripts.

 - Those who package completion for distros already have a way they
   have been using to install them.  They suffer the same as those
   who build from the source.

 - Those who use pre-packaged Git and completion scripts would not
   care.

 - Those who have *not* installed from the source may benefit for
   being able to say "make install" and let it be installed, but
   they have to dot-include /usr/share/git-completion.bash location,
   which is new, not from /etc/bash_completion.d/git as they are
   used to.

A better change might be to give a new Makefile target, perhaps

    $ make install.contrib-completion

without moving the scripts from their current place.  That way,
nobody gets hurt, and those who are new to Git who want to build
and install from the source would not have to invent their own way
to install stuff from contrib/ (the same goes for other contrib/
tools such as contrib/workdir/ we may want to add a new target to
let you say "make install.contrib-workdir").

I _may_ be persuaded to fold the installation of all possible
contrib/ stuff into the regular "make install", but I haven't
thought things through.

The patch does two unrelated things:

 - Move things in the source tree.

 - Install the completion by default.

I very much agree that the latter may be a good thing to have in the
polished end result.  I am not sure if the installation location
chosen is sensible.  At least, another redirection

    git_completion_dir = $(sharedir)

may be necessary to allow people install these in the location they
want.
