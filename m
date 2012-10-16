From: David Aguilar <davvid@gmail.com>
Subject: Re: build deps
Date: Mon, 15 Oct 2012 18:39:02 -0700
Message-ID: <CAJDDKr5QaByGg0wW_fwFErRyMA6hbg2kHskxOqY4Z_rLoo1maQ@mail.gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com>
	<5072FAD1.1000807@gmail.com>
	<CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com>
	<50735939.10604@gmail.com>
	<CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
	<50776D0D.9090306@gmail.com>
	<CACnwZYfmz1BTo6okzFh8jXbw+0MAV0sEanYXNzAnV7L4p7nY_g@mail.gmail.com>
	<507C2F6E.9060100@drmicha.warpmail.net>
	<7vd30jwj7v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Thiago Farina <tfransosi@gmail.com>,
	Andrew Wong <andrew.kw.w.lists@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 03:39:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNw7o-0007nN-HE
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 03:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab2JPBjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 21:39:04 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49623 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab2JPBjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 21:39:03 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so5999017vbb.19
        for <git@vger.kernel.org>; Mon, 15 Oct 2012 18:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h1Vncl9S0qe1E8Z3R5p358HGrlzeqrp/Hk24VOV3gvY=;
        b=N7e6oDHtgoV34lOkt2lzJOCW8oaVE4ZHArbz1umyM7btHH8k1EHbxYwLKiYAcxGu+j
         7AeCB/pPvzWVtHJodIq4HjaeErGEn9wWA7IWNg2eq7X5fYG6mGzuZtRQ5ivw9LRpk6xl
         YtFqj47bGoR+LFtvFw8+FFxmuCYWEJMRDme0PrTynTf89lfnDRZrLeQnPBOhkJSBh/5h
         6o2PWuz4roMnYWmvsDWaLPc0DXisJXpPFJfdCF+j79lvcZWeDvCFRYC9x2wDuIfGBTJ1
         t9KxJFyQb8522aAL1KJ1nbMX3U6eV42eBup6zfJ1eOh5t2AKOIdJGslYEmxPi/bbiL8I
         sccA==
Received: by 10.220.231.138 with SMTP id jq10mr7781347vcb.29.1350351542811;
 Mon, 15 Oct 2012 18:39:02 -0700 (PDT)
Received: by 10.58.182.10 with HTTP; Mon, 15 Oct 2012 18:39:02 -0700 (PDT)
In-Reply-To: <7vd30jwj7v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207794>

On Mon, Oct 15, 2012 at 1:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>>> grep.c:451:16: warning: comparison of unsigned enum expression < 0 is
>>> always false [-Wtautological-compare]
>>>                 if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
>>>                     ~~~~~~~~ ^ ~
>>> 1 warning generated.
>>
>> Right, that enum type starts at 0. Junio, you last touched this area.
>> Can we just dump the first comparison or did you have something else in
>> mind?
>
> I think it was a leftover from the very first implementation that
> defensively said "this has to be one of these known ones", and tried
> to bound it from both sides of the range, regaredless of the actual
> type of the field (these GREP_HEADER_WHAT things may have been
> simple integers with #define'd values).  Dropping the "negative"
> comparison is perfectly fine.

This snippet of code came up before:

http://thread.gmane.org/gmane.comp.version-control.git/184908/focus=185014

There seemed to be good reasons to keep the check at the time.

Was this same snippet not also touched when Nguyen Thai Ngoc Duy
worked on the "even if I'm drunk" patch?:

http://thread.gmane.org/gmane.comp.version-control.git/206413/focus=206539

With the "drunk" patch then we wouldn't need the check at all,
which is really nice.

I hope that helps jog folks' memories.
I'm not sure if the above discussions are relevant anymore,
but I figured it'd be good to provide some more context.

cheers,
-- 
David
