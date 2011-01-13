From: Joe Corneli <holtzermann17@gmail.com>
Subject: Re: working with a large repository and git svn
Date: Thu, 13 Jan 2011 00:54:27 +0000
Message-ID: <AANLkTi=uuBuunYmwmLYD_vUnPkDBk9YDLtATw9GtX33z@mail.gmail.com>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
	<201101120830.47016.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jan 13 01:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdBST-0008O1-M1
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 01:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab1AMAy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 19:54:29 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52937 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab1AMAy2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jan 2011 19:54:28 -0500
Received: by iwn9 with SMTP id 9so1093307iwn.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 16:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type:content-transfer-encoding;
        bh=3HifjKS5U9zDT1HJTVqLBglQ44pnAyaGDRh1ARl5/ww=;
        b=AVw7PmqvMlR/1i+T/mAOaUW2zaLuwPkQcTViTPdi1fzcVr5Jxhwp2gx8K9noDb5Sm3
         WIpryhJaCBkJ3SmZBs3yrB+Z3RdbezHfLNQ6PCy4UCRhHqUI70gA2759ToMIGcO2T/kv
         1R8efn67chcey+C2Gx4CJGLAx5JRvYl+NWqVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=KSs/fYb6DlAwAaMqL5kP6XcG+EBqOZPUfWVhQpYYi34JmX54wspb11Gr5n06N8b0lw
         Z2Jv8F4zPrLQMmrNYCCiNVYYzyEPQGVx6pdjMUIzRwmbCCBZfIEokTmL8MJ5Wb3yul4a
         Ue1fdvBkbXBlM1YKgeowzaPZ7MNLV+s8RfJfo=
Received: by 10.231.36.68 with SMTP id s4mr1813842ibd.178.1294880067447; Wed,
 12 Jan 2011 16:54:27 -0800 (PST)
Received: by 10.231.85.146 with HTTP; Wed, 12 Jan 2011 16:54:27 -0800 (PST)
In-Reply-To: <201101120830.47016.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165031>

> =A01) Sounds like git-svn is running out of resources on your machine=
 --
> that's probably a bug, but work around it: Don't dcommit all 20000 re=
visions
> at once. Maybe write a shell script that goes through and dcommits a =
100
> commits at a time.

Hm, I found a related blog post here, but designed for interactive use:
http://fredericiana.com/2009/12/31/partial-svn-dcommit-with-git/
Could you give me a more detailed hint about how to do what you suggest=
ed?

> =A02) Do you need the full history to be in SVN? Can you rebase/squas=
h large
> parts together and thus need to commit less revisions in the first pl=
ace?

Maybe.  We want a tool for managing the entire history, and Git seems
like a good tool for that.  At the same time, checking out the entire
history can take a long time - if we could just check out just the
latest files and check them back in in a sensible way, that would be
good - SVN does seem suitable for that purpose.  If there's a git-only
way to do this I'd be happy to know about that as well!

> =A03) I love git-svn for working with Subversion repositories, but yo=
u could
> consider a different tool, like tailor, if you can't make git-svn do =
what
> you want.

Tried it, but it didn't even get through the initiation phase.  I
asked for help in the relevant mailing list.

> people working on a fast-import tool for SVN, so you could git-fast-e=
xport
> and svn-fast-import in a big batch.

Not finding these.

> =A04) Does 8 GB of data really belong in the same repository? Maybe i=
t should
> really be split up and used with git submodules or SVN externals? Tha=
t may
> make things easier to work with in the long term.

Probably true.  if there was a nice way to give each *file* its own
associated "repository", then stitch these together into packets (even
"on demand"), that would be cool.  I was assuming we could do fancy
stuff like this as "future work" however - and it would seem that if
we use a completely git-based solution we'll be there.

> =A05) Do you really want to be going from Git, to Subversion? That se=
ems like
> a big step backwards. =3D)

If there's a good way to just pull down the latest revision into a
working copy and be able to push that back to the repo that would be
nice.  This doesn't seem to be the Git way, but for an 8 gig repo it's
probably pretty important feature.  Thoughts?

Thanks,
Joe
