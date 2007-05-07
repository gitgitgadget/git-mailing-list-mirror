From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sun, 6 May 2007 17:37:48 -0700
Message-ID: <56b7f5510705061737g3f7cd443i47175f67f13eb059@mail.gmail.com>
References: <463BD40C.6080909@gmail.com>
	 <Pine.LNX.4.64.0705050324580.4015@racer.site>
	 <7vwszolz26.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
	 <Pine.LNX.4.64.0705051637450.4015@racer.site>
	 <7vwszmfod8.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0705061653100.4015@racer.site>
	 <7v1whtdfd2.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0705070110040.4167@racer.site>
	 <7v6475bi69.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 07 02:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkrFj-00033G-5a
	for gcvg-git@gmane.org; Mon, 07 May 2007 02:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbXEGAiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 20:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbXEGAiJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 20:38:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:16464 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927AbXEGAht (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 20:37:49 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1416013wra
        for <git@vger.kernel.org>; Sun, 06 May 2007 17:37:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TVD/bRi6G5oBrfrbNW30M9/e05hu6HGSNRlDwrusoNxPAYPAmEvxG2OLKjwsGZDEnejLPxgf4zJA1PJyV/8SyyGcKes3hfv1UW/IgkY0yPTQrEmL8IGPznKqtI0oOkP0hYrycqmvtFqZny0hXWabpctyxXv6vcL9a2rS+z83Sls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LbeClsmhMJwsAGgPeiM1qSHfhM8TIjoanbIzMRDlcGFJcGlmcU7vPIE5LdlvTJF/D+ZcSZxP9x8EY91MKGurwbnRQXf9SYBJu5UuZ7ylv3vFbNbEa3/HCzLAgLHD4LOaU/VlL4nGFyAnKsXiJiGpV8L8oGV+yIGMGsRbDu3Kxu8=
Received: by 10.114.39.16 with SMTP id m16mr1926969wam.1178498268361;
        Sun, 06 May 2007 17:37:48 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Sun, 6 May 2007 17:37:48 -0700 (PDT)
In-Reply-To: <7v6475bi69.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46401>

On 5/6/07, Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Sun, 6 May 2007, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >> > On Sat, 5 May 2007, Junio C Hamano wrote:
> >> >
> >> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> >>
> >> >> >> (a) In a bare repository, I believe
> >> >> >> setup.c:setup_git_directory_gently() determines the prefix to be
> >> >> >> NULL.  This means my patch will see ALL paths as absolute, except
> >> >> >> :../path which will result in an error.
> >> >> >
> >> >> > My point was that it feels inconsistent to take the current path into
> >> >> > account in one case, but not in the other.
> >> >>
> >> >> I do not understand your reasoning.  In a bare repository you cannot
> >> >> even be in a subdirectory to begin with.
> >> >
> >> > Exactly! That is my point. If you can do it in a working directory, but
> >> > also with a bare repository, I find it highly confusing and inconsistent
> >> > to have different meaning.
> >>
> >> Sorry.  Now you confused me further.  I can do:
> >>
> >>      cd Documentation
> >>         git diff v1.5.0 v1.5.1 -- git.txt
> >>
> >> Is that confusing, inconsistent and bad for the users?
> >
> > Well, I am partly at fault that you _can_ execute git-diff outside of a
> > repository.
> >
> > But given the _arguments_ you give to git-diff as above, I'd expect it to
> > actually care about the working directory. IOW I would _not_ expect this
> > to work outside of a working directory (even if it does).
>
> Oh, I was not thinking about "outside of repository" use.  I was
> talking about your earlier "bare repository vs inside worktree
> vs inside a subdirectory of worktree" point.  In a bare
> repository,
>
>         git diff v1.5.0 v1.5.1 -- Documentation/git.txt
>
> is the only form that makes sense, as you cannot say "I am
> interested in Documentation/" by _being_ in that subdirectory.
> In a repository with worktree, you can, and we let you do so.
>
> I would expect v1.5.0:Documentation/git.txt notation would be
> the only sane variant that would make sense to name that blob in
> a bare repository for the same reason.  I do not expect anybody
> to complain because we do not allow him to say v1.5.0:git.txt in
> a bare repository, either.
>
> Also I sympathize with people who would wish to (eventually) be
> able to do:
>
>         $ cd Documentation/
>         $ git show v1.5.0:git.txt
>
> in a repository with worktree, by making the "relative path" the
> default behaviour.  They would need to do either one of:
>
>         $ git show v1.5.0:/git.c
>         $ git show v1.5.0:../git.c
>
> if we ever made the "relative path" the default.  As long as you
> make sure that you make:
>
>         $ git show v1.5.0:/git.c
>
> work the same way in a bare repository _if_ we make the
> "relative path" the default, I do not see any inconsistency
> problem there.
>
> A bare repository and a repository with working tree are
> different.  In the former, you cannot say "I am interested in
> this subtree" by _being_ in a subdirectory; in the latter you
> can.  Taking advantage of that and allowing the user to express
> himself better (only) in the latter is not an inconsistency.
> Not being able to do that in a bare repository comes from what a
> bare repository inherently is.

Each of the examples given already works as described above
in the current patch [if you change one #define to enable
"relative is default"].  I will get around to fixing the one
error I described elsewhere and re-submit.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
