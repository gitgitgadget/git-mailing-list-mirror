From: Leo Razoumov <slonik.az@gmail.com>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Fri, 21 May 2010 08:52:13 -0400
Message-ID: <AANLkTilctjct-a911H14XMnaBydYR1I6lPbEuFThTJ99@mail.gmail.com>
References: <ht3194$1vc$1@dough.gmane.org>
	 <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 21 14:52:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFRi9-0005rY-Dm
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 14:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab0EUMwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 08:52:16 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64251 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0EUMwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 08:52:15 -0400
Received: by wwi18 with SMTP id 18so639460wwi.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=ZO+QEMErGbAKdiWDHbQVRvWugskgPQIg+7pcCwRJpv4=;
        b=ZDCNtQbmDAhvMeI4+foxTwuWVc80LtRfj1LLtENwXy8BRjjpUNwpAL6+X+eXgLQnz8
         VYI3hGVJnkQI4eae+JtvdYje868o61rc06m9wGQVR311SL+nGlYyxE5rYExcp6NXkD+V
         B1nk667J2hVATs3oYkEUNJOK/oWzgd+W8Jae0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Gd47YPMWoIYwT/bGCxr2a0DAizexD9cMdSpGQeePHGCEDdSFHIOPyDGpGF+IfzHbW5
         E+pk9JN7eZvc5JKpYQlnKJEzocTF798FCbE90HkGlYgXqS5vfxoSTqVL0rEJ26sz+KSD
         B08HePfeuyGIQi5mWoUeZyv4C5Mxp1ck2IBI4=
Received: by 10.227.157.69 with SMTP id a5mr1402210wbx.146.1274446333263; Fri, 
	21 May 2010 05:52:13 -0700 (PDT)
Received: by 10.216.67.8 with HTTP; Fri, 21 May 2010 05:52:13 -0700 (PDT)
In-Reply-To: <7vy6fe7ldo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147451>

On 2010-05-20, Junio C Hamano <gitster@pobox.com> wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
>
>  > One additional small point: why do untracked files in a submodule make the
>  > module dirty?  I've often got a few "temp.ps" or "debug.log" or
>  > "backtrace.log" files lying around -- inappropriate to add to an ignore
>  > file, but they don't make my working directory dirty.
>
>
> "They don't make my working directory dirty" is something only you can
>  decide, until you tell git about that fact, isn't it?
>
>  The way to tell git about them is to use the ignore/exclude mechanism.
>  Why are they "inappropriate to add to an ignore file"?  At least you could
>  have "*.log" in your personal exclude $GIT_DIR/info/exclude, no?

Please, correct me if I am wrong, but I always thought that repo's
dirty designation has to do with changed files _in_ the repo.
Untracked files are _not_ in the repo and, as such, are irrelevant for
repo's clean/dirty status.

Speaking of .gitignore and untracked files. Explicitly mentioning all
such untracked files in .gitignore is often unpractical. For example,
during build process some large projects autogenerate many temporary
*.c  *.h *.cpp files. Hunting all of them down and adding to
.gitignore is a waste of time and one cannot use globs *.c *.h for
obvious reasons.

I think that it is consistent and logical to drop untracked files from
repo's dirty/clean decision process.

I would be interested to know of any counter-example: that is, a
use-case where it makes logical sense to declare a repo dirty when it
gets an untracked file not mentioned in .gitignore.

--Leo--
