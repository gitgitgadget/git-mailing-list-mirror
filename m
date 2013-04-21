From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] prompt: fix tracked files for zsh
Date: Sun, 21 Apr 2013 15:00:16 -0700
Message-ID: <7vehe3sfwv.fsf@alter.siamese.dyndns.org>
References: <1366531890-19899-1-git-send-email-felipe.contreras@gmail.com>
	<m2fvyk8fb8.fsf@igel.home> <7vli8cuv5j.fsf@alter.siamese.dyndns.org>
	<m2a9or907f.fsf@igel.home>
	<CAMP44s36TO6DQ_3j7rSOoOM6QS-Y0DW_z6WX_GF3ODFfupb6jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 00:00:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2JL-0006kq-Fq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 00:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab3DUWAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 18:00:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543Ab3DUWAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 18:00:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5EB188A9;
	Sun, 21 Apr 2013 22:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u7uGDPMaiV24RWGf7hVUaznM2Kg=; b=abvVT+
	X9bjl7UCQQFPjMnT/JURwshn3arh95RxIiX41+SHIXIPhBsT2sN96o5Q7QchTw1w
	IgOUCTbzi7pmAqR9IMen2JWhjrUgnYo9SYrJc5Qt4yZyitupWurw7NYV/jNaDq2T
	Lf9iZiNJXsUOj4pmpah4gVSwbFflXRD71vXfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9YykUhzTD5aaUhTh1ypLiLrfINUnUgC
	bE5hfLHNnOI5dMxCaKizoRx4YbiFVo6kTWHSIXLK3S3rbD1e7SXE/Mvf//nWgM1I
	LN1vSk0iCjOfXkF6xUgS5Os/7Uqwkb46zhwlQm/YHWCiMLqf0pgTW0togVcdIoYD
	d6e3+GdRiLY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76299188A8;
	Sun, 21 Apr 2013 22:00:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4F7D188A7;
	Sun, 21 Apr 2013 22:00:17 +0000 (UTC)
In-Reply-To: <CAMP44s36TO6DQ_3j7rSOoOM6QS-Y0DW_z6WX_GF3ODFfupb6jg@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 21 Apr 2013 16:00:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA72DF7A-AACE-11E2-89CE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221978>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 21, 2013 at 2:02 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>
>>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>>
>>>>> +                           if [ -n "${ZSH_VERSION-}" ]; then
>>>>> +                                   u="%%"
>>>>> +                           else
>>>>> +                                   u="%"
>>>>> +                           fi
>>>>
>>>> aka u="%${ZSH_VERSION:+%}"
>>>
>>> Do you need/want a colon there?  Even if it is empty, as long as it
>>> is defined we would want this, no?
>>
>> The original wouldn't.
>
> I thought you were trying to improve the original ;)

OK, so I _think_ everybody is in agreement that the patch should
look like this.  OK?

-- >8 --
From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] prompt: fix untracked files for zsh

With "bash.showUntrackedFiles" option, presense of untracked files
is signalled by adding a per-cent sign '%' to the prompt.  But
because '%' is used as an escape character to introduce prompt
customization in zsh (just like bash prompt uses '\' to escape \u,
\h, etc.), we need to say '%%' to get a literal per-cent.

Helped-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 756a951..054c52e 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -340,7 +340,7 @@ __git_ps1 ()
 			   [ "$(git config --bool bash.showUntrackedFiles)" != "false" ] &&
 			   [ -n "$(git ls-files --others --exclude-standard)" ]
 			then
-				u="%"
+				u="%${ZSH_VERSION+%}"
 			fi
 
 			if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ]; then
