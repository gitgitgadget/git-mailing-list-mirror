From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/18] convert trivial cases to FLEX_ARRAY macros
Date: Mon, 15 Feb 2016 23:18:56 -0500
Message-ID: <CAPig+cQOF7CsJNoiu8FAMk+csrOWG2dbEyxqfpWNwvGdUsjxcw@mail.gmail.com>
References: <20160215214516.GA4015@sigill.intra.peff.net>
	<20160215215244.GG10287@sigill.intra.peff.net>
	<CAPig+cSQG7gWStpRy76D_YzuCFPsXJLBzXCjQ-X_Q3sZthx3iw@mail.gmail.com>
	<20160216031554.GB13606@sigill.intra.peff.net>
	<20160216032626.GA19954@sigill.intra.peff.net>
	<20160216033620.GA26430@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 05:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVX6w-0007Fm-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 05:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcBPES6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 23:18:58 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:36620 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbcBPES5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 23:18:57 -0500
Received: by mail-vk0-f48.google.com with SMTP id c3so123053660vkb.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 20:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O7EOusyC0kXRWbhbktDhHXNtqZ9cYQ3XjY+mVepf/wM=;
        b=nqmMMsWVoIYtGsZQ/ofoGt6vsMY51VptFDYYlKPFCgwIVh2VF5EffM66PYPzPsfLgz
         7QLJJtvBmT2ZFBobVwnH5++GnAvopjfutNGLrIgsH8l8uM5a23kIngLJ4zKjrMwJaMNS
         tMxCtyTRpop4wbXmduRbjzMnyD63KGe/dh7AVSXLEOff/Adf2XnQMNtHXoN831z5Kw9k
         7K49w7J+IbJteitDckmDDAojWxefMtQCNStloGZdhFVxhBxRv1QjanK1wFa2nzpD6Rwc
         ncg7VH9L+dS7iu7PB9VIeaAh/LgCR7T0FbIfKzqGTYfzDU2ii9h+JGIUGOoOGL+JpGIB
         Hf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=O7EOusyC0kXRWbhbktDhHXNtqZ9cYQ3XjY+mVepf/wM=;
        b=laqlBcJGik9YnJJBUS7B7I6TevFFAeu/rmIpBjmVx5UY5N2i+QJoNEFzCBN9uMyDtz
         yMtjtDDVqJxak8G5WyHdyklb5Yz5t43bbajODlGoPkVWCH9r/Apet6AWYxEdRqze0jHb
         SdzTxzNcu+nFDPPAG89Glr/BRze6n5Sf4ZLZ6uwBLWTwkoRU/E47imEeYul8e+JOcXo+
         gr53dgkuIcI4Gs7rIL6IdrRfmOxJ5/S3YQj93cv54GO+kbOXiJ2O/l4JVp6bEiJhytGh
         RAKC6EYvjSne4yKl9V8VzieNEWVxl4leCWOXByoP/TXxWpRQMtxg1peTRVLXDQ2uayQx
         6z5w==
X-Gm-Message-State: AG10YOTMqinFL5riOjWB+HDbrfKpjfMWRTk7yuqmAXMaAS8rhP4iSlrcVjg5iSn2HtjMj1831JehCks9nEdN/g==
X-Received: by 10.31.168.76 with SMTP id r73mr16007258vke.117.1455596336934;
 Mon, 15 Feb 2016 20:18:56 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 20:18:56 -0800 (PST)
In-Reply-To: <20160216033620.GA26430@sigill.intra.peff.net>
X-Google-Sender-Auth: ZcLJeBVd0Gz0HU5Lk4JH70NsyUs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286315>

On Mon, Feb 15, 2016 at 10:36 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 15, 2016 at 10:26:26PM -0500, Jeff King wrote:
>> We could do this on top of my series (I can also factor out the fix
>> separately to go at the beginning if we don't want to hold the bugfix
>> hostage).
>>
>> -- >8 --
>> Subject: [PATCH] reflog_expire_cfg: drop misleading "len" parameter
>
> Here it is as a separate fix. Applying my series on top would need a
> minor and obvious tweak. I'll hold a re-roll for more comments, but will
> otherwise plan to stick this at the front of the series.

Yep, I prefer this version of the patch too, as it makes it explicit
that a bug is being fixed rather than it happening "by accident" via
the FLEX_ALLOC_MEM conversion, which is easily overlooked.

> -- >8 --
> Subject: [PATCH] reflog_expire_cfg: NUL-terminate pattern field
>
> You can tweak the reflog expiration for a particular subset
> of refs by configuring gc.foo.reflogexpire. We keep a linked
> list of reflog_expire_cfg structs, each of which holds the
> pattern and a "len" field for the length of the pattern. The
> pattern itself is _not_ NUL-terminated.
>
> However, we feed the pattern directly to wildmatch(), which
> expects a NUL-terminated string, meaning it may keep reading
> random junk after our struct.
>
> We can fix this by allocating an extra byte for the NUL
> (which is already zero because we use xcalloc). Let's also
> drop the misleading "len" field, which is no longer
> necessary. The existing use of "len" can be converted to use
> strncmp().
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> @@ -408,13 +407,12 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
>                 reflog_expire_cfg_tail = &reflog_expire_cfg;
>
>         for (ent = reflog_expire_cfg; ent; ent = ent->next)
> -               if (ent->len == len &&
> -                   !memcmp(ent->pattern, pattern, len))
> +               if (!strncmp(ent->pattern, pattern, len) &&
> +                   ent->pattern[len] == '\0')

If 'ent->pattern' is shorter than 'pattern' then the strncmp() will
fail, thus it will short-circuit before ent->pattern[len] has a chance
to access beyond the end of memory allocated for 'ent->pattern'. Okay,
makes sense.

>                         return ent;
>
> -       ent = xcalloc(1, (sizeof(*ent) + len));
> +       ent = xcalloc(1, sizeof(*ent) + len + 1);
>         memcpy(ent->pattern, pattern, len);
> -       ent->len = len;
>         *reflog_expire_cfg_tail = ent;
>         reflog_expire_cfg_tail = &(ent->next);
>         return ent;
> --
> 2.7.1.574.gccd43a9
