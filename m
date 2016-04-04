From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for multiple options
Date: Mon, 04 Apr 2016 12:32:27 -0700
Message-ID: <xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Kevin Brodsky <corax26@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 21:32:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anAEm-0005tM-AA
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 21:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbcDDTcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 15:32:32 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755847AbcDDTcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 15:32:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E1F5D50C2D;
	Mon,  4 Apr 2016 15:32:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H1xuFK1fuJOE7722ML0wa0tVxR0=; b=jSCChz
	YXrYA72t28JndYp2+435pOMcraOGR+Hkl3IFsCiuFlWNGWO/Lh7ksoBe1ERJGyMd
	+e+wZKQ4DZ+4tSLcZfXy6ahACFgWo16JOYEWUEsUNlU62gEX6taRJwGrM7WGDsAY
	yH5hEfo/PeSU6reKgyJ8cKW7UkZSzKt+Cy7pA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CtpXLzZ4gBtT9vUCwFxjq91GlrwqoUBf
	VXAMgl9LiKH7eHufn8sBqFJt0NuhkJOwISAb2j5r/B/n3pZOjizJBw1UwA5Awyky
	ToEsRVaZLME8Vijd2SK/Qxidr0Yi45GVmS6Mq3hr0DvEibG/HDeZi7Yo4cq9kzhn
	1SEhuUWoOp8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8F8350C2C;
	Mon,  4 Apr 2016 15:32:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A56E50C2B;
	Mon,  4 Apr 2016 15:32:29 -0400 (EDT)
In-Reply-To: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Sun, 27 Mar 2016 17:26:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F80D7098-FA9B-11E5-BBDC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290717>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Documentation/diff-options.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 306b7e3..6eb591f 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -28,10 +28,12 @@ ifdef::git-diff[]
>  endif::git-diff[]
>  endif::git-format-patch[]
>  
> +ifndef::git-format-patch[]
>  -s::
>  --no-patch::
>  	Suppress diff output. Useful for commands like `git show` that
>  	show the patch by default, or to cancel the effect of `--patch`.
> +endif::git-format-patch[]

Given that the ifndef/endif block immediately before this part is
also about excluding -p/-u/--patch when formatting the documentation
for format-patch, perhaps the attached may be a smaller equivalent?

 Documentation/diff-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 306b7e3..42e6620 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -26,12 +26,12 @@ ifndef::git-format-patch[]
 ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
-endif::git-format-patch[]
 
 -s::
 --no-patch::
 	Suppress diff output. Useful for commands like `git show` that
 	show the patch by default, or to cancel the effect of `--patch`.
+endif::git-format-patch[]
 
 -U<n>::
 --unified=<n>::
