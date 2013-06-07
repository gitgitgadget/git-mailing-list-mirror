From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/18] Follow perlcritic's recommendations - level 5 and 4
Date: Thu, 6 Jun 2013 21:42:59 -0400
Message-ID: <CAPig+cTm0yXRdHgJR91qNwari08ZyZJjGTedGCqaO3zc3A06Ug@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-2-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 03:43:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uklhz-0007fw-St
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755558Ab3FGBnE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 21:43:04 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59369 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab3FGBnB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 21:43:01 -0400
Received: by mail-lb0-f174.google.com with SMTP id x10so1666578lbi.5
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 18:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RaalZcJGzdlrRbuz2beah5fthtAe7Rem3FBMoUUOwyU=;
        b=irE7u5/U6lQiOqpO585PuVAgVVhFdXsBgJXC36BzKdyaOCSSGX2LEGEw3fFswvhb7m
         +5dKfLKiHK91mISjSIrrzl4HSPnKlcKxe5kH3RRj3W+S+F0WbKznTACzSG11HExGZ49b
         nkg6XfFvB/kqfegJlQRBTfZFLNvO3kF4ArFcG96RBWVEFZGjOznU2Qk5F5zIxz67XORV
         Tl5zgAQcG2BfaYVs7tBnR8smD86dDHs21nGM5Qfka0cI6G0WVMWShTblK+UXElu0TgFe
         Qyknefxso8DrBxZO9vEHzPuRzrhwFqivCxPqNfTbpSWNTB7zxyLkbj4XKt5nSjzzZNPc
         zv9w==
X-Received: by 10.112.159.202 with SMTP id xe10mr164606lbb.52.1370569379236;
 Thu, 06 Jun 2013 18:42:59 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 18:42:59 -0700 (PDT)
In-Reply-To: <1370547263-13558-2-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: Y7t6ixYjjBF4bWFVJN1gRcuA7SY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226578>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Fix warnings from perlcritic's level 5 and 4. They correspond to the =
following
> cases:
> - always end a submodule with a return
> - don't use the constant pragma, use the Readonly module instead
> - some syntax details for maps, and others.

Although loosely related by being mentioned by perlcritic (4,5), each
bullet point is otherwise unrelated, and mixing such unrelated changes
into a single patch can make review more difficult.

> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   81 +++++++++++++++++=
----------
>  1 file changed, 51 insertions(+), 30 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 410eae9..83cf292 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -15,32 +15,32 @@ use strict;
>  use MediaWiki::API;
>  use Git;
>  use DateTime::Format::ISO8601;
> +use warnings;
>
>  # By default, use UTF-8 to communicate with Git and the user
> -binmode STDERR, ":utf8";
> -binmode STDOUT, ":utf8";
> +binmode STDERR, ":encoding(UTF-8)";
> +binmode STDOUT, ":encoding(UTF-8)";

This change isn't explained or rationalized in the commit message.

> @@ -96,6 +96,9 @@ unless ($fetch_strategy) {
>         $fetch_strategy =3D "by_page";
>  }
>
> +# Remember the timestamp corresponding to a revision id.
> +my %basetimestamps;

Although this is a simple textual relocation, it's not clear why it's
needed or preferable, and the commit message does not explain it.

> @@ -473,9 +486,6 @@ sub get_last_local_revision {
>         return $lastrevision_number;
>  }
>
> -# Remember the timestamp corresponding to a revision id.
> -my %basetimestamps;
> -
>  # Get the last remote revision without taking in account which pages=
 are
>  # tracked or not. This function makes a single request to the wiki t=
hus
>  # avoid a loop onto all tracked pages. This is useful for the fetch-=
by-rev
> @@ -555,7 +565,7 @@ sub mediawiki_smudge {
>
>  sub mediawiki_clean_filename {
>         my $filename =3D shift;
> -       $filename =3D~ s/@{[SLASH_REPLACEMENT]}/\//g;
> +       $filename =3D~ s{$SLASH_REPLACEMENT}{/}g;

Although patch 2/18 replaces regex // with {}, the change sneaked into
this patch (1/18) prematurely.

>         # [, ], |, {, and } are forbidden by MediaWiki, even URL-enco=
ded.
>         # Do a variant of URL-encoding, i.e. looks like URL-encoding,
>         # but with _ added to prevent MediaWiki from thinking this is
> @@ -569,7 +579,7 @@ sub mediawiki_clean_filename {
>
>  sub mediawiki_smudge_filename {
>         my $filename =3D shift;
> -       $filename =3D~ s/\//@{[SLASH_REPLACEMENT]}/g;
> +       $filename =3D~ s{/}{$SLASH_REPLACEMENT}g;

Ditto regarding // to {}.

>         $filename =3D~ s/ /_/g;
>         # Decode forbidden characters encoded in mediawiki_clean_file=
name
>         $filename =3D~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf("%c", he=
x($1))/ge;
> @@ -588,7 +599,8 @@ sub literal_data_raw {
>         utf8::downgrade($content);
>         binmode STDOUT, ":raw";
>         print STDOUT "data ", bytes::length($content), "\n", $content=
;
> -       binmode STDOUT, ":utf8";
> +       binmode STDOUT, ":encoding(UTF-8)";

Unexplained change.

> +       return;
> }
>
>  sub mw_capabilities {
> @@ -1314,7 +1334,8 @@ sub get_mw_namespace_id {
>  }
>
>  sub get_mw_namespace_id_for_page {
> -       if (my ($namespace) =3D $_[0] =3D~ /^([^:]*):/) {
> +       my $namespace =3D shift;
> +       if ($namespace =3D~ /^([^:]*):/) {

Another change not mentioned by the commit message.

>                 return get_mw_namespace_id($namespace);
>         } else {
>                 return;
> --
