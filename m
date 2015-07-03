From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: Re: [PATCH v2 3/4] log --count: added test
Date: Fri, 3 Jul 2015 01:30:44 -0700
Message-ID: <CAKDoJU7MT5PkoPKaF=NYne0sgNfGC6q+y7+57L0135dgxKThgw@mail.gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
	<1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
	<vpqwpyh4rup.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 03 10:31:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAwNA-0007dd-VR
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 10:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbbGCIaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 04:30:55 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34698 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115AbbGCIao (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 04:30:44 -0400
Received: by oigx81 with SMTP id x81so73610840oig.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=d0xAJuEBkwHgnuBHiHDb4rRCFTdfXFT1jZOv7Hsws1A=;
        b=X7/fG2nP3WzY9TlYDdJxnLuKtsAp2C+2J1v1yKDjYK5N49pT6w7DGD3fDx79yG1l4a
         iJiW0g8G1e3fLnbj012ZH2jQTX+txBUNEhZgQdNE7W73ZlQk9Ro6QjrfbcGgzOUlKpSt
         ZFAB7bjzvtxIlth1p4nhVUzwFH4Jw3obw8XrwGMl0Xnd84p+xsuiLVsNrtZO2VTbPK/w
         nrszvrZAA3MQlX2SRXt8velbykOSfhTDbeYjFjjgJ+jIOQsX1yJK6/LKxMZXL1uEhyq0
         TCTdjERREUgRUbvFesHZCcjqwwX7RQi386192CZtNf6se8uWec66frUZIj5e8Wqyioyq
         zQBw==
X-Received: by 10.202.210.148 with SMTP id j142mr32528350oig.68.1435912244065;
 Fri, 03 Jul 2015 01:30:44 -0700 (PDT)
Received: by 10.76.153.101 with HTTP; Fri, 3 Jul 2015 01:30:44 -0700 (PDT)
In-Reply-To: <vpqwpyh4rup.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273286>

Matthieu,

Ok, I'll fix that.  I think I can also add tests, I can look at the
tests for rev-list --count, with the understanding that I saw somebody
else had made changes for the  --use-bitmap-index option, and I am
basing off of master for this, and thus don't feel comfortable with
--use-bitmap-index at this time.

If it's acceptable practice, I'll just squash everything I do on this
feature and it's tests into one commit with a more detailed comment,
and send the patch for that.  I wasn't sure about how much history I
should save, and how much I should split stuff up, so I appreciate
your clarification.

Thank you for your time,
Lawrence Siebert

On Fri, Jul 3, 2015 at 12:34 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Lawrence Siebert <lawrencesiebert@gmail.com> writes:
>
>> added test comparing output between git log --count HEAD and
>> git rev-list --count HEAD
>
> Unless there is a very long list of tests, I'd rather see this squashed
> with PATCH 2/4. As a reviewer I prefer having code and tests in the same
> place.
>
>> Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
>> ---
>>  t/t4202-log.sh | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
>> index 1b2e981..35f8d82 100755
>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -871,4 +871,11 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>>       test_must_fail git log --graph --no-walk
>>  '
>>
>> +test_expect_success 'log --count' '
>> +     git log --count HEAD > actual &&
>> +     git     rev-list --count HEAD > expect &&
>
> The weird space is still there.
>
> Also, we write ">actual", not "> actual" in the Git coding style.
>
> That is actually a rather weak test. rev-list --count interacts with
> --left-right, so I guess you want to test --count --left-right.
>
> Also, some revision-limiting options can reduce the count like
>
> git log --grep whatever
>
> and you should check that you actually count the right number here.
>
> (I don't know this part of the code enough, but I'm not sure you
> actually deal with this properly)
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 
About Me: http://about.me/lawrencesiebert
Constantly Coding: http://constantcoding.blogspot.com
