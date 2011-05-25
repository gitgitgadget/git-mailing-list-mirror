From: Elazar Leibovich <elazarl@gmail.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 14:28:12 +0300
Message-ID: <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
	<SNT124-W39164C74A457129811245DC4740@phx.gbl>
	<BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
	<SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 13:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPCGC-00006m-5i
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 13:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1EYL2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 07:28:13 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46577 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1EYL2M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 07:28:12 -0400
Received: by yia27 with SMTP id 27so2974927yia.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 04:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VixspgI28vv5u1GaWuW7e7QiTNmATGmhrboydj5AOh4=;
        b=tmCSM9RaUzQjpsnq6dQVDo8kSq+bwbqfwL3gHZ+B1DcEwa3UkaBhg4gN4yxGgkYINW
         eqcy4oOZoIFAcaXnC4yTuqzgZZqkmB+3z8A6fSE9Va0zeddMdGN9QTKisOjUhPodSZ2i
         E+81wnSR12JlYLRi7NJnH5Ts4bM9UgGKvFVbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=o8fI9qR9jB8uCwSVrHAiT0JZX0HpqHmLiSGW7UG/rcKf8MVcnnbM/KA5+U75Q21Sz9
         f1t2HWB4Jo19/phRoQUQvO7YezpRsC+YEP6dRsFo6/vEgPYAqS9Y2f6cM59j54AXdzgK
         meW0d8kUFCUPLVWnnkMK17BJGesxYgx+81cY4=
Received: by 10.236.145.162 with SMTP id p22mr6374459yhj.160.1306322892156;
 Wed, 25 May 2011 04:28:12 -0700 (PDT)
Received: by 10.236.208.134 with HTTP; Wed, 25 May 2011 04:28:12 -0700 (PDT)
In-Reply-To: <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174385>

On Wed, May 25, 2011 at 2:21 PM, Tim Mazid <timmazid@hotmail.com> wrote:
>
> Well, personally, I've never used the --grep option. I pipe it through
> grep, where I can supply options such as -v.

But then you must use single-line commits output. Which is
inconvenient if you want to read all the commit message.

> However, if the --grep
> option already exists, then it does make sense to allow users to use
> options they would normally be able to with grep.
>
> As for the syntax, that seems like a good idea on the surface, but
> how would you go about supporting other grep options? Such as
> "-i"?

Now that I think of it, we already have the '--not' option for
revision specifiers. Why won't we use it for grep patterns? That way
-v will not be overloaded (it usually means verbose). For example

    git log --all --not --grep A --grep B

Would mean find all commits without A and with B, in SQL "SELECT *
FROM COMMITS WHERE message NOT LIKE '%A%'  AND message LIKE '%B%'".
