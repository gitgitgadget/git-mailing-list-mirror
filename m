From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 14/22] git-remote-mediawiki: Check return value of open
 + remove import of unused open2
Date: Fri, 7 Jun 2013 20:14:42 -0400
Message-ID: <CAPig+cQHPjjpt_JYHjua6VWzTjTFog9VzhpD0hOLKSPCrEnEdg@mail.gmail.com>
References: <1370641344-4253-1-git-send-email-celestin.matte@ensimag.fr>
	<1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Sat Jun 08 02:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul6ny-00025X-47
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 02:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929Ab3FHAOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 20:14:46 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:56860 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726Ab3FHAOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 20:14:45 -0400
Received: by mail-la0-f50.google.com with SMTP id dy20so1994510lab.9
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2rb+FRmc4QX697gizhWKAO1b29RTKRtVD0zqBDW69SI=;
        b=bohxTMqxArCPY43qwSDwrTRxGRV44Gtl+ufncfvGOJMoWlgJ0csnexdzE/u/U23E4r
         NhEfCDaEsYCxrql0IcPded3eqgOatG2RDSmp/Z3oO+kYPE61Y8yAuH6txthGSPMNr6dX
         +4PDF33jZ2KRjoYcfyQkoXTTQWRD4YQe8r5zOYg27yIjwts2SJQtBF4OS8H2N9EdVKI+
         3MqJTEjhFkxuxMPS3fM2Zpno6/7FhyTjmtQl3p5ScguxDGhgN/ulHOL5tUdrYWKD+mU4
         9ssg+DzCAU65iARL8atCqSICYTRQLwb/+c2U/+fKWVV/MmYeKBCjfCrTh6mpuqP3GFCI
         SruQ==
X-Received: by 10.112.19.162 with SMTP id g2mr2266840lbe.9.1370650482288; Fri,
 07 Jun 2013 17:14:42 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Fri, 7 Jun 2013 17:14:42 -0700 (PDT)
In-Reply-To: <1370641344-4253-15-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: y4wMnvelZUxFaEoaC_Xcdm2jlWU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226769>

On Fri, Jun 7, 2013 at 5:42 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index ae6dd2e..1c34ada 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -22,7 +22,6 @@ binmode STDERR, ":encoding(UTF-8)";
>  binmode STDOUT, ":encoding(UTF-8)";
>
>  use URI::Escape;
> -use IPC::Open2;
>  use Readonly;
>
>  # Mediawiki filenames can contain forward slashes. This variable dec=
ides by which pattern they should be replaced
> @@ -338,7 +337,8 @@ sub get_mw_pages {
>  sub run_git {
>         my $args =3D shift;
>         my $encoding =3D (shift || "encoding(UTF-8)");
> -       open(my $git, "-|:$encoding", "git " . $args);
> +       open(my $git, "-|:$encoding", "git " . $args)
> +           or die "Unable to open: $!\n";
>         my $res =3D do {
>                 local $/ =3D undef;
>                 <$git>

These two changes are unrelated and could be split into distinct
patches (IMHO, though others may disagree).
