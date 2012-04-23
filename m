From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH 0/2] git-svn: fixes for intermittent SIGPIPE
Date: Mon, 23 Apr 2012 19:10:43 +0400
Message-ID: <CANiYKX7=og814EYvXkQ4jeOWkr7e9GZAXu1SKUYSDza6BCGtGw@mail.gmail.com>
References: <cover.1333381684.git.rkagan@mail.ru>
	<CANiYKX5RNb3YXhGWXzpfDz+XK1PM6zyN=zrDKk3_4StCu2ukzg@mail.gmail.com>
	<xmqqvckqld7q.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:10:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMKug-0002uf-0O
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 17:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690Ab2DWPKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 11:10:45 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55127 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2DWPKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 11:10:44 -0400
Received: by obbta14 with SMTP id ta14so12786881obb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JxViO0btTtuIfm+xJYoydnPyTlOSwcJo7XBUxvPU+jE=;
        b=ghwshypxG/HTbInpJoXk8ibYog1Vi7pShPnQowT7HKTmDVLMGgVfgD06QK/vh9CKll
         y5Fbif5cGRdrPpEKBvrRvzpJ0lkaf/rghxuromCRj/Xwj5/l5e69875kaobMlNzIl1bB
         fuWpkQ72ojByV5HtTf5hK9nWoym/CHyyJyq33qdHhYGrYPw6MvOOaeJtCvR7n42WCGHJ
         C5O4llIVndA25erFgRANcPEDsY89a/REg7U92nX2NcLpZENf7Dgsbsx8b5woMmmEXyl7
         Y/tNzlUgTRj8noMui45+0n2Njo/Q2mTxgxZcMJhpsDoYNUS2i0DPWDEd3uU9F4cDl7Rt
         0dTg==
Received: by 10.182.12.6 with SMTP id u6mr23841050obb.12.1335193843892; Mon,
 23 Apr 2012 08:10:43 -0700 (PDT)
Received: by 10.182.46.129 with HTTP; Mon, 23 Apr 2012 08:10:43 -0700 (PDT)
In-Reply-To: <xmqqvckqld7q.fsf@junio.mtv.corp.google.com>
X-Google-Sender-Auth: GWi2dgEEF9r7Tmm8d9hlvGXKEs4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196128>

23 =C1=D0=D2=C5=CC=D1 2012=9A=C7. 18:44 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=
=D8 Junio C Hamano <gitster@pobox.com> =CE=C1=D0=C9=D3=C1=CC:
> Roman Kagan <rkagan@mail.ru> writes:
>
>> IIUC the series was approved by Eric. =9AWhat do I need to do now to
>> have it reviewed for accepting into the master tree?
>
> I see this:
>
> =9A =9A =9A =9ADate: Tue, 10 Apr 2012 21:11:20 +0000
> =9A =9A =9A =9AFrom: Eric Wong <normalperson@yhbt.net>
> =9A =9A =9A =9AMessage-ID: <20120410211120.GA27555@dcvr.yhbt.net>
>
> =9A =9A =9A =9ARoman Kagan <rkagan@mail.ru> wrote:
> =9A =9A =9A =9A> + =9A =9A =9A =9A =9A =9A my $signew =3D POSIX::SigS=
et->new(SIGINT, SIGHUP, SIGTERM,
> =9A =9A =9A =9A> + =9A =9A =9A =9A =9A =9A =9A =9A =9A =9A SIGALRM, S=
IGPIPE, SIGUSR1, SIGUSR2);
>
> =9A =9A =9A =9AConsidering your 2/2 patch, can we remove SIGPIPE here=
?
> =9A =9A =9A =9AOtherwise, I think this series is good. =9AThanks!
>
> What usually happens after such an intial round of review is for you =
to
> think about the comments like this one given during the review, and
> either submit a patch updated accordingly, or discuss why your origin=
al
> is better than the suggested update, and then the reviewer responds t=
o
> it, and repeat the process until everybody involved in the discussion
> accepts the outcome.

I replied on the very same day that I thought that Eric's comment
would better be addressed in a followup patch, and that patch would be
purely cosmetic anyway.
So I felt like I could wait until these two are merged or commented by
more people.  My bad; will resubmit the series with the third patch
included to hopefully get Eric's full approval.

Thanks,
Roman.
