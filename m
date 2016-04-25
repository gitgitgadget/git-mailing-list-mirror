From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/83] builtin/apply: move 'check' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 11:57:47 -0700
Message-ID: <CAGZ79kYUr9wQ--898OeyqVw_upqxfVNRsOveUAPSn=PtXZ4xBQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:57:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulhg-0001Ed-UM
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbcDYS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:57:49 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35193 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbcDYS5s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:57:48 -0400
Received: by mail-ig0-f178.google.com with SMTP id bi2so75345178igb.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3GH8Ub315ALXFgzmpZk8QRGGT3wSujKBogoXPWxZeqU=;
        b=CSWKKcuf2YR6XVgSUQDQ5OyhhJeYm9Lsq4hg5ZMLcCkQw1yyn7GIJf19UGV3lx11By
         N2iY06qCLY43W7/beFy1P1jWUGU9bK9BNONYie7yns9a4AoAgAEWTaj1PHjsPcbAezAa
         g/05Mehh3tQMNiqBKyufpvZafvG/NhrfrqAtKI/eUyEnHXbDY8G8JiZWxGm/Y107tXbS
         tNsYxfAoc2N4tetyip2KweTotgPtXYQjHFAuExEaR9hwrBpqFjJvSurFQNFJlOw3WpQY
         4POXfREtRfWcFxhyfdO7Q1TPf6yPOq0AxeGIZ+A8rL1fF6cl9yjo1QAWNh+omiYDnsVJ
         C6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3GH8Ub315ALXFgzmpZk8QRGGT3wSujKBogoXPWxZeqU=;
        b=g7vizshND8UD/YurfJcAbR3z7CUbjnsXXzv8NoeyMk7MjRX07sJIlA8//AjW2RZydk
         wkobKRruqe7xScdTn/NEPbhez7EeTiGftCPNQem1dKRgLpHpk5ySRDA3qnv1yrx3shb9
         Rt6KFbfHt2aF+COKprWFyHdMeCjEUvCH1eIrW76ZT0Zts/7tp+JC+Z2skf1DL02/DswW
         sAstIRdc146sm0AEcw3jMt+l3Eb/2em3Oc0JBH4lomoBO1wuP+5Vv0rKyOwcCn1qZebj
         YfJQ3pqjA3+dNi71gvRlPsGzrUm/ZXXNZK3Tgf0Eg8cEY+IDPBgkQ5Co2tbWiflwLFRb
         WHXA==
X-Gm-Message-State: AOPr4FU3o6DKpdTwR+DJ0MmK4MQxV1IktN9WPP3tPWmf9odYs7sbuYqrW/JddrxePKqCcgt5cp2fIKHHIHEypF5U
X-Received: by 10.50.24.131 with SMTP id u3mr14583395igf.93.1461610667300;
 Mon, 25 Apr 2016 11:57:47 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 11:57:47 -0700 (PDT)
In-Reply-To: <1461504863-15946-10-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292545>

On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index ad81210..6c628f6 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -25,12 +25,15 @@ struct apply_state {
>         const char *prefix;
>         int prefix_length;
>
> +       /*
> +        *  --check turns on checking that the working tree matches the
> +        *    files that are being modified, but doesn't apply the patch

This is true, but at this part of the file/code we rather want to know what
`check` does, instead of what the command line option --check does.
(They are 2 different things, though one leading to the other one?) How about:

    /*
     * Only check the files to be modified, but do not modify the files.
     */


>  /*
> - *  --check turns on checking that the working tree matches the
> - *    files that are being modified, but doesn't apply the patch

Oh I see it was moved from here. Not sure if we want to rename
comments along the way or just keep it in this series.
