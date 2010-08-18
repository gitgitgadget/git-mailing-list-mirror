From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 18 Aug 2010 16:07:12 +0000
Message-ID: <AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>
	<AANLkTi=mH9WPbJMKXRrgvdcuqZfHj1kC49M0jKUhaYeS@mail.gmail.com>
	<AANLkTi=V1-vNjA36BXC5OD+ek-S_1RLVBFt==atxtJk5@mail.gmail.com>
	<4C6C01A9.4080306@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 18:07:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OllAg-0001hR-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 18:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864Ab0HRQHQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 12:07:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53166 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558Ab0HRQHO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 12:07:14 -0400
Received: by fxm13 with SMTP id 13so393881fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IxvKoCsgAdI1Hfpo5mzY5vVRu9LmzaSVJ2MSe9hCJfs=;
        b=Fzom+wVEgjyxe6ImUGZ0iAaTEudInB0Fhj9VncMPzhNOX+xVUNdlUOgRocarOnhw+W
         P7VDeG78d770fuL+AWeFQUnL7kN4128ii0XqAlrq2CqiDlV/OqihFOSkJQVrjcZw/kPB
         mRV0slXMyWjwsKqYkt8mQPAnj0KLT2VVPAxXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=maY13ZaBzKWsTNfCFIROW+iTH/BQ49Em7BqxR2rZy63LWXp3Qg786y5dzYufn5sUFT
         pypYT9nK82JXh3h34B9EY63sDlDpH8HknBKHavWufRwa4B+kPIDnqzjLF7g2gud88njD
         WOmjlSajA+1P4qnDSlhH05maCxkIYd/zkndBg=
Received: by 10.223.124.145 with SMTP id u17mr8032515far.92.1282147633176;
 Wed, 18 Aug 2010 09:07:13 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 18 Aug 2010 09:07:12 -0700 (PDT)
In-Reply-To: <4C6C01A9.4080306@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153865>

On Wed, Aug 18, 2010 at 15:52, Joshua Jensen <jjensen@workspacewhiz.com=
> wrote:
> =C2=A0----- Original Message -----
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> Date: 8/18/2010 6:53 AM
>>
>> On Wed, Aug 18, 2010 at 12:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n<avarab@gmail.com>
>> =C2=A0wrote:
>>>
>>> On Mon, Aug 16, 2010 at 19:38, Johannes Sixt<j6t@kdbg.org> =C2=A0wr=
ote:
>>>>
>>>> + =C2=A0 =C2=A0 =C2=A0 return fnmatch(pattern, string, flags | (ig=
nore_case ?
>>>> FNM_CASEFOLD : 0));
>>>
>>> On Solaris 10:
>>>
>>> dir.c: In function `fnmatch_icase':
>>> dir.c:34: error: `FNM_CASEFOLD' undeclared (first use in this funct=
ion)
>>> dir.c:34: error: (Each undeclared identifier is reported only once
>>> dir.c:34: error: for each function it appears in.)
>>
>> Actually, reading the fnmatch manpage it's not just Solaris, but all
>> non-GNU systems:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0FNM_CASEFOLD - If this flag (a GNU extens=
ion) is set, the pattern
>> is matched case-insensitively
>
> Well, that's no good. =C2=A0:(
>
> Thanks for the research. =C2=A0It helps tremendously.
>
> One easy way out of this situation would be to duplicate the GNU fnma=
tch()
> into fnmatch_icase(). =C2=A0I have not looked at the source code, so =
it may not
> be possible. =C2=A0If it can be copied in, does anyone object?
>
> I'll also look for a non-GNU function that may work.

According to some further research at least FreeBSD and NetBSD have
copied this GNU extension. You may find their versions easier to
integrate.
