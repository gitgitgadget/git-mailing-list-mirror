From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Thu, 19 May 2016 14:34:29 -0400
Message-ID: <CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu May 19 20:34:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Smc-0006OG-A9
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442AbcESSei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 14:34:38 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37288 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbcESSef (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 14:34:35 -0400
Received: by mail-ig0-f169.google.com with SMTP id s8so49257385ign.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=szINW0iY6OhoQJaOjgcgoiBj1genKaO2cZKUe7bEyzQ=;
        b=C3xbDcm1nMI8EbMJnu2E/q65mda/bmlofpEyDmIZGkPhYWDHxt+SNl6g58NpwIH+Um
         zBIm1XEH3mfan3ttSzgtdRYTtx49HFkUs4fVm78i20sqXOhrM2JfcKyppk6cz2S/1Po9
         2tC5xSBT0Ulhjg+/31umWehWHqJOn+iQoj2zYP8fl4n2n96JbbxRcUiHL2352AC9o2a/
         832uB/+ync6tOzUbV877vrwb0mF5ajLKqd483zZztdCl7Vuo6V7NJI/FaI/isizoIx6V
         4T99NBWtJx0V43bbvCz6xS6tOQYbFYnywhIGdlZs/E9vv/srhsIvFS7Lelxoee04GvcY
         Vx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=szINW0iY6OhoQJaOjgcgoiBj1genKaO2cZKUe7bEyzQ=;
        b=i9dXRjcLfV2EQc60DDFHlOTZhcmkGhjL/tXQRWwmE6+NnvcunjIbsm0sgGXGbRc/aj
         Ya8Ox83ymmMpiaFlg/WhTYZ1VvHGVu/jE2hB8oWZHTCxZeDdn9JKuiYgJJsKg0Ccl5s4
         LUVhwXoh2/nA6Sf+cwH60U5+CEZvrhk+DeUK0FIq3j8I8SRUX+n7c4n418+E8y7q05K/
         qw61z7HPdsmO3cl4LQVqr0uqhf8ZTxBXhFcpWRUrbkaqhnftaNSmtI+S1WzwAJ1Z2uVW
         2w7GpW8sFfaC68XeXS03huZoq5i2LAH568Xa2BAcWOpTIOKgCdhbuRpJvAZVNVWJPtCe
         NnSA==
X-Gm-Message-State: AOPr4FVd7tmIvQeO2D1Y6v+RDaH3T/SDOXwPEU2X0QEtj/3tcEYmenzqUg6OZrHF+qg597WEaTsCFhF95zfcCg==
X-Received: by 10.50.6.15 with SMTP id w15mr4349466igw.91.1463682869762; Thu,
 19 May 2016 11:34:29 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Thu, 19 May 2016 11:34:29 -0700 (PDT)
In-Reply-To: <1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
X-Google-Sender-Auth: sHvJfUKc_SmK8OvF-T9BqEWR_30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295088>

On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.pt> wrote:
> The test t9003-help-autocorrect.sh fails when run under GETTEXT_POISON,
> because it's expecting to filter out the original output. Accommodate
> gettext poison case by also filtering out the default simulated output.
>
> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
> diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
> @@ -31,10 +31,14 @@ test_expect_success 'autocorrect showing candidates' '
>         git config help.autocorrect 0 &&
>
>         test_must_fail git lfg 2>actual &&
> -       sed -e "1,/^Did you mean this/d" actual | grep lgf &&
> +       sed -e "1,/^Did you mean this/d" actual |
> +       sed -e "/GETTEXT POISON/d" actual |

Why not do so with a single sed invocation?

   sed -e "..." -e "..." |

> +       grep lgf &&
>
>         test_must_fail git distimdist 2>actual &&
> -       sed -e "1,/^Did you mean this/d" actual | grep distimdistim
> +       sed -e "1,/^Did you mean this/d" actual |
> +       sed -e "/GETTEXT POISON/d" actual |

Ditto.

> +       grep distimdistim
>  '
