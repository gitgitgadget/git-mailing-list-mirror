From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Tue, 28 May 2013 19:31:47 +0530
Message-ID: <CALkWK0k=2NZsbSnxS50w+bux8q9mZh7GZzpCqhTP=2jqyHnBSg@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8AEkmiWP46tOBkXRkWDGO+k5YW+GJB-ak8HfTpghQP5eQ@mail.gmail.com>
 <CACsJy8Av8LmiefR5XFuFadZERmivZAAB9TbysFjeUSb2hzgWBw@mail.gmail.com>
 <CACsJy8CW-xtXR15m80oaoex0QF5Vi2L2-kqEzOPxCY2UBmdhxw@mail.gmail.com> <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 16:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhKTw-0004SS-CF
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 16:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933982Ab3E1OC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 10:02:28 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41086 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235Ab3E1OC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 10:02:28 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so21317191iet.14
        for <git@vger.kernel.org>; Tue, 28 May 2013 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Jd0TDn0B1QqqkHzcjSCh3C/j1+EQh3qjnns1Kx09TnI=;
        b=U5ANSwX1QMIE8eNM2VuBmHGn9o6ti9wP4rzC5ymp7NsYLzFe52N41TI4ilk6lRUfHa
         tl14jK3yzJ5yws3ZSY8k5QIcibNv5w7sCnYVynJbkNWUZecSMmQrQgzf9sV41lwcFLwu
         m4oFofBOtselHL6xkxSTLOTPOxiS3sWFcDt6ZdWIKkqkyOZvgtwQVcCUpGqhbTY+uxs3
         0ETcsdoIa4sPDAxmADzFMP/mMIgV8Iudy+hK2vGm4Mkc/By60Q54wimTrlPc1rFjebVV
         HCy/kjYgaDNQta0HEzYB50GkmPmeyXqhi5kwHz0L2TVAHToDdvLye7Yvw4Uou5VfpLP9
         sNyg==
X-Received: by 10.50.141.230 with SMTP id rr6mr6992505igb.89.1369749747469;
 Tue, 28 May 2013 07:02:27 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Tue, 28 May 2013 07:01:47 -0700 (PDT)
In-Reply-To: <CALkWK0kb2D2nH_pDi0TihmFzuEAvWnGJeX0sOXD1TEWLZ7YWHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225654>

Hi Duy,

I just woke up and started looking at the series: it's rather well
done, and I'm confident that this is the way forward.  To reciprocate,
I've done some work at gh:artagnon/git for-each-ref-pretty.  See:

https://github.com/artagnon/git/commits/for-each-ref-pretty

There is one major problem though:

%>(N) doesn't work properly with f-e-r, and I'm not sure why.  I'm not
talking about your last patch where you compute * -- that works fine;
it's just that %>(N) doesn't when N is a concrete number.

Also, a couple of minor annoyances:

1. When f-e-r is invoked with refs/tags, we get stray output.  Atleast
it doesn't segfault, thanks to your ignore-commit patch.  Maybe
printing stray output is the right thing to do, as opposed to erroring
out.

2. %>(*) only works with f-e-r atoms, not with pretty-format atoms.
This is ofcourse obvious from the implementation, but isn't it a
little consistent?

Should we start off a new pretty-ref-formats document, where we
explicitly exclude things like %ae (because of the hex overriding
thing)?  I don't think it's a problem if documented properly.
