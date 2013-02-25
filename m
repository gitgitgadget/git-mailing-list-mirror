From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: make mandir, htmldir and infodir absolute
Date: Mon, 25 Feb 2013 12:35:26 -0800
Message-ID: <7vppzow2r5.fsf@alter.siamese.dyndns.org>
References: <cover.1360700102.git.john@keeping.me.uk>
 <20130212222508.GG12240@google.com> <7vmwv9ducx.fsf@alter.siamese.dyndns.org>
 <7vip5xdtt6.fsf@alter.siamese.dyndns.org>
 <7vehgldt8e.fsf_-_@alter.siamese.dyndns.org>
 <20130224195500.GA27578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Feb 25 21:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA4mB-0007g4-W8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 21:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758265Ab3BYUfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 15:35:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535Ab3BYUf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 15:35:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BDC7B438;
	Mon, 25 Feb 2013 15:35:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RnrZKNEz+XuNbSqjMltnsQyjTcw=; b=xHA6Mu
	gC5Wxvmppyr5AQmKGzL2g37N4CEtj++aiVRSJKJa7G+W4DXE7WG6jm+RpS+TDi0T
	sh3KY68AabKqe0zYxnVtwNaNJzLuUoVdqUQSFTKMfrU0MAseAIJASFt6PowzZiLd
	mtNbfVB6PRvtxnzZHBte12jx2t0OMuG9tPUBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jkk/uZpUqmeOw1vajL4ZSl7ugBneh4dI
	svgb2uKf5sjntUe+g9awMjGMeLew/N57aEJ5eKrrAvJediOByrZ7Du446H9Uu4Ro
	SG2xAWxPu/3bvjQOTBe/GGybEpoyGVq2HF9AY8f++RJJnfJo5DlCICjpMzycSiw+
	/PEPiFEXN+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CDF7B437;
	Mon, 25 Feb 2013 15:35:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4AD90B436; Mon, 25 Feb 2013
 15:35:28 -0500 (EST)
In-Reply-To: <20130224195500.GA27578@serenity.lan> (John Keeping's message of
 "Sun, 24 Feb 2013 19:55:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4126290-7F8A-11E2-812E-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217104>

John Keeping <john@keeping.me.uk> writes:

> This matches the use of the variables with the same names in autotools,
> reducing the potential for user surprise.
>
> Using relative paths in these variables also causes issues if they are
> exported from the Makefile, as discussed in commit c09d62f (Makefile: do
> not export mandir/htmldir/infodir, 2013-02-12).
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> On Tue, Feb 12, 2013 at 03:09:53PM -0800, Junio C Hamano wrote:
>> A longer term fix is to introduce runtime_{man,html,info}dir variables
>> to hold these funny values, and make {man,html,info}dir variables
>> to have real paths whose default values begin with $(prefix), but
>> as a first step, stop exporting them from the top-level Makefile.
>
> Here's an attempt at doing that.
>
> If this is sensible, should bindir_relative be calculated in the same
> way?

Thanks for taking the cue from existing bindir_relative, which I
overlooked.  Calling these *dir_relative, not runtime_*dir as I
hinted, makes a lot more sense and overall makes things consistent.

As most people would want to say bindir=/usr/local/bin and not
bindir_relative=bin from the command line (and I suspect that people
coming from ./configure would not even have a way to specify the
latter), I think your suggestion to make bindir the primary one and
derive bindir_relative from it makes sense.

What do Windows folks think?

[patch unsnipped for others' reference]

>  Makefile | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7c75e3b..087eec4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -360,33 +360,39 @@ STRIP ?= strip
>  # Among the variables below, these:
>  #   gitexecdir
>  #   template_dir
> -#   mandir
> -#   infodir
> -#   htmldir
>  #   sysconfdir
>  # can be specified as a relative path some/where/else;
>  # this is interpreted as relative to $(prefix) and "git" at
>  # runtime figures out where they are based on the path to the executable.
> +# Additionally, the following will be treated as relative by "git" if they
> +# begin with "$(prefix)/":
> +#   mandir
> +#   infodir
> +#   htmldir
>  # This can help installing the suite in a relocatable way.
>  
>  prefix = $(HOME)
>  bindir_relative = bin
>  bindir = $(prefix)/$(bindir_relative)
> -mandir = share/man
> -infodir = share/info
> +mandir = $(prefix)/share/man
> +infodir = $(prefix)/share/info
>  gitexecdir = libexec/git-core
>  mergetoolsdir = $(gitexecdir)/mergetools
>  sharedir = $(prefix)/share
>  gitwebdir = $(sharedir)/gitweb
>  localedir = $(sharedir)/locale
>  template_dir = share/git-core/templates
> -htmldir = share/doc/git-doc
> +htmldir = $(prefix)/share/doc/git-doc
>  ETC_GITCONFIG = $(sysconfdir)/gitconfig
>  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
>  lib = lib
>  # DESTDIR =
>  pathsep = :
>  
> +mandir_relative = $(patsubst $(prefix)/%,%,$(mandir))
> +infodir_relative = $(patsubst $(prefix)/%,%,$(infodir))
> +htmldir_relative = $(patsubst $(prefix)/%,%,$(htmldir))
> +
>  export prefix bindir sharedir sysconfdir gitwebdir localedir
>  
>  CC = cc
> @@ -1548,12 +1554,12 @@ ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
>  DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
>  bindir_SQ = $(subst ','\'',$(bindir))
>  bindir_relative_SQ = $(subst ','\'',$(bindir_relative))
> -mandir_SQ = $(subst ','\'',$(mandir))
> -infodir_SQ = $(subst ','\'',$(infodir))
> +mandir_relative_SQ = $(subst ','\'',$(mandir_relative))
> +infodir_relative_SQ = $(subst ','\'',$(infodir_relative))
>  localedir_SQ = $(subst ','\'',$(localedir))
>  gitexecdir_SQ = $(subst ','\'',$(gitexecdir))
>  template_dir_SQ = $(subst ','\'',$(template_dir))
> -htmldir_SQ = $(subst ','\'',$(htmldir))
> +htmldir_relative_SQ = $(subst ','\'',$(htmldir_relative))
>  prefix_SQ = $(subst ','\'',$(prefix))
>  gitwebdir_SQ = $(subst ','\'',$(gitwebdir))
>  
> @@ -1685,9 +1691,9 @@ strip: $(PROGRAMS) git$X
>  
>  git.sp git.s git.o: GIT-PREFIX
>  git.sp git.s git.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
> -	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
> -	'-DGIT_INFO_PATH="$(infodir_SQ)"'
> +	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
> +	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> +	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
>  
>  git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>  	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
> @@ -1697,9 +1703,9 @@ help.sp help.s help.o: common-cmds.h
>  
>  builtin/help.sp builtin/help.s builtin/help.o: common-cmds.h GIT-PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
> -	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
> -	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
> -	'-DGIT_INFO_PATH="$(infodir_SQ)"'
> +	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
> +	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
> +	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
>  
>  version.sp version.s version.o: GIT-VERSION-FILE GIT-USER-AGENT
>  version.sp version.s version.o: EXTRA_CPPFLAGS = \
