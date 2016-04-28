From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/5] t5550: break submodule config test into multiple sub-tests
Date: Thu, 28 Apr 2016 08:21:21 -0700
Message-ID: <CAGZ79kacgJ_=C-Y=QkSDmvEvCrmEbcvdMkg0x76zkj-Y86m4=g@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net>
	<20160428133704.GB25319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:21:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnl1-0001qo-MJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbcD1PV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:21:28 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37298 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbcD1PVY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:21:24 -0400
Received: by mail-ig0-f173.google.com with SMTP id s8so23748052ign.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=uQio5W8WYR9bRkyLCIpq4CjzLZnvIP0K4fGv8hB2y4g=;
        b=lKJhSaNR/Txg/Um05JtCdrbCuScJKTq474ghIvmoMOO49z1dgpjK5K/s5mi+8B3cBN
         x/LwWlxUKsUYsMpkx2nU+D1u+32EgtumhwTs5fkRQ3Ng9QAP16ImYz+ujUANuVQH+IRl
         VsyytPRJS/3e+hrx6O+WxkZM/sx9ib9+5TiXu1HtQIk1dqYUblsrz0b0ZyG+HYsWplxN
         WSXxOmUcmKzWaHWvFfjaLflIqqBiT3/W13CfPlR7k6/QE8FkmsBuC8gLTar7KDdXOOrt
         bA0wI6yZm6U2KxctMySHrCPYecQYRi5KgBtILT3Z5/mo+67Ab6/pPv0Y2pSNRux49yp2
         eYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uQio5W8WYR9bRkyLCIpq4CjzLZnvIP0K4fGv8hB2y4g=;
        b=TP8qTniWzQNpm5ehvjxTY4iYrjEqpMDI0wy8FF0z9Y7nU/34iZAUQwFO8IGC2GyDPr
         v1Xb3U0yLMvMMTmRfokUWwix5+cfjNhXWOTxYyWMljpg7+hYzYdKKrHng8hCYOE5BqOh
         lcoFARly8mPQWicqiDVQv3Pw0b3iz4OcTsGZ9++YyeJPKAzgT+aQbOjStzNDq84AOAdn
         BCeQt7NTLXE+vA8XvTK0WDo4obre1IspVbyEm9P2xIU7cA47B+7Hmfw/8ytTpylaSC2A
         umG8o7AJPdMWudtgPcF+UOIyUr8OVxyRTF3gs43EWRRk8ZURWDMYj2pCxBZ2LrGurIiD
         c0bw==
X-Gm-Message-State: AOPr4FVJcDqYZjdQxyKVKhP6jlenYAmgFZDQeg3AYQjK0Bl7U6NmQUuAUW+q76F3GoTUAunFmtDVLdzz4pJ/+ftZ
X-Received: by 10.50.24.131 with SMTP id u3mr18965036igf.93.1461856882006;
 Thu, 28 Apr 2016 08:21:22 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 28 Apr 2016 08:21:21 -0700 (PDT)
In-Reply-To: <20160428133704.GB25319@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292893>

On Thu, Apr 28, 2016 at 6:37 AM, Jeff King <peff@peff.net> wrote:
> Right now we test only the cloning case, but there are other
> interesting cases (e.g., fetching). Let's pull the setup
> bits into their own test, which will make things flow more
> logically once we start adding more tests which use the
> setup.
>
> Let's also introduce some whitespace to the clone-test to
> split the two parts: making sure it fails without our
> cmdline config, and that it succeeds with it.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5550-http-fetch-dumb.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index 81cc57f..e8e91bb 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -91,17 +91,21 @@ test_expect_success 'configured username does not override URL' '
>         expect_askpass pass user@host
>  '
>
> -test_expect_success 'cmdline credential config passes into submodules' '
> +test_expect_success 'set up repo with http submodules' '

set up or setup?

$ grep -r "set up" |wc -l
69
$ grep -r "setup" |wc -l
1162

Apart from that nit, this patch looks good to me.

>         git init super &&
>         set_askpass user@host pass@host &&
>         (
>                 cd super &&
>                 git submodule add "$HTTPD_URL/auth/dumb/repo.git" sub &&
>                 git commit -m "add submodule"
> -       ) &&
> +       )
> +'
> +
> +test_expect_success 'cmdline credential config passes to submodule via clone' '
>         set_askpass wrong pass@host &&
>         test_must_fail git clone --recursive super super-clone &&
>         rm -rf super-clone &&
> +
>         set_askpass wrong pass@host &&
>         git -c "credential.$HTTPD_URL.username=user@host" \
>                 clone --recursive super super-clone &&
> --
> 2.8.1.617.gbdccc2d
>
