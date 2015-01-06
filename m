From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui.sh: support Tcl 8.4
Date: Tue, 06 Jan 2015 11:42:11 -0800
Message-ID: <xmqqvbkjofvw.fsf@gitster.dls.corp.google.com>
References: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:43:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8a1I-0002VL-SU
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 20:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbbAFTmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 14:42:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756516AbbAFTmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 14:42:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 534E42DB2E;
	Tue,  6 Jan 2015 14:42:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4DFz7cG8utjeyPFgKArCPi2kmG4=; b=VscbVO
	YqDr2rSftwbAmKEzAsdvBozlLffMvQPKyaQgpqY9jTlFJA2caNATCD6aTrc8zbVO
	/xhLMxOkW/4A2IoHGtlklIcHqShuHqEo+Bpg5Vun39+EZveztDcQgnt1L/yQcIMw
	8e+OGSD2sq9y7tuJsX9xjdFx3GUREnDhrxnmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KaKBzZ3QFzBLD7PqsLKu7+k5cptuQ7T8
	nNdV65cSIkgIX/41iwd3EghUc82iDYTShBJ79wN8DJ1cqPTO6FtHvxIbWMUQArX2
	Tz41dksJZiLqw7hbDUj24pfWE4xOSzklO9mYbLxpF+P7cWf+uqalOmaj25dFCSKT
	RaVgX8VOfAk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 493D62DB2D;
	Tue,  6 Jan 2015 14:42:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D52CA2DB2A;
	Tue,  6 Jan 2015 14:42:13 -0500 (EST)
In-Reply-To: <97e448e7908a1f959a7294e389553b5@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Tue, 6 Jan 2015 02:41:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CF1030A-95DC-11E4-B65B-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262097>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Tcl 8.5 introduced an extended vsatisfies syntax that is not
> supported by Tcl 8.4.

Interesting.  We discussed this exact thing just before 2.0 in

    http://thread.gmane.org/gmane.comp.version-control.git/247511/focus=248858

and nobody seems to have noticed that giving the new range notation
to vsatisfies is too new back then.

> Since only Tcl 8.4 is required this presents a problem.

Indeed.

> However, what we really want is just a basic version compare,
> so use vcompare instead to restore compatibility with Tcl 8.4.

My Tcl is not just rusty but corroded, so help me out here.

 * Your version that compares the sign of the result looks more
   correct than $gmane/248858; was the patch proposed back then but
   did not get applied wrong?  This question is out of mere
   curiosity.

 * Would it be a good idea to update the places $gmane/248895 points
   out?  It is clearly outside the scope of this fix, but we may
   want to do so while our mind is on the "how do we check required
   version?" in a separate patch.

Thanks.

> Signed-off-by: Kyle J. McKay
> ---
>  git-gui/git-gui.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index b186329d..a1a23b56 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -1283,7 +1283,7 @@ load_config 0
>  apply_config
>  
>  # v1.7.0 introduced --show-toplevel to return the canonical work-tree
> -if {[package vsatisfies $_git_version 1.7.0-]} {
> +if {[package vcompare $_git_version 1.7.0] >= 0} {
>  	if { [is_Cygwin] } {
>  		catch {set _gitworktree [exec cygpath --windows [git rev-parse --show-toplevel]]}
>  	} else {
> @@ -1539,7 +1539,7 @@ proc rescan_stage2 {fd after} {
>  		close $fd
>  	}
>  
> -	if {[package vsatisfies $::_git_version 1.6.3-]} {
> +	if {[package vcompare $::_git_version 1.6.3] >= 0} {
>  		set ls_others [list --exclude-standard]
>  	} else {
>  		set ls_others [list --exclude-per-directory=.gitignore]
