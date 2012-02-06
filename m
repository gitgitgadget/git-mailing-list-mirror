From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Mon, 6 Feb 2012 12:31:29 -0500
Message-ID: <CABURp0rt=LcjMfDU61m0de-gLpX1a3x3vhb0zVxCbceSvD9jFw@mail.gmail.com>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
 <20111129220854.GB2812@sandbox-rc.fritz.box> <loom.20111210T062013-538@post.gmane.org>
 <7vborhaqgw.fsf@alter.siamese.dyndns.org> <CALFF=ZQKRgx_AodBQH17T9cSe_JFtoKie7DoMMfkTXCyCFospw@mail.gmail.com>
 <7vaa6x4m5l.fsf@alter.siamese.dyndns.org> <CABURp0pPqpkWXdC+97wR8HZeX=Nbi0bn-3ji+k9LQnj0kFjCnQ@mail.gmail.com>
 <4EE7BEF5.6050205@web.de> <CABURp0pDoS1wgJ+Fs3XFX=A_EuR4Gzi4mHLiQP+-icT_d3J+WQ@mail.gmail.com>
 <4F28554D.9090107@web.de> <CABURp0pSGGT8eyzNad-dNNx49oioAxOPOf3dmqu7M3fnV+PzdA@mail.gmail.com>
 <4F29BEB7.1080901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Leif Gruenwoldt <leifer@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuSQ0-0002dQ-5X
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 18:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab2BFRbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 12:31:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51761 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402Ab2BFRbu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 12:31:50 -0500
Received: by lagu2 with SMTP id u2so3258494lag.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 09:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CxCPkyTmf39rHAoYK5cKI8Pe4mhfx4LIZxhPURKcJCc=;
        b=wygJgsvfyOm7xNBqogFHiBaty6xjNalCQBPIS3KIJpQhp+aV5XkqgZQKBv8P2nw50C
         x3u8/nNo5oIMNRb+BAimwxcS9Upof490O5OL3i3nM4jg62xgr4RdkmtFice5pGUHlmjw
         +FXCozCmurDRSImj+39RXXYXiq7cvk8hw3iQs=
Received: by 10.112.30.73 with SMTP id q9mr5312446lbh.30.1328549509232; Mon,
 06 Feb 2012 09:31:49 -0800 (PST)
Received: by 10.112.4.101 with HTTP; Mon, 6 Feb 2012 09:31:29 -0800 (PST)
In-Reply-To: <4F29BEB7.1080901@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190082>

On Wed, Feb 1, 2012 at 5:37 PM, Jens Lehmann <Jens.Lehmann@web.de> wrot=
e:
> Am 31.01.2012 23:50, schrieb Phil Hord:
>> What I mean is that a developer may be completely focused on one
>> particular submodule (his domain). =A0He does his work in this modul=
e,
>> and when it's ready he commits and pushes to the server. =A0'git sta=
tus'
>> shows him that his directory is clean. =A0But this is only because h=
e
>> doesn't really know where the submodules top-directories are, so he
>> doesn't realize that he has changes in another submodule that he has
>> not committed. =A0He has to know to run 'git status' from somewhere =
in
>> the superproject (ostensibly in the root directory of that
>> superproject). =A0But he may forget since 'git status' already assur=
ed
>> him he was done.
> <snip>
>> I guess what would help here is something like the opposite of 'git
>> status' showing the status of descendant submodules; =A0it would hel=
p if
>> it showed the status of sibling submodules and the superproject as
>> well.
>
> Hmm, I really think the fact that submodules are unaware that they
> are part of a superproject is a feature. I'd prefer seeing that kind
> of problem being tackled by the CI server and/or user education. Or
> maybe a pre-commit hook which issues a warning in that case?

I agree that submodule isolation is a feature essential to the
architecture of git and the submodules implementation.  But it is also
a limitation, not just of this example.  A pre-commit hook is a nice
idea, but it doesn't help 'git status' (which is the standard go-to
answer point for "where am I").

This has me thinking more about recursing siblings now, though. I find
myself typing something like this quite a lot:
    git submodule foreach 'git grep "someFunction" || :'

Or worse (in that the UI is more unwieldy):
    git submodule foreach 'git log --oneline "-SsomeFunction" || :'

But what I want is this:
    git --git-dir=3D${TOP}/../.git grep --recurse-submodules "someFunct=
ion"

But not really, because I am lazy and that is too much typing.
    git grep --include-siblings "someFunction"

Maybe I can add a "sib" macro to get this:
    git sib grep "someFunction"

But now I've really wandered off-topic.
Phil
