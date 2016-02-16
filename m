From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 23:10:41 -0500
Message-ID: <CAPig+cSyz7uYeHu=nP_V+6LaaWJZ-Bv6CR=9hmF8_cf74mnuHA@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215244.GG10287@sigill.intra.peff.net>
	<CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
	<20160216031554.GB13606@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:10:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVWyN-0001N2-35
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcBPEKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:10:43 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:36486 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbcBPEKm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:10:42 -0500
Received: by mail-vk0-f46.google.com with SMTP id c3so122948967vkb.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 20:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ylN/tM6vw2ilVFlxBmeTILkgR9nWLXXaN0nsDIpwwBY=;
        b=FkpVIhZE+UjmFr6iaJmzwoqYLMnqYfXTrWtf37uY02lsDGKFmL0Hpt00y20z+SNiPA
         tcmIxg0CLHOAfM3zv4SCKf2yYXPS3ayerYxwbBzo3AztB/L6GFf4PPonw4Ghpr09CkYE
         jsBWgfipzeep/jhcvY7TtRTg4oX9AzrqZ3asursfiKKqufoGsq3NEgDLPgAK/y+BZiKD
         QL1nbnCAsWqtm+X4qGrK7tBV+UGn1ClQBmc6xRQRzTthtYHchyT6gGhafKIavO3+8dL1
         tYVf3ZdSeodqHuj7UhCl9nK/AlKkR+S3yCVcKAJKNbBInHaoHCjltUcioAYd+yKkT41l
         7m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ylN/tM6vw2ilVFlxBmeTILkgR9nWLXXaN0nsDIpwwBY=;
        b=bXCwjeqJU/eLmRce9oZASaG6GfGrKVKgbr+gHD13pZjxTGiI3HCPyxytn9dhB27qnG
         abpNZ64kt6Ufu+eI4Gxf5BrfQlgtGwEjdFMUNl7gJpa9NbGhGW5m57vLrFD3CnViSho3
         +lrxv6maZEELr+3y2Q7oGCjjVjQG5DQXxqelvPSu49oRto5tHd7Y6woUvi0itYbECXWS
         rpFPrCwWToyvxM0ElhI+Lsqu2nkgtbECaDmN6ry/zD23GfCqmZVRfn7seAI2Egmd/OcK
         RtBZxWLjpxMS7+hexKf0jm9z+2FIFkporfGLK6aJ29ZAN9Dcb6uroTkLICOkkb+PIqHo
         C0jA==
X-Gm-Message-State: AG10YOQTpyxMvO17b//Zzx/fyR5yJZUyyXrWAurehZYuvaIKuBhcKhGxAQ+0QClfGLm7vnsrY6vv9Z8tQKEtEg==
X-Received: by 10.31.168.76 with SMTP id r73mr15987267vke.117.1455595841282;
 Mon, 15 Feb 2016 20:10:41 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 20:10:41 -0800 (PST)
In-Reply-To: <20160216031554.GB13606@sigill.intra.peff.net>
X-Google-Sender-Auth: UzIhmvel1aaq4zUz6AnKrBk1T3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286314>

On Mon, Feb 15, 2016 at 10:15 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 15, 2016 at 09:17:05PM -0500, Eric Sunshine wrote:
>> > -       ent = xcalloc(1, (sizeof(*ent) + len));
>> > -       memcpy(ent->pattern, pattern, len);
>> > +       FLEX_ALLOC_MEM(ent, pattern, pattern, len);
>>
>> Does the incoming 'len' already account for the NUL terminator, or was
>> the original code underallocating?
>>
>> Answering my own question: Looking at reflog_expire_config() and
>> parse_config_key(), I gather that 'len' already accounts for the NUL,
>> thus the new code is overallocating (which should not be a problem).
>
> Actually, I think the original underallocates. If we have
> gc.foobar.reflogExpire, then "pattern" will poitn to "foobar" and "len"
> will be 6. Meaning we allocate without a trailing NUL.

Ugh, yeah, I misread the code.

> That _should_ be OK, because the struct has a "len" field, and readers
> can be careful not to go past it. And indeed, in the loop above, we
> check the length and use memcmp().
>
> But later, in set_reflog_expiry_param(), we walk through the list and
> hand ent->pattern directly to wildmatch, which assumes a NUL-terminated
> string. In practice, it probably works out 7 out of 8 times, because
> malloc will align the struct, and we're on a zeroed page, so unless the
> string is exactly 8 characters, we'll get some extra NULs afterwards.
> But I could demonstrate it by doing:
>
>   gdb --args git -c gc.foobar12.reflogexpire=never reflog expire --all
>
> and breaking on wildmatch, which yields:
>
>   Breakpoint 1, wildmatch (pattern=0x85eb70 "foobar12Q", text=0x85e4d4
>         "refs/heads/master", flags=0, wo=0x0)

Nice confirmation.
