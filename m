From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Thu, 2 May 2013 02:27:12 +0530
Message-ID: <CALkWK0mz6+RS-fZAjz=1+kVN6WFTb+cX98V=8AGfzybacf28RQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-5-git-send-email-artagnon@gmail.com> <CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
 <CALkWK0n2odCn=GnYSXv7g113PFEX42WF1d2GBGV=ye2TuY3CHA@mail.gmail.com>
 <CAMP44s34X+6c2V0iU_+dfNR9ULXD+Q0CDFk0S9qdK0n8AC81DQ@mail.gmail.com>
 <CALkWK0mfHVBLPdU7jyiBR=-kSguCBFOhsEsXYYthBuQbtX7MuA@mail.gmail.com> <CAMP44s1dWhpVhUar2-u1NAqK-TPssxZYgGMY9_SVxvuKSFT4QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 22:58:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXe6A-00024g-PC
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616Ab3EAU5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:57:55 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:59925 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab3EAU5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:57:54 -0400
Received: by mail-ie0-f178.google.com with SMTP id aq17so2458629iec.9
        for <git@vger.kernel.org>; Wed, 01 May 2013 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zfPLycQav2LmvXja/BKjJO1XSCu/07kH9tJTAVRyyVw=;
        b=ArP/B4mvi2MkudE8W2vDh7rs7ASNgOjtNcS5ojz9956cRw5Hh4oNVxdOboL5myfwA8
         t8CU4uce5+oBd2uWs+xRQeTdmEPNqAQCd29UDtMhVoRjfvjNlN+MEExo7lgT22TMJkCU
         Pr7xwkXNCQ4Gw7B8l61sIb2DzlB9fkwR2qAa+dQSsYWAAw3Bb2wk55b9Zt8ormvt3U8P
         Vb3JsuKLm+cafayV2Hyut4HukiC0+0yI2XVQ4U7I61HHqTNGynLA5X/Mr3n/q+jie9Id
         bcO2qruu9aueGPb/807u+MrFmbBW7hBce1SgLZiGA15YYwZ6d25+wMXbN15SWIjkTK2F
         sFTg==
X-Received: by 10.42.123.66 with SMTP id q2mr2179643icr.12.1367441873604; Wed,
 01 May 2013 13:57:53 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 13:57:12 -0700 (PDT)
In-Reply-To: <CAMP44s1dWhpVhUar2-u1NAqK-TPssxZYgGMY9_SVxvuKSFT4QA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223143>

Felipe Contreras wrote:
> If you are arguing in favor of arbitrary symbolic refs plus @{u} to
> work, a patch that allows that, and nothing else, should make sense.
> Such patch would trigger further discussion, for example, if
> get_branch() is the right place to achieve that.

What kind of absurd argument is this?  I am trying to solve the @ ->
HEAD problem correctly.  In the process, I fixed general symbolic-ref
handling and cleaned up the @-parsing logic.  Does anyone have a
problem with the fix, or am I missing something?

So, start the discussion.  What are you waiting for?

> I still see this in the code:
>
>         if (!name || !*name || !strcmp(name, "HEAD"))

Remove the !strcmp(name, "HEAD") and tell me what you see.  "HEAD"
will get resolved just like any other symbolic ref, via the hunk I
added.
