From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/4] drop some obsolete "x = x" compiler warning hacks
Date: Thu, 21 Mar 2013 16:16:00 +0100
Message-ID: <CABPQNSadzAFqJq8=zi36BdL9Qcoi-WsoEj0yhdAZ4GvvkyHfVQ@mail.gmail.com>
References: <20130321110338.GA18552@sigill.intra.peff.net> <20130321111028.GC18819@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 21 16:17:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIhEr-0003Ka-6l
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 16:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3CUPQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 11:16:41 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:48144 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab3CUPQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 11:16:41 -0400
Received: by mail-ia0-f169.google.com with SMTP id j5so2610217iaf.28
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 08:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=+cw7vfzNT+YCoJycFhDghrqCZbek0F+645EZnJ/X7UA=;
        b=ot/hBkzDbBLI057jKfmyvW5emnNlhsINf+DUC+Dstnas0MR43YACvCoIWssgS44D8Z
         fuTNI7kl9JA2Zl+sqKOMvNU6t+UpRESRFejDWFpGoBl1bHjCUcxMt1mEl5IparnjX0tL
         x7d+JRkS7NSeuo4kKqfasvDNByzrH82Ltoi7GOrzPKI5RNNZEoB6InppS4f5x2NwJdIQ
         ryFdfJuZ0VFE00iGMKXKf+TkI6SOquRy5uqvj/iIOJ3wCeE0VLPHPlh8h4QadYjjwMCo
         XtxhKTDRgpZwE/dZdEb3vBValHHQvwe8eM2KIA1n791UoRaZI9gD0sGFkZBWf5u6mL8n
         O5lw==
X-Received: by 10.42.215.196 with SMTP id hf4mr16123759icb.23.1363879000563;
 Thu, 21 Mar 2013 08:16:40 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Thu, 21 Mar 2013 08:16:00 -0700 (PDT)
In-Reply-To: <20130321111028.GC18819@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218733>

On Thu, Mar 21, 2013 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> In cases where the setting and access of a variable are
> protected by the same conditional flag, older versions of
> gcc would generate a "might be used unitialized" warning. We
> silence the warning by initializing the variable to itself,
> a hack that gcc recognizes.
>
> Modern versions of gcc are smart enough to get this right,
> going back to at least version 4.3.5. gcc 4.1 does get it
> wrong in both cases, but is sufficiently old that we
> probably don't need to care about it anymore.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> gcc 4.2 is conspicuously missing because no current Debian system even
> has a backwards-compatibility package for it, making it harder to test.
> And 4.3 was old enough for me to say "I do not care if you can run with
> -Wall -Werror or not", let alone 4.2.

Just a data-point. This is the version we use in msysGit:

$ gcc --version
gcc.exe (TDM-1 mingw32) 4.4.0

So yeah, it's not going to increase false positives here, I guess.
