From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: 'cherry' does not cope well with merges
 from upstream
Date: Fri, 2 Jul 2010 03:18:12 -0500
Message-ID: <20100702081812.GA9219@burratino>
References: <1278012954-sup-3724@pimlott.net>
 <20100701210919.GA4283@burratino>
 <4C2D995D.2020708@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Pimlott <andrew@pimlott.net>, git <git@vger.kernel.org>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>,
	Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 02 10:18:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUbSW-00083K-QG
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 10:18:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab0GBISq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 04:18:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36035 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab0GBISn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 04:18:43 -0400
Received: by iwn7 with SMTP id 7so2988000iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 01:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rjBJEBH1xt137A3ZdbzcG9Am3hlKaAa7q4r44M/akOM=;
        b=dgFZRJlycLy8/H+zxTPWZR0/h+gsnqucZxkRgJZTW/rvCiPO2ECGAOrIt6/AC3368E
         XWzWGfCF5nxtiFkwg1DDdEiOfrTQiBVTZNnpKDFCDWNhSWAdjNHdPVP/aHiDy3cujdhw
         MG40L2K0LLNf3fHVju+lh+pAvpQCJHLJ/BQkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WmxqqlV3PjFcfZ4PsgNmQMIXXnrgTf4gKGm9MrhgMhS0UE2LfQYsW/w37d6cXXQpLY
         MTTEB9zjdrWoUHL4mTgosHX3ZKjDR1EI2IGd+LorpZnq6e4wG9HdPgantcO8SkRTL8xZ
         rF2/2YjMp53/sWxFfck7Kv0dyJIXYvxhswxWM=
Received: by 10.231.45.66 with SMTP id d2mr429678ibf.170.1278058722626;
        Fri, 02 Jul 2010 01:18:42 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1921515ibh.22.2010.07.02.01.18.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 01:18:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C2D995D.2020708@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150114>

Michael J Gruber wrote:
> Jonathan Nieder venit, vidit, dixit 01.07.2010 23:09:

>> Add a BUGS section to explain the problem.
>
> This is not a bug. git cherry works exactly as described.
>=20
> At worst, it is a misfeature.

Unix man pages have a history of using BUGS sections to describe
misfeatures and even unavoidable design constraints.

One nice effect is to encourage people to think of programs as
fixable.  But maybe it is bad PR. ;-)

> git cherry would be more useful if you could specify a "limit" which =
is
> an ancestor of "fork-point", not only descendants.
>
>> Thoughts?  Improvements?
>
> Allow general "limit" :)

Hmm, I am not totally sure I understand.  Conceptually =E2=80=98git che=
rry=E2=80=99
currently does something like the following:

 1. List all commits limit..head and find their patch ids
    (limit defaults to upstream if not specified)

 2. List all commits head..upstream and find their patch ids

 3. For each commit listed in step 1, check if it is in the
    list from step 2 and print its commit id with a + or -
    accordingly.

Are you suggesting that the limit should replace head in
step 2?  Or something else?

> git-cherry(1) never speaks about upstream..head nor head..upstream. I=
t
> uses "fork-point", and a merge creates a new "fork-point", i.e.
> merge-base.

This explanation becomes problematic when there is more than one merge-=
base:
http://thread.gmane.org/gmane.comp.version-control.git/150067/focus=3D1=
50093

Thank you for the comments.  I considered using the <limit> argument
to work around this but didn=E2=80=99t try the modification you suggest=
 above.
I would be happy to find that it works (generalized for repos with
a more shallow history to --full).

Sleepily,
Jonathan
