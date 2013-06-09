From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-remote-mediawiki: Fix a bug in a regexp
Date: Sun, 9 Jun 2013 01:11:45 -0400
Message-ID: <CAPig+cQ4Juwz0TOGzQjhGRZn8JofiYUG9xT9kJhoj5Z6yAMoGw@mail.gmail.com>
References: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 07:12:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlXvD-00030j-7b
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906Ab3FIFLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:11:49 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:43927 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab3FIFLs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 01:11:48 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so4848951lab.28
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8ErpvM04I7Ltj7aRlfGOr9vuOqKE3A2xlfqFLkmYk4I=;
        b=G/2PCFnlfjMm8ivHLYEO/8rTVdb+N8F/GkXo4FxfOR3L3f0ZAfBSxaL11oEgACgjkA
         7ndIckNkRaZCFScD7Y6eL0oPAUj0Z2q1HWTB2UHikkcEzC3wa1kyrxzhI3YSnR94MmdJ
         ER5/479uqE6+ON/GenewzmddC1Vqh7l8U2FHTHhDHNfONW+YKBz7PJy9ZLtm6DPlFAqq
         YgRG0+HAc0cA+XmEgHa3V2q7gUIJ7qAoszv1/W1VSw9bIs2NGItOSpVmwZCeF+I144Xo
         qX6KM01d/I6sJHipluBA/KYUiJoFfHsJhUg89Q6DuB82Xw6gRMGiSYC2mxTCy6CpWqys
         My9w==
X-Received: by 10.152.29.169 with SMTP id l9mr2479039lah.31.1370754705491;
 Sat, 08 Jun 2013 22:11:45 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sat, 8 Jun 2013 22:11:45 -0700 (PDT)
In-Reply-To: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: AqAllQhui3MXUHeE-Afga_E2jxc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226882>

On Sat, Jun 8, 2013 at 9:35 AM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> In Perl, '\n' is not a newline, but instead a literal backslash follo=
wed by an
> "n". As the output of "rev-list --first-parent" is line-oriented, wha=
t we want
> here is a newline.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 7af202f..a06bc31 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -1190,7 +1190,7 @@ sub mw_push_revision {
>                 # history (linearized with --first-parent)
>                 print STDERR "Warning: no common ancestor, pushing co=
mplete history\n";
>                 my $history =3D run_git("rev-list --first-parent --ch=
ildren $local");
> -               my @history =3D split('\n', $history);
> +               my @history =3D split(/\n/, $history);
>                 @history =3D @history[1..$#history];
>                 foreach my $line (reverse @history) {
>                         my @commit_info_split =3D split(/ |\n/, $line=
);

It would be quite acceptable to include this patch in your existing
patch series.
