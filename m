From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 2 May 2010 13:18:54 -0500
Message-ID: <20100502181854.GC16051@progeny.tock>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun May 02 20:19:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8dlB-0003D5-PD
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 20:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829Ab0EBSS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 May 2010 14:18:58 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:59237 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab0EBSS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 14:18:57 -0400
Received: by iwn40 with SMTP id 40so2306549iwn.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 11:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RTA6mV4UBCp//AH2LrdNjOWjjdgTwWd+PiZG1Ms4dg0=;
        b=VuBFdIMkGiCXMl9mSHTZw5G8iaN0lsnI7aJGwa0QimwI8tywul/IyeBQ2vxghhiNrn
         BCCY62xgJrTXhzCiBPUarjp2Bwgg3/cGfq72ucqBnF6v68H5SFDvg7oS8/BESrMnIler
         hSCZDnkpZkBg0+n6GVS2imnqUHmRJQAQ/G5Wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=yF5XFilrKcPrv5IrN32vf96DU3cd6/DAa+u0VNUaLJlofjE/g0OBTFFCCoHkcbsaLL
         tRnYu2TQXtkmW5+I1YdfCxLk7sSgD3KijdUZab03tKev33eLN+NY52GndNCHH4ZOuruA
         3pPeUcYw7oO6QaGW2EXc38ZLhLjM8zkaiqkXc=
Received: by 10.231.160.209 with SMTP id o17mr1836992ibx.20.1272824335609;
        Sun, 02 May 2010 11:18:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3603504iwn.14.2010.05.02.11.18.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 11:18:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19419.1721.763210.679444@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146193>

Eli Barzilay wrote:

> Using `--no-merges' helps in
> avoiding the confusing parts, but that's dangerous in omitting
> non-trivial merges too -- and those are probably even more worth
> noting than other changes (just because they'll highlights changes
> that are "hotter" in the sense of more people working on that code).
>=20
> The only way I've seen to distinguish the two is to use `git show' an=
d
> see if there is no diff output (eg, "git show --pretty=3Dformat: $rev=
").
> But that doesn't help in getting the list of modified files.

Maybe --name-only or --name-status can help.

Note that most conflicts will not show up here: if the merge result
matches either parent, then git diff --cc and friends will not
consider it interesting at all.  A command to list conflicts and their
resolutions would be expensive but valuable, I think.  A na=C3=AFve
implementation would involve redoing the merge.

[...]
> Is there *any* way to get `git diff --stat' to do the same thing that
> `git show' does?  (Or a way to get `git show --stat' not show all
> files again...)

A =E2=80=9Cmerge diffstat=E2=80=9D sounds like an interesting idea, but=
 the detailed
semantics are not obvious to me (maybe separate counts for nontrivial
added and removed lines from each parent?).

Thanks for the food for thought,
Jonathan
