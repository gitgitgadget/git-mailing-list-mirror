From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Thu, 5 Dec 2013 13:43:29 -0500
Message-ID: <CACPiFCKZ4c-FgY36Y8J8OJ9E=MYxrc1BNadBF2QUWm_PD8KMLw@mail.gmail.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 05 19:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vodtz-0000FV-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 19:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757358Ab3LESnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 13:43:51 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:42805 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757350Ab3LESnu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 13:43:50 -0500
Received: by mail-ve0-f179.google.com with SMTP id jw12so14189076veb.38
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=+03/g2TVdCSo03BWbiT4PoYsfTyQBOf1Qws9sqKSKvM=;
        b=H/pTIMjLlvmDdvTC3WeTZLsLxZesqV2K9Udqsq1Fc5rf1ksnoXxmaGtwGo+Qe4gaJz
         0OizZEBooT/SmBfUzH0WyVjB+fPS2jPZweZ2Y5mFERMYSZNWUHshtxs3s09cw0wngPqb
         Vwr9Wsr56S+Dw3ECSVbamr1Q9kjsWJCby7a3RoaMi8K2gS6fpRSainBdcqehlzxVCtKc
         kkv156MdFAIPPLHK0jjgcHNyBmhpbY90iG5JvaMCRWLXgydF2yIupMPQNlCPiT/x3Kfo
         OALaSTz5xVY72IHiDK+xp2cuy4ILhJ8GaAkUq/O0uRjT9zJRa73H11GoBj3Y7W/37Leh
         Jjlw==
X-Received: by 10.52.98.194 with SMTP id ek2mr54882853vdb.11.1386269029940;
 Thu, 05 Dec 2013 10:43:49 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 5 Dec 2013 10:43:29 -0800 (PST)
In-Reply-To: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238895>

On Wed, Dec 4, 2013 at 6:01 PM, Martin Langhoff
<martin.langhoff@gmail.com> wrote:
> Is there a reasonable approach to scripting this?

Found my answers.

The 'subtree' merge strategy is smart enough to "mostly" help here.
However, it does not handle new files created in the subdirectory.

My workflow is this one. It is similar to the recipes for the subtree
merge strategies, but invoking git mv to pull files out of the

git merge -s ours --no-commit upstream/branch
git read-tree --prefix= -u upstream/branch
git mv mysubdir/* ./ ### read-tree can't do this
git commit

... time passes

git merge -s subtree --no-commit upstream/branch
if [ -d mysubdir ]; then
    # handle new files
    git mv mysubdir/* ./
fi
git commit

glad that I ended up reading a lot about subtree.

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
