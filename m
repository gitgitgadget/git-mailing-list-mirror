From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC/PATCH 1/3] teach --histogram to diff
Date: Thu, 14 Jul 2011 00:36:18 +0800
Message-ID: <CALUzUxqv5PTche5-fG5CPVg+hrO1a0R73gF23gcJbWM3wO_wbA@mail.gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
	<1310451027-15148-2-git-send-email-rctay89@gmail.com>
	<7vy6036zon.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:36:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2QC-0005AG-A3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab1GMQgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 12:36:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39540 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193Ab1GMQgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 12:36:19 -0400
Received: by ewy4 with SMTP id 4so2248345ewy.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jZ5HtwGd8uBEu0qehhchYP7XPEmC6tlAn/PBQI2uMbw=;
        b=MjWeZpVyW8vkHUxCnsMdnm0cZkebIhmtVuUACmyx2f+29mxai3EWzm0pLHmJHARBq+
         UwCvB00eOgpUdkuJxX3TreQrx8RNvnphExoLYhFQvAWq+MUW2iFFWx3VbwwG1/gnfcab
         3vbP46tZke8Aw/OKyitGIkf1zzl9OC7J8DAnk=
Received: by 10.14.20.17 with SMTP id o17mr401277eeo.109.1310574978067; Wed,
 13 Jul 2011 09:36:18 -0700 (PDT)
Received: by 10.14.29.14 with HTTP; Wed, 13 Jul 2011 09:36:18 -0700 (PDT)
In-Reply-To: <7vy6036zon.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177058>

On Wed, Jul 13, 2011 at 3:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> This is just half-a-review (bottom half of the file).
> [snip]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D histogram_diff(=
xpp, env,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 line1, lcs=
=2Ebegin1 - line1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 line2, lcs=
=2Ebegin2 - line2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result =3D histogram_diff(=
xpp, env,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcs.end1 +=
 1, LINE_END(1) - lcs.end1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lcs.end2 +=
 1, LINE_END(2) - lcs.end2);
>
> The result from the first half before lcs is discarded?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 result *=3D -1;
>
> Again, what does this function (called recursively) return, and what =
does
> flipping the sign of it do?

Oops, my bad.

>[snip]
>> + =A0 =A0 reduce_common_start_end(xpp, env, &line1, &count1, &line2,=
 &count2);
>
> What this does is logically not specific to histogram algorithm but c=
an be
> applied to other backends, no? And I vaguely recall that Linus did tr=
y
> something like this once, found some issues with it when context is s=
et to
> non zero, and stopped doing it (sorry, I do not have any more details=
).
>
> I am not suggesting you to remove this call or hoist the call to one =
level
> up to xdl_do_diff(), but I do have to wonder how much of the performa=
nce
> improvement you reported is due to this common head/tail reduction.

I believe xdiff already performs this for the Meyers algorithm (in
xprepare.c:xdl_trim_ends()), but the Meyers code doesn't look like it
uses this information at all. If this is the case, then I do think
that a large part of the performance improvement is due to this common
reduction - for git log -p, one would expect a pretty large number of
common head/tail lines in files within a commit.

--=20
Cheers,
Ray Chuan
