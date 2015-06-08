From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 07/13] prune_remote(): use delete_refs()
Date: Mon, 8 Jun 2015 09:57:04 -0700
Message-ID: <CAGZ79kYcO95M6DsPa71uckOcOKs-mkz2P+NtEKx5qYfOcDw99g@mail.gmail.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
	<2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:57:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20MI-00055f-Ou
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbbFHQ5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:57:07 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:34712 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbbFHQ5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:57:05 -0400
Received: by ykfl8 with SMTP id l8so54899645ykf.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/aOGqcPl6dBb6k1EwHmkXEbDI7FHBO7vORVSV0xClIw=;
        b=SufVU6s4aBZPsmbFJcrwVzDIJ422hU82KU5C68KfxjC+VGFX+3zG/HJGG0PHN7tyRe
         frqgZ3PJEokpos2OgLW/GAzUa2d1TW1kXVnhFLh8AcSUwWR3/T9luSbzC8f5L7IobWlA
         LI4xba6QIv2z6vlzMXEAtfE9AlACL3iV/e5aigOxEXEbB5Myk6zCxEW5jKuwt4II65dk
         Xj/Du4pjYP9zjv2PJA0oyvPpOlu0Fob349cYOgVdu/rkOV/r2mzdIO5t8Gmo5e7Vs8C9
         nGygjOcrPuDq0WN4zNrE9vN7++rQgcdvs+CjvnoVrIXABq/SiHU4gUYJeXfnNMNNV6WB
         7HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/aOGqcPl6dBb6k1EwHmkXEbDI7FHBO7vORVSV0xClIw=;
        b=gHwmY/EaEZPQQx6hbOKr9zrLTTl1axzJGnDit1MCbkTgge0prSPc61Tj2kf3HdX3us
         7ixBsqOtdJyQX69ZlIdBYhZA4bIx+yDj3GYCcYNfINsTxuhc2iI2k/6XG3KHLd5ko9y7
         4Tf+9VRe8bDGFhT1Yw+4n94PWUs64ZbeCoYKgXPvZzIHflBBF3m/8PcMbdwAFwSt9NZB
         hwWhbClc8W0650rz5EiRvO23R3uFcGPXzPA8ZgIrQ08T+uPZi2g0aZplWaB1RpWDYche
         UmSrz/LX3HDVYT76jpAWd3jWIpSdAJ93tr9Rp9WaK2bB9TwHCJjBmDAtV+9s3Dh9Cjiw
         ED6w==
X-Gm-Message-State: ALoCoQkd497fjvSbS1+k5AJQKR/hzBNM8+RB00lHblIx/hbb7/m2HJbi7miPaNHOz7X4YRArcz8+
X-Received: by 10.13.238.71 with SMTP id x68mr17436914ywe.129.1433782624742;
 Mon, 08 Jun 2015 09:57:04 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Mon, 8 Jun 2015 09:57:04 -0700 (PDT)
In-Reply-To: <2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271078>

On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> This will result in errors being emitted for references that can't be
> deleted, but that is a good thing.

This sounds a bit like hand-waving to me. "Trust me, I'm an engineer!".


>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/remote.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index c8dc724..cc3c741 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1314,19 +1314,12 @@ static int prune_remote(const char *remote, int dry_run)
>                 string_list_append(&refs_to_prune, item->util);
>         string_list_sort(&refs_to_prune);
>
> -       if (!dry_run) {
> -               struct strbuf err = STRBUF_INIT;
> -               if (repack_without_refs(&refs_to_prune, &err))
> -                       result |= error("%s", err.buf);
> -               strbuf_release(&err);
> -       }
> +       if (!dry_run)
> +               result |= delete_refs(&refs_to_prune);
>
>         for_each_string_list_item(item, &states.stale) {
>                 const char *refname = item->util;
>
> -               if (!dry_run)
> -                       result |= delete_ref(refname, NULL, 0);
> -
>                 if (dry_run)
>                         printf_ln(_(" * [would prune] %s"),
>                                abbrev_ref(refname, "refs/remotes/"));
> --
> 2.1.4
>
