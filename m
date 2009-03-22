From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in 
	alternate or kept packs
Date: Sun, 22 Mar 2009 09:48:15 -0500
Message-ID: <ee63ef30903220748q4e78e626t2ea3930809a670d6@mail.gmail.com>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
	 <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, nico@cam.org
X-From: git-owner@vger.kernel.org Sun Mar 22 15:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlOzy-0000U2-4B
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 15:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbZCVOsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbZCVOsS
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 10:48:18 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:49401 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613AbZCVOsR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 10:48:17 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1765210yxl.1
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 07:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AxlsaVoqB+kSP1aAK83TEA16gp47+uuOBh3ZS+7eDUU=;
        b=w4/WOTwVL8eopbPvyVVVjlC8OJZM1YCU67tz2YQejxQmL2UU+2zBhw4joiKIkMR9O+
         JBRejn4bTGoJIEQwG+YOBTBaK6yhfm09mtHA/1FIj1ZUsyBYEWIvSu4AYzykUI0bJdm9
         B0QxctWUOnKYYrg6rnHqkNPbp3PSpFSGq6LnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mLufHr/29tC/3lzOU3No76QWY1O+U+cBhImEoGNVEpd9UFRukR3RK3lbCwqXXxwxla
         n/EGVJhIKeRBL4zdaHsukZzcP4RTdd4KXTofN/6NYFvTPabFXaxLjqF5QMkspwbgud9/
         +Q19wiPR7t1Z84m31Oc+Y4dqxnjwDugVIKd4k=
Received: by 10.150.201.2 with SMTP id y2mr10840360ybf.124.1237733295219; Sun, 
	22 Mar 2009 07:48:15 -0700 (PDT)
In-Reply-To: <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114144>

On Sat, Mar 21, 2009 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Brandon Casey <drafnel@gmail.com> writes:

> Both patches are whitespace damaged, but I can cope.

I just retrieved one of the patches from gmane and some long lines
were wrapped.  I tried out the gmail imap instructions from
SubmittingPatches for sending these patches.  Those instructions say
that it is possible to send properly formatted patches through gmail,
and seem to instruct to use the web interface for actually sending the
patches.  I wonder if there is some way to instruct gmail to not wrap
long lines? Or whether I did something else wrong?

Previously, I have used gmail's pop interface indirectly through my
phone provider which strips out the "From" field and replaces it with
one that only has my email address and not my name.

> =C2=A0But I am not sure about one thing...
>
>> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
>> index 6222f19..3f477c5 100644
>> --- a/builtin-pack-objects.c
>> +++ b/builtin-pack-objects.c
>> @@ -1944,6 +1944,29 @@ static void
>> add_objects_in_unpacked_packs(struct rev_info *revs)
>> =C2=A0 =C2=A0 =C2=A0 free(in_pack.array);
>> =C2=A0}
>>
>> +static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1=
)
>> +{
>> + =C2=A0 =C2=A0 static struct packed_git *last_found =3D (void *)1;
>> + =C2=A0 =C2=A0 struct packed_git *p;
>> +
>> + =C2=A0 =C2=A0 p =3D (last_found =3D=3D (void *)1) ? packed_git : l=
ast_found;
>
> Why (void *)1, not like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static struct packed_git *last_found;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct packed_git *p =3D last_found ? last=
_found : packed_git;
>
> Am I missing something?

Heh, I am missing something too.  Maybe I should have _thought_ more
about this code that I copied from sha1_file.c: find_pack_entry() and
I would have asked the same question about _that_ code.

Maybe Nico has some idea?

I'll send a new patch, unless Nico has some thoughts.

-brandon
