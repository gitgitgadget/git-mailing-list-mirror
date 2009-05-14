From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 14 May 2009 17:57:00 -0400
Message-ID: <32541b130905141457u196e1a68w8250489b88eb83c4@mail.gmail.com>
References: <20090504211423.GK15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> 
	<20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> 
	<20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> 
	<32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> 
	<20090513222243.GQ15420@raven.wolf.lan> <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com> 
	<20090514214120.GR15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 23:57:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ivh-0002eg-GQ
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 23:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbZENV5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 17:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZENV5U
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 17:57:20 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:11578 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbZENV5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 17:57:19 -0400
Received: by yw-out-2324.google.com with SMTP id 5so886272ywb.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=VGcVl67PX/OMBX/K+LLCZOEyCENPDmG5sbsrWSRdE3o=;
        b=bYOaiNZW+fAs+qtHW7gNRFXPy+T61mXzEg5D/Ma9t8EE6GprvyYOmof46/vxX8i8J7
         GipGkwVBvWOCNBrzwASi6zkQMzW8Kyz5llej0GeEEIOgCd2OhjobwkpWgsYzWWI4eyoA
         YnR/dqX2Mnji7FYJwto6u32pwR1Bx1ex9vMxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=MBKbrebEeTm9pE6bO+RKPmHzyXYHeFpbXpnVP1pC5BIqQjx/JrNQYfilk5WaSj3ZQv
         +8Eo/B0cve+RBIrrptxegLOkKOON/AVCRZmYWIVkkdEHrO1btP1oTwGwlpZmEUV0rGP2
         s6BvPy8XJH8cGxk+QsXGCYgDWVc5WlR1oZgCc=
Received: by 10.151.156.16 with SMTP id i16mr4411953ybo.290.1242338240389; 
	Thu, 14 May 2009 14:57:20 -0700 (PDT)
In-Reply-To: <20090514214120.GR15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119228>

On Thu, May 14, 2009 at 5:41 PM, Josef Wolf <jw@raven.inka.de> wrote:
> On Thu, May 14, 2009 at 02:35:18AM -0400, Avery Pennarun wrote:
>> No criss-cross merges, no insanity, no question about whether it's c=
orrect.
>
> Indeed, this looks pretty simple. =A0But AFAICS, this works only when
> starting out with a virgin repository. =A0In my situation, public is
> currently empty and have to be constructed from scratch by picking
> from the privates.

Not exactly; you simply produce a "public" repository however you want
to produce it.  One easy way would be to copy one of the existing svn
branches, cherry pick and revert whatever commits you want, and call
it public.  The prior history of that branch doesn't matter to the
algorithm.

> So here's my second plan:
> 1. instead of doing the cherry-picking in a single repository, it mig=
ht
> =A0 be helpful to do it in separate repositories: one repository for =
each
> =A0 direction. =A0While there are still two remote svn repositories i=
n each
> =A0 svn repository, there is no need for criss-cross anymore. =A0The =
flow
> =A0 of the data is in one direction and it seems (at least at first g=
lance)
> =A0 I can use git-svn-rebase to get a linear history.

it's still criss-crossing, it's just less obvious that way.  One
repository is exactly the same as two repositories in git; all that
matters is the branch histories.  So if you think this will fix it,
you're probably missing something :)

> 2. After the synchronization is done, I would merge the two repositor=
ies
> =A0 into a third one to create the public repository. =A0Since this w=
ill be
> =A0 a pure git environment, I hope that the problems that are caused =
svn's
> =A0 lack of merge support will vanish.

I'd say that basically none of your problems have anything to do with
svn's lack of merge support, and everything to do with the fact that
you aren't doing all your changes first on a 'public' branch and then
merging from there into the private branches.  (That's really not so
hard to do in svn either, and would save a ton of confusion.)

> At first glance, this seems to work. =A0But there's the drawback that=
 I
> have to keep track of what have been merged manually. =A0So there's
> certainly room for improvement :)

Right, the crossmerge() function in the script I sent is designed to av=
oid that.

> I will have to play a little bit with this script to get a better
> understanding how it works. =A0But from the description, I got the
> impression that it matches my (current) work flow pretty good:
> Currently, initial changes are done in some private repository and
> propagated to the other repositories from there. =A0The only exceptio=
n
> is that currently, there's no such thing as a "public" repository.

The public repository is nothing special and doesn't require any work
from you; it's simply maintained automatically from the private
branches.  (Of course, if you start doing all your changes in the
public repository, life gets a little simpler.)

Have fun,

Avery
