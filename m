From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: how to list commits on branch since last merge
Date: Tue, 8 Mar 2011 12:39:10 -0500
Message-ID: <AANLkTimE52XWMtpuyaU7MbnyYVszKqNbTPSV=QxLyij3@mail.gmail.com>
References: <AANLkTi=zW9hOhnddw6HsjQwV2qLf_R_qeNna+XeN6U6x@mail.gmail.com>
 <4D75ED72.8030203@drmicha.warpmail.net> <AANLkTinOEutM92k4SUGEXbfTpzGcQitpW4CZbcQbg0R4@mail.gmail.com>
 <AANLkTikK8Uc8=wKROYWWxZ_6OtQtqBmFCZN760M1LO+c@mail.gmail.com>
 <4D75FB7B.70403@drmicha.warpmail.net> <AANLkTim_h6vbvnmy7oUNYmV82vCzLLfWKq=3_UY9kPYw@mail.gmail.com>
 <20110308171251.GA1823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 08 18:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px0st-0003Hj-RD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 18:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab1CHRjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Mar 2011 12:39:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45367 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471Ab1CHRjl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2011 12:39:41 -0500
Received: by iyb26 with SMTP id 26so5039354iyb.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=A3XENUlUglDpPFjB+ZEy6DybXwQr32e1ZggLION1Uck=;
        b=QxfzZBRgR6QFdJtoE/0Ced/z6M8VQfTqb5gKsQ5IxMIdPgmo9ihPloBgH5V4H2FjZ/
         VR42C6WsDE7jkTOjccrPjLoZE0lwXQIUxbkUOcuPKg4iBxH16T3GPUsz66HUe/xQi1EV
         4LLWQidHM6zApLtbKSRiTXBOD/hpGzErxX/mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aSGRibD4vYGVMwg6QqE4pEpL4gcHYLzHsUoovD8rGz5fvCXXN+/tupt2ARHQY9vbDc
         +UBVB/DDCQ1ai0UHtwh57VmOPM4NQyxPWiRHiusRlc6vQcWR+3E6mJBH78XhD5km91wZ
         jwKgHoECibiXi+eZMhBpCEzpMn9EOVcfbWxog=
Received: by 10.43.43.198 with SMTP id ud6mr6967220icb.127.1299605980549; Tue,
 08 Mar 2011 09:39:40 -0800 (PST)
Received: by 10.231.34.7 with HTTP; Tue, 8 Mar 2011 09:39:10 -0800 (PST)
In-Reply-To: <20110308171251.GA1823@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168668>

On Tue, Mar 8, 2011 at 12:12 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 08, 2011 at 05:11:16AM -0500, Jay Soffian wrote:
>
>> Going back to my original picture, I mean commit m:
>>
>> =C2=A0 o---o---x---o---... =C2=A0 =C2=A0foo
>> =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 \
>> =C2=A0 =C2=A0 o---o---m---o---... =C2=A0bar
>>
>> merge-base foo bar gives me x; to get m I then need to grep the outp=
ut
>> of rev-list --parents for x.
>
> Isn't the merge the first commit in bar that is not in foo? IOW:

No, because bar is never merged to foo. Let me relabel the picture:

 =C2=A0 o---o---x---o---... =C2=A0 =C2=A0foo
 =C2=A0 =C2=A0\ =C2=A0 =C2=A0 =C2=A0 \
 =C2=A0 =C2=A0 a---b---c---d---... =C2=A0bar

> =C2=A0git rev-list foo..bar | tail -n 1

That would return 'a'. merge-base foo bar returns x. I want 'c'. So
again, I can do either:

  $ git rev-list foo bar --merges --parents | grep " $(git merge-base f=
oo bar)"

Or:

  $ git rev-list --ancestry-path foo...bar ^foo | tail -n 1

I guess this is not at all a common thing, since it seems to be
confounding the list. :-)

My use case is that I maintain a downstream project, so bar never
merges back to foo, but sometimes I ask the question "what have we
done on bar since we last merged in foo". I think --ancestry-path
really is the answer:

  $ git log --reverse --ancestry-path foo...bar ^foo

Is actually quite nice.

j.
