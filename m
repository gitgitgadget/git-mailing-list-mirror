From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 2/2] Write to a stack log when stack is modified
Date: Fri, 22 Feb 2008 15:58:25 +0000
Message-ID: <b0943d9e0802220758j76248cf3rb4dbb86f03b57b16@mail.gmail.com>
References: <20080214012119.22365.54526.stgit@yoghurt>
	 <20080214012912.22365.83207.stgit@yoghurt>
	 <b0943d9e0802201446g2840c3d9v576f840936253525@mail.gmail.com>
	 <20080221071819.GA8250@diana.vm.bytemark.co.uk>
	 <b0943d9e0802220605t56257718p850c677a59671862@mail.gmail.com>
	 <20080222145609.GA19172@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:59:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSaJN-0005tg-EB
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 16:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbYBVP6c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754280AbYBVP6b
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 10:58:31 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:7328 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310AbYBVP62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 10:58:28 -0500
Received: by rv-out-0910.google.com with SMTP id k20so289705rvb.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E8bivrSiTrcSomRMpmk9x+3JAdxFXyhe70sQviTg564=;
        b=vP9U5E1i6pb/8C5ySmVBJZoPVJVCXZaCPRZ/Y3e48qK6jTHot47StZ4VPL9SdezXYwxXJAUuwZQuG3mtgvalgCNCovHYx+SMqgORlmyxf5obsBNIZ14NQaLZnWWckoqg7w6Sh6iqLAzkSwPVnvtLks+O53oH2/CM5X9XV/talTg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXN85/LT+YwChY78LVE7AL/VCbLL1zZm+8/wGLCVKuT9wB/0Sz1V26nlQNVKBhm2ra/XzsAvOve6L+H2aA89W/ZcH+pNETeOrg2ADB/dy1FMMaPotXuhUFATtxstYRuu2i6uWdmGtM7CjoEBwMtW03JPe9yZc1yigo4E5P0Lm7U=
Received: by 10.141.167.5 with SMTP id u5mr66795rvo.220.1203695905880;
        Fri, 22 Feb 2008 07:58:25 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Fri, 22 Feb 2008 07:58:25 -0800 (PST)
In-Reply-To: <20080222145609.GA19172@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74731>

On 22/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-02-22 14:05:55 +0000, Catalin Marinas wrote:
>
>  > On 21/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>  >
>  > > On 2008-02-20 22:46:48 +0000, Catalin Marinas wrote:
>  > >
>  > >  > The abstractions are really nice (and I still wonder how StGI=
T
>  > >  > codebase increased that much when all I needed two years ago
>  > >  > was a simple script-like application to reorder commits :-)).
>  > >
>  > > :-) I'll take some of the blame, but StGit was quite large alrea=
dy
>  > >  when I started submitting patches to it.
>  >
>  > Anyway, the new restructuring is much cleaner, though heavily OO a=
nd
>  > some people might not like it (me not included).
>
>
> That it's conceptually OO is unavoidable, I think (the only way to
>  avoid that would be through obfuscation). And using Python's OO
>  features to write code for such a model is the least bad you can do =
in
>  Python. IMHO.

I agree.

>  > > When you say "it's still slow", are you referring to the existin=
g
>  > > per-patch log, my per-branch log, or just StGit in general?
>  >
>  > I think it's more GIT in general. Checking the tree status takes
>  > some time and a 3-way merge on a 512MB RAM machine with GIT using
>  > over 200MB gets a bit slow.
>
>
> I just upgraded my laptop from 512 MB to 2 GB, so I'll start
>  neglecting this kind of problem, I fear. :-/

You can boot with mem=3D512MB (or even less) :-).

>  > >  Have you noticed any difference between commands using the old
>  > >  and new infrastructure (say, stg push vs. stg goto)? The latter
>  > >  should be taking less time, due to touching the worktree only
>  > >  when necessary.
>  >
>  > In the patch pushing functions, it now first calls simple_merge()
>  > which is still a 3-way merge but without rename detection. The old
>  > StGIT implementation was using "git-diff | git-apply" and falling
>  > back to the recursive merge. Most of the patches apply cleanly and
>  > we don't need the three-way merge which uses more RAM.
>
>
> I didn't include patch application because it wasn't necessary to get
>  things working, and is easy to add at any later point.
>
>  I'd be curious to see how much of a difference it makes.

It makes a difference if you don't have much RAM available. I think
once a patch falls back to three-way merge, Linux already makes room
available for the subsequent merges. But, as I said, most of the time
the patches just apply cleanly.

>  > We could use this "modified" feature to automatically export patch=
es
>  > (some people asked for this in the past, as means for backup in ca=
se
>  > of StGIT failures).
>
>
> You mean automatically export only the changed patches?

Yes, at refresh and pushing, but for the latter, only if a patch was mo=
dified.

>  One cool thing we could do is export the patches as files in a git
>  branch -- the log machinery I'm building should make it trivial. Tha=
t
>  way, you'd get the history of the patches too.

Yes, I don't think it is difficult to do (it just need to be optional
as some people might not need it).

--=20
Catalin
