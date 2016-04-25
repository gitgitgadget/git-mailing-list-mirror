From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 53/83] builtin/apply: make find_header() return -1 instead
 of die()ing
Date: Mon, 25 Apr 2016 20:18:55 +0700
Message-ID: <CACsJy8B7g8WgWbr4M4LHFyBshN2gi30pL1bCcZcTPB7qtmnWdQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:19:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1augQM-0006GP-DH
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbcDYNT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:19:28 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36272 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932435AbcDYNT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:19:26 -0400
Received: by mail-lf0-f44.google.com with SMTP id u64so16050965lff.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XL8d3W6Wq5RnokIx5jUO3qP4TVBfzEw2z8lnUkbVUjI=;
        b=ruH0hzC1GjzcUoUCm7cdyxQzH/Fj/EyCjbJH1eM+LiicM1b8g2HD99IL5Rmqtos4PV
         gdxJX1/z4TQNsDHV5/jAfe9WRnGycIzfHpS/Ki8TBsjzX4m1864bTOa2O4okUsuvHd/x
         rdmhMU+vYaKIMJflf7m+31t0t0G1F7Lg4JdlenGMsq7Kxo2bFWunKdCszbBhxwmhXAnM
         Rxyh8GrgXAGrdZhjVRDNlZQlh9fnkSqOzfHScR6yVjLeQdtLhJOzo0oQmUGRFJD/lN+M
         U+9gbUk8NDrxVyv2DCBZfcKtlG2Zk+Ew58oLh+HmVIedz19y27AyLcFsMEHr6vzh1MbZ
         mifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XL8d3W6Wq5RnokIx5jUO3qP4TVBfzEw2z8lnUkbVUjI=;
        b=COXVGSXUO6vRiIC+HTE1yJTlUplPuFs4/zy/MN+GgnE2kahxpCAna080grzSeV+YpN
         urDCCbxuqwHFwNvI6InOEH9hYLG6ya9Pr131DQqrgV4vF3OUb7E2Pkeiy8YMgyHBzUsb
         xl0cpFVxeMOSLM2xfKcJeeTwZmQSduxtVKtAx5VdKBnzGxUpZgDv6O4Gj1eT+Rc2kDz+
         WgtCD6Vgo6L8Bji/2/EfpWmze/kFinz3/UehZ/xtClZPVXEnWbQTI7iqc+a8K5FvhNqm
         XAAiaprm+qiQKWbzz7E8V7W4lYQr8LgZNsQp1PsjsI/sm4EFzxmkMWQh2uYfpblRtw9J
         8Qfg==
X-Gm-Message-State: AOPr4FV9SgGPOF/tFYIRNeBGv9UvakSs0Ph1CJvqBuS9ldqk7R7LFum1ybXsXMVGmXS0sXNferQoJt2ZepzIbQ==
X-Received: by 10.25.22.19 with SMTP id m19mr14272523lfi.118.1461590365132;
 Mon, 25 Apr 2016 06:19:25 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 06:18:55 -0700 (PDT)
In-Reply-To: <1461504863-15946-54-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292474>

On Sun, Apr 24, 2016 at 8:33 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> To be compatible with the rest of the error handling in builtin/apply.c,
> find_header() should return -1 instead of calling die().
>
> Unfortunately find_header() already returns -1 when no header is found,
> so let's make it return -2 instead in this case.

I don't think this is a good way to go. Too many magic numbers. I
don't have a better option though. Maybe returning names instead of
numbers would help a bit.

>  test_expect_success 'compare diagnostic; ensure file is still here' '
> -       echo "fatal: git diff header lacks filename information (line 4)" >expected &&
> +       echo "error: git diff header lacks filename information (line 4)" >expected &&
>         test_path_is_file f &&
>         test_cmp expected actual

Not your fault. But this test_cmp should be test_i18ncmp. I don't know
if anybody has still been testing with gettext poison though. May
probably not worth changing.
-- 
Duy
