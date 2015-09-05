From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Fri, 04 Sep 2015 18:23:28 -0700
Message-ID: <xmqq613pek1b.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<CA+55aFw-PObyj2boqpeA9DDcKeAuCGouT7Qd2Zw02+sxvd2CgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:23:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY2Ce-0000yl-4e
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758826AbbIEBXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:23:32 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34685 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbbIEBXa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:23:30 -0400
Received: by padhy16 with SMTP id hy16so36943206pad.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=adQquI9iz6gA+2gATEK305L+COpJRTqVkLq2YpyULjQ=;
        b=SVXl7wEmAa+T+Ei10xYHId+j3N33HE4SQ6AysOfl4HpzWyYKwVpCjSncVJg/ckKr8X
         m3ak+3GoZp5C8cOe0Zf0QiP084Brwk7KLPQfSmPt4VPeVIeQsDJS4SmODjM9Fckwb8nG
         OKJvQ6KGeqMiD+w3sBdJ4CeF0NnMAgUhm489qhTaT8PCH9fNUgH6dSHyrhOoBoLXeXgd
         GIIiamAVypfvcOMmOp9p00gsE2Cb8EqCkz1T7+erQxJ5I4iAuKIXr0UZPo49vCeOVLk6
         5zMohFCcKX1yeLm7Wrk2z9aP5C5qjJidhgA9G/WLGDIVQkwEU1hABYAjgo6x9PC351cT
         SlSw==
X-Received: by 10.68.239.202 with SMTP id vu10mr14699166pbc.135.1441416210286;
        Fri, 04 Sep 2015 18:23:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id hk4sm3916347pdb.22.2015.09.04.18.23.29
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 18:23:29 -0700 (PDT)
In-Reply-To: <CA+55aFw-PObyj2boqpeA9DDcKeAuCGouT7Qd2Zw02+sxvd2CgA@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 18:06:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277357>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The thing is, and that was what the report was all about, not every
> line _is_ of that format. We have commetns from the sign-off people.
> Things like this:
>
>     Signed-off-by: Noam Camus <noamc@ezchip.com>
>     Acked-by: Vineet Gupta <vgupta@synopsys.com>
>     [ Also removed pointless cast from "void *".  - Linus ]
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

OK, I didn't know that was acceptable in the kernel community
to have random comments like that inside the block.  Can these
comments span multiple paragraphs?  What I am wondering is what
you want to see in a case like this:

     Signed-off-by: Noam Camus <noamc@ezchip.com>
     Acked-by: Vineet Gupta <vgupta@synopsys.com>
     [ Also removed pointless cast from "void *". - Linus]
     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
     [ Ahh, we have to tell at least these people

      - stakeholder class 1
      - staeholder class 2
     ]
     Cc: foo
     Cc: bar
