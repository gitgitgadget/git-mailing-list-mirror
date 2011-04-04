From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Mon, 4 Apr 2011 09:36:15 +0530
Message-ID: <20110404040610.GA30737@kytes>
References: <20110403172054.GA10220@kytes>
 <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 04 06:07:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6b4d-0003zM-6h
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 06:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815Ab1DDEHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 00:07:25 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45306 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab1DDEHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 00:07:24 -0400
Received: by yxs7 with SMTP id 7so2043551yxs.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 21:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xuOwLmwf8Zf49H+ucYvaSVOOoxbBjV98J5Mg9xW4xg4=;
        b=cq/QSDLzZjsMFIrKZdrBtenbpegVPxDXFKUCCA6GhrJguag/nQ2osQYcA6PHFRtkdu
         WY0gYN0laPd27FffS40cZ3zmgymduH7UFRIUtXB81MUJI/gv7oDFEJBaHnDdFMwq3JvN
         7/AaI9jRth2tlbAKZr8Pa75lvtnvS/OTVnyUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bJPu8E5DD4AYCQ5sRXUnIWQfOGlnMRvh4pr7l/EZaJIWr8S+E8NRxx3W05JlXOibXj
         B4kta6r1raGlGE7SG+259MsRI1h9FFmCqNyI2VxDYwpx+Vj0cCA33ca7KkOsWXAtBHsw
         hJcj2IVqFXkFHYy/+w9SylWZCb2ZQllCsfCpc=
Received: by 10.236.139.129 with SMTP id c1mr8871806yhj.340.1301890043998;
        Sun, 03 Apr 2011 21:07:23 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x68sm1399346yhn.57.2011.04.03.21.07.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 21:07:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170785>

Hi Daniel,

Daniel Barkalow writes:
> On Sun, 3 Apr 2011, Ramkumar Ramachandra wrote:
> > To write git-sequencer, a new builtin command, and implement existing
> > commands on top of that.  This should give the commands more
> > functionality, improve their error handling, and make them faster.
> > The project can only be considered successful if all (or most) of the
> > code written gets merged into upstream.
> > 
> > The Git Sequencer was a 2008 GSoC project as well; unfortunately most
> > of the code did not get merged into git.git.  The learning from all
> > that work should serve as a huge headstart this year.
> 
> One of the things that is hard about sequencer is that it is ultimately a 
> complete replacement for several differently-implemented programs in 
> different languages, with different temporary file formats and differrent 
> supported operations. As such, you could probably spend an entire summer 
> just getting it reviewed, revised, and accepted, starting with a working 
> implementation.

Agreed.  I've chosen to use the same commands and temporary files as
'git-rebase--interactive.sh', because I think those commands are
sufficient to implement everything else.

> So I think your proposal is good in how [1/5] includes getting something 
> useful merged. My suspicion is that the outcome will be something like 
> that you implemented all 7 tasks and got 4 of them merged, assuming that 
> you really push getting things merged as soon as they're ready, without 
> spending too much time porting other things to use the core and getting 
> the ports reviewed before the core is accepted.

Hm.  In that case, we'll just have a sequencer that can cherry-pick --
I personally wouldn't be too happy with this outcome either.

> I actually think that it would be a worthwhile feature for git's library 
> code to have a uniform mechanism for communicating that it is requesting 
> human intervention in the middle of a particular operation, where library 
> operations which conflict with being able to continue this operation are 
> either blocked or abort the operation, and the library is able to be told 
> in general that the human intervention is done and the library operation 
> should be finished now (or produce complaints about the user's work). That 
> is, a library-level, single-interrupted-step "sequencer". For that matter, 
> it should also apply to the common '"git merge" gets a conflict' case, and 
> it would be useful to get some representational uniformity between that 
> and cherry-pick getting a conflict.

Until 4/7, I'd only planned to make the 'git-sequencer' binary like
the 'git-rebase--interactive.sh' script, except that it would accept a
TODO file on stdin, instead of interactively opening up an editor.

Your idea is a slightly more ambitious version of what I'd planned for
6/7, especially since 'merge' contains a lot of cruft like MERGE_HEAD
and CHERRY_PICK_HEAD.  I can shift my focus after 4/7 though -- here's
what I have in mind.  Do you have something similar in mind?

enum commit_todo_action {
     ACTION_PICK;
     ACTION_REWORD;
     ACTION_EDIT;
     ACTION_SQUASH;
     ACTION_FIXUP;
     ACTION_EXEC;
};

struct commit_todo_list {
       struct commit *item;
       enum commit_todo_action action;
       struct commit_todo_list *next;
};

int sequencer_cherry_pick(struct commit *base, struct commit_list *list);
int sequncer_rebase(struct commit *base, struct commit_todo_list *list);
int sequencer_handle_conflict(); /* Returns ABORT (1) or RESOLVED (0) */

/**
 * The sequencer_handle_conflict function essentially starts with a
 * working tree with unmerged files and results in either a working
 * tree without unmerged files (in which case it returns 0), or simply
 * returns 1.  Advantage: Consistency. Each individual script will not
 * have to maintain its own temporary files.
 */

> I think replacing existing multi-step processes is going to be a lot more 
> contentious and involve user-visible changes which involve matters of 
> taste and such. But I think you can make a valuable contribution in how a 
> single current step is handled before getting tangled in that, and be much 
> more likely to get a useful outcome than if you try to tackle the whole 
> problem.

Okay.  I'll replace 5/7 - 7/7 in my proposal with an alternative as
soon as I sketch out the details more clearly.

Thanks for your suggestions!

-- Ram
