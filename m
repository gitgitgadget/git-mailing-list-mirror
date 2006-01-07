From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Teach cvsexportcommit to add new files
Date: Sat, 7 Jan 2006 20:29:08 +1300
Message-ID: <46a038f90601062329s35163616i7c658e4d6ede294b@mail.gmail.com>
References: <20060106205441.GA32585@nowhere.earth>
	 <7virsxrnik.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jan 07 08:29:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev8Vr-00067Y-5M
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 08:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWAGH3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 02:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWAGH3J
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 02:29:09 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbWAGH3I convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 02:29:08 -0500
Received: by wproxy.gmail.com with SMTP id i30so1254110wra
        for <git@vger.kernel.org>; Fri, 06 Jan 2006 23:29:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jfLvqHAafAt4pi6wLNIMbJ17G/9n4kBWz44lKeQPDQsH2eZ9fWMWmychF7yPft+A8ByBnKjBBLmDVsMMAm7YWonDAgd+MB6JqbpUyTmlWCC5kIPf+jlHJ4df2dXMA3QFBIoeZor39ZA7zqsYajcJEp2NMLYisHa/D5G6k2kNiK4=
Received: by 10.54.120.2 with SMTP id s2mr3212267wrc;
        Fri, 06 Jan 2006 23:29:08 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Fri, 6 Jan 2006 23:29:08 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virsxrnik.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14239>

On 1/7/06, Junio C Hamano <junkio@cox.net> wrote:
> Yann Dirson <ydirson@altern.org> writes:
>
> > Teach cvsexportcommit to add new files
> > "cvs add" support was already there, but the "unknown" status
> > returned when querying a file not yet known to cvs caused the
> > script to abort prematurely.
>
> Thanks.  I'll take the patch as is, but I noticed that the
> cvsexportcommit still has some room for polishing.

Definitely. It's a bit of a hack job that I got started with, and as
it's /worked for me/ so far, haven't done much with it. I am actually
quite busy at the moment, so I don't think you'll see many patches
from me on this fron yet...

(BTW: I'm hoping to find a bit of time to code the git-cvsdaemon that
I've mentioned before, which would be a hell of an interesting
addition, methinks.)

>  * The command is to be run from CVS working copy (as desribed
>    in the documentation) and seems to assume that the parent
>    commit is checked out at least for the paths involved between
>    the commit and the parent (not clearly documented).

Indeed, and you can also use it for the same thing you'd use git-am --
for instance, to "merge into CVS" feature branches kept on GIT.

>  * I wonder if it is safe with filenames with embedded SP?

It's not -- shame on me. Backticks should be replaced with
safe_pipe_capture() as Eric's done on git-archimport.

>  * I think this grep '^Binary' is unsafe; different versions of
>    gnu diff say just "Files differ".

Unsure how to detect binary files safely. Is there a way to ask git
whether it considers the files to be binary?

(snipped several good suggestions here...)

> I am getting an impression that _if_ we care about applying
> fuzzy patch like this, giving fuzz feature to git-apply would
> help this program somewhat, but at the same time I do not think
> of a good reason to even accept nonexact patch when synching two
> SCM histories.

Well, with some fuzz you can use this to merge something into CVS even
if the trunk or branch you're merging into has moved forward a bit.
OTOH, I guess you can go back to git and do a git-rebase if needed.

cheers,


martin
