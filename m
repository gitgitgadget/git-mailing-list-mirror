From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 7/8] branch.c: use 'ref-filter' APIs
Date: Sat, 22 Aug 2015 17:51:42 +0200
Message-ID: <CAP8UFD3rXJqB1DEz5LfdM8xxanzoJp6J=weED+FygeZmufG4Sw@mail.gmail.com>
References: <1440226309-25415-1-git-send-email-Karthik.188@gmail.com>
	<1440226309-25415-8-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 17:51:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTB5J-0003xS-CU
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 17:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbHVPvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 11:51:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34908 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbbHVPvo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 11:51:44 -0400
Received: by lbcbn3 with SMTP id bn3so58831115lbc.2
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3ERcawUhGZ0HTQt274YuGnh5ixMb0bMTiUtMqaWKo/g=;
        b=BHCOmv4CMUrCigxuSSQGj/2zlwyU8izWiZ7TICXSvC8bpwohz3HlHxos3+4R/RwFKR
         Skv2TwlZupBOVEWe5eBCj+7jcLa++AwT4wJkCaHT9tC/UDMJWGKiQ43JVu7CtJUdvUjq
         LpZ3qGQoRHhLyrtsJVfsFqvNuBaCMZACdsxvxJ8UxRlvyAkSiGt1oCG/W4RPXfamz1SE
         Dqp3tavbFAX6LlWM9TiohTjjdr+O3Q+dzqp9lDhiuwkfVcPsBNXy/Vk19TKCG5eOh+KN
         RaVdqLUlweqOeDtYhMYIxdvAv2FJuYhGcLPZz5iMW3L3U5xx+B5guO6eMipHzzPgiHQy
         +JXA==
X-Received: by 10.112.85.204 with SMTP id j12mr12526674lbz.47.1440258702539;
 Sat, 22 Aug 2015 08:51:42 -0700 (PDT)
Received: by 10.112.21.168 with HTTP; Sat, 22 Aug 2015 08:51:42 -0700 (PDT)
In-Reply-To: <1440226309-25415-8-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276390>

On Sat, Aug 22, 2015 at 8:51 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> The test t1430 'git branch shows badly named ref' has been changed to
> check the stderr for the warning regarding the broken ref. This is
> done as ref-filter throws a warning for broken refs rather than
> directly printing them.

[...]

> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index 16d0b8b..db3627e 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -41,7 +41,7 @@ test_expect_success 'fast-import: fail on invalid branch name "bad[branch]name"'
>  test_expect_success 'git branch shows badly named ref' '
>         cp .git/refs/heads/master .git/refs/heads/broken...ref &&
>         test_when_finished "rm -f .git/refs/heads/broken...ref" &&
> -       git branch >output &&
> +       git branch 2>output &&
>         grep -e "broken\.\.\.ref" output
>  '

Maybe the test could be renamed to 'git branch warns about badly named
ref' and maybe you could also check that "broken\.\.\.ref" is not
printed on stdout.

Thanks,
Christian.
