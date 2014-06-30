From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] sha1_file: use strncmp for string comparison
Date: Mon, 30 Jun 2014 20:59:53 +0700
Message-ID: <CACsJy8A5Dq6MP8kH7R3POSjXoJjYvWF695fKj1YgTdscF5xYxA@mail.gmail.com>
References: <53AED59B.1020209@web.de> <CACsJy8B_DAjLRcMe4ys2LGkLOcKuW-PL_WNHyFB8Ry3Uv38LCw@mail.gmail.com>
 <53AFA775.1090900@web.de> <53AFAA89.6050200@web.de> <20140630134317.GB14799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 30 16:00:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1c8D-0004FB-Mq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 16:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbaF3OA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 10:00:26 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:57552 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaF3OAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 10:00:25 -0400
Received: by mail-qc0-f169.google.com with SMTP id c9so7089492qcz.28
        for <git@vger.kernel.org>; Mon, 30 Jun 2014 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SKvJ9iFtmeASohY4kl4RrLVkOwgaD1N6wthO0FUffkY=;
        b=AmFWhD6Z0mwFk+UAQCIe8D2inyx/eiVyGLUmlbUOUqdvhdXqbHIfDt4/DG+KyRYg3O
         WnzCg5teeGtB6O6s26wd+THOY7WdVp9gwirfO3NmUL65VU9B38k4xB/CnaxcFJN+bdn8
         rpeT/6XFFbpRfq9Q+s1drUk8uO/ipcWKeAyYlW1HESc57gZXPPLCmR2gDuNEx72tKPwO
         Zz4Ya9BN0Mt3+x+p3b6uHT8fpVbfVa/WL0RNfjEsCOAiUrYDF6xb/mg6D1K2MI0+/Rau
         zXu9Omw7J3HRaMYx0/8Yd/t/cauoDPLpPZYjBHaAyeeOL9O9hPPHLXrR1CRhum9vpcVh
         kZ+g==
X-Received: by 10.224.13.82 with SMTP id b18mr23366649qaa.8.1404136823848;
 Mon, 30 Jun 2014 07:00:23 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Mon, 30 Jun 2014 06:59:53 -0700 (PDT)
In-Reply-To: <20140630134317.GB14799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252669>

On Mon, Jun 30, 2014 at 8:43 PM, Jeff King <peff@peff.net> wrote:
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 394fa45..8adab14 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1207,7 +1207,8 @@ static void prepare_packed_git_one(char *objdir, int local)
>>               if (has_extension(de->d_name, ".idx")) {
>>                       /* Don't reopen a pack we already have. */
>
> If we don't follow my suggestion above, we still have this
> has_extension. This is a reimplementation of ends_with, isn't it? We can
> probably drop it and just use ends_with.

This calls for another patch if we just want to kill has_extension()
in favor of ends_with(). There are 12 call sites of it.
-- 
Duy
