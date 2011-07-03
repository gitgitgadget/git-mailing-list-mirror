From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How do I get the name of the parent branch?
Date: Sun, 3 Jul 2011 13:43:12 -0400
Message-ID: <CAG+J_DwH8WLitQdqmgp6dLU6-Aq6Gb4nUs2y1z_UGST4Boofcw@mail.gmail.com>
References: <4E109D8F.3030402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 03 19:45:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdQj8-0006V4-EE
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 19:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab1GCRnO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jul 2011 13:43:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37813 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab1GCRnN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2011 13:43:13 -0400
Received: by ywe9 with SMTP id 9so1770711ywe.19
        for <git@vger.kernel.org>; Sun, 03 Jul 2011 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nQ8+75xnUFX14rJDz2UwP1F4womT/0qdV0oxwIDnJ1g=;
        b=goUqj7V4vhWXy2MDLg/mN1/cCkH3TAy7O8Tern9v3Q0UD2LfoKllgyFea5R6azmHn2
         UrsOCg+kREOc97rvRjaCq321UvGClHalIfuJ2Xts24dyqowPRy1GPzEOBhBV9IUNfdNo
         2mAEQdcmD4Hm4lxTjhLhmrStOLcmVHsYJ2dQ0=
Received: by 10.236.78.232 with SMTP id g68mr6556357yhe.416.1309714992846;
 Sun, 03 Jul 2011 10:43:12 -0700 (PDT)
Received: by 10.147.169.9 with HTTP; Sun, 3 Jul 2011 10:43:12 -0700 (PDT)
In-Reply-To: <4E109D8F.3030402@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176576>

On Sun, Jul 3, 2011 at 12:49 PM, Bruce Korb <bruce.korb@gmail.com> wrot=
e:
> Google results point to how to get to commits that have gone into
> parent branches, but fundamentally I just want to have a script
> that constructs a diff of what has changed since the latest branch
> without having to do manual research to figure out the name.
>
> As best as I can tell, you use:
>
> =C2=A0 git format-patch -o pdir --ignore-if-in-upstream $branch
>
> the hard part seems to be (but ought not be) figuring out
> the value for "$branch".

Depending upon how you created the currently checked out branch, git
recorded the parent (which is usually referred to as the "upstream"
branch these days) in .git/config, and you can get this information
thusly:

  $ git rev-parse --abbrev-ref @{upstream}

(But you should not be afraid to look at .git/config and see where
this information is recorded. Look for a section named [branch
"$branch].)

Of course, you can use @{upstream} directly:

  $ git log @{u}..  # @{u} is a synonym for @{upstream}
  $ git diff @{u}

j.
