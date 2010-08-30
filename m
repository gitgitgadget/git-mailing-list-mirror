From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: factor HOME=$(pwd) in test-lib.sh
Date: Mon, 30 Aug 2010 11:08:20 +0000
Message-ID: <AANLkTin=RG-48wPc2sUr+6-Tezgr4MhKfOqn3a3se52m@mail.gmail.com>
References: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
	<1283161842-22689-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTi=81oEPHko45Mo2d1qn+qWy-TVLvrFcXaVKd8Lu@mail.gmail.com>
	<vpqtymcs74z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 13:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq2Gc-00079F-Qp
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 13:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab0H3LK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 07:10:27 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54131 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0H3LK0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 07:10:26 -0400
Received: by iwn5 with SMTP id 5so4836135iwn.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sM9K9qfiyAioVCIeNssGPelBqhyrHe6kJ2zDhjygnho=;
        b=tzv/MPKToWIoI5FeApPycmYRNzBQdRdWgziA5Q96bBvrHgBVuPL6+iuOcXTmSIhoZL
         2LGOzeA0lVAVTqJfycFpyLw9Lgit2j3snY/0F2huD3I7QxQ5vR7853NzS0TDML6bWoAv
         IdYQRRB+VsbHZ6g5fQvbsUZ1wn8XuXNVibZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rJMj6QhiaK2mEUp5N22A8u6FZhCE0mvuQpJc9bzKGRJXRxTRnser5SmZt3+8Su2CKx
         9CQ4Nkr5PDbwzBrHBc8GxmSxvSlTnzRuSBMU/AjHImcYofm8v4ENN0V0QOgyAHcg/gdT
         S1kAnwMiXMWoJWGHTwq9kWoSrl8kAelS2efyg=
Received: by 10.231.85.206 with SMTP id p14mr5185923ibl.89.1283166500254; Mon,
 30 Aug 2010 04:08:20 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 30 Aug 2010 04:08:20 -0700 (PDT)
In-Reply-To: <vpqtymcs74z.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154785>

On Mon, Aug 30, 2010 at 10:54, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.com> writes:
>
>> On Mon, Aug 30, 2010 at 09:50, Matthieu Moy <Matthieu.Moy@imag.fr> w=
rote:
>>> The same pattern is used in many tests, and makes it easy for new o=
nes to
>>> rely on $HOME being a trashable, clean, directory.
>>
>> Looks good, but why not:
>>
>>> +HOME=3D$(pwd)
>>> +export HOME
>>
>> This instead:
>>
>> HOME=3D$TRASH_DIRECTORY
>> export HOME
>>
>> Looks like it might be more correct given this (always an absolute
>> path), but I haven't tested:
>
> That should work too, but with your version, I have to think harder t=
o
> make sure $TRASH_DIRECTORY is absolute (that should be OK), and won't
> make any issue with symlinks (I have no idea whether it is OK or not)=
,
> while it's trivially correct with mine (pwd is absolute, and the -P
> option of the cd command right above prevents issue with symlinks).

I don't know what's best here (and I didn't look hard at this).

but I recently brought down the number of $(pwd) invocations in
test-lib.sh down to exactly 1, so everything that comes later is now
defined in terms of that pwd invocation.

Defining everything that comes afterwards in terms of that pwd might
be clearer.

But it's a trivial issue.
