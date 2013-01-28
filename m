From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH v2 06/10] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sun, 27 Jan 2013 16:36:23 -0800
Message-ID: <CA+sFfMcyupLGPt8-3PWMzwgGR3zrm4ZfA-7KwBh5VkMXmhuTKQ@mail.gmail.com>
References: <1358757627-16682-1-git-send-email-drafnel@gmail.com>
	<1358757627-16682-7-git-send-email-drafnel@gmail.com>
	<20130122083825.GG6085@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org,
	Brandon Casey <bcasey@nvidia.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:36:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzciP-0005F6-Hd
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089Ab3A1Ag0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:36:26 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36288 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757084Ab3A1AgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:36:24 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so984665wib.17
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=n1lkj3vVCkZsL+rCVZq4BN3G4f2KpsaZhY41ixsnD3Q=;
        b=b3ZP2eefP7Jtu5t/WY0CNwEgDJf3hKx2/5udL9RkJXH7PRmTsOVFuFx8+2P1iXBOXj
         Syh3PS8D5XLOlw/oFqv3r++69jXP/HMT4RvSJw+3z6XodfuQrGRvK3gpRL0SvIqfxI5Q
         aFTWKlt7e3ShbT7OCM1wyRcrAoqy7Qp21g3u98u25JmAxXFXnZBWe28SeS8Ky9gDGGBn
         ExmFkiXOIIl92wX+MjeKsiUqBPuhSN1mFAtZ6ZtMXl8hrRE94hLcz5thLDAF4nK52gUZ
         HxZKD/h/PT0Kwfw99n/0Sm2kG8fBzigInYXx8kEmHR/fgf1fElKD2pRcSpg5WAb5hzOI
         zmFw==
X-Received: by 10.194.23.37 with SMTP id j5mr18234480wjf.28.1359333383439;
 Sun, 27 Jan 2013 16:36:23 -0800 (PST)
Received: by 10.194.143.18 with HTTP; Sun, 27 Jan 2013 16:36:23 -0800 (PST)
In-Reply-To: <20130122083825.GG6085@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214757>

On Tue, Jan 22, 2013 at 12:38 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Brandon Casey wrote:
>
>> Teach append_signoff how to detect a duplicate s-o-b in the commit footer.
>> This is in preparation to unify the append_signoff implementations in
>> log-tree.c and sequencer.c.
> [...]
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -1082,9 +1101,10 @@ int sequencer_pick_revisions(struct replay_opts *opts)
>>       return pick_commits(todo_list, opts);
>>  }
>>
>> -void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>> +void append_signoff(struct strbuf *msgbuf, int ignore_footer, int no_dup_sob)
>
> Isn't the behavior of passing '1' here just a bug in "format-patch -s"?

I think that is an open question.

> Style: callers will be easier to read if the function takes a flag
> word with named bits, as in:
>
>         #define APPEND_SIGNOFF_DEDUP (1 << 0)
>         void append_signoff(..., int ignore_footer, unsigned flag)

Can't I just be lazy!!!  Ok, you win. :b

-Brandon
