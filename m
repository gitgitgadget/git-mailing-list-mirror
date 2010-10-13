From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac
 (probably Linux)
Date: Wed, 13 Oct 2010 12:35:24 +0200
Message-ID: <AANLkTinw0CNjdZZOzB8rQmZ3uQiB_sGCGa2B0jJfWf7=@mail.gmail.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com>
	<AANLkTimB6s_yt6L59xpqsWO_yBsZxuVCiExFoSm9FcN1@mail.gmail.com>
	<C29949EA-5717-4BA3-936E-354FCB107877@jetbrains.com>
	<38052CF8-66F3-40FD-8D2D-8FD58A622F7B@jetbrains.com>
	<AANLkTi=6nJAYKB_MTjXL3oftcWtr_wtdHaULYzRcP6oP@mail.gmail.com>
	<AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 12:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5ygF-0000H4-Pu
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 12:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab0JMKf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Oct 2010 06:35:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40367 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0JMKfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Oct 2010 06:35:25 -0400
Received: by qwa26 with SMTP id 26so952128qwa.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oQvfbMLhZME2rIwtSk58AQF7qbfDstPG9xpQORDHC8o=;
        b=MCuTzhSHVenZU5qFbQkC84OEXhIOgfhHLW0NMME+Q9z5OJckuJ8EeD3Duq+eLk9p2o
         lqc0uiieMvxAzfDRb9yaE06HoEC5cWGdwnYLnAkgbZa4D2seKIfDNLpvzE5Ug3j+tsDU
         ENpgTCTiaK1kwJG/jA8EGgsPOgO8ltCH+q3HA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FV6mkOtT2nnJy4+B9rLmSw8jLdO0GALlr4k0uTsx6THa5LLc5s7Y3ho+gDGU+VmQmC
         mmrGcktstf/Xj6UXa/k5vyFpAReGc2RzhkGxto2apFhTsPYnOMzebpIcFx6/wZsMPkkn
         p6tjyO+8XpHpXghSNAyj+T6fMkLI7bBrSGoXM=
Received: by 10.229.240.141 with SMTP id la13mr7306424qcb.267.1286966124551;
 Wed, 13 Oct 2010 03:35:24 -0700 (PDT)
Received: by 10.229.87.212 with HTTP; Wed, 13 Oct 2010 03:35:24 -0700 (PDT)
In-Reply-To: <AEC0873D-4AFC-402E-9D7D-197A7D40DCDD@jetbrains.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158926>

2010/10/13 Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>:
>
> 12.10.2010, =D0=B2 19:25, Alex Riesen =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB(=D0=B0):
>>
>> Besides, if you have to just check if the tree under a path is chang=
ed
>> you can always use
>> --exit-code or --quiet to "git diff", it will speed them up.
>
> Unfortunately, that's not enough: I have to know which files have cha=
nged and how (created, deleted, modified).
> Also I feel that it's not the size of the output which is slow - the =
scan of directories itself is.

Yeah, that's Windows for you.

> I've made a script which executes these commands (which allow to get =
the total status) on a large
> repository many times.
> My results show that "ls-files -douvm"+"git diff-index --cached" is t=
he fastest combination.
>
> Do you think I could achieve the same result in a simpler or faster w=
ay?

No, don't think so. But you can run the commands in parallel, I suppose=
=2E

And of course a patch implementing a command that does this (or improvi=
ng
the performance of "git diff") will be gladly considered here.
