From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Mon, 4 May 2009 11:58:20 -0400
Message-ID: <32541b130905040858v2a0b7a6br5b056a365fcb6855@mail.gmail.com>
References: <20090428223728.GE15420@raven.wolf.lan>
	 <20090429160129.GF15420@raven.wolf.lan>
	 <32541b130904291113p6f99a82ft824cd3c482447117@mail.gmail.com>
	 <20090429223747.GG15420@raven.wolf.lan>
	 <32541b130904291907q4003ad86v4728c5b2ba0aacb7@mail.gmail.com>
	 <20090430222808.GH15420@raven.wolf.lan>
	 <32541b130904301559w329bdd4bo6f2736a505b7235f@mail.gmail.com>
	 <20090501142811.GI15420@raven.wolf.lan>
	 <32541b130905011217x7f339d41x696fedee7298e3a4@mail.gmail.com>
	 <20090502215852.GJ15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 17:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M10Yq-0006Ph-7Z
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 17:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271AbZEDP6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2009 11:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756104AbZEDP6X
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 11:58:23 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:41011 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbZEDP6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2009 11:58:22 -0400
Received: by gxk10 with SMTP id 10so7944377gxk.13
        for <git@vger.kernel.org>; Mon, 04 May 2009 08:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=31XuvwW+Swmx23epOQajt0bs5UosQGH0KHtENQcnztI=;
        b=KCuazGAG1f57SK4I3aPwwLEQuCb2dNQLpfn+TRh3pOFmFtPP2piCd1f3v1deH9cwjk
         zl7tnNU9kReD9OR3JhAEbC91KRb4Dz2K5vkffnYQJJXjBDZ7GawNuv30fKvoX1yloHrC
         sqRRtM3KAkgj2aliRO+a6zS1u4DW2e12JmPug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=G88bP2hOurPGP5e8pWk2PRj3rx0bAcB/Q0D8VCCXavVTbnq5Oe6FLAC7AsQZrjxVS6
         M6LOqBNnIl4+KeEJXMS0/y59Ta6wYYBfrqKfQqoXnwjLwsAxokK2x1umqax/q6YbhkMe
         nYLtI0vwd02KCVSmHhq7+l0vQ7ElbeZREs0f4=
Received: by 10.151.139.3 with SMTP id r3mr12356068ybn.117.1241452700777; Mon, 
	04 May 2009 08:58:20 -0700 (PDT)
In-Reply-To: <20090502215852.GJ15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118250>

On Sat, May 2, 2009 at 5:58 PM, Josef Wolf <jw@raven.inka.de> wrote:
> Somehow, I still can't get it work. =A0This is what I do:
[...]
> =A0# move stuff from svn-2 to svn-1
> =A0#
> =A0git svn fetch svn-2
> =A0git checkout svn-1
> =A0git cherry-pick 05b964
> =A0[ =A0continue cherry-picking ]
> =A0git merge --no-ff -s ours svn-1

Note that you probably should be merging '-s ours svn-2' here, not
svn-1.  svn-1 already contains svn-1 (of course) so that merge didn't
do anything.  It most especially doesn't mark svn-1 as being
up-to-date with svn-2, and that's probably going to make trouble
later.

> =A0# check what I have done
> =A0#
> =A0git diff svn-1-orig svn-1/trunk # shows what I expect

This is unsurprising, since you haven't changed either branch during th=
e above.

> =A0# move the result to svn-1
> =A0#
> =A0git checkout svn-1/trunk
> =A0git merge --no-ff svn-1
> =A0git svn dcommit

This looks ok.

> =A0# move stuff from svn-1 to svn-2
> =A0#
> =A0git svn fetch svn-1
> =A0git checkout svn-2
> =A0git cherry-pick -n c9dae
> =A0[ continue cherry-picking ]
> =A0git merge --no-ff -s ours svn-2

Again, you seem to have merged in the wrong branch here.  This one
should be svn-1.

> =A0# check what I have done
> =A0#
> =A0git diff svn-2-orig svn-2/trunk # shows what I expect

Again, these branches haven't changed, so no surprise here either.

> =A0# move the result to svn-2
> =A0#
> =A0git checkout svn-2/trunk
> =A0git merge --no-ff svn-2
> =A0git svn dcommit

This seems ok.

> At this point, we should be synchronized.

Yes, although there are no merges between svn-1 and svn-2, so the next
attempt at merging will merge *everything*, causing conflicts.

> =A0git checkout svn-2/trunk
> =A0git svn fetch svn-1
> =A0git merge --no-ff svn-1
>
> BOOM. =A0Although no new commits were fetched, we get a lot of confli=
cts
> here. =A0So git is not fully aware about the fact that we are synchro=
nized.

You seem to almost have it.  Fix the -s ours merges above and I think
you'll be in business.

Have fun,

Avery
