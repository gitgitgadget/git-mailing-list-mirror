From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] difftool: Disable --symlinks on cygwin
Date: Thu, 26 Jul 2012 13:31:05 +0200
Message-ID: <CABPQNSZ=yWxVivadJfh9BMPtqiiGyyEL0vZu+fvsu_Zzhd7yhw@mail.gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com> <1343186064-49350-4-git-send-email-davvid@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 13:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuMIK-00089P-MK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 13:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab2GZLbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 07:31:47 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38199 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab2GZLbq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 07:31:46 -0400
Received: by vcbfk26 with SMTP id fk26so1533689vcb.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=K48WN/xzvAHlO2sH5nIDJO/6vf8kTJXh4joUlrlt2Ck=;
        b=nRDm2gNg3sGKcOYz1gkioePS8qbLghQFxz0eglCNxaDXYva9IoQHkZaf4Phu0Y/TkC
         02NK/uQ5p05/EqdlEGhvUzgGre6faotwJ5gpg8FvzNGXb1omxPpjqwH1RMsDGueaNKDa
         unN5gA3OCmuBw/+O9ZbNcmb+RByRgaWI7LnQNQK3CPyYfWfzpSgxmucUUZbOL5cehQdM
         MqtcCFbp2qRQYEzhypm3Nf643Q68wB5P79RUh6CnYwCxLCYM7GjCpnfvR4rbFQjuD9ku
         etcnPuiVVaW32FBQUisFuEHa+H5liXODnZ3IagDyTiGkc6sI3fnlBevViFWbwCTOU100
         eZWw==
Received: by 10.52.90.52 with SMTP id bt20mr2187845vdb.42.1343302305821; Thu,
 26 Jul 2012 04:31:45 -0700 (PDT)
Received: by 10.58.35.207 with HTTP; Thu, 26 Jul 2012 04:31:05 -0700 (PDT)
In-Reply-To: <1343186064-49350-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202255>

On Wed, Jul 25, 2012 at 5:14 AM, David Aguilar <davvid@gmail.com> wrote:
> Symlinks are not ubiquitous on Windows so make --no-symlinks the default.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> I don't have cygwin so I can't verify this one myself.
> Is 'cygwin' really the value of $^O there?
>
>  git-difftool.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index 591ee75..10d3d97 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -291,7 +291,8 @@ sub main
>                 gui => undef,
>                 help => undef,
>                 prompt => undef,
> -               symlinks => $^O ne 'MSWin32' && $^O ne 'msys',
> +               symlinks => $^O ne 'cygwin' &&
> +                               $^O ne 'MSWin32' && $^O ne 'msys',

I thought Cygwin supported (their own version of) symlinks? What's the
rationale for not using it by default there?
