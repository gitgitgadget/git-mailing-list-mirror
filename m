From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Remove ancient Cygwin compatibility code
Date: Fri, 11 Dec 2015 11:54:09 -0800
Message-ID: <xmqqmvtgep7i.fsf@gitster.mtv.corp.google.com>
References: <20151201191743.GI14466@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 11 20:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Tll-00042V-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 20:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbLKTyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 14:54:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751051AbbLKTyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 14:54:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 15E953299C;
	Fri, 11 Dec 2015 14:54:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6YDCcXY1lyr++PRfDebUU/j6ic=; b=Vuwjbf
	ybJS2E8mNNGvpHPGmkqkowCUjZC+sw92mSNkEIdDdVxD7u5/uu6KZqrwaxmyx0V2
	PWLm8VhKzKqScYzrFrU4l8OfEvvGX/r43WIwP+Qcngh03gtYfxoxAcXT+en2ct8E
	8bEJYEIzKkY6cVQD4yiwSUhnLAhA7io6sv5NI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6aIkR96vbBEy7WTq/en0jOkwYWIloMb
	etbjGQ5gg1nVfi+308a350dpZQlZpiNWCKeAQsOlUoC7IIlGcmTs+6cQcGhofoqy
	TP14xyrW5SZWAWAjsT+b9CuSXKmWscdMWfTDsvwE6yKNqYus1hyfhOQZD4AE01MI
	RnxxudI75Vw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D6133299B;
	Fri, 11 Dec 2015 14:54:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8501B3299A;
	Fri, 11 Dec 2015 14:54:10 -0500 (EST)
In-Reply-To: <20151201191743.GI14466@dinwoodie.org> (Adam Dinwoodie's message
	of "Tue, 1 Dec 2015 19:17:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2258F72-A040-11E5-AE97-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282274>

Adam Dinwoodie <adam@dinwoodie.org> writes:

> Remove special path handling for Cygwin in the git-gui Makefile.  This
> used to be necessary, but has been being patched out of the official
> Cygwin distribution builds since Git v1.7.9, and should really be
> patched out of the upstream code rather than being patched every time in
> the Cygwin build process.
>
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
> I'm the current Cygwin maintainer for Git; this code has been patched
> out of the Cygwin Git builds since v1.7.9,* well before I took over.
> It's clearly stable and causing no problems, so having it in the
> upstream code rather than patching every time seems The Right Thing To
> Do.
>
> (* The actual patch used in the Cygwin builds just replaces `ifeq
> ($(uname_O,Cygwin))` with `ifeq ($(uname_O,noThanks))`, but that's
> clearly the appropriate solution for a quick manual patch, not for the
> actual upstream code.)
>
> Sending with apologies to Shawn Pearce for the noise; I'd misread the
> SubmittingPatches doc and sent to him alone first.
>
> I've based this patch off the git-gui tree rather than the main Git tree
> per the SubmittingPatches doc.  Pipe it through `sed
> 's!Makekfile!git-gui/\0!g'` for a version that applies cleanly to the
> main Git source tree.

Pat, this looks like a good thing to have.

More generally, should I expect a pull request from you sometime in
a week or two for updates in the git-gui part?

Thanks.

>  Makefile | 21 +++------------------
>  1 file changed, 3 insertions(+), 18 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 4f00bdd..e369046 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -136,25 +136,10 @@
>  GITGUI_RELATIVE :=
>  GITGUI_MACOSXAPP :=
>  
> -ifeq ($(uname_O),Cygwin)
> -	GITGUI_SCRIPT := `cygpath --windows --absolute "$(GITGUI_SCRIPT)"`
> -
> -	# Is this a Cygwin Tcl/Tk binary?  If so it knows how to do
> -	# POSIX path translation just like cygpath does and we must
> -	# keep libdir in POSIX format so Cygwin packages of git-gui
> -	# work no matter where the user installs them.
> -	#
> -	ifeq ($(shell echo 'puts [file normalize /]' | '$(TCL_PATH_SQ)'),$(shell cygpath --mixed --absolute /))
> -		gg_libdir_sed_in := $(gg_libdir)
> -	else
> -		gg_libdir_sed_in := $(shell cygpath --windows --absolute "$(gg_libdir)")
> -	endif
> -else
> -	ifeq ($(exedir),$(gg_libdir))
> -		GITGUI_RELATIVE := 1
> -	endif
> -	gg_libdir_sed_in := $(gg_libdir)
> -endif
> +ifeq ($(exedir),$(gg_libdir))
> +	GITGUI_RELATIVE := 1
> +endif
> +gg_libdir_sed_in := $(gg_libdir)
>  ifeq ($(uname_S),Darwin)
>  	ifeq ($(shell test -d $(TKFRAMEWORK) && echo y),y)
>  		GITGUI_MACOSXAPP := YesPlease
