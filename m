From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: refactor of --progress option
Date: Sat, 31 Oct 2015 11:10:59 -0600
Message-ID: <CAOc6etasvk6f0XhJumwXtYiC7h_ufQUAyN1BktQ=qdd4_f0hSQ@mail.gmail.com>
References: <1446310669-9790-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:11:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsZgI-0005YC-CY
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbbJaRLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:11:00 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34988 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbbJaRK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:10:59 -0400
Received: by pasz6 with SMTP id z6so103941100pas.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gaLSvOJbY6gRaF4dXBlIxx3qBlhBGM/Yx3P2YWEEw20=;
        b=cddUHrMVV6X4nXR39JGuuPqkFKRadO2Kovggcrke2k+nOONWKpfFfH5hGWHOLgsYlF
         lRQibkE46UyHAy8NL3sUtmwPRNxkttgPS9Y+ws7hufawuOyuJNS7n1ABW178Ij1k/3bI
         csfZXUEOc+F1zyGGlQ/X1cFJdrCE3AL0AFpbKQWrkTABpfGF+LTNoJAEjivyBq8+RJDc
         jxmIJSLE3s84VIvKfbmErRfXRuqaixN/CUsovRHSWDKgb/baZJs5aYp98jqPtnPUQ7is
         gBvbxb7CAbplms1ms5sRiPN4CXqi+gv4Y/0+7S3+kF10Fu8AFcxWvZle/Owny00XfUJe
         B38w==
X-Received: by 10.66.124.165 with SMTP id mj5mr15708257pab.58.1446311459424;
 Sat, 31 Oct 2015 10:10:59 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Sat, 31 Oct 2015 10:10:59 -0700 (PDT)
In-Reply-To: <1446310669-9790-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280582>

On Sat, Oct 31, 2015 at 10:57 AM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> +       /*
> +        * Final processing of show_progress
> +        * Any of these 3 conditions will make progress output be skipped:
> +        * - selected --quiet
> +        * - selected --no-progress
> +        * - didn't select --progress and not working on a terminal
> +        */
> +       opts.show_progress = !opts.quiet && opts.show_progress &&
> +                            (opts.show_progress > 0 || isatty(2));
> +

I did a very small adjustment there from what I had sent yesterday.

It was (opts.show_progress >= 0 || isatty(2))

It was unnecessary to include the case of a 0 because it was discarded
by the second item on the outer short-circuited if:
opts_show_progress.

Let me know of your feedback and thanks.
