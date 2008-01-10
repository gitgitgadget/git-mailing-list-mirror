From: Gregory Jefferis <jefferis@gmail.com>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 19:58:41 +0000
Message-ID: <C3AC2971.10D2D%jefferis@gmail.com>
References: <7vmyrgry20.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Jan 10 20:59:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD3Yb-0007p2-69
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 20:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755272AbYAJT6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2008 14:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbYAJT6s
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 14:58:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:32246 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYAJT6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 14:58:47 -0500
Received: by fg-out-1718.google.com with SMTP id e21so812618fga.17
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        bh=Rs/P9BlhKBs7jF6jFm80VN9AhSsAfBddvYV2LE5Gfns=;
        b=X1fKAW96QAWglrlebvh5rbvl2r0gbKjrh5AGOWrWwcFY26KJhdsZdGnWLuO8ePP4sYWdQDPJYzNNjR7HlytEYRUEWclYCYghC3pPPzqP69jV3hyKA0qVrPG5LkCwYcpw8iekuPZfhrq27ICYtD1lrte+P476gz2cqQx10I2iVEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:cc:message-id:thread-topic:thread-index:in-reply-to:mime-version:content-type:content-transfer-encoding;
        b=ZzO0hUei2Wn1/9VGFQYT6PzvCMDoeEIh0NbjX8bFIDl7MJsq6fsGMDoPwNbqbbLiZVNx0Hq5CvlWolX5SQnUtvKEc7pkJLDdvWiJgSsimf/IHBZWOf0Ph4Ctkh2fbomUI/VlDEQpJe54NhY7c1+FH8Dky34DnCl+Ty5a+cDwRks=
Received: by 10.86.59.2 with SMTP id h2mr605304fga.19.1199995125625;
        Thu, 10 Jan 2008 11:58:45 -0800 (PST)
Received: from ?131.111.101.105? ( [131.111.101.105])
        by mx.google.com with ESMTPS id 12sm2389165fgg.6.2008.01.10.11.58.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Jan 2008 11:58:44 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: CRLF problems with Git on Win32
Thread-Index: AchTwzJwcMjW8L+2EdyK5wAUURoPUg==
In-Reply-To: <7vmyrgry20.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70080>

On 8/1/08 18:07, "Junio C Hamano" <gitster@pobox.com> wrote:

> Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:
>=20
>> msysgit installs plain git.  core.autocrlf is unset.  Whatever plain
>> git's default is, this is msysgit's default, too.
>=20
> That sounds like a mistake if you are installing a port to a
> platform whose native line ending convention is different from
> where plain git natively runs on (i.e. UNIX).

I'm not sure that I understand the whole deal about platform default li=
ne
endings.  Isn't plain git functionally agnostic about line endings?  Yo=
u can
check in CRLF text files to git and it doesn't care.  You can diff, sho=
w etc
just fine.  I haven't yet found anything that breaks with CRLF files.  =
In
this sense plain git is already Windows ready.  Maybe I'm missing somet=
hing?

Doesn't the problem only come if you try to diff a CRLF file with a new
version that has LF only line endings?  Then right now you have to use
something like:

    git diff --ignore-space-at-eol

Or if a Windows user clones a repository created on another system.  Fo=
r
these cross-platform circumstances, it seems to me sensible to have an
option (probably enabled by default on all platforms) that allows files=
 to
be munged on check in to whatever EOL style the repository creator pref=
erred
(probably stored in .gitattributes and could be different for different
files in the repo - e.g. a windows vendor src dir on a cross-platform
project).  Note that this means that munging would only happen if someo=
ne
actually asked for it - which would be a sensible thing to do as the
administrator of a cross-platform project.

Then there would be a separate option (probably not enabled by default)=
 to
check out with the platform's native line ending instead of whatever is=
 in
the repo. This would allow people to work with inflexible toolsets.

=46inally for people who want to work with native line endings that are
different from repository line endings, then it might be necessary to
improve the handling of diffs by providing a config var to make
--ignore-space-at-eol the default (or perhaps more correctly
--ignore-line-endings) for text files.  From my preliminary reading of =
list
history improving the inspection of content rather than trying to chang=
e
content might be the more gitish thing to do.

In conclusion all of these CRLF options are designed to help Windows us=
ers
play nicely with others.  But it seems to me na=C3=AFve Windows users c=
an be
perfectly happy with plain git so long as they stay in their own Window=
s
world.

jm2c, corrections welcome and apologies to those suffering from eol
exhaustion,

Greg.
