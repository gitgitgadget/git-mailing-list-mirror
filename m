From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH v2 2/3] Introduce git-discard
Date: Fri, 24 Jul 2009 12:02:49 -0600
Message-ID: <51419b2c0907241102s31c2fbaeof81e2fb053465c89@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 20:08:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUPCB-00014O-1e
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 20:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbZGXSIc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 14:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbZGXSIb
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 14:08:31 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:60094 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbZGXSIb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 14:08:31 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2009 14:08:30 EDT
Received: by yxe36 with SMTP id 36so199125yxe.33
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jEZSuSeXNFXy8tgnmG27nZ5fScEN3TDsF0X/N1GoVrI=;
        b=KJ4Vxys/U22MkR//TO+WgtotVOUEohwdt+qh/9293w48G2Wa5mn30wtovwmD6YZ2wZ
         /YmahP5/nFBf6Ea/+PlOx+vxg6tQ16+8JOFcFvA3Eq8tzSmOlJ3tYzi7r1IeuuijM207
         I6MpItPLljM45dpf/oZqHOW6e5HH9Y8pvFpu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m6UCT/DPTCLG+0mkgy/RLXE9LwCT1YI3PbsCjrdx+V81PGhVP4f3MJxggL8IpWrOYy
         fxjNo9SM/55Bw+nN6nyrIFoOzCG/MQ8MRJ+nfXMorHptqmtqWT3vrZIFHBmjNTLXawh8
         Q9q4rYgt5XTmWHppEklyyPkngsXHggmV/Y6Fg=
Received: by 10.100.48.17 with SMTP id v17mr4810660anv.135.1248458570716; Fri, 
	24 Jul 2009 11:02:50 -0700 (PDT)
In-Reply-To: <cf51e6aa92ea98fc9409826cc0468a01fdf7b01e.1248452530.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123935>

On Fri, Jul 24, 2009 at 10:24 AM, Thomas Rast<trast@student.ethz.ch> wr=
ote:
> The new command 'git discard' is precisely the same as 'git checkout =
--'.
> +(This is the same as `git checkout \-- <paths>`.)

Actually, there's an important difference:

> + =C2=A0 =C2=A0 =C2=A0 exec git checkout "$@"

$ git branch foo HEAD~20
$ touch foo && git add foo
$ echo hi >> foo
$ git discard foo
A     foo
Switched to branch "foo"

You really do need that "--".
