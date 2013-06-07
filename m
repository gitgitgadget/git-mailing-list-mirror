From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/18] Put long code into a submodule
Date: Fri, 7 Jun 2013 00:01:38 -0400
Message-ID: <CAPig+cT+H2gqVjeBvR7iZ9mKz1+H1w7kt3htKOZxWHgkfq2mNA@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-11-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:01:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukns1-0007nL-VE
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737Ab3FGEBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 00:01:42 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:46369 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FGEBl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 00:01:41 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so3316399lab.32
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 21:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZMZMpGzdsAKNgLQZZUf1OnfTYKzwdSiwbK/3oAVLT/8=;
        b=hQNNkC1LY0gs++gOWH1VKqffGolNKHP2nKPVWQ4xPVA2qWcUKLg/fn9IkqSTp2KI57
         Ff20JEhjU6Xa8eInqUXqh8//C382pBSR7nBqUnAKzpQRpWwAZukCVtQjHZbUCC1MaczC
         2hN4sMZLpEqQTFJsz/fd9KTrS5/xxM4TXMcb3SdT2Iti2pSD4WQHymNxs1JXqOlZaL7V
         eMj91jOWA+41D6PKVR0NjBOMcN+0T/bht6/smGAq7lKqpBigA5/DjfmKw5i7CsOrBxzo
         n8+eHS6K7G5iPnkzR5yRn3sccxQJwHQGsh3diim80YWZEVOObUjVRNQZievjrFoyPBDj
         Tc6w==
X-Received: by 10.112.205.69 with SMTP id le5mr379390lbc.3.1370577698626; Thu,
 06 Jun 2013 21:01:38 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 21:01:38 -0700 (PDT)
In-Reply-To: <1370547263-13558-11-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: GQnLUO_xY9qsTWW5aW6-N9SxWZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226584>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   44 ++++++++++++++++-=
----------
>  1 file changed, 26 insertions(+), 18 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 1c34ada..1271527 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -133,24 +133,7 @@ while (<STDIN>) {
>         @cmd =3D split(/ /);
>         if (defined($cmd[0])) {
>                 # Line not blank
> -               if ($cmd[0] eq "capabilities") {
> -                       die("Too many arguments for capabilities\n") =
if (defined($cmd[1]));
> -                       mw_capabilities();
> -               } elsif ($cmd[0] eq "list") {
> -                       die("Too many arguments for list\n") if (defi=
ned($cmd[2]));
> -                       mw_list($cmd[1]);
> -               } elsif ($cmd[0] eq "import") {
> -                       die("Invalid arguments for import\n") if ($cm=
d[1] eq "" || defined($cmd[2]));
> -                       mw_import($cmd[1]);
> -               } elsif ($cmd[0] eq "option") {
> -                       die("Too many arguments for option\n") if ($c=
md[1] eq "" || $cmd[2] eq "" || defined($cmd[3]));
> -                       mw_option($cmd[1],$cmd[2]);
> -               } elsif ($cmd[0] eq "push") {
> -                       mw_push($cmd[1]);
> -               } else {
> -                       print STDERR "Unknown command. Aborting...\n"=
;
> -                       last;
> -               }
> +               parse_commands();
>         } else {
>                 # blank line: we should terminate
>                 last;
> @@ -168,6 +151,31 @@ sub exit_error_usage {
>      die "ERROR: git-remote-mediawiki module was not called with a co=
rrect number of parameters\n";
>  }
>
> +sub parse_commands {
> +       if ($cmd[0] eq "capabilities") {
> +               die("Too many arguments for capabilities\n")
> +                   if (defined($cmd[1]));
> +               mw_capabilities();
> +       } elsif ($cmd[0] eq "list") {
> +               die("Too many arguments for list\n") if (defined($cmd=
[2]));
> +               mw_list($cmd[1]);
> +       } elsif ($cmd[0] eq "import") {
> +               die("Invalid arguments for import\n")
> +                   if ($cmd[1] eq "" || defined($cmd[2]));
> +               mw_import($cmd[1]);
> +       } elsif ($cmd[0] eq "option") {
> +               die("Too many arguments for option\n")
> +                   if ($cmd[1] eq "" || $cmd[2] eq "" || defined($cm=
d[3]));
> +               mw_option($cmd[1],$cmd[2]);
> +       } elsif ($cmd[0] eq "push") {
> +               mw_push($cmd[1]);
> +       } else {
> +               print STDERR "Unknown command. Aborting...\n";
> +               last;

In the original code, 'last' lived directly in the enclosing 'while'
loop, but after this patch, it is inside parse_commands(). With 'use
warnings' enabled, you are going to see an "Exiting subroutine via
last" diagnostic.

> +       }
> +       return;
> +}
> +
>  # MediaWiki API instance, created lazily.
>  my $mediawiki;
