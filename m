From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Rebasing stgit stacks
Date: Tue, 23 Jan 2007 22:03:26 +0000
Message-ID: <b0943d9e0701231403qefb28f0h91d3f599699b9908@mail.gmail.com>
References: <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com>
	 <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com>
	 <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com>
	 <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net>
	 <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com>
	 <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0701221458r77b2b48hfa41d3dffcb848d0@mail.gmail.com>
	 <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 23:07:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Tnm-0006Qk-CT
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 23:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965549AbXAWWES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965542AbXAWWDh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 17:03:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.230]:13753 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965529AbXAWWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 17:03:27 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1257778nze
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 14:03:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Vb12DnbAK8+Wnp0X/0HbQwWtBHt9N5qQ9x/A0eoX4+HNa6CEOONMpewvI2fEAdSrZ2RMOc3VuMDW6DoKjw5ZPqUQkmOBZS59x+Bg9X6WuDXq+8dePQmm2BMQMtfml89qE0R+jTAKTudErY8wQ0s7RjWqRzvuXP/COeiEgkepdjE=
Received: by 10.65.137.15 with SMTP id p15mr10634196qbn.1169589806951;
        Tue, 23 Jan 2007 14:03:26 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Tue, 23 Jan 2007 14:03:26 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070123074945.GB4083@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37577>

On 23/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Mon, Jan 22, 2007 at 10:58:41PM +0000, Catalin Marinas wrote:
> > On 22/01/07, Yann Dirson <ydirson@altern.org> wrote:
> > The unapplied patches can have any commit as a parent, either in the
> > direct history of the current branch or in any other branch, there is
> > no restriction here. They get in line with the current branch's head
> > during the push operation.
>
> Right.  I'm just emphasizing that, since they are (even temporarily)
> not part of the GIT branch from a GIT point of view, but part of the
> stack, the 2 concepts, while closely linked, are not strict subsets of
> each other.  Rather, they share some common points, but neither would
> be parent of the other in a class hierarchy.

Indeed, but my point is that they are really tightly coupled and not
easy to disconnect in the current design. Maybe we could loose the
coupling post 1.0 but I'm not convinced it wouldn't create confusion
among users. I also don't think there would be many users wanting to
move a stack on top of a different branch when some import or multiple
cherry-picking would be enough.

> > >Indeed I was thinking about that today, and thought that maybe it
> > >would make sense not to use a head ref (and thus not using a real
> > >branch), which would minimize the risk of someone committing by error
> > >(and thus minimize the need to use "assimilate"), since porcelainish
> > >commit tools would then refuse to commit there.
> >
> > But isn't this what Quilt already does (i.e. a different mechanism for
> > patches, on top of any SCM)?
>
> I'm not sure wat you mean here.  I'm only talking of StGIT and the GIT
> world here.

I got the (wrong) impression that you'd like to disconnect StGIT
patches from GIT commits which would mean re-writing Quilt or some
other form of patch management.

> > One of the base ideas of StGIT is that the top patch represents the
> > head of the current branch and that the patches applied on the stack
> > always form the recent history of the current branch.
>
> I'm not willing to change the concept.  I'm just wondering whether
> using a non-head reference (eg. stacks/<name> or stacks/<name>/top)
> would not be better.  For this we may need to consider using detached
> HEAD support from 1.5.0, but I'm just thinking loudly, I have not
> looked at what that thing provides exactly yet.

It might be a good idea (probably post 1.0) since we have a 'commit'
command to update the head of the branch already. I'll have to think a
bit more to make sure it doesn't break existing use-cases. I also
haven't followed the detached HEAD support. StGIT currently relies on
the HEAD giving the information about the current branch.

> > As I said, the idea of moving the stack (patches) on top of a
> > different branch should be done as an import (or multiple
> > cherry-pick or clone), otherwise we loose the coupling between
> > branches and stacks.
>
> I'll have to think more about that - I'm not sure I get you point.  By
> moving/cloning we keep (or could keep) the patches' history.  By
> importing we cannot do that.

The 'pick' command could be (easily) fixed to preserve the history of
a patch (I'll add this to the todo list). The log commit would have
the picked patch's log as a parent rather than none.

StGIT grew up almost (or just 2 months behind) at the same time with
GIT with a lot experimental/prototype features implemented. Now we
probably have a lot more ideas (and users) about how we should use GIT
and StGIT and can re-design parts of StGIT to accommodate the new
use-cases. As I said, I'll first like to get a 1.0 out this spring.

-- 
Catalin
