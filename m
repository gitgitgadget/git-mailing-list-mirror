From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 7/7] unpack-trees: free cache_entry array members for merges
Date: Sun, 2 Jun 2013 19:04:55 -0500
Message-ID: <CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx>
	<CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com>
	<51AB86BB.3080203@lsrfire.ath.cx>
	<CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com>
	<51ABAA84.8090301@lsrfire.ath.cx>
	<CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com>
	<51ABD00C.7080503@lsrfire.ath.cx>
	<CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com>
	<51ABD99A.2030303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Jun 03 02:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjIGj-00036d-U7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 02:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343Ab3FCAE6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 20:04:58 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:55989 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755301Ab3FCAE5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 20:04:57 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so2906833lab.28
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 17:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2rulxWvUxcRdZCxD/UDBdGVJKx4/X0+4qFKi3X/xFGs=;
        b=qREMBIA00VPJ6KUhxSeHJQpLGRt2Yum0QH20+/HAP9Mr5xIwCFputUX3eOoLLUKh4A
         bmfpFpY+uhOtoUNLV4BRR7JcUuQy6S1LgROgGqnzSq2Ufpar7TLatPBkLGfvkHdN+n+j
         XIbQLvvKmAPII1HGPmWPPaox8KZPZkfNMdAR0RXRgeYpUzhiZPlGiGRXzs8YhbgCUbxO
         g+6SZECokU5apl27ln892zUdarBKiVL0EknjzCDz5OeeHNvuMuSUm7F2q3BrW21C4AT9
         oLAxBGPO+kaQWsz7tWGMraJHplTk21V+c7d9u28MoIFaCTMjep7cdtFR93KRbVg5DO+D
         XqVg==
X-Received: by 10.152.2.233 with SMTP id 9mr9848672lax.34.1370217895687; Sun,
 02 Jun 2013 17:04:55 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sun, 2 Jun 2013 17:04:55 -0700 (PDT)
In-Reply-To: <51ABD99A.2030303@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226199>

On Sun, Jun 2, 2013 at 6:47 PM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 03.06.2013 01:23, schrieb Felipe Contreras:
>
>> I didn't say we should do 'if (ce) free(ce);' instead of 'free(ce);'=
 I
>> said we should do 'if (cd && ce !=3D o->df_conflict_entry)' instead =
of
>> 'if (ce !=3D o->df_conflict_entry)'.
>
>
> I did assume you meant the latter.
>
>
>> There's no reason not to.
>
>
> Only the minor ones already mentioned: More text,

=46ive characters.

> one more branch in object
> code,

Which might actually be more optimal.

> no benefit except for some hypothetical future case that's caught by
> the test suite anyway -- or by code review.

That's not the benefit, the benefit is that the code is clearer.

> I wonder if we already reached the point where we spent more time dis=
cussing
> this change than the time needed by the envisioned developer to find =
and fix
> the NULL check that suddenly became necessary. :)

Maybe, but if what you want is to avoid the discussion, you could just
add the extra five characters and be done with it.

--=20
=46elipe Contreras
