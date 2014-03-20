From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Lost commit during rebase!
Date: Thu, 20 Mar 2014 14:41:15 -0500
Message-ID: <CAHd499AM5niunTURoop+JspxMgBwhWY8upRpo5RU-gux7+BZ8A@mail.gmail.com>
References: <CAHd499CBkuCJvZ+U3GEcnw0UFot5JooZVdj2sHT_3p0s6ScwcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:41:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQiqH-0006Ej-DO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 20:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759754AbaCTTlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 15:41:19 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:48694 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759650AbaCTTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 15:41:16 -0400
Received: by mail-ve0-f175.google.com with SMTP id oz11so1499903veb.34
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=79wQp+FLmN6ggUOVRMknvG38JjACSsbssu9cTmlu1kE=;
        b=o9zceblj96Azi1bP3Fk+uJwyaNthDHVXpVSpBHUQa8AqI4BpD4Hlax3UVPaJri2RdP
         zlEpqkqXl1V3ked1CjvqNXE0k8qHK4tQWoS+AZqqdDms574bMqoQXIrMSilZM2W7q4wN
         EhMgZs3kjXr2fOpW9gDFyXokb0rLbAEnHiRwZmYQDsqghGX3cPzAlJxEq2NUHu2awiHd
         FwgP57jj0pXKBnxzxqzq6Un3zRfm+V9E977lxCfMuF0qmaiKIXZtzn8SK2C6EIUQDGUM
         Jpy1dN8XRVYjhDTPkGwoVkQenZUCGavIS6LNIe9Vf76mB8kobcdgTXmh/gYHMOJlBHV7
         EjIA==
X-Received: by 10.221.44.8 with SMTP id ue8mr1144869vcb.55.1395344475238; Thu,
 20 Mar 2014 12:41:15 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.2.79 with HTTP; Thu, 20 Mar 2014 12:41:15 -0700 (PDT)
In-Reply-To: <CAHd499CBkuCJvZ+U3GEcnw0UFot5JooZVdj2sHT_3p0s6ScwcQ@mail.gmail.com>
X-Google-Sender-Auth: EH5O6wj8KVtLen3fT38fvcW29qY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244577>

Sorry it looks like I missed some basic documentation:
http://git-scm.com/docs/git-rebase

This issue (combining preserve merges with interactive option) is
described in the BUGS section.

Is there a way I can go about this without losing my merge commits?

On Thu, Mar 20, 2014 at 2:37 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a local-only branch with just under 70 commits. I also have
> merge commits on this branch.
>
> The log of the top few commits on my branch looks like so:
>
> * de651ff       (20 minutes ago) (HEAD, survey) Robert Dailey - WIP:
> GOTO implementation
> * 2a68a23       (21 minutes ago) Robert Dailey - Move boost::phoenix
> include & namespace changes to own header file
> * e1cd568       (19 hours ago) Robert Dailey - WIP: GOTO flow changes
> * b039bb5       (19 hours ago) Robert Dailey - Remove superfluous
> include of own header
> * 4bdeb27       (20 hours ago) Robert Dailey - Rename NavigateBackwards()
>
> I had two commits that I wanted to squash and also reorder another
> one. The command I ran is:
>
> git rebase -pi `git merge-base origin/master survey`
>
> I ran this command with 'survey' branch checked out. Once my editor
> appears, the last few commits in the file look like so:
>
> pick 4bdeb27 Rename NavigateBackwards()
> pick b039bb5 Remove superfluous include of own header
> pick e1cd568 WIP: GOTO flow changes
> pick 2a68a23 Move boost::phoenix include & namespace changes to own header file
> pick de651ff WIP: GOTO implementation
>
> I modify the last 3 commits in the file so now it looks like this:
>
> pick 4bdeb27 Rename NavigateBackwards()
> pick b039bb5 Remove superfluous include of own header
> pick 2a68a23 Move boost::phoenix include & namespace changes to own header file
> pick e1cd568 WIP: GOTO flow changes
> squash de651ff WIP: GOTO implementation
>
> What I did was:
>
> 1. Move 2a68a23 back one commit
> 2. Mark de651ff for squash
>
> After this, I save the file, close, and rebase operations begin. After
> the rebase is done, my log looks like this:
>
> * 94d06df       (19 hours ago) (HEAD, survey) Robert Dailey - WIP:
> GOTO flow changes
> * b039bb5       (19 hours ago) Robert Dailey - Remove superfluous
> include of own header
> * 4bdeb27       (20 hours ago) Robert Dailey - Rename NavigateBackwards()
>
> Notice that the commit with description "Move boost::phoenix include &
> namespace changes to own header file" is missing! I looked at reflog:
>
> $ git reflog
> 94d06df HEAD@{0}: rebase -i (finish): returning to refs/heads/survey
> 94d06df HEAD@{1}: rebase -i (squash): WIP: GOTO flow changes
> e1cd568 HEAD@{2}: rebase -i (pick): updating HEAD
> 2a7b27a HEAD@{3}: rebase -i (pick): Move boost::phoenix include &
> namespace changes to own header file
> b039bb5 HEAD@{4}: rebase -i (pick): updating HEAD
> 4bdeb27 HEAD@{5}: rebase -i (pick): updating HEAD
> 2e40bcd HEAD@{6}: rebase -i (pick): updating HEAD
> 3ca6bb3 HEAD@{7}: rebase -i (pick): updating HEAD
> e63b1e5 HEAD@{8}: rebase -i (pick): updating HEAD
> 4d40c00 HEAD@{9}: rebase -i (pick): updating HEAD
> ec078c1 HEAD@{10}: rebase -i (pick): updating HEAD
> de48c5d HEAD@{11}: rebase -i (pick): updating HEAD
>
> It shows that it "picked" the commit that's missing now. Is this a bug
> or am I not doing something right? I'm using Git for Windows version
> 1.9.0
