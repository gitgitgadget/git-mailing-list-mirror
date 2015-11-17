From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH] Optimize usage of grep by passing -q
Date: Tue, 17 Nov 2015 01:59:11 +0100
Message-ID: <CAHYJk3S-pBQGDk_PPXw5mgzuXhdKqifRB4Vwz1Nu0TecXz4JQg@mail.gmail.com>
References: <1447710209-13117-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyUc9-0001Ae-Dd
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbbKQA7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:59:13 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35835 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbbKQA7M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:59:12 -0500
Received: by qgec40 with SMTP id c40so62558422qge.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 16:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nU79AbweoygbB0Rnz5MStm3h3yoikikwz/HbKLfrj54=;
        b=F/27CUZJc0iGM1Z4HQycP1ibJ9gi9LqMk3zxwIFnhO762ItEVvNXeuba0oppWDMp7X
         33RxiHTA8PB1uurudgKxoYwyqbIGOSh9IMiy9U+cS7OonSCfd+eS6bYvmm5ZVpUrUB0r
         gtdSlGaGkr/1Av4MTTtkFp0pIzLdrLd7Na13F0oUNvNzehym3kHtgJBN82J2rpbV1x/F
         1Xmz98Fe+JlxJazS2QVyp2h1/d89BggSYXwPYSuCneiR5r4yS3F8ljI2h8l5tDQw2q3g
         Rxm8dzGpUlLrq0J5tCJHiS9HNjdSOcov1G4wSZwJBqGtQKFdDnexs8t2KsHonJUpnPWt
         Vsww==
X-Received: by 10.140.99.42 with SMTP id p39mr10209039qge.28.1447721951657;
 Mon, 16 Nov 2015 16:59:11 -0800 (PST)
Received: by 10.55.38.202 with HTTP; Mon, 16 Nov 2015 16:59:11 -0800 (PST)
In-Reply-To: <1447710209-13117-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281375>

On Mon, Nov 16, 2015 at 10:43 PM, Stefan Beller <sbeller@google.com> wrote:
> Instead of redirecting all grep output to /dev/null, we can just
> pass in -q instead. This preserves the exit code behavior, but is faster.
> As grep returns true if it finds at least one match, grep can exit promptly
> after finding the first line and doesn't need to find more occurrences
> which would be redirected to /dev/null anyways.
>
> This is true for the gnu version of grep. I am not sure if all
> versions of grep support this optimization. In case it is not,
> we'd revert this patch.

POSIX specifies -q, so you should be fine.
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

-- 
Mikael Magnusson
