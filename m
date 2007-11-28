From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 18:42:56 -0500
Message-ID: <9e4733910711281542r5b1e5dd9o68ff8565f9000453@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <20071128092234.GA12977@diana.vm.bytemark.co.uk>
	 <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com>
	 <Pine.LNX.4.64.0711281600320.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 00:43:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxWYp-0001dj-5F
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 00:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757715AbXK1Xm6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 18:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366AbXK1Xm6
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 18:42:58 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:3277 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbXK1Xm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 18:42:57 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1972366wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 15:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=szqkqybW+r4kM2ReR5EXM6jLAM2U+Bv2Ya1rpQ1+kPA=;
        b=cKBdoM3IAE0Two6mtetmKDehmo95PERlnKyWiiXzZq1PN1YpubSRFx75wOk+pNen9nQTukE4E8t6A1bcsFkrMzBLugN8LUDC8Fp5o04vJQ/BZUQMEVGVppDjzwKlVVI9emYG+i8G2BHOXUM4qcX34qLoPfnayOmwgjqzIPhKIlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=xVVD9HfgGUbbVCMBoMcBu1rsHVhBQvPM6GjF6qrkjB0Wbc+bVI6FRKQYa2JSV+c/Ho4yE6l3uVuALD4bSu/ZkdZHhKvFmnEzHbjjFFzlv2BfK5ge0Zu/qX2vH2lNwhtAQpEb0J7A0S+ZobsWq6+bGmaW/oC64vHIeiA/CYe42LA=
Received: by 10.115.54.1 with SMTP id g1mr97511wak.1196293376838;
        Wed, 28 Nov 2007 15:42:56 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 15:42:56 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711281600320.5349@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66465>

On 11/28/07, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Wed, 28 Nov 2007, Jon Smirl wrote:
>
> > all my patches applied
> > git rebase
> > cursing.... I immediately knew what I had done
> > update stg and install it
> > stg repair
> > four of my 15 patches tried to apply, I received messages that there
> > were all empty
> > most stg commands won't work, they complain that the commit references
> > in the stg .git/* state are not correct.
> >
> > I then proceed to manually attempt repair.
>
> This sounds like the content of the applied patches got pulled into the
> non-stgit history of the branch it's working on, sort of like a stg commit
> except that stgit didn't know you'd done it. Then cleaning everything up
> from stgit's perspective caused all of those patches to become empty,
> since they were already applied in the base.
>
> I think fundamental issue you're having is that stgit is implementing the
> functionality of quilt using git's engine, not providing a version control
> system for patch series, which is what you really want. I've actually been
> working on a design for a git builtin for the idea that the patch series
> is your work product, and you want to version control that (additionally,
> you want to use git's engine to help with working on the series and
> represent it).
>
> Out of curiousity, are you using stgit as an integrator (with your work
> being keeping a collection of patches produced separately up-to-date) or
> as a patch developer (with your work being producing a state containing a
> single large new feature while maintaining this change as a series of
> self-contained patches)? I've been thinking primarily about the integrator
> task, in part because I've found it easy enough to do the developer task
> without anything other than current git. (That is, "git rebase -i" seems
> to work fine for making changes to a single logical patch series, all of
> whose patches are prepared locally and aren't independantly named in some
> particular fashion; the things that aren't handled are "I need to replace
> the pull of netdev.git with a new pull of netdev.git" or "I need to
> replace '[PATCH] fix-the-frobnozzle-gadget' with
> '[PATCH v2] fix-the-frobnozzle-gadget'.)

I'm a patch developer. You need to change the patches continuously to
track feedback on the lkml type lists. You also have to rebase in
order to keep tracking head. Other people often work on the same
things and this triggers merges against the pending patches.

Another class of problem is that I can write code a lot faster than I
can get it into the kernel. Currently I have 14 pending PPC patches
that I'm maintaining while I try and get a core change into the i2c
subsystem. All of the other patches depend on the core i2c patch.

Of course the version of the i2c patch that finally gets accepted will
probably cause me to have to rework the whole patch stack again.

stgit is what you need for this work flow. It lets me easily rebase or
edit specific patches. It also lets me easily maintain private debug
patches that I can apply as needed.

I'd just like for stgit to become a core part of git so that is can be
made more bullet proof. I'm losing my patch stack every couple of
weeks. It's normally a "user error" but it is way to easy to make
these user errors.


>
> The developer assist I'd actually like to see is: "I've got a single
> commit on top of a series of commits on top of an upstream commit; I want
> to distribute the changes made in the final commit to points in the series
> where the code that gets replaced (or context that gets inserted into) in
> the final commit gets introduced, with interactive stuff for sticking
> other hunks into particular commits or into new commits at some point in
> the series." That is, I want to do my revision of a patch series on the
> final commit of the series, and then have these changes distributed to the
> appropriate points, rather than doing work on intermediate states (unless
> what I'm fixing is stub code that gets replaced again in a later patch).
>
>         -Daniel
> *This .sig left intentionally blank*
>


-- 
Jon Smirl
jonsmirl@gmail.com
