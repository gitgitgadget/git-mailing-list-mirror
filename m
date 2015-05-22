From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] test_bitmap_walk: free bitmap with bitmap_free
Date: Fri, 22 May 2015 09:37:27 -0700
Message-ID: <CAGZ79kZqRE78qFGPcU9xiFDiGG3X0kaBFdH+rGhUCZBM3ikUDA@mail.gmail.com>
References: <20150522005336.GA26326@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 22 18:37:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvpx7-0000KR-96
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849AbbEVQhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:37:31 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35287 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757810AbbEVQh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:37:28 -0400
Received: by qgew3 with SMTP id w3so11394365qge.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YzmNPdHefRmDrqq44Z2q0Vr3PUGPi2IWeJJA4Eghv+o=;
        b=AK8lHJ+GLLErn71mXDz27l4XYDJdzN3ADoskSegEOblkQnCKsEqYj3On3ETkXeBoGV
         M0nDA0Theg2KWdAA3n+K6W8ynZdYqPt3/x0gWq4wZEVqHo11I9j9Lb85dCcqvdnWESvz
         p2IBZ+88OadV6aUKou8Y9R6B0qJS9sOCfdBg5R7inQjGyIe76sogfdcZw20lUK3Do/US
         JTDCj1NPnTxiSDO4b1ex8mnbe/n32cnVQHZRn/3WcWLTM6/84ZOQdikC4FjkvFWK0dnA
         +MlXXWxc+CUjKmzVAdweZXdXY5yO45NoLlZn+EPYiK6hdJaWB0rOS987vxRYKSM3mRJI
         P+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YzmNPdHefRmDrqq44Z2q0Vr3PUGPi2IWeJJA4Eghv+o=;
        b=A6Os8vUBb7uY8yMVLByEbP1tT0TkxVpxPTTtSH6FmnoOgDDt/8Zm+u2txCWVzLrqN3
         Rd3zbCKvhyGBh2yQjNxQjw5QFmoBUZOVQb5Lo4P60ErNnDApZp1knykzRfTvhDKYNlTy
         wpXlla+1HZmOsSBzJRkfhT+fyKdZs6vUlq7wiLFIdhWcnShdpuyNQHathm9M1RX6O8QU
         WDqjZnUsOhu1JSYNjbRqdTjlkdKlua4MFVFdL6+j+oHuM+OdjBMkb1+W17aETrS7xBmf
         vRbaw8gMMRhHrL2paVUT72/PIzeH/Cf108l7cjigI0IQf0wilpB1PAEAri4IVD46th0v
         sWeQ==
X-Gm-Message-State: ALoCoQk/Acsyfq9Y/Ut4ojqBvTRlB5UfHQMU4/YkAOxfiY99ZrVW2agDQMY/ESfLYic5sI/4o8ve
X-Received: by 10.55.19.197 with SMTP id 66mr20060012qkt.24.1432312647276;
 Fri, 22 May 2015 09:37:27 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Fri, 22 May 2015 09:37:27 -0700 (PDT)
In-Reply-To: <20150522005336.GA26326@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269734>

On Thu, May 21, 2015 at 5:53 PM, Jeff King <peff@peff.net> wrote:
> Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> noticed that we leak the "result" bitmap. But we should use
> "bitmap_free" rather than straight "free", as the former
> remembers to free the bitmap array pointed to by the struct.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Sorry, I should have noticed this when reviewing the original.

No need to be sorry, me too.
This looks good to me.

>
>  pack-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 62a98cc..d64bd94 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -987,7 +987,7 @@ void test_bitmap_walk(struct rev_info *revs)
>         else
>                 fprintf(stderr, "Mismatch!\n");
>
> -       free(result);
> +       bitmap_free(result);
>  }
>
>  static int rebuild_bitmap(uint32_t *reposition,
> --
> 2.4.1.528.g00591e3
