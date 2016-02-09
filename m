From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 05/12] ref-filter: introduce parsing functions for each
 valid atom
Date: Tue, 9 Feb 2016 22:30:50 +0530
Message-ID: <CAOLa=ZRwKx-y_-st+BpKmpp6uBBPaDu7+DjDnsKswG8y_V32Gg@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-6-git-send-email-Karthik.188@gmail.com> <CAOLa=ZQxbCYd_bpf4PSpRVvejOgi=farNPtHgP_mZZypOf6cnQ@mail.gmail.com>
 <CAPig+cSt9Dub88ywP8mc8dPq6pXFvn4OTSJmEWbAiTeirRB7xA@mail.gmail.com>
 <CAOLa=ZTFVLxiP5PXszwmS3xueitQJd3FhJ968hf58yvWX=qmGA@mail.gmail.com> <87wpqg4opn.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, Git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 18:01:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTBfK-0004LV-Gw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 18:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbcBIRBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 12:01:22 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35542 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbcBIRBU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 12:01:20 -0500
Received: by mail-vk0-f41.google.com with SMTP id e6so121036814vkh.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 09:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HbSq/jcr1aYAbsZWFdO17kwXlp54a1mCphBHRjuNGu8=;
        b=0eJkTrn8b8pGxmZ0nBuDGs6/ud+3I9QkfD9fl12n/rzva9zPRDOpTP1pglexz9ogrV
         UJCmwPvGXweyOljdWSDfSJef/LIu7/v1SnvFaiYys2V3M91rn/fxWAcb9Na75/BcXTEb
         q6xhtMFq8WgAN67QnbE5ttysPSCMoAgcoxHz8ZY3742PfzevTsn0ML8h6sDSjf2q+H4D
         28Ax0jhaiHxFlAQiDxYSHbJyP0p8i0HqhbcVouj3M94cRPwusw8m0b+4/xVUWsW6YBcf
         o0W3AJ4sjLDJn1DPCebZ2x1HUFyZTJrawJCsSs+e/AlPHBHyPvEPQsv5LKyMuiP4Aq89
         G2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=HbSq/jcr1aYAbsZWFdO17kwXlp54a1mCphBHRjuNGu8=;
        b=lP43Img1PxeGD+e/3rSdt6U8bq2Gu/e118ge/PyX+yokDLA08jVn1eP7LXQNHaH7i1
         Peu+vJY5U01LrC1KfqAaLuG8NBOErZgB5hiYRre17LFGmgTr8jELf8nCFIn7f+cx6XWI
         Ejh+rkzKrsiFCcTA1QbUqvM/agSzKuPwexrAGI8CTLc59gAtSiq0FEMOwnMUeuxgYXDb
         Slf2Q9rJ3TlHwP7N0eJKQ0dBfvQt1e1mw5ddnCzENYF3/iym5KAmvjBEgZWSnQj9vNB5
         I7c6ZSa9HEy6pkmNHBTAaTLcnz7XfndRHswuvNwT2lgrw1FYNVeZ/jYRDaH9gZfVCp/5
         9z6A==
X-Gm-Message-State: AG10YOSW6Pb+ijCW+eAoACc27y5X5KfXTPL9xNSa65R2w4LbKnW1RfraI5+MmfUZnWNKeiON6fhaf+63AXHDOw==
X-Received: by 10.31.155.131 with SMTP id d125mr23293323vke.146.1455037279920;
 Tue, 09 Feb 2016 09:01:19 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Tue, 9 Feb 2016 09:00:50 -0800 (PST)
In-Reply-To: <87wpqg4opn.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285839>

On Sun, Feb 7, 2016 at 7:17 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +               if ((( arg && len == arg - sp)  ||
>> +                    (!arg && len == ep - sp )) &&
>
>                       len == (arg ? arg : ep) - sp &&

This is better I feel. Thank You

-- 
Regards,
Karthik Nayak
