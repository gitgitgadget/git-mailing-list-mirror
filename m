From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 21:22:06 +0200
Message-ID: <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
References: <20060326014946.GB18185@pasky.or.cz>
	 <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
	 <e06hts$1ne$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 21:22:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNaoV-0006M3-DR
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 21:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWCZTWI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 14:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWCZTWI
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 14:22:08 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:27933 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751247AbWCZTWH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 14:22:07 -0500
Received: by zproxy.gmail.com with SMTP id 13so1148369nzp
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 11:22:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KrlJcmcjRl8kR4VyywTChFdk4ZkWEY2/FdK2laPQpCd81PPa+7hAVdYsiyRlFtrA8zsUbzA818QIzFYNY7UIpQWFcJHT36LIEeRMnmUPsNSmp0ibETv+gJurvwiydOfrpCRyxA67l3n9dAQORcXennpA2OSKYhsG0JB71C6Biio=
Received: by 10.65.215.10 with SMTP id s10mr258940qbq;
        Sun, 26 Mar 2006 11:22:06 -0800 (PST)
Received: by 10.65.163.13 with HTTP; Sun, 26 Mar 2006 11:22:06 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18055>

On 3/26/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> So wouldn't it be _much_ nicer to have a "graphical git-whatchanged",
> where you just delve deeper (and you don't even look at the whole file
> like git-whatchanged does, but you ask for a very particular region).
>
> Ie, what I imagine would be something gitk/qgit like, where you see the
> file content, select a line or two (or a whole function), and it goes back
> in history and shows you the last diff that changed that
> line/two/function. We can do that EFFICIENTLY. Much more efficiently than
> git-annotate, in fact. And then when you see the diff, you might say "I'm
> not interested in this one, that was just a re-indent" and then continue
> back.
>
> THAT is the kind of graphical tool I'd want. And dammit, it should even be
> _easy_. I'm just a total clutz myself when it comes to doing things like
> QT or nice tcl/tk text-panes, and this really does have to be visual,
> since the whole point is that "select text" and interactive part.
>
> So if somebody wants to be a hero, and feels comfortable with those kinds
> of things, this really should be a fairly straightforward thing to do (it
> would be useful even without rename detection or data movement detection,
> but it's also something where you really _could_ do efficient data
> movement detection by just looking at the "whole diff" when something
> changed in that small area).
>

I am a thousand miles away from being an hero (and glad of it), but....

I really need a bit of feedback or comment about this because IMHO
qgit annotate is *almost* very similar to what you would ask, so I
need to understand well the difference:

FIRST WAY

After annotating a file history (double click on a file name in
bottom-right window or directly from tree view), you see the whole
file annotated. If you have the diff window open you see also the
corresponding patch (scrolled to selected file name).

Now, double clicking on the chosen code line in file content makes
currently two things:

  - Diff window is updated to show corresponding revision patch, i.e.
the last patch that modified that line of code.

- File content, as well as file annotation, changes to show the
content of the file just after the patch was applied, from there it is
normally possible to go back in the history of that code region in the
same way, i.e. double clicking on interesting lines.

Biggest limitation of 'annotation browsing' is that 'code removing
only' patches are not annotated and you need to check them  directly
in diff window.

SECOND WAY

Without opening the file viewer it is possible to select a file (or
more then one or one directory) from tree view and press magic wand
button. This causes main view to be updated with git-rev-list  --
<selected paths>  content, i.e. a filtered view.

With diff viewer window open you can browse across file patch history
related to chosen file.

Biggest limitation is that all the revisions who touch the file are
shown, not only the ones limited to a selected region.

IF I HAVE UNDERSTOOD...

If I have understood what you would like to see it something like the following:

- From diff/file viewer window select a code region.

- Press Magic wand button and feed git-rev-list with <selected path>
_and_  <selected content>

- Show git-rev-list output on main window as usual, but now selected
revisions are filtered out not only for path but also for region of
code touched.


Am I guessing correctly?

Marco
