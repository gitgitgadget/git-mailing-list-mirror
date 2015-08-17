From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 11:47:43 -0700
Message-ID: <xmqq614deoq8.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	<xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
	<CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
	<xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:47:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPRm-0002ET-Pe
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbbHQSrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:47:46 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33105 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbHQSrp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:47:45 -0400
Received: by pdrh1 with SMTP id h1so59241412pdr.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wVw3N0XW6IDDHrxGARRJdhKvm3wRDn8mo5rwzQeiKrw=;
        b=Dc4qUEYnyH4VzVNSctnloL0IqnXe2mofJY9KfKaqZs6wdrECZdQaRbIOQ/cMLzjISb
         j1EFX5qnSDQO3xy3EB9mtK4MT81mW04JNANzCt443eslhd1shF1qdemLbyp9EYCOjKTs
         V4lRtqRMbliwTWRi++cfSyYy949HjMSPiSS5GaxxOFjosgBwSRHsTDfr4ex0Uep9L0YS
         0VjnWS0Yd9chMat1QDR7LSRAyQ1uJWfyjGeYc9miXpMB4jSeKI8dLvdlgkgWjkJOPBmb
         +rw2bjbHFo+/n+ShXCgHz98tay5TESNsiCMyGqv+hjM3wShwTYyV+oqh6xWHNGhwimPd
         t5dA==
X-Received: by 10.70.50.2 with SMTP id y2mr5159748pdn.5.1439837265326;
        Mon, 17 Aug 2015 11:47:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id fe8sm15574361pab.40.2015.08.17.11.47.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 11:47:44 -0700 (PDT)
In-Reply-To: <CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 17 Aug 2015 14:32:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276071>

Dave Borowitz <dborowitz@google.com> writes:

> On Mon, Aug 17, 2015 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> My preference on Bikeshed 1. would probably be to add
>>
>>     --sign=yes/no/if-asked
>>
>> and to keep --[no-]signed for "no" and "yes" for existing users.
>
> Incidentally, I just looked up incidence of true/false vs. yes/no in
> command line options,...

My yes/no was a short-hand for "yes" (and various other ways to
spell "true") and "no" (and various other ways to spell "false").  I
was NOT bikeshedding to say "I do not like true/false but favor
yes/no".

I actually was expecting a short discussion on sign vs signed,
though.  As "tag --sign" is not "tag --signed" even though we call
the resulting object a "signed tag", "push --sign" may be a good
enough way to spell "signed push".  I _think_ signed pushes are
recent enough that we still have time to deprecate --signed form,
but I do not think it is worth it.

So an updated suggestion would be that we'd take (this is a pretty
much exhaustive enumeration) these:

    --no-signed
    --signed
    --signed=if-asked
    --signed=yes/true/on/1/2...
    --signed=no/false/off/0

We might want to throw in 'always' and 'never' as synonyms for
'true' and 'false', but again I do not think it is worth the
confusion factor, as 'always' and 'true' already mean different
things in some other contexts.

Thanks.
