From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with (auto-update on checkout or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 17:48:54 -0400
Message-ID: <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <alpine.DEB.1.00.0804301121240.17469@eeepc-johanness>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
	 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
	 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Harper" <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:50:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrKBm-0004zI-Nw
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 23:50:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761115AbYD3VtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760462AbYD3VtA
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 17:49:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:59078 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763993AbYD3Vs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 17:48:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so502547fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 14:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SvhdBq+sa0PNP2Vyd7kuBG1kW9dnow33p3ViXfv3I5c=;
        b=Oul9I+cXM8/6DuoiwdA/ZcXkoP3nPviJKYd+gHEEv5Rj3UFR1OtMSGUj36khI4GGItKtvGleRZqAY+C/dX/LRGaAGHleNsr2j13pibaWVHRbrAN5qLKiC9PJ8hQn6J0Ynw5JVTKkM0AUfwnl06MhsLg+hNmhhWUQmXgaWYEJLsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wrZ99SEwzB7hftOvW0ouc7mc8Iyy/QVxCIYf9CahD2lv/1iuvPqraNIIsyJ1tFwZmRyODR+ybJ7rX5zdncWFxcAJgTVfFgkwj+pql82azRw9kmdGOX9uUq8WafWMxdkL8aeoc5Ge5knnS1+M34eNr6/dLW1WzW6YiwxFzjERczw=
Received: by 10.82.126.1 with SMTP id y1mr188827buc.20.1209592134586;
        Wed, 30 Apr 2008 14:48:54 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 14:48:54 -0700 (PDT)
In-Reply-To: <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80875>

On 4/30/08, Tim Harper <timcharper@gmail.com> wrote:
> > What about the following case:
> > - submodule matches the super module checkin
> > - make changes to submodule but to *not* commit them
> > - switch supermodule branches, which should checkout a different submodule
> > - submodule checkout causes a conflict with uncommitted files
> > [all of the above were meant to be steps in the same test case]
>
> Oooh - this could be a problem currently, especially if you're not on a
> branch.  If you have to resolve conflicts the way to resolve them is to
> commit, and you can't switch to a branch to commit unless you resolve your
> issues.  In which case, you'll probably want to resolve, commit, then create
> a new branch with your current HEAD, then merge it into a branch.  I'll
> visit that as issues arise.  This is bleeding edge experimentation here :)

I know how to deal with it manually, but I'm more concerned about what
would happen in the automatic case, that is, the submodule is dirty
and the supermodule tries to switch branches.

I guess the standard thing to do would be to just have git-checkout in
the supermodule check all the submodules first, and if any of them are
dirty, refuse to do anything at all.

>  Here's a link to the bundle.  It's written in ruby.:
>  http://github.com/timcharper/git-tmbundle/
>
> What does it have to do with submodules?  It's essentially a "GUI" for git.
> It provides automation for a lot of common tasks also.  My team has a need
> for submodules, but unfortunately in their current state I couldn't
> recommend it to them, so I "smoothed over" the rough edges by automating a
> lot of the awkwardness.  So far, it's been working well for us.

Hmm, so the bad news is that it doesn't really help me then :(

It would be awesome if you could turn the fancy behaviour of this
bundle into patches to git-submodule, for example, and then have your
textmate macros call the modified git-submodule.  It might be a bit of
an uphill battle to get the patches accepted into the release, but I
think it's worth the effort, as git-submodule in its current state is
just a non-starter for my group at least.

Have fun,

Avery
