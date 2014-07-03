From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 5/7] replace: refactor replacing parents
Date: Thu, 3 Jul 2014 15:42:34 +0200
Message-ID: <CAP8UFD3wSxYVuwSLApQikEbXgsvU2H=6PQ-tmvRjdBinDNmGVA@mail.gmail.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.43446.chriscool@tuxfamily.org>
	<xmqqtx6zfp3m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:42:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hHl-00047b-6P
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 15:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653AbaGCNmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 09:42:38 -0400
Received: from mail-vc0-f171.google.com ([209.85.220.171]:35917 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756103AbaGCNmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 09:42:35 -0400
Received: by mail-vc0-f171.google.com with SMTP id id10so227945vcb.2
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=U+J1yXqHvs+gb8FP+LbTkp9gMnFKJACcSZUf4gWShBw=;
        b=w5R5eb5N+s4fFEPp5k+0TaZ3gWjhbTQLvPmsEAwUlwMhgfOaw5NdrzHTaMhNQzd3wB
         MztXspFQ9jOQxOrIplDcUiSTuUocziWu2BMiQ+oB973jc73zDvjEmvojxlQ9u4POfrdt
         8+3fsohlaKPzuAvk1YCl/DwvzIagiqk2ewoy2uZXbLM5Uta6HSccbKk8JqLiJQrf2Xew
         Cn7FzgXsQtykJ/rmScmkU5NBHyJIFNpr7/bpnWlITGszxM4UevIzRyOP/SYDpV14CwF7
         br0IaYO/aoZGf1eBZ69RVFP8ImQZScc970Mjbn1QA/ylPjqrtOjevdxZazpWwbpVbjih
         btHg==
X-Received: by 10.58.119.75 with SMTP id ks11mr4034210veb.20.1404394954340;
 Thu, 03 Jul 2014 06:42:34 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Thu, 3 Jul 2014 06:42:34 -0700 (PDT)
In-Reply-To: <xmqqtx6zfp3m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252860>

On Wed, Jul 2, 2014 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/replace.c | 42 +++++++++++++++++++++++++-----------------
>>  1 file changed, 25 insertions(+), 17 deletions(-)
>>
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index 3515979..ad47237 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -295,27 +295,14 @@ static int edit_and_replace(const char *object_ref, int force)
>>       return replace_object_sha1(object_ref, old, "replacement", new, force);
>>  }
>>
>> -static int create_graft(int argc, const char **argv, int force)
>> +static void replace_parents(struct strbuf *buf, int argc, const char **argv)
>
> It is somewhat strange to see that a new function introduced earlier
> in the series is rewritten with a "refactoring".  Shouldn't the new
> function have been done right from the beginning instead?

Yeah, I will do it right from the beginning in the next patch series.
