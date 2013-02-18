From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH] shell-prompt: clean up nested if-then
Date: Mon, 18 Feb 2013 23:56:46 +0100
Message-ID: <1361228206.17734.4.camel@mas>
References: <1361204512.4758.10.camel@mas>
	 <1361204601-4573-1-git-send-email-martinerikwerner@gmail.com>
	 <20130218191040.GB3234@elie.Belkin>
	 <0c94f24b-f7ee-4699-87a7-6861b927cea4@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, trsten@science-computing.de,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Simon vanaf Telefoon <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Feb 18 23:57:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7Ze7-0004fV-Fh
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 23:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757552Ab3BRW4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 17:56:52 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:60385 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757530Ab3BRW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 17:56:51 -0500
Received: by mail-la0-f52.google.com with SMTP id fs12so5894025lab.39
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:x-mailer:mime-version
         :content-transfer-encoding;
        bh=sCQl6JLmqv0BoviiGaTKnvFz0SLqUtLwyC5/unuLFhc=;
        b=FhsogXqW+Jr2e9tK/NhABwyIOIuL0HDH81vp2VWkAD3b7SYBznjEm4/oBm+VTutXnC
         K2q3TNuCVoPw+lopqgD+JwreMSjGXekWZk3nbF4O/rI3vey8LkSNe+Xl70xBL5KuLNWe
         GtXfSk4tvwkX7+GOPST92P13mrmOu52r+I7VS68dZHBwGaOZIrP+kh3H1KPOiYQizmkg
         r1RDLTBIdEWw+tcY1kzWIh2dI0kqi8ZARBXrSCgkrCuyfJUmQtrJTL9/Ycj4K5dWGZTN
         3Ul3Z+R6Tnqsbq7pvQNX78MDlzbO/nn5kx3X5UB5mp5WguBti0bH/Sigev8KCuEXqi1k
         9NMw==
X-Received: by 10.112.42.103 with SMTP id n7mr6206819lbl.52.1361228209501;
        Mon, 18 Feb 2013 14:56:49 -0800 (PST)
Received: from [130.238.247.62] (student-247-62.eduroam.uu.se. [130.238.247.62])
        by mx.google.com with ESMTPS id er8sm21331331lbb.9.2013.02.18.14.56.47
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 14:56:48 -0800 (PST)
In-Reply-To: <0c94f24b-f7ee-4699-87a7-6861b927cea4@email.android.com>
X-Mailer: Evolution 3.6.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216545>


On Mon, 2013-02-18 at 21:31 +0100, Simon vanaf Telefoon wrote:
> Hi all, sorry for top posting :-( blame the phone and k9
> 
> I have a small issue with the use of test instead of [
> If that only applies to this section of the entire file. 
> Coding style has some value.
> 
> Combining nested ifs with && seems harmless enough, though should be
> well tested.
> 
> Cheers
> Simon 
> 

Ah, indeed, I looked around a bit more, and as per
http://mywiki.wooledge.org/BashPitfalls it seems like 'test' is bad to use with multiple &&'s anyways.

I've changed to using [] && [] and rerolled the patch.


> Jonathan Nieder <jrnieder@gmail.com> wrote:
>         Hi Martin,
>         
>         Martin Erik Werner wrote:
>         
>                 Minor clean up of if-then nesting in checks for environment variables
>                 and config options. No functional changes.
>         
>         Yeah, the nesting was getting a little deep.  Thanks for the cleanup.
>         May we have your sign-off?
>         
>         Once this is signed off,
>         Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Meh, I keep on missing that :/
Old (and new) patch is:
Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>

>         
>         Patch left unsnipped for reference.
>         
>                 ---
>                 contrib/completion/git-prompt.sh |   27 +++++++++++++--------------
>                 1 file changed, 13 insertions(+), 14 deletions(-)
>                 
>                 diff --git
>                 a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>                 index 9b2eec2..e29694d 100644
>                 --- a/contrib/completion/git-prompt.sh
>                 +++ b/contrib/completion/git-prompt.sh
>                 @@ -320,26 +320,25 @@ __git_ps1 ()
>                     b="GIT_DIR!"
>                    fi
>                   elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
>                 -   if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
>                 -    if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
>                 -     git diff --no-ext-diff --quiet --exit-code || w="*"
>                 -     if git rev-parse --quiet --verify HEAD >/dev/null; then
>                 -      git diff-index --cached --quiet HEAD -- || i="+"
>                 -     else
>                 -      i="#"
>                 -     fi
>                 +   if test -n "${GIT_PS1_SHOWDIRTYSTATE-}" &&
>                 +      test "$(git config --bool bash.showDirtyState)" !=
>                 "false"
>                 +   then
>                 +    git diff --no-ext-diff --quiet --exit-code || w="*"
>                 +    if git rev-parse --quiet --verify HEAD >/dev/null; then
>                 +     git diff-index --cached --quiet HEAD -- || i="+"
>                 +    else
>                 +     i="#"
>                     fi
>                    fi
>                    if [ -n "${GIT_PS1_SHOWSTASHSTATE-}" ]; then
>                     git rev-parse --verify refs/stash >/dev/null 2>&1 && s="$"
>                    fi
>                 
>                 -   if [ -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" ]; then
>                 -    if [ "$(git config --bool bash.showUntrackedFiles)" != "false" ]; then
>                 -     if [ -n "$(git ls-files --others --exclude-standard)" ]; then
>                 -      u="%"
>                 -     fi
>                 -    fi
>                 +   if test -n "${GIT_PS1_SHOWUNTRACKEDFILES-}" &&
>                 +      test "$(git config --bool bash.showUntrackedFiles)" != "false" &&
>                 +      test -n "$(git ls-files --others --exclude-standard)"
>                 +   then
>                 +    u="%"
>                    fi
>                 
>                    if [ -n "${GIT_PS1_SHOWUPSTREAM-}" ];!
>                   then
>                 -- 
> 
