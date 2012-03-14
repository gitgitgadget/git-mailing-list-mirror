From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] index-pack: support multithreaded delta resolving
Date: Wed, 14 Mar 2012 17:29:32 +0700
Message-ID: <CACsJy8Ae=oy5UsN1zHDptOO4_kVv4NuHgHGp2aPokmO_wgOhwA@mail.gmail.com>
References: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
 <1331519549-28090-3-git-send-email-pclouds@gmail.com> <4F5E95A2.8050106@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Mar 14 11:30:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7lT9-000552-4R
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 11:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760699Ab2CNKaG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 06:30:06 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64747 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760672Ab2CNKaE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 06:30:04 -0400
Received: by wibhq7 with SMTP id hq7so2330387wib.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Oqx2BfIMbVpFuCwlxPQjFBrLluV5X53BowJ+Cl1g4wI=;
        b=0uaDotX7fwhjoZdaLrLUPQc8OzqLDONxNXv7hPSFrSGHlRW9KMVig3h6WtDwC9HccL
         dDtuxCsT9b6IF1dWOXQaxxxgA+I3g284SC9TZs+IQjslN5q1U2kMpJCHUy7AYjkkoTIL
         GnDsP72C8GVIMAf5ur9dXa4j5WSCbei3NAXtDvMDOM/7gsC+vCjI2bwwD6IIAiITCNgK
         KSDaEv2Pycwt1xmhqb7ny9PlHrHKQ6dnRbiz0J9fC+BVPdkx9/3zW94aavj/niOrCmlW
         7PDUkksrCweDgyT7xM9ZwRsQvQHHaMpBDoQr2DBnEE7hJDlBvvIpkmZp8jeNaYdhgUHK
         fekA==
Received: by 10.180.106.9 with SMTP id gq9mr4956260wib.17.1331721003265; Wed,
 14 Mar 2012 03:30:03 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Wed, 14 Mar 2012 03:29:32 -0700 (PDT)
In-Reply-To: <4F5E95A2.8050106@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193093>

2012/3/13 Ramsay Jones <ramsay@ramsay1.demon.co.uk>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> [snipped]
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I changed Ramsay's mutex patch a little bit and incorporate it=
 here.
>> =C2=A0Ramsay, it'd be great if you could try it again on MinGW
>
> Hmm, well do you want the good news, or the bad news ... :-D
>
> First, I should say that I feel like I'm doing a very bad job of
> communicating, so let me apologize for that and hope that this time
> I make a better job of it!
>
> This patch breaks the build on MinGW, since the emulation code has no=
t
> (thus far) included an implementation of pthread_key_delete(). I simp=
ly
> commented out the call to that function, in cleanup_thread(), so that=
 I
> could test the remainder of the patch.
>
> Although this patch is an improvement on previous patches, it still f=
ails
> in *exactly* the same way as earlier attempts.
>
> I probably didn't make clear before that 'nr_threads' has been given =
too
> many duties, which is the main reason for me introducing a new variab=
le
> 'threads_active'. For example, ...

You are right. I will incorporate your changes in the next reroll. Than=
k you.

> [I ran the same four tests as before, five times in a row. On *one* o=
ccasion
> t5300.22 (verify-pack catches a corrupted type/size of the 1st packed=
 object data)
> failed because the 'dd' command crashed! So, maybe there is a problem=
 lurking.]

I fail to see how verify-pack can make dd crash, especially when
verify-pack is called after dd in t5300.22. Anyway it's good to keep
an eye on this case.
--=20
Duy
