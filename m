From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe --contains: default to HEAD when no commit-ish is given
Date: Mon, 24 Aug 2015 11:47:58 -0700
Message-ID: <xmqqd1yc4j6p.fsf@gitster.dls.corp.google.com>
References: <1440072823-18024-1-git-send-email-szeder@ira.uka.de>
	<1440168632-15412-1-git-send-email-szeder@ira.uka.de>
	<xmqqoai07gen.fsf@gitster.dls.corp.google.com>
	<20150824181417.Horde.2DAlveA2ZaXbdApUl8wLOQ8@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:48:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTwmt-0001WE-4V
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 20:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbbHXSsB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2015 14:48:01 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33489 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbbHXSsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 14:48:00 -0400
Received: by pacti10 with SMTP id ti10so29931764pac.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=tRtnEhMYYCJq3ue3DMQc85U29snS2oNQHvNFjGMC7NM=;
        b=ReRyxMfIzE6kqRMC0T4Zk4qdVAuGNjEBEfnJoTTeK7dti6/XqVSYk2/hLpQmZyxHz2
         zib6lwzoBZoFbk5MUMDnus2xYor6xCD6Kuv9pyUd9psp2HOC3sm1gVdnwZ20GLcF8AbJ
         7ya+JdAfh6d6nIBKyVaka/9PIGwk0Wmua7z4qcAleiXaaQpVBvf/JOocg+4WWnnOANwS
         PCemmQ2/FeD6u17L38ORmn0qYdF7/Co4TnzhT4t73iYuPMoWz68JpCHr8Rp/K6Cizmb7
         /OfA+UD7VobB0ggSNF/ijS97CCZIG77V2SkqKNTPcFAyZ8dj43mf5nJBBC+xlpbLPsV7
         3jGQ==
X-Received: by 10.68.249.101 with SMTP id yt5mr48891682pbc.6.1440442080214;
        Mon, 24 Aug 2015 11:48:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:813d:881a:159:a8e7])
        by smtp.gmail.com with ESMTPSA id s13sm18239437pdi.70.2015.08.24.11.47.59
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 24 Aug 2015 11:47:59 -0700 (PDT)
In-Reply-To: <20150824181417.Horde.2DAlveA2ZaXbdApUl8wLOQ8@webmail.informatik.kit.edu>
	("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Mon, 24 Aug 2015 18:14:17
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276477>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

>> By the way, I usually prefer a fatter 'else' clause when everything
>> else is equal, i.e.
>>
>> 	if (!argc)
>>         	argv_array_push(&args, "HEAD"); /* default to HEAD */
>> 	else {
>> 		while (*argv) {
>>                 	...
>> 		}
>> 	}
>>
>> because it is easy to miss tiny else-clause while reading code, but
>> it is harder to miss tiny then-clause.  In this case, however, the
>> while loop can be replaced with argv_array_pushv() these days, so
>> perhaps
>>
>> 	if (!argc)
>>         	argv_array_push(&args, "HEAD"); /* default to HEAD ... */
>> 	else
>> 		argv_array_pushv(&args, argv); /* or relay what we got */
>>
>> or something?
>
> Indeed, I didn't notice argv_array_pushv() being added, log tells me
> it happened quite recently.  I suppose with both branches becoming a
> one-liner the order of them can remain what it was in the patch,
> this sparing the negation from 'if (!argc)'.

Another reason to favor the way the code is illustrated for
educational purposes above is it is easier to see exceptional case
first, i.e. "if we have nothing then we do this special thing, but
otherwise we do the normal thing".

But that is a much weaker preference than the preference to "fatter
else"; I could go either way.

> v2 comes in a minute.

Thanks.
