From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: move out of contrib
Date: Tue, 06 May 2014 20:18:15 -0500
Message-ID: <536989d764672_250b14ed2ec66@nysa.notmuch>
References: <1399077403-19678-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 03:29:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhqfU-0006yF-9w
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 03:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbaEGB3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 21:29:04 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:64158 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaEGB3C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 21:29:02 -0400
Received: by mail-ob0-f175.google.com with SMTP id wo20so360687obc.34
        for <git@vger.kernel.org>; Tue, 06 May 2014 18:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EVz4Q0OBazDDMmsdRJQhIuIigUOFQkQ0pczjfy2EClo=;
        b=Bi+Xzhlq0ezVwWlfOW9k75THN6FsDaWWtBAWCg6N7lRqlldAvdl9u8ne+/XSkY8mqb
         LZPb5kL7CoPg50H64cIbu2dZ7B81kOGgd2nzqX5fJPDoKgOAV/5wyTuHzXCvXfpqoYhP
         Ox3E7stHrI3CJ/eEtJbOP+ozCwo09HFinXVJUSaaFpWdsSNaKoT7sDkmDHCJsAr5Ik31
         s15wwobgWjbOxGGpTx/YFTMGmRe6hI22mX/PMV92IZ9zHEGLH85hCyScsJeE8TlCwYaD
         KD0o6+kqsqP651Vanr4Kn/71wf1YrIj0OFzFlpT2I33RSbpwHD51BapR+wZEEcNf6nck
         Sz9g==
X-Received: by 10.182.33.6 with SMTP id n6mr12932238obi.48.1399426141826;
        Tue, 06 May 2014 18:29:01 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f1sm59307847oej.5.2014.05.06.18.28.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 18:29:00 -0700 (PDT)
In-Reply-To: <xmqq38gmctzn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248277>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > These have been stable and widely used for quite a long time, they even
> > have tests outside of the contrib area, and most distributions ship
> > them, so they can be considered part of the core already.
> >
> > Let's move them out of contrib and install them by default.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Makefile                                           | 5 ++++-
> >  {contrib/completion => shared}/git-completion.bash | 0
> >  {contrib/completion => shared}/git-completion.zsh  | 0
> >  {contrib/completion => shared}/git-prompt.sh       | 0
> >  t/t9902-completion.sh                              | 2 +-
> >  t/t9903-bash-prompt.sh                             | 2 +-
> >  6 files changed, 6 insertions(+), 3 deletions(-)
> >  rename {contrib/completion => shared}/git-completion.bash (100%)
> >  rename {contrib/completion => shared}/git-completion.zsh (100%)
> >  rename {contrib/completion => shared}/git-prompt.sh (100%)
> 
> I am not sure whom this change is meant to help.
> 
>  - Those who build from source *and* care about having the latest
>    completion must already have a way they have been using to
>    install them.  They will have to change their procedure to adjust
>    for the change of the path, *and* disable the part of "install"
>    that installs it to $(sharedir) which is unlikely to match where
>    they have been installing completion scripts.

No.

>  - Those who package completion for distros already have a way they
>    have been using to install them.  They suffer the same as those
>    who build from the source.

Yes, *if* they have been packaging them, they have a way. But what if
they haven't been doing so?

And for the ones that have a way, now they need one hack less.

>  - Those who use pre-packaged Git and completion scripts would not
>    care.

No.

>  - Those who have *not* installed from the source may benefit for
>    being able to say "make install" and let it be installed, but
>    they have to dot-include /usr/share/git-completion.bash location,
>    which is new, not from /etc/bash_completion.d/git as they are
>    used to.

Wrong. They don't have to dot-include anything, bash-completion does
that automagically. If they don't have bash-completion, sure, they'll
need to dot-include the new location.

And the location is not /usr/share/git-completion.bash, it's
$(sharedir)/bash-completion/completions.

Although after reading bash-completion's README, it should actually be:

 % pkg-config --variable=completionsdir bash-completion

> A better change might be to give a new Makefile target, perhaps
> 
>     $ make install.contrib-completion
> 
> without moving the scripts from their current place.

But they are not contrib, they are part of the core, and should be
distributed by default.

> That way, nobody gets hurt, and those who are new to Git who want to
> build and install from the source would not have to invent their own
> way to install stuff from contrib/ (the same goes for other contrib/
> tools such as contrib/workdir/ we may want to add a new target to let
> you say "make install.contrib-workdir").

There is already a way to install from contrib.

 % make -C contrib/remote-helpers install

The fact that you never picked my fixes to make it so is another matter.

> I _may_ be persuaded to fold the installation of all possible
> contrib/ stuff into the regular "make install", but I haven't
> thought things through.

But the completions are not contrib, they are essentially part of the
core.

If you want to demote them to contrib, then they shouldn't be tested by
default, and t9902-completion.sh and t9903-bash-prompt.sh should be
moved out to contrib.

You cannot have your cake and eat it at the same time.

> The patch does two unrelated things:
> 
>  - Move things in the source tree.
> 
>  - Install the completion by default.
> 
> I very much agree that the latter may be a good thing to have in the
> polished end result.  I am not sure if the installation location
> chosen is sensible.  At least, another redirection
> 
>     git_completion_dir = $(sharedir)
> 
> may be necessary to allow people install these in the location they
> want.

ifneq ($(prefix),$(HOME))
	bashcompletiondir := $(shell pkg-config --variable=completionsdir bash-completion 2> /dev/null)
endif
ifndef bashcompletiondir
	bashcompletiondir = $(sharedir)/bash-completion/completions
endif

-- 
Felipe Contreras
