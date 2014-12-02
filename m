From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/19] Add git-list-files
Date: Tue, 2 Dec 2014 18:45:52 +0700
Message-ID: <CACsJy8DBkGVhaJnCTs9_E+g6FYYr4V-6S=XB5wrGBFPjHnEu1A@mail.gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com> <20141202054226.GA1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 12:46:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvluV-0000Gq-TD
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 12:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478AbaLBLqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 06:46:24 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:37242 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402AbaLBLqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 06:46:23 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so11019895ieb.26
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 03:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eNy4OenAR75V21VNMFeCPPEkHc3CtVPVTB2z4rAbLss=;
        b=egfg3YSCMhctH5hzk09eBcIPmwm5lO5gCTovZUgVZq1AgpF6SQBmNpWFiM0Ohr2v/H
         tqLCsSOpjJ5ybmLgf7i88P2zyxIxK3yD5VCex+b1kD4VwwuO8IVuAyOBDp9W74QZmk2e
         +qwKY++z418qh1fJGRluU5q4XY94Ebt+5WkLsL+qn2FLagDg1Jd8z/HpGkfTYgKIAQy/
         brT/ZEnc85UKyx57xkDzTqWWpMj5lvTbrBeFX6Xi5Yh0hWUVu+KcEvmUrMX1j5jX+TRo
         2PYpaDnURc+rRRVYk0O0mvwzQpCDjgUS5t2sWHsPUcpJLVSDj6B2c1f0OhxnCaRFLEoJ
         Qd3w==
X-Received: by 10.42.167.1 with SMTP id q1mr2176617icy.48.1417520782806; Tue,
 02 Dec 2014 03:46:22 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 03:45:52 -0800 (PST)
In-Reply-To: <20141202054226.GA1948@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260554>

On Tue, Dec 2, 2014 at 12:42 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Nov 30, 2014 at 03:55:48PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> This is something else that's been sitting in my tree for a while no=
w.
>> It adds "git list-files", intended to be aliased as "ls" with your
>> favourite display options.
>
> When I read the subject, I thought "why isn't this called git-ls?". T=
hen
> when I read this paragraph, I thought "if the point is for everybody =
to
> make their own ls alias, why do we need list-files at all, instead of
> just adding options to ls-files"?
>
> I'll let you decide which (if any) you'd like to answer. :)
>
> My guesses:
>
>   1. If it were "git-ls", it would stomp on existing aliases people h=
ave
>      constructed.

Yes, Matthew Moy (I think) at least had this git-ls alias and he did
complain. Also we could not agree on what should be the good defaults
for git-ls if it's built in.

>   2. If it is a wrapper around ls-files, then the options may be
>      constrained; ls-files already squats on useful options like "-d"
>      (which, if we are matching traditional ls, is more like our "-t"=
).

Also right. I want to keep option names close to GNU ls.

> As a side note, I wonder if it would be sensible to whitelist some
> commands as porcelain, and allow aliases to override them (either
> entirely, or just to add-in some options).

Agreed. Maybe not all porcelain (some like git-branch almost functions
like plumbing).

We also need away to stop alias (e.g. in scripts). In scripts I can
specify full path to a command to make sure I won't hit an alias. I
guess we can't do the same here. The closet to "full path" is git-cmd
form, as opposed to "git cmd" form) but I think we don't want to bring
back git-cmd. Maybe just a "git --no-alias cmd" and GIT_NO_ALIAS..

And if  people now can override standard commands, I think it makes
sense to ship a default alias set (with lower priority than
user-defined aliases). After all people need to check twice if the
command they type really means what they think it is..
--=20
Duy
