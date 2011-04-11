From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH 00/11] Sequencer Foundations
Date: Mon, 11 Apr 2011 10:19:05 +0530
Message-ID: <20110411044900.GA20939@kytes>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <201104110518.04413.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 06:50:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q994w-0005H7-9V
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 06:50:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab1DKEt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 00:49:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46573 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1DKEtz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 00:49:55 -0400
Received: by iwn34 with SMTP id 34so5269355iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 21:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0FocupAEIhEfXSKjhRbPuUdCtflmCkScH6RXi0nXB6M=;
        b=RJ9qmPkvf3dBPq2bYkmXqIrE/gdIDUkVTykncH+yz3AHYn3sq4Ys3rrmp3TABj0w9K
         iu9ii13dySoc5ldn/Pla83pOPR65r0o0fqCd01GFp5W+5SLh1dxpIQsEWa3hwP0C7qo+
         ijQwIePyhnXqDFJYbKImyfpZCOJO92HRssTUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=THkaUOUDGp+w68rR69AbuKuFjW6BctUWb38N/qbKhm6PqhYGVCmOdZD5PsTw5PFuwv
         RdHQoDNGr7rq2ibKIugEXp1MMYOsW4zy4qABSP3uSSBvtyMF0jndRAOgQvxTyvgo8/Vb
         HCd7ta6SYibgtyISJbFIa0fQZO2vRc4oWdBKg=
Received: by 10.231.117.157 with SMTP id r29mr4860686ibq.128.1302497394013;
        Sun, 10 Apr 2011 21:49:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i26sm2852544iby.58.2011.04.10.21.49.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 21:49:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104110518.04413.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171303>

Hi Christian,

Christian Couder writes:
> On Sunday 10 April 2011 17:11:46 Ramkumar Ramachandra wrote:
> > Hi,
> > 
> > I've started working on building a sequencer for Git.  
> 
> So you are starting the GSoC early! Great!
> When (or before) it really starts, just make sure you put your work on a 
> public Git repository and you send status updates regularly (weekly if 
> possible).

Ofcourse.  I've already discussed many of these issues last year [1].
The work corresponding to this particular series can be found in the
'sequencer' branch on my GitHub fork [2].  Since the results haven't
been announced, and the coding period hasn't begun, this work should
be treated like "normal work" -- I just wrote it this weekend.

> > 3. From the format of the TODO and DONE files, one more thing should
> > be clear- I'm trying to stick to a slight variation of the 'rebase -i'
> > format.  This part will go into the sequencer.  Then I'll use a
> > cherry-pick specific file to keep the command-line options.  Yes, I'm
> > trying to work on Daniel's idea [3] from the very start.  Is this a
> > good idea?
> 
> I think that the TODO and DONE file format will need at one point to include 
> options and it is simpler if this change is done early. Using a cherry-pick 
> specific file to keep the options is not very generic for a sequencer that could 
> be used for many things.
> 
> For example, as we have rebase --interactive, we will probably want to have 
> cherry-pick --interactive, and when editing the TODO file we might want to use 
> different cherry-pick options when picking different commits.

Point noted -- I shouldn't narrow down the various things I can do
with a single commit early on and lock us into a more restrictive
design.  However, I'm not in favor of making it too generic; I
certainly wouldn't like to edit an instruction sheet that looks like
this:

cherry-pick -m 1 -s -r 83a4fe9
revert -n 3a6fe42
cherry-pick -x --ff dacfe41
cherry-pick -s recursive -Xpatience b31d4e2

It'll become impossible to tell which options are disallowed over what
else, and it'll become a nightmare to debug when something goes wrong.
My idea is that we add commit-specific options in an optional
backward-compatible manner later:

pick 83a4fe9
revert 3a6fe42 # -n
pick dacfe41 # -s
pick b31d4e2

That way, there'll be two sets of options:

1. One "global" set of command-line switches that applies
to all the commits, which will be written to a command-specific
location.  The sequencer itself knows nothing about this.

2. Optional commit-specific stuff that's passed in the
form of a (modified) commit_list to the sequencer API to write to the
todo/ done files.

Do you like this idea?

> This would also make the different cherry-pick options available when using 
> rebase --interactive once it uses the sequencer.
> 
> > [1]:
> > http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170908
> > [2]: http://thread.gmane.org/gmane.comp.version-control.git/162183 [3]:
> > http://thread.gmane.org/gmane.comp.version-control.git/170758/focus=170834
> 
> [3] is missing here.

Your email client is perhaps wrapping too aggressively? It's fine in
my original email [3].

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/142623/focus=142821
[2]: https://github.com/artagnon/git
[2]: http://article.gmane.org/gmane.comp.version-control.git/171255
