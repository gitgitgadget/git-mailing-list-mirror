From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] tests: fix autostash
Date: Sat, 8 Jun 2013 18:49:52 +0530
Message-ID: <CALkWK0=qVXL=DtJzYRGFLQQh3_-cGC_t_zpaiTL9KVKN4--mVg@mail.gmail.com>
References: <1370648714-7872-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=OdcLDCd9OonUS6kBZhA=oz3HYJT8Eiqnh1A++s5yWww@mail.gmail.com> <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 15:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJ4P-00019U-Sq
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 15:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab3FHNUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 09:20:34 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45373 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab3FHNUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 09:20:33 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so12593859iec.5
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZZ1vLjubsx+p2pg41UjIp854Z8CqgUY5URwe9VyebqY=;
        b=F/EnK/LrIrc+Fp2kFKsbgbowYjNA8Zsldlem2Z2Nyim/rlS6V+3S0yy+rCFBjQvWlL
         UPAKxXhAqewG0ki0PMPLhCmOFByHdyve4gJ7ZabaAo3Z+X/8unOpwdIhm8ohr88AGOUw
         j73w6vY5km+et7pLiJqF9V98TC2lTGzmH1Jc/CnTuEhncxkPwTawBFYyP/Zb+OHBeHdn
         8qOv3455YoD1v9QPN+BNOO5rMXTuc5iVs1myMoqjY/7jqG502iS+dc2XM1PBPqdHDCBz
         YO579fO0KUF114c5X1xQMlsx9soY+hcOM0LTsOI0LtnRYpzpvnuoQ7tPMQupFFyqOvTP
         3pBg==
X-Received: by 10.50.79.231 with SMTP id m7mr871026igx.40.1370697633116; Sat,
 08 Jun 2013 06:20:33 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sat, 8 Jun 2013 06:19:52 -0700 (PDT)
In-Reply-To: <CAMP44s3rYXOmGWR3JM8xy8ON4pqDRhYWVMQqOAyODVr5myq+yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226816>

Felipe Contreras wrote:
> Yes you do. The rest of the tests expect that the previous rebase has
> been aborted.
>
> In fact, all the tests depend on the previous test finishing
> correctly, which is not the way tests should be written.

How else am I supposed to write them?  If there is a stale state from
the previous test, there isn't too much I can do.  Or should I be
cleaning up state at the beginning of each test, instead of at the
end?

> Doing 'rm -rf $dotest' is even worst than 'git rebase --abort',
> because it relies on the implementation of 'git rebase', which might
> need to remove more files than $dotest.

Huh?  Tests aren't allowed to rely on how a command is implemented?

  $ git grep test_path t

Ofcourse they're implementation details.  Even in this very test, I
check $dotest/autostash plenty of times.

Have you read rr/rebase-autostash?  The whole idea is to inject
$dotest/autostash and teach various scripts about how their
assumptions about $dotest have changed.

> This wouldn't be a problem if the tests were implemented correctly,
> but they are not, so 'git rebase --abort' is the only sane option.

Then show me how to do it correctly.
