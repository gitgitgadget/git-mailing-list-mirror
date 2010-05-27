From: Marko Kreen <markokr@gmail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 16:58:52 +0300
Message-ID: <AANLkTiko_Azw-cXNFe11oXkijvtER2I9qiRE_gVFouht@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 15:59:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdbw-0000PB-JR
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab0E0N6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 09:58:55 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62784 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab0E0N6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 09:58:54 -0400
Received: by gyg13 with SMTP id 13so4028070gyg.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zm6bX/1PI8hKj/guOuJumaoE1N9ygFFPfignXsq+clA=;
        b=jUjweLhNidLOEDPMZemC78cbxJiFG+Wtczg7+8MATDTzNYPb+XULcsEu641aVicHr/
         CGJ5+KBfxcII0wTHOnrXnaPSKiOTyC2UaXQXe5uvaPD75E729OL6J6inMODpm2oIW8Nv
         kd1j5qRDuNyuZEyGZskSRpbjZgfGJBXoA+r+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=KcBFK/VqNy7EiPxy10JH8hOptsUNYyAzx1OyjW8kxyJzVHiRbaHEoMvPtPFIcaN8M1
         q364qYgNkrr8/8Jf5BuB4czz+isssZI3/VEhcRYWOusp2+88tXvdmR8e1rpXVdGcdi5j
         VLlDtQ7CulThuLLJYXQ40IV+ZRQFIzIBOkI/Q=
Received: by 10.151.21.10 with SMTP id y10mr196830ybi.85.1274968732118; Thu, 
	27 May 2010 06:58:52 -0700 (PDT)
Received: by 10.151.48.11 with HTTP; Thu, 27 May 2010 06:58:52 -0700 (PDT)
In-Reply-To: <AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147857>

On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.com> wrote:
>  > On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
>  >> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>  >>  <kusmabite@googlemail.com> wrote:
>  >>  > On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  >>  >> Implement the subset of poll() semantics needed by git in terms of
>  >>  >> select(), for use by the Interix port.  Inspired by commit 6ed807f
>  >>  >> (Windows: A rudimentary poll() emulation, 2007-12-01).
>  >>  >>
>  >>  >
>  >>  > A possible problem with this approach is that the maximum number of
>  >>  > file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
>  >>  > maximum number of file descriptors select can handle is limited by
>  >>  > FD_SETSIZE.
>  >>  >
>  >>  > I don't think this is a big problem in reality, though - both values
>  >>  > seem to be pretty high in most implementations. And IIRC git-daemon is
>  >>  > the only one who needs more than 2, and it doesn't even check
>  >>  > RLIMIT_NOFILE.
>  >>  >
>  >>
>  >>
>  >> To be clear: I think this strategy is the best option (at least for
>  >>  non-Windows, where select() might be our only option).
>  >>
>  >>  But perhaps you should include a check along the lines of this:
>  >>
>  >>  if (nfds > FD_SETSIZE)
>  >>         return errno = EINVAL, error("poll: nfds must be below %d", FD_SETSIZE);
>  >>
>  >>  Just so we can know when the code fails :)
>  >
>  > Well, per your own FD_SET example, the FD_SETSIZE on windows
>  > means different thing than FD_SETSIZE on old-style bitmap-based
>  > select() implementation.
>  >
>  > On Unix, it's max fd number + 1, on windows it's max count.
>  >
>
>
> Are you sure this applies for all Unix, not just some given Unix-y system?

Not sure.  Just pointing out that the above check is not
universal enough.

-- 
marko
