From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Re: [PATCH v4 0/4] git-submodule add: Add --local-branch option
Date: Thu, 29 Nov 2012 13:51:25 -0500
Message-ID: <CABURp0rAJ3mVf2pN-B7NqBDysdCaZGfm2EHSWKr5iynzF6dA-g@mail.gmail.com>
References: <20121127183125.GA4185@book.hvoigt.net> <20121123175402.GH2806@odin.tremily.us>
 <20121127190105.GQ10656@odin.tremily.us> <20121127232858.GA4742@book.hvoigt.net>
 <20121128024205.GG15213@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Nov 29 19:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9DP-0002k2-7d
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 19:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab2K2Svs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 13:51:48 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57452 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003Ab2K2Svr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 13:51:47 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so6613725eek.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5Ao0JNWZuHgEIvxV9kHbV7U2WrnODe7yPSzdFoR1jRM=;
        b=TqnTtsMHq7HmN8qR7wKka6XYUBxSaQN4bPY2m3ibNHtEvMT63foyuJYj8RBtZOqYqV
         3lxeUslg2IG3338oft5/4U5aN3q2ydu1uldUDwoGOCZ74uSXWML49Y5SlsDv0RGSH0l5
         MTOHLGALB90+vymdEwR20JcvwOzSVWoa/y6swnILWq34J/biyPzzaEwhJJynnOgmXlFv
         uzdlHsmEZoE/yE2lEPrC/P9vFNcAtQeFR+sl4LFcKAtyMcwYS8KrgWH46jGzPc1VazP8
         SQMhT7iQU/dNSWib1sH6xw/sd7mFgyekKeu7XvPuG0PaKJh8B/jy9/b2gP6xd8CANvw0
         oICQ==
Received: by 10.14.175.198 with SMTP id z46mr84854847eel.26.1354215105992;
 Thu, 29 Nov 2012 10:51:45 -0800 (PST)
Received: by 10.223.68.210 with HTTP; Thu, 29 Nov 2012 10:51:25 -0800 (PST)
In-Reply-To: <20121128024205.GG15213@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210860>

On Tue, Nov 27, 2012 at 6:28 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> Hi,
>
> On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
> > On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> > The v4 series leaves the remote branch amigious, but it helps you
> > point the local branch at the right hash so that future calls to
> >
> >   $ git submodule foreach 'git pull'
> >
> > can use the branch's .git/modules/<name>/config settings.
>
> But IMO thats the functionality which should be implemented in submod=
ule
> update and not left to the user.
>
> > > I would think more of some convention like:
> > >
> > >     $ git checkout -t origin/$branch
> > >
> > > when first initialising the submodule with e.g.
> > >
> > >     $ git submodule update --init --branch
> > >
> > > Then later calls of
> > >
> > >     $ git submodule update --branch
> > >
> > > would have a branch configured to pull from. I imagine that resul=
ts in
> > > a similar behavior gerrit is doing on the server side?
> >
> > That sounds like it's doing pretty much the same thing.  Can you th=
ink
> > of a test that would distinguish it from my current v4 implementati=
on?
>
> Well the main difference is that gerrit is automatically updating the
> superproject AFAIK. I would like it if we could implement the same
> workflow support in the submodule script. It seems to me that this is
> already proven to be useful workflow.


It is proven in Gerrit, but Gerrit implements a central-server
workflow.  That is, only Gerrit ever floats the submodules, and he
pushes the result for everyone else to share.  I fear the consequences
of everyone pulling submodules and then later trying to merge
superprojects with someone else's breadcrumbs.

Do you have some idea how this would be handled?

Phil

ps. Apologies for my lateness on this topic. I'm trying to catch up now=
=2E

pps. Re-sent since Gmail has hidden the "plain text" option in a
different place, now.

On Tue, Nov 27, 2012 at 9:42 PM, W. Trevor King <wking@tremily.us> wrot=
e:
> On Wed, Nov 28, 2012 at 12:28:58AM +0100, Heiko Voigt wrote:
>> On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
>> > On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
>> > The v4 series leaves the remote branch amigious, but it helps you
>> > point the local branch at the right hash so that future calls to
>> >
>> >   $ git submodule foreach 'git pull'
>> >
>> > can use the branch's .git/modules/<name>/config settings.
>>
>> But IMO thats the functionality which should be implemented in submo=
dule
>> update and not left to the user.
>
> Then you might need submodule.<name>.local-branch,
> submodule.<name>.remote-repository, and submodule.<name>.remote-branc=
h
> to configure
>
>   $ git checkout submodule.<name>.local-branch
>   $ git pull submodule.<name>.remote-repository submodule.<name>.remo=
te-branch
>
> and this would ignore the $sha1 stored in the gitlink (which all of
> the other update commands use).  This ignoring-the-$sha1 bit made me
> think that a built-in pull wasn't a good fit for 'submodule update'.
> Maybe if it went into a new 'submodule pull'?  Then users have a clea=
r
> distinction:
>
> * 'update' to push superproject $sha1 changes into the submodules
> * 'pull' to push upstream-branch changes into the submodules
>
>> > > I would think more of some convention like:
>> > >
>> > >   $ git checkout -t origin/$branch
>> > >
>> > > when first initialising the submodule with e.g.
>> > >
>> > >   $ git submodule update --init --branch
>> > >
>> > > Then later calls of
>> > >
>> > >   $ git submodule update --branch
>> > >
>> > > would have a branch configured to pull from. I imagine that resu=
lts in
>> > > a similar behavior gerrit is doing on the server side?
>> >
>> > That sounds like it's doing pretty much the same thing.  Can you t=
hink
>> > of a test that would distinguish it from my current v4 implementat=
ion?
>>
>> Well the main difference is that gerrit is automatically updating th=
e
>> superproject AFAIK. I would like it if we could implement the same
>> workflow support in the submodule script. It seems to me that this i=
s
>> already proven to be useful workflow.
>
> Ah, sorry, I meant the configuring which remote branch you were
> pulling from happens at submodule initialization (via .git/modules/=85=
)
> for both your workflow and my v4.
>
> You're right that having a builtin pull is different from my v4.
>
>> https://github.com/hvoigt/git/commits/hv/floating_submodules_draft
>
> I looked over this before, but maybe not thoroughly enough ;).
>
>> > > How about reusing the -b|--branch option for add? Since we only =
change
>> > > the behavior when submodule.$name.update is set to branch it see=
ms
>> > > reasonable to me. Opinions?
>> >
>> > That was the approach I used in v1, but people were concerned that=
 we
>> > would be stomping on previously unclaimed config space.  Since noo=
ne
>> > has pointed out other uses besides Gerrit's very similar case, I'm=
 not
>> > sure if that is still an issue.
>>
>> Could you point me to that mail? I cannot seem to find it in my arch=
ive.
>
> Hmm.  It seems like Phil's initial response was (accidentally?) off
> list.  The relevant portion was:
>
> On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
>> Some projects now use the 'branch' config value to record the tracki=
ng
>> branch for the submodule.  Some ascribe different meaning to the
>> configuration if the value is given vs. undefined.  For example, see
>> the Gerrit submodule-subscription mechanism.  This change will cause
>> those workflows to behave differently than they do now.
>>
>> I do like the idea, but I wish it had a different name for the
>> recording.  Maybe --record-branch=3D${BRANCH} as an extra switch so =
the
>> action is explicitly requested.
>
> As I said, I'm happy to go back to --branch if opinions have changed.
>
> On Wed, Nov 28, 2012 at 12:28:58AM +0100, Heiko Voigt wrote:
>> On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
>> > On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
>> > > > Because you need to recurse through submodules for `update --b=
ranch`
>> > > > even if "$subsha1" =3D=3D "$sha1", I had to amend the conditio=
nal
>> > > > controlling that block.  This broke one of the existing tests,=
 which I
>> > > > "fixed" in patch 4.  I think a proper fix would involve rewrit=
ing
>> > > >
>> > > >   (clear_local_git_env; cd "$sm_path" &&
>> > > >    ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null)=
 &&
>> > > >     test -z "$rev") || git-fetch)) ||
>> > > >   die "$(eval_gettext "Unable to fetch in submodule path '\$sm=
_path'")"
>> > > >
>> > > > but I'm not familiar enough with rev-list to want to dig into =
that
>> > > > yet.  If feedback for the earlier three patches is positive, I=
'll work
>> > > > up a clean fix and resubmit.
>> > >
>> > > You probably need to separate your handling here. The comparison=
 of the
>> > > currently checked out sha1 and the recorded sha1 is an optimizat=
ion
>> > > which skips unnecessary fetching in case the submodules commits =
are
>> > > already correct. This code snippet checks whether the to be chec=
ked out
>> > > sha1 is already local and also skips the fetch if it is. We shou=
ld not
>> > > break that.
>> >
>> > Agreed.  However, determining if the target $sha1 is local should =
have
>> > nothing to do with the current checked out $subsha1.
>>
>> See my draft or the diff below for an illustration of the splitup.
>>
>> [snip diff]
>
> This looks fine, but my current --branch implementation (which doesn'=
t
> pull) is only a thin branch-checkout layer on top of the standard
> `update` functionality.  I'm still unsure if built-in pulls are worth
> the configuration trouble.  I'll sleep on it.  Maybe I'll feel better
> about them tomorrow ;).
>
> Cheers,
> Trevor
>
> --
> This email may be signed or encrypted with GnuPG (http://www.gnupg.or=
g).
> For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Pr=
ivacy
