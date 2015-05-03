From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/4] generate-cmdlist.sh: parse common command groups
Date: Sun, 3 May 2015 17:10:52 -0400
Message-ID: <CAPig+cRqvd=_n9huD_txEr6EXVrWZx0onReL5bh_mCKy3M3LOg@mail.gmail.com>
References: <554405D5.9080702@gmail.com>
	<55456990.6000509@gmail.com>
	<55456A40.80806@gmail.com>
	<xmqqpp6hv94x.fsf@gitster.dls.corp.google.com>
	<CAPig+cSRiw7QeAzuxAJF8mikeK1YiNoNATKzMz71L8E29LLp4Q@mail.gmail.com>
	<55468ABB.8050504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 23:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp1AA-0003rW-Lo
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 23:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbbECVKz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 17:10:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35425 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbECVKx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 17:10:53 -0400
Received: by igbyr2 with SMTP id yr2so71684890igb.0
        for <git@vger.kernel.org>; Sun, 03 May 2015 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=L1Ylw8o/QSwFNgoUqYc9hZnvojPd7p6Bl0GH5DMalEM=;
        b=skAkiEDC35769T+SVIxi8wtdrtQcYwOFGLqnD/0tQa7VwW2FnW/6QCGGM1LbdyiN+J
         UVN5LT4262hiQyNxHU/Oo5Co7w4+SfaExNW9/B8ObZ2mKvOrW4HXIctLsIY8uJ3Lj3kf
         OfHMtJ/K9td2aUSBm8q7YLll9A/8VUaiW+urd3Nbz7a2OmodsV2GdydqZ+Ylj9yeLrW3
         wu6oQmvPdilS5usOXP4BPbwKTDGGzJcqA/WRcchcD07Y4ybJbuO0FaG9/J8HYJZkIm0/
         d7ywKWeCGwCdql4fvFAlT5QkkGbGQ47BKNcq7VDn1D7i3yr7tbodBMA9aCKpshprNc1v
         z5cQ==
X-Received: by 10.107.31.134 with SMTP id f128mr24411867iof.19.1430687452809;
 Sun, 03 May 2015 14:10:52 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 14:10:52 -0700 (PDT)
In-Reply-To: <55468ABB.8050504@gmail.com>
X-Google-Sender-Auth: BSrtFjG0SPI_9cYPRxg7YfgirfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268294>

On Sun, May 3, 2015 at 4:53 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/03/2015 10:40 PM, Eric Sunshine wrote:
>>> These people may have helped you to polish your earlier round to
>>> come up with this version, but I do not think they should be listed
>>> as reviewed-by (in the sense that they would say "Yes, I read this
>>> version and consider it very good--I endorse the change!") yet.
>>
>> Minor addendum: If you'd like to acknowledge Luke for $(...) and
>> Andreas for IFS munging, then Helped-by: would be appropriate (and
>> doesn't require their consent).
>
> Thanks for the precision, I got confused with this one.

What Junio meant was that Reviewed-by: is something that reviewers
"give" explicitly when they are confident that they understand and
believe your patches are correct. You may incorporate a "given"
Reviewed-by: into a patch when re-rolling if the patch hasn't changed
since the previous round (or has changed in very minor ways which
don't affect the Reviewed-by:). Someone merely reading your patch and
commenting on it (and possibly making suggestions) does not warrant a
Reviewed-by: since comments and suggestions alone don't necessarily
mean that they agree that a patch is acceptable or correct, thus don't
add Reviewed-by: without it being "given".

Helped-by: is for acknowledging someone's assistance.

More below.

>> So, something like this, perhaps:
>>
>>      [groups]
>>      init    starting a working area
>>      info    examining history and state
>>      ...
>>      branching    branching and merging histories
>>
>>      [commands]
>>      git-branch    mainporcelain branching
>>      ...
>>      git-clone    mainporcelain init
>>      ...
>>
>> This way, the 'N' in "N_group" is unnecessary since presentation ord=
er
>> is implied by the [groups] table, and you don't need the "common-"
>> prefix anymore since any command having an attribute from the [group=
s]
>> table is automatically considered common.
>
> It's a good idea. I'll look into it.

'awk' might be helpful to implement this sort of scheme, as well as
Junio's suggestion of emitting only a group number in the generated
table rather than a string. If so, try to stick to POSIX (and avoid
GNU or other extensions).
