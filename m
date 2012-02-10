From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 20:00:27 +0700
Message-ID: <CACsJy8AQdz=uwDm+FOgcUB5JOi5U7w-W4w7yUPL6wd2FO-bArg@mail.gmail.com>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl> <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com>
 <4F34FE9A.7020600@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 14:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvq6G-0002Lz-Mf
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 14:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab2BJNBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 08:01:11 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44679 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab2BJNBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 08:01:10 -0500
Received: by wgbdt10 with SMTP id dt10so2775049wgb.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 05:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=tzLEkXTHzTSG4KGys4sgFpjy+VZ4MFBC6Hvtj2Gy4Bk=;
        b=clloGXtoYb0eopuTMFhCusR6RSVNVu1aLB5gTuPEK4HWRl/wdI9dw+NgIOdpoBm0iQ
         m+k8c2LDOReQVxjQ3L4Lq70/+M8N87h0nBh20av/NQ5Y5Nb91O8jIntg1sQie/Z39pYg
         ra6j390bl08rZCK3Uz/cpxPcZ+ef3yCdsjB+o=
Received: by 10.216.52.198 with SMTP id e48mr771555wec.18.1328878857390; Fri,
 10 Feb 2012 05:00:57 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 10 Feb 2012 05:00:27 -0800 (PST)
In-Reply-To: <4F34FE9A.7020600@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190404>

2012/2/10 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
>> I tried this in the past and "git log -p" looked ugly on git.git
>> mainly because commit messages are still ~70 char long lines on my 2=
79
>> char wide terminal. If this is project dependent, perhaps a config
>> key? Also the "50" below the changed line, maybe you want to change =
it
>> to 0.6 * width.
>
>
> Thanks for all the comments. I'll post a newer version, but I have tw=
o
> questions:
>
> I agree that making the output very wide with lots of +- is not very
> elegant. (E.g. 8f24a6323ece9be1bf1a04b4b5856112438337f2 has
> =C2=A0 builtin/grep.c | =C2=A0142 +++--------------------------------=
=2E...--
> which doesn't look right.). So I think it would make sense to limit
> the graph part to something like 50 columns, even if there's more spa=
ce.
> I believe that git.git would look fine with this change. There are so=
me
> fairly long lines
> (t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=3DTESTC=
ASE_initial..master
> is 86 chars) but with 50 columns of graph the output would take 140 c=
olumns
> -- with the graph part slightly sticking out from the 80 column
> descriptions, but still not too ugly.

You also need to pay attention, not to exceed term_columns() because
of this dynamic name part. But the idea sounds good to me.

It would be even better if we had some heuristics to shorten
exceptionally long names with ellipsis, to keep the name part from
being overly stretched.

> Should I add a new option --stat-graph-width in analogy to
> --stat-name-width, or should this be hard-coded?

I don't know about other people, but I have no urge to change graph wid=
th.
--=20
Duy
