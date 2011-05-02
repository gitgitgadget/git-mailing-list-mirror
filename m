From: Ciaran <ciaranj@gmail.com>
Subject: Re: [RFC PATCH] Pass empty file to p4merge where no base is suitable.
Date: Mon, 2 May 2011 01:01:26 +0100
Message-ID: <BANLkTi=wpxzyn01=g5g1JmjY1UPVQ6faHQ@mail.gmail.com>
References: <BANLkTimXBayYAScPfk2j9spxcYrmtMJKxg@mail.gmail.com>
	<7vwriq3p0t.fsf@alter.siamese.dyndns.org>
	<BANLkTimf1q8JM46J-X1BCwQ+GaeWAgv75Q@mail.gmail.com>
	<7v7haarsrd.fsf@alter.siamese.dyndns.org>
	<BANLkTikv0YmB-u74sOrQUQZGQvYJNmBx_w@mail.gmail.com>
	<BANLkTimD_S3ik7-0j0gMCiEo3aoRwCy92Q@mail.gmail.com>
	<7vk4eaq8m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 02:01:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGgZz-0003PL-G8
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 02:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab1EBAB3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2011 20:01:29 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60263 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555Ab1EBAB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 20:01:27 -0400
Received: by pzk9 with SMTP id 9so2836548pzk.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LLFqoI1KoUrz8Oo2cqDnwJOEl1lEfqQYKgIOHRfQOc8=;
        b=xilHE4kIl4Y9/BYb01g/mZ4S2A+6ky/DQwI/vz4IF21QaHkJRNeVc04I8/RKvFAfMK
         53BiSNMSvY2Lu/sYIIEW9KovxwHtBDSz0JOIITjYKW1JH1bYuk5Q+2fQAalVjUglnULo
         IsGZWiOBtmrQICCGxkoDAW1itdh2Wvyj6xloc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UiikoPznGjXD1HilXq7xJlD5UqlQuMlmqOwTcWnalATDYOMjEphI1Xk0wC0nzlxhN7
         D1/ItlV4kb92oMC6caTBwW4OB9h77YQrVb/LvrhMbFu+KCrAUZk7w5UipLa+oQOg09bf
         iIivNvqyl+5CXKGN+6fLEUMUYRM8TKLYeCEck=
Received: by 10.68.0.7 with SMTP id 7mr8238944pba.188.1304294486520; Sun, 01
 May 2011 17:01:26 -0700 (PDT)
Received: by 10.68.62.6 with HTTP; Sun, 1 May 2011 17:01:26 -0700 (PDT)
In-Reply-To: <7vk4eaq8m3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172555>

On Mon, May 2, 2011 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ciaran <ciaranj@gmail.com> writes:
>
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> index fb3f52b..4db9212 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -258,12 +258,9 @@ run_merge_tool () {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> =A0 =A0 =A0 p4merge)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if merge_mode; then
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch "$BACKUP"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if $base_present; then
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_to=
ol_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_to=
ol_path" "$LOCAL" "$LOCAL" "$REMOTE" "$MERGED"
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 touch "$BACKUP"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $base_present || >"$BASE"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "$merge_tool_path" "$BASE"=
 "$LOCAL" "$REMOTE" "$MERGED"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 check_unchanged
>
> Will queue this version as-is; thanks.

Thank you.

>
>
> Somebody might want to revisit if that "touch" is still really necess=
ary,
> though. =A0It is outside the scope of this change, as that has been t=
here
> before this patch.
The only reason my patch touches it was to 'fix' the whitespace (i.e.
it was mixed tabs + space chars, where all the other instances of that
line aren't)

I did debate backing that change out though :)
- cj.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
