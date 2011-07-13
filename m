From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [RFC/PATCH 0/3] teach --histogram to diff
Date: Thu, 14 Jul 2011 00:35:37 +0800
Message-ID: <CALUzUxo1tBDjmN_Xu9OnQn3OFqzuDovU48d+nmkokm6mVOVWwg@mail.gmail.com>
References: <1310451027-15148-1-git-send-email-rctay89@gmail.com>
	<CAJo=hJu5ubkzUyyPM0nqP+J9CU3hBtAHfuzaLSuN214Hux4qTA@mail.gmail.com>
	<7vfwmb8ken.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2PW-0004oW-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab1GMQfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 12:35:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39199 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756473Ab1GMQfi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 12:35:38 -0400
Received: by eyx24 with SMTP id 24so2156317eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Mmu201eRprZzF9++exdaSb5C7KRBVkKIyxfMUVwGUww=;
        b=HvF/N4txCvb5Jyqvsya+GMfe4Q+fEYETcnR8zgJVST7CW0QBN+/ClhAnBxKrOapKd7
         fUQ3BfNydJJK5Y7+4wmLMzPjbRMx/0VZQaMLIuSavl/7igRshVD+GVX7A/ESajzUgw4P
         Ow2F6Cx+2J4MXurDniIRydVnOEgM8bhvxbrNk=
Received: by 10.14.0.82 with SMTP id 58mr391898eea.237.1310574937179; Wed, 13
 Jul 2011 09:35:37 -0700 (PDT)
Received: by 10.14.29.14 with HTTP; Wed, 13 Jul 2011 09:35:37 -0700 (PDT)
In-Reply-To: <7vfwmb8ken.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177057>

On Wed, Jul 13, 2011 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Have you looked at a patch that differs in output between Myers and
>> patience, and then compared those to the histogram version?
>
> $ git log -p v1.6.6..v1.7.6 | git patch-id >/var/tmp/md
> $ git log --histogram -p v1.6.6..v1.7.6 | git patch-id >/var/tmp/hd
> $ diff -u0 /var/tmp/md /var/tmp/hd |
> =A0sed -ne '/^+/s/^+[0-9a-f][0-9a-f][0-9a-f]* //p' |
> =A0while read commit
> =A0do
> =A0 =A0 =A0 =A0git show "$commit" >/var/tmp/1
> =A0 =A0 =A0 =A0git show --histogram "$commit" >/var/tmp/2
> =A0 =A0 =A0 =A0interdiff /var/tmp/1 /var/tmp/2
> =A0done

Thanks for taking the time to run this.

> shows there is one that gives vastly different appearance, but it all
> boils down to which lines to take as common, and for this particular
> example neither is more readable over the other (9560808f2ef5a34d2a).
>
> Running the above "show" with larger -U$n value shows there don't see=
m to
> be any discrepancies between the two.

I suspect it's due to that change being mostly a lot of additions on
the right side, without much deletions on the left.

--=20
Cheers,
Ray Chuan
