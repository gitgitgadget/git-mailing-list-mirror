From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Thu, 25 Apr 2013 14:24:47 -0500
Message-ID: <CAMP44s3LhYt+eNaKWyoDWAPtepaOKXLhYsPXg5dPjYN8MoGA-w@mail.gmail.com>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net>
	<5178C583.6000703@viscovery.net>
	<7vehdy7j5f.fsf@alter.siamese.dyndns.org>
	<CAMP44s0FHnm0xeSuzVNxVhn_rMQ=oKqoDxCU+OWGKPNOxmnGyA@mail.gmail.com>
	<7vwqrq31tv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:24:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRmo-0002v7-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638Ab3DYTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:24:49 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:61684 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508Ab3DYTYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:24:49 -0400
Received: by mail-la0-f45.google.com with SMTP id em20so1787627lab.4
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AikIlr3JGXDUm6WXbFaDuMtdEPbcorCuKc1fBkxBmZM=;
        b=OLScvlFZB9ynK1nWED0935nDu3sGM7pUNkmwdBzfklx3DjA33/E//dR/4DWUiVWuEf
         PgBzHus13QVWFbCPc1bMCxv1dOYCR+13Gt2P+hUXcsgB/p2/EuVlpHgu/nkfB8Vik93R
         BvDfaKiy1UZ2HNhABLx3PRBC8IExIugztbGoFeACrz1psLcjRaRzqPPmUgsJ4MLG+os5
         O22KiLYnKBUuQxkitjTOF4en68WQqcyWm0qIJMBsp3t+wBRu8MtUs0HWzsWqJ31VASm3
         jGQ6nN/odfN0D4GTzfAnKWK/vetUrY64PQwrTJWlhmiU/MVzSZW4uhExAuHJDgLp7S0h
         MwPg==
X-Received: by 10.112.135.3 with SMTP id po3mr17228291lbb.103.1366917887528;
 Thu, 25 Apr 2013 12:24:47 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 12:24:47 -0700 (PDT)
In-Reply-To: <7vwqrq31tv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222418>

On Thu, Apr 25, 2013 at 1:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>> ...
>>>> +             git for-each-ref --format='%(refname) %(objectname)' |
>>>> +             while read ref a
>>>>               do
>>>> -                     test $a == $b && continue
>>>> +                     case "$before" in
>>>> +                     *"$ref $a"*)
>>>> +                             continue
>>>
>> I wonder if we should bother with this at all. The purpose of the code
>> was mainly to show to users that they should report the success only
>> if the refs have been updated, but the code is becoming more
>> obfuscated, a comment should do the trick. And then, we can just
>> report success for all the refs (and explain in the comment why).
>
> Are you proposing to say "ok $ref" to everything we see in the
> resulting repository, even the ones the caller of remote-testgit did
> not ask us to do anything with?
>
> Wouldn't the caller be surprised if we did so?

Why would it? The only effective difference is what you'll see
reported in the UI, but there's no user here.

-- 
Felipe Contreras
