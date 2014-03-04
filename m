From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] Setup.c: PATH_MAX is the length including the Nil
Date: Tue, 4 Mar 2014 22:19:27 +0530
Message-ID: <CAFbjVc=bt4NX2uAPx98YCqEh_gKY=KVsm1iFHU8N86aqKL3VoQ@mail.gmail.com>
References: <1393950550-9668-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Sun He <sunheehnus@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 17:49:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKsX8-0005aO-2d
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbaCDQt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 11:49:29 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:39741 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaCDQt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:49:29 -0500
Received: by mail-la0-f49.google.com with SMTP id mc6so5769526lab.36
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=XgOMdF5fPXbmjZchrVzFs/GipEfQFqnQlXQeE+MOsR4=;
        b=LenjBA6qI+CpBmEQeurvY8BVl6ArEPX4vnJqrN1ECHF0sD8LPH6WcRG3PJqm/URhY5
         tCBv64QonkhpKykf4Z6QRMNOIGpSpuGyqv4K6fLn6mQzmzxsWhHdT5CJSN2C0p/vY+F4
         Kdx0Gag/Y9ygy13HoxfLOUzv+PX6kP5x/OpVhlwg73qBybltKeBx5NncYTeG+Nwaw3B2
         4LWvg1OLTVNtBUBN+yYNrfZlZz8i/FCyn1AR1XMxns7lIbzvKS5FNkPes+XnSPxtJTJK
         IMFZ4nMJoW5pOPXG1IimGcmfufJ/8C7wmfyVBnZsaNX6EPzhv3eKN9f4VV7FFqd4aQUU
         x4xA==
X-Received: by 10.152.3.99 with SMTP id b3mr176639lab.61.1393951767771; Tue,
 04 Mar 2014 08:49:27 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Tue, 4 Mar 2014 08:49:27 -0800 (PST)
In-Reply-To: <1393950550-9668-1-git-send-email-sunheehnus@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243358>

On Tue, Mar 4, 2014 at 9:59 PM, Sun He <sunheehnus@gmail.com> wrote:
> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>
> Check the limit.h of linux and find out that the MACRO
> #define PATH_MAX        4096    /* # chars in a path name including nul */
> So if the magic number 40 is just the size it should be. (e.g. hash code)
> It may bring bugs with the length(4056) of long name(gitdirenv).
> As gitdirenv could be set by GIT_DIR_ENVIRONMENT.
> If it is a bug, it will almost never occur.
> But I need your help to know if there is the PATH_MAX of git is the mirror of the
> PATH_MAX of linux and if this fix is right?
> If it was, there may be many places like "PATH_MAX + 1" could be replaced by
> just "PATH_MAX". And there may be many places like this.
>
> Cheers,
> He Sun

Hi,
I am not getting what exactly you are trying to tell, but git defines
its own PATH_MAX.
Its defined in git-compat-util.h: #define PATH_MAX 4096
That is why instead of making buffers using PATH_MAX, use strbuf.
All these problems of buffer overflow will be gone.
I hope you are concerned about buffer overflow.

Cheers

-Faiz
