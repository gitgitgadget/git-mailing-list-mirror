From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Wed, 23 Apr 2014 10:07:20 -0700
Message-ID: <xmqqlhuw0ybb.fsf@gitster.dls.corp.google.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
	<20140422060120.GA10198@hashpling.org>
	<53560b09bbe96_2400128531085@nysa.notmuch>
	<20140422065549.GA11224@hashpling.org>
	<535611fac1b7b_268bd0b308f5@nysa.notmuch>
	<20140422073008.GA11584@hashpling.org>
	<535620a6e8274_3d2216372ec9d@nysa.notmuch>
	<20140423075601.GA18585@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:07:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd0dz-0000SX-PE
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaDWRH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:07:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaDWRHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:07:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 068A07E494;
	Wed, 23 Apr 2014 13:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NzvdNCDYbwVwcgy97Q97a8+DaUw=; b=YUD9Xk
	U2qnSd+SKxt3+ppBQCiCr8zrKNHgyeVkSK57E3hADmpfwxsWesLI7XWMBsXVEPi3
	ptEfOCPG14116qTJGCev5CuSpddoOOVgzCRna8NVFG/L/0zR7HqtPHy8MVi+OLZU
	n9OESyMd6DkegRB/dOjZSAyKykAnaHer5Jmog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BuxqEyGMd72YJHrpTfJrY7oSRe2oJ0w1
	js5YQAUkCs9DwNZwLclT8CYezBSzMeCpVOKyYOYAcZKQCJKMQUigExPp+Tr6iQmH
	WXnIbAm92zcTDm5jIZ+nxNTz04ErVwRvap6Vx96Ywl5RjeV8y6pVj0IdToizLzRe
	9UzaPCHEFu0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5BB7E493;
	Wed, 23 Apr 2014 13:07:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B46597E48F;
	Wed, 23 Apr 2014 13:07:22 -0400 (EDT)
In-Reply-To: <20140423075601.GA18585@hashpling.org> (Charles Bailey's message
	of "Wed, 23 Apr 2014 08:56:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC6E8D92-CB09-11E3-9B56-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246851>

Charles Bailey <charles@hashpling.org> writes:

> The bit of documentation that I was thinking of is in
> Documentation/git-mergetool.txt where it states that "--prompt" is the
> default which is now only partially true.

Thanks for being careful to help tying the loose ends.

Perhaps like this?

I take that your original motivation was to confirm to run a tool on
this particular (as opposed to another) path, but the user can also
take the prompt as to confirm to run this (as opposed to some other)
tool.  The latter of which of course is irritating for those who
told which exact tool to use.

I think the large part of the reason why you and Felipe had to have
a long back-and-forth was because it was unclear that the prompt
served these two purposes from the documentation, so I attempted to
clarify the first motivation by adding a brief half-sentence.


 Documentation/git-mergetool.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 07137f2..ec089ff 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -71,11 +71,14 @@ success of the resolution after the custom tool has exited.
 --no-prompt::
 	Don't prompt before each invocation of the merge resolution
 	program.
+	This is the default if the merge resolution program is
+	explicitly specified with the `--tool` option or with the
+	`merge.tool` configuration variable.
 
 --prompt::
-	Prompt before each invocation of the merge resolution program.
-	This is the default behaviour; the option is provided to
-	override any configuration settings.
+	Prompt before each invocation of the merge resolution program
+	to ask if it should be run for the path.
+
 
 TEMPORARY FILES
 ---------------
