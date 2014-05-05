From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Bump core.deltaBaseCacheLimit to 96m
Date: Mon, 5 May 2014 17:26:56 +0700
Message-ID: <CACsJy8BG8fRPk74R_-YABCGMn-YwbDcLHtjUNX7KE66jX1mR4A@mail.gmail.com>
References: <1399223637-29964-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue May 06 18:52:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhhxJ-0005Yp-5N
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbaEEK12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 06:27:28 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:61064 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756086AbaEEK11 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 06:27:27 -0400
Received: by mail-qa0-f52.google.com with SMTP id cm18so5966994qab.11
        for <git@vger.kernel.org>; Mon, 05 May 2014 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tOOn/M6gE2/6tXHdOfbF5kiUWMsVsL6h2TAhOSgxbzw=;
        b=X/lAwXFyfnHRYPG6meUrYgBQFbYgaLYLTOR8q3FqIExjYV8EbxLI/7VpmcnqhLD6g6
         DNgot8+As8hJr+UECXZpJtmYcBJ87ZcDxOCwpoWANdpOBBoJN2rcfrLeNnyhQS8gLfjz
         CJ/soUaAn4o7Myu1iypiP+zWOid+HJQ/JLIUPnf+Hmc+5P4VIJVOxxKQh9pRSAUvnMEg
         OvJ/60TwHttibe8bMiL+eg9m9YdYo5MP+HgFPOT84bgpSI3UyQ4VpObKQeiy1oGjaHDc
         L45luXQjj/cwwK7eMrQvYXAlZ4qp1Kt+jHvWC8ibs+mwW5kypIeaRdzBs9/IfdYU9xaA
         pUpA==
X-Received: by 10.140.91.161 with SMTP id z30mr40094627qgd.65.1399285647057;
 Mon, 05 May 2014 03:27:27 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 5 May 2014 03:26:56 -0700 (PDT)
In-Reply-To: <1399223637-29964-1-git-send-email-dak@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248157>

On Mon, May 5, 2014 at 12:13 AM, David Kastrup <dak@gnu.org> wrote:
> The default of 16m causes serious thrashing for large delta chains
> combined with large files.
>
> Here are some benchmarks (pu variant of git blame):
>
> time git blame -C src/xdisp.c >/dev/null

...

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1932e9b..21a3c86 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -489,7 +489,7 @@ core.deltaBaseCacheLimit::
>         to avoid unpacking and decompressing frequently used base
>         objects multiple times.
>  +
> -Default is 16 MiB on all platforms.  This should be reasonable
> +Default is 96 MiB on all platforms.  This should be reasonable
>  for all users/operating systems, except on the largest projects.
>  You probably do not need to adjust this value.

So emacs.git falls exactly into the "except on the largest projects"
part. Would it make more sense to advise git devs to set this per repo
instead? The majority of (open source) repositories out there are
small if I'm not mistaken. Of those few big repos, we could have a
section listing all the tips and tricks to tune git. This is one of
them. Index v4 and sparse checkout are some other. In future, maybe
watchman support, split index and untracked cache as well.
-- 
Duy
