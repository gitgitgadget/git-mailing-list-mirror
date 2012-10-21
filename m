From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2012, #06; Fri, 19)
Date: Sun, 21 Oct 2012 11:24:14 +0700
Message-ID: <CACsJy8A2PdG69hB1=YgHMAdibO=7_Uu5qvmyAqcrhdBVWy761g@mail.gmail.com>
References: <7vmwzii37w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 21 06:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPn5t-00074N-Ot
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 06:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab2JUEYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 00:24:46 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51517 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab2JUEYp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 00:24:45 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1543098obb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dA1n5tmOZDiy5LdUXx8C8x/5dUbFbnTnFmoFAc3J4nM=;
        b=ITaEI98Oq+muSBNzxOoAbUjmFQDN50ljfQXDaOti6vh/1DHSeNr7RH39HGl1yIgm5U
         6ALMt2qRgStukRyuVlKz0v+sAdytn0HLjnthTDxxhX9P21ccaKhjrm5lYFcObKNar5ow
         JByM5+e+5d5eQ+OtKDcXR7G/mdIHvHp6XoR/80LvmlM4Azv1HD2/27WEIFHqUjm/EhCL
         jqvzP+p/bBRLnHOiIW2RibcvfP2KCwNcv84TCRoJ7tNJgp7p+wKRSw/e200Y+xooqUkM
         GBe4YZ2Fx4zINk1f79yq1Uisua3iEU+EVgasXwuqN7SM5X6AD+ZnGvbBAYitg1zVQIJD
         mWvg==
Received: by 10.60.22.136 with SMTP id d8mr5024757oef.124.1350793484517; Sat,
 20 Oct 2012 21:24:44 -0700 (PDT)
Received: by 10.182.108.10 with HTTP; Sat, 20 Oct 2012 21:24:14 -0700 (PDT)
In-Reply-To: <7vmwzii37w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208101>

On Sat, Oct 20, 2012 at 4:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/wildmatch (2012-10-15) 13 commits
>
>  Allows pathname patterns in .gitignore and .gitattributes files
>  with double-asterisks "foo/**/bar" to match any number of directory
>  hierarchies.
>
>  I suspect that this needs to be plugged to pathspec matching code;
>  otherwise "git log -- 'Docum*/**/*.txt'" would not show the log for
>  commits that touch Documentation/git.txt, which would be confusing
>  to the users.

I do want non-recursive "*" in pathspec and "**" can help retain the
recursive "*" semantics. But can we just flip the coin at some point
and change "*" semantics in pathspec from recursive to non-recursive?

I have no problem with that but then we might want to change other
places that use fnmatch without FNM_PATHNAME too, e.g. apply, branch,
for-each-ref... Or we could go with new syntax
":(glob)Docu*/**/*.txt". A bit ugly.
-- 
Duy
