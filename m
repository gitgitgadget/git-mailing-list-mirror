From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: rebase-with-history -- a technique for rebasing without trashing 
	your repo history
Date: Fri, 14 Aug 2009 08:47:02 +0530
Message-ID: <2e24e5b90908132017i1c6be9abt9b08219acc1cb600@mail.gmail.com>
References: <4A840B0F.9060003@alum.mit.edu>
	 <20090813161256.GA8292@atjola.homenet> <4A849634.1020609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 14 05:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbnIL-0001U6-L4
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 05:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbZHNDRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2009 23:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755633AbZHNDRD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 23:17:03 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:55046 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbZHNDRC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2009 23:17:02 -0400
Received: by yxe5 with SMTP id 5so1580316yxe.33
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 20:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sS5T0/D+fUiKzlxG6BDsARfK4vpQcPBRD56O3KQR8fQ=;
        b=ujbLbll/OUBjBz0eo3fSmuhYz+vrO02PqphEPVl38oV9DY/8pxmSiXdjN75ypSHW4H
         iLqWxz4uCoyYCWSg/b6l0ZW52FwklyXwhisCGhbNdPxfARA30x6GTVtcgOiN4vOiVaSc
         97ILKQ4r5VvioxhWgvMRl52s+0NumjEtcbR20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xqczyKfAx0BK4WkntBc3SbAbjovcOUsLA2McF0wwf5UZPjv58Oa9fciY97L9QLPz/6
         gjYZLfCIx6kVN/jLx+XuVsJ67dmVxU2ve4Kyuf2SAvu09p0I4Q/YBBICuAvZ+4OunYNx
         uIdG+f23CrscI31U/ZPLZ3N+VL2U3z+9iC5gw=
Received: by 10.231.14.204 with SMTP id h12mr201046iba.41.1250219822741; Thu, 
	13 Aug 2009 20:17:02 -0700 (PDT)
In-Reply-To: <4A849634.1020609@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125893>

Hi,

I'm one of those wannabe experts who thinks he knows enough about git
to teach people in his workplace but obviously pales in this group,
but with that caveat, let me say:

2009/8/14 Michael Haggerty <mhagger@alum.mit.edu>:

> Now that you mention it, there are some other uses of rebase whose
> history could be recorded correctly, or at least better, in the DAG. =
=A0I
> am not ready to advocate any of these changes, but I think they are

I see you've made your own caveat :-)

> worth discussing.

[snip]

> A---B1---B2----C
> =A0\ =A0 =A0 =A0 =A0 \ =A0 =A0\
> =A0---------B12---C'

> A---B12---C
> =A0\ =A0 =A0 \ =A0 \
> =A0B1---B2---C'

[snip]

> A---C
> =A0\ =A0 \
> =A0B---C'

[etc etc... many such snipped]

To me, the ability to *forget* the mistakes I made (for whatever
definition of "mistake" you wish) as long as it's private to my repo,
is one of the main attractions of git.  I'm one of those guys who
saves early, and saves often, when editing files.  This translates to
commit early, commit often, in the git world.

I see no earthly reason why I would ever *want* those commits
preserved, so I hope that, if this sort of thing ever gets into the
code, it is definitely *not* the default :-)  It is not sufficient for
me that the GUI knows how to suppress their display, it is necessary
that they *disappear completely*.

And that reminds me.  You often hear people on #git ask how to get rid
of some files (maybe containing passwords etc) that inadvertently got
into the repo, and the answer, a lot of the time, is filter-branch,
because the "bad" commit is pretty old.  I suspect that for every
person who asks that question on the list because he already pushed,
there are 4 who discovered such an error much earlier, (when the file
went into only a couple of commits at the top maybe), did a rebase -i
with "edit" or whatever, and got rid of the evidence, err I mean
password :-)  If this sort of thing were to be the default, they'd
have to use a filter-branch even for such simple cases.

=46inally, speaking as someone who teaches git, this adds enormous
complexity to the basic concepts.  Complexity is good when the
benefits are obvious, but to me they are not obvious [see *my* caveat
at the top before you react to this statement]
