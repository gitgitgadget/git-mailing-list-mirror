From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/14] revert: Eliminate global "commit" variable
Date: Wed, 6 Jul 2011 15:07:32 +0530
Message-ID: <CALkWK0=qrtKhvg_Ob_ipeG66R=A=2AaxFSFjYrtFqBFxa=UekQ@mail.gmail.com>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-7-git-send-email-artagnon@gmail.com> <20110706085519.GC15682@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 11:38:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeOYR-0006eR-EU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 11:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab1GFJhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 05:37:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33114 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab1GFJhx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 05:37:53 -0400
Received: by wwe5 with SMTP id 5so6759090wwe.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=exugcZvmwVTh7uwW/vJJSWY7p/SRy0JGF4TDPKqN0oo=;
        b=d3h17jEUd7PIAZUsDsIMBWZI/m4jYRrKU96V90OeJjneFiWOdp3jHm2AlHVpGvXDDZ
         n+tzECXp94sTkQfd0mjC1w6wgy3do4I1TjTaLFaAE2guAtNfanLkjk9bXFw+VKHxGL5r
         BeTibPXqH4c93no2wRRA2yKmEyWWj1nfUz2rI=
Received: by 10.216.60.72 with SMTP id t50mr1789934wec.92.1309945072210; Wed,
 06 Jul 2011 02:37:52 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 02:37:32 -0700 (PDT)
In-Reply-To: <20110706085519.GC15682@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176673>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Since we want to develop the functionality to either pick or revert
>> individual commits atomically later in the series, make "commit" a
>> variable to be passed around explicitly as an argument for clarity.
>> This involves changing several functions to take an additional
>> argument, but no functional changes. =C2=A0Additionaly, this will pe=
rmit
>> more than one commit to be cherry-picked at once, should we choose t=
o
>> develop this functionality in future.
>
> I don't understand the last sentence above --- doesn't "git cherry-pi=
ck
> A B" work already?

Ugh.  Removed the line.

> The patch looks good, except for:
>
> [...]
>> -static void write_cherry_pick_head(void)
>> +static void write_cherry_pick_head(struct commit *commit)
> [...]
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 write_cherry_pick_head();
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 write_cherry_pick_head(sha1_to_hex(commit));
>
> I don't see how this would even compile.

Rebase fail.  Thanks.

-- Ram
