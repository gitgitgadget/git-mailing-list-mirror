From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Change colors to be based on git status -sb in color
 mode
Date: Tue, 16 Oct 2012 14:30:40 -0700
Message-ID: <7vtxtuqf3z.fsf@alter.siamese.dyndns.org>
References: <7vvceatnn4.fsf@alter.siamese.dyndns.org>
 <20121016193405.GA12073@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Oct 16 23:30:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOEj0-0001zg-3D
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 23:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab2JPVan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 17:30:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753928Ab2JPVam (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2012 17:30:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33A5F87B2;
	Tue, 16 Oct 2012 17:30:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O0TfA2ODmyo865zm+O4jeBhbylQ=; b=R43h/Z
	hf63erLpURT+w/7DIwj1GMRV8l8fHqJokfN/or3wnFHpeDeBHUVm61sqvP/FR/LP
	WZXI4DfDAKCxuOO+uIXz1vSaNtxt9OSvrUaCxDc8+NVHfFyhAFbj8ZquAUBCLJaf
	Y5vW06rdelmOnc9KT5rkfG9zE9sC3fav+Ad7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VjnWPqy00uNZJshsM9haC9DJmskltcor
	K8+bPAoC2puiGzFqpPyXuAKk5WvdaC21sX6Y1/V3wB+L/XLaaL1UqI3grXTty4Ik
	2DKwMeByru3qKGCLY98O3TkJXNmzajcY3aluaOgi9lHjnnEyaSiJedQZ+L1w/cXE
	pIn3Dw8v6zA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20E3687B1;
	Tue, 16 Oct 2012 17:30:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A49287B0; Tue, 16 Oct 2012
 17:30:41 -0400 (EDT)
In-Reply-To: <20121016193405.GA12073@simaj.xs4all.nl> (Simon Oosthoek's
 message of "Tue, 16 Oct 2012 21:34:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BC6997F0-17D8-11E2-A0E0-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207881>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> Hi
>
> Fixed the mistakes of the last one, and I'm now using the symbolic names "ok_color" and "bad_color".
> The test for headless state is now more direct, and I hope it is still correct.
>
> /Simon

Will apply with a bit more readable log message.

I think it would be a good idea to squash something like the
attached into this patch, though.

 contrib/completion/git-prompt.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-prompt.sh
index dced628..9f0b6bb 100644
--- i/contrib/completion/git-prompt.sh
+++ w/contrib/completion/git-prompt.sh
@@ -215,7 +215,7 @@ __git_ps1_show_upstream ()
 __git_ps1 ()
 {
 	local pcmode=no
-	#defaults/examples:
+	local detached=no
 	local ps1pc_start='\u@\h:\w '
 	local ps1pc_end='\$ '
 	local printf_format=' (%s)'
@@ -264,7 +264,7 @@ __git_ps1 ()
 			fi
 
 			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
-
+				detached=yes
 				b="$(
 				case "${GIT_PS1_DESCRIBE_STYLE-}" in
 				(contains)
@@ -335,8 +335,7 @@ __git_ps1 ()
 				local flags_color="$c_lblue"
 				local branchstring="$c${b##refs/heads/}"
 
-				if git symbolic-ref HEAD 2>/dev/null 1>&2
-				then
+				if [ $detached = yes ]; then
 					branch_color="$ok_color"
 				else
 					branch_color="$bad_color"
