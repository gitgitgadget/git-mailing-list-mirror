From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: Make git-gui lib dir configurable at runtime
Date: Mon, 21 Jul 2014 14:06:41 -0700
Message-ID: <xmqqbnsiifq6.fsf@gitster.dls.corp.google.com>
References: <1405966809-30882-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:07:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9KnT-0007V7-Js
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 23:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbaGUVGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 17:06:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50528 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928AbaGUVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 17:06:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1443C2BC67;
	Mon, 21 Jul 2014 17:06:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FocwURQyKe+/hKMCbq1kuGxFQ3k=; b=TXtZpI
	MWX291X/rM/ylneHmx+Yp5IlpBt2mhNxncvDJMLhCxnhDAbUbIVvv89/4fMLqGzv
	d+BhfzQWq75TDTTguSHKwnYcqvh/N2e0yZO7dM/ia6crabDxtnxARkfQ4e0Dkkt+
	ZxYpjg73mFSuVOB5f+mAOrveZAmSOlqKciCaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/hKf0dbpGB5lKpE0CBbXOOPYJRvnm15
	Au4sp+jqSpPgJ/i3D0VjnYOlQxCBp5IWPOW4uL7Mw9rpSIjZvYH3hln4CA3pOspx
	/2JNny+bauNvfs0nSVKzq9+VH010kBYOsOjW7xXo+w4HZ8mQk8Qhth72aCXmcTSC
	tDh3sWmL95w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 082142BC66;
	Mon, 21 Jul 2014 17:06:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5C7712BC50;
	Mon, 21 Jul 2014 17:06:43 -0400 (EDT)
In-Reply-To: <1405966809-30882-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 21 Jul 2014 14:20:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EACA9314-111A-11E4-A553-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253996>

David Turner <dturner@twopensource.com> writes:

> Introduce the GIT_GUI_LIB_DIR environment variable, to tell git-gui
> where to look for TCL libs.  This allows a git-gui which has been
> built with a prefix of /foo to be run out of directory /bar.  This is
> the equivalent of GIT_EXEC_PATH or GITPERLLIB but for git-gui's TCL
> libraries.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  git-gui/Makefile   | 3 ++-
>  git-gui/git-gui.sh | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Would a similar change to gitk necessary/beneficial to platforms
that would benefit from this change?

git-gui directory in my tree comes from its upstream repository
git://repo.or.cz/git-gui.git/, and it is maintained by Pat Thoyts
(Cc'ed).

gitk is from git://ozlabs.org/~paulus/gitk.git maintained by Paul
Mackerras <paulus@samba.org> (not Cc'ed).

Note that these two upstream projects do not have leading
directories git-gui and gitk-git themselves (they are merged to my
tree while their paths being renamed).  A patch that is appliable to
them would touch paths without them (e.g. Makefile and git-gui.sh
for an equivalent of the patch I am responding to).

Thanks.

> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index cde8b2e..56bf9e2 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -177,7 +177,8 @@ git-gui: GIT-VERSION-FILE GIT-GUI-VARS
>  	echo then >>$@+ && \
>  	echo '	'echo \'git-gui version '$(GITGUI_VERSION)'\' >>$@+ && \
>  	echo else >>$@+ && \
> -	echo '	'exec \''$(libdir_SQ)/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\' \
> +	echo '	libdir="$$(GIT_GUI_LIB_DIR:-$(libdir_SQ))"' >>$@+ && \
> +	echo '	'exec \"'$$libdir/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\" \
>  		'"$$0" "$$@"' >>$@+ && \
>  	echo fi >>$@+ && \
>  	chmod +x $@+ && \
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index b186329..6cbb36e 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -49,7 +49,11 @@ catch {rename send {}} ; # What an evil concept...
>  ##
>  ## locate our library
>  
> -set oguilib {@@GITGUI_LIBDIR@@}
> +if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
> +	set oguilib $::env(GIT_GUI_LIB_DIR)
> +} else {
> +	set oguilib {@@GITGUI_LIBDIR@@}
> +}
>  set oguirel {@@GITGUI_RELATIVE@@}
>  if {$oguirel eq {1}} {
>  	set oguilib [file dirname [file normalize $argv0]]
