From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool does does not respect current working directory
Date: Thu, 19 May 2011 20:59:00 -0700
Message-ID: <20110520035856.GA13582@gmail.com>
References: <loom.20110514T160931-46@post.gmane.org>
 <7v1uzznr09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 05:59:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNGrv-0001FS-2q
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 05:59:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934767Ab1ETD7O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 23:59:14 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:51759 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934188Ab1ETD7N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 23:59:13 -0400
Received: by pxi16 with SMTP id 16so2229545pxi.4
        for <git@vger.kernel.org>; Thu, 19 May 2011 20:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Z1Q5DqhzerfRdjq8Nc5W/+q21JJZjWtvW6KiRodjOVg=;
        b=jq8u5oD8bYV+SgOmWvSCH5s/ilEN0mvsZ3KwnZThqWHBuh/ECIb46E2/2+Qe/WqFZV
         0Nf6odDi/5HuHCMFqkEFmUXwxnjDSxIsmznIKKTVvxoYR51OyDOushjs24Jt2V3bc3UD
         4tDjBOdooe+6p2ozHM5jRHqY/B/2CSJLc4kkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ttrOSUhbdrwy15b/eB8UQqaY+W6X59g+gWGBEOOEUgs50sBkXtXbdlljYs4+QQEiGD
         A40+mlWntQwJddILiodWkSH1jIyGz2s6bXy9KU4jE00oQ7uvfjnVLJg8+0uI4C7EM81R
         qLql9JLbOeIkNjFdKWdGywD3GCdkxjuDMdN8s=
Received: by 10.68.35.99 with SMTP id g3mr6300446pbj.53.1305863953186;
        Thu, 19 May 2011 20:59:13 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id a20sm2180218pbu.59.2011.05.19.20.59.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 May 2011 20:59:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1uzznr09.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174036>


Hello,

On Sun, May 15, 2011 at 10:39:18PM -0700, Junio C Hamano wrote:
> Fr=C3=A9d=C3=A9ric Heitzmann  <frederic.heitzmann@gmail.com> writes:
>=20
> > Unfortunately, 'git difftool' does not keep the current working dir=
ectory while
> > launching gvimdiff.
> >
> > =3D> Is it done on purpose ?
> > If not, it is probably a good idea to fix this.
>=20
> I will not comment on "on purpose?" part, as I do not use difftool my=
self.
>=20
> But the right set of questions to ask is not the above, but these:
>=20
>  - Is it on purpose that difftool runs its diff viewer from the top o=
f the
>    working tree?
>=20
>  - Is there any existing user who depends on that current behaviour? =
 IOW,
>    would anybody suffer if difftool suddenly starts to run the diff v=
iewer
>    from the subdirectory that the user started "git difftool" from?
>=20
> If the answers to both of them are No, then it might be a good idea t=
o
> change the behaviour.

Another thing to consider is ensuring that there is a
consistency between 'diff' and 'difftool'.

When you run 'git diff' from a subdirectory git will show you
a diff against the entire tree.  In this respect, 'difftool' is
consistent.  In that sense, yes, this is very much "on purpose".

Is there something that isn't working because of the internal
chdir?  I'm not sure if you want to change the chdir behavior
for aesthetic purposes or if there's something it is
preventing you from doing.  If what you're trying to accomplish
is to have 'difftool' only show you changes within the current
directory then you can accomplish that today by passing ".",
e.g. "git difftool ."


Implementation details:

difftool is a thin wrapper around 'git diff'.  Specifically,
it is implemented as a $GIT_EXTERNAL_DIFF script which means
that it inherits most of its behavior from 'diff'.
The "chdir to root" behavior actually happens inside of
'git diff'.

Can we can change the behavior? Sure, anything is possible.
The question is *should* we change the behavior?
Even though I highly doubt there are any scripts relying on it,
I don't think we gain much by doing so.  The downside to
changing it is that we lose consistency, which is not so good.
I hope that's a compelling enough argument :-)

I hope the "." thing helps.

Cheers,
--=20
					David
