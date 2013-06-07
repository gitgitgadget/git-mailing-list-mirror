From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/18] Clearly rewrite double dereference
Date: Fri, 7 Jun 2013 00:04:39 -0400
Message-ID: <CAPig+cQdwO9dBr2xVC4z8=M6_ELJdLNhzZa5DUW-MCo6_gOAJA@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-19-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 06:04:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uknuw-0001SQ-04
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 06:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771Ab3FGEEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 00:04:42 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:54650 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FGEEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 00:04:41 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so3748209lbh.24
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 21:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=F0YonnK/k38v2IH8j913av/PBr5x7pkTUarQVjylAP4=;
        b=yD4baNAQEtn43D5iOoH/QMjidZKxtXhQRJIqA0xBdGeHsoe6YrPSUs4qRiujUNF1GS
         pOC+rmC25V1tjnXAPdlU3UmbhQYYcT4vLCDNppi1BiTI1wgjwr0HnFrxevf9o0ZcC/mM
         azSilXrxxhKm43JqWqZJe8wwN5Yrrfcx1/D0ftGtdMWTHD1qLSGUYu1gHFfK7dUeJQ7J
         1axxoLuZ4hXxxC89x3zr80VImF1B5nzVXcXtS4Zltvq8mtcDf+hKKsmeURTzKuNuTyT9
         3Onjur7HP7nLKxedITlNWADigUK9Ev7twVACojV7lkMsIhpm5IqnWX7NBBY20k3bJaXy
         VURg==
X-Received: by 10.112.19.162 with SMTP id g2mr381497lbe.9.1370577879664; Thu,
 06 Jun 2013 21:04:39 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 21:04:39 -0700 (PDT)
In-Reply-To: <1370547263-13558-19-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: wNigUQBDuTVqIhm9WBz_-jAIg-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226585>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> @$var structures are re-written in the following way: @{ $var }
> It makes them more readable.
>
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 20ddccb..06e6f4d 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -233,7 +233,7 @@ sub get_mw_tracked_pages {
>  sub get_mw_page_list {
>         my $page_list =3D shift;
>         my $pages =3D shift;
> -       my @some_pages =3D @$page_list;
> +       my @some_pages =3D @{ $page_list };

Minor style nit: Existing code in git-remote-mediawiki.perl does not
have whitespace inside @{}. It prefers @{$foo} rather than @{ $foo }.
This nit applies to this entire patch.

>         while (@some_pages) {
>                 my $last_page =3D $SLICE_SIZE;
>                 if ($#some_pages < $last_page) {
> @@ -733,7 +733,7 @@ sub import_file_revision {
>
>         print {*STDOUT} "commit refs/mediawiki/${remotename}/master\n=
";
>         print {*STDOUT} "mark :${n}\n";
> -       print {*STDOUT} "committer ${author} <${author}\@${wiki_name}=
> " . $date->epoch . " +0000\n";
> +       print {*STDOUT} "committer ${author} <${author}\@{ ${wiki_nam=
e} }> " . $date->epoch . " +0000\n";
>         literal_data($comment);
>
>         # If it's not a clone, we need to know where to start from
> @@ -759,7 +759,7 @@ sub import_file_revision {
>                 print {*STDOUT} "reset refs/notes/${remotename}/media=
wiki\n";
>         }
>         print {*STDOUT} "commit refs/notes/${remotename}/mediawiki\n"=
;
> -       print {*STDOUT} "committer ${author} <${author}\@${wiki_name}=
> " . $date->epoch . " +0000\n";
> +       print {*STDOUT} "committer ${author} <${author}\@{ ${wiki_nam=
e} }> " . $date->epoch . " +0000\n";
>         literal_data('Note added by git-mediawiki during import');
>         if (!$full_import && $n =3D=3D 1) {
>                 print {*STDOUT} "from refs/notes/${remotename}/mediaw=
iki^0\n";
> @@ -881,7 +881,7 @@ sub mw_import_revids {
>         my $n_actual =3D 0;
>         my $last_timestamp =3D 0; # Placeholer in case $rev->timestam=
p is undefined
>
> -       foreach my $pagerevid (@$revision_ids) {
> +       foreach my $pagerevid (@{ $revision_ids }) {
>                 # Count page even if we skip it, since we display
>                 # $n/$total and $total includes skipped pages.
>                 $n++;
> @@ -916,7 +916,7 @@ sub mw_import_revids {
>                 my $page_title =3D $result_page->{title};
>
>                 if (!exists($pages->{$page_title})) {
> -                       print {*STDERR} "${n}/", scalar(@$revision_id=
s),
> +                       print {*STDERR} "${n}/", scalar(@ { $revision=
_ids }),
>                                 ": Skipping revision #$rev->{revid} o=
f ${page_title}\n";
>                         next;
>                 }
> @@ -949,7 +949,7 @@ sub mw_import_revids {
>                 # If this is a revision of the media page for new ver=
sion
>                 # of a file do one common commit for both file and me=
dia page.
>                 # Else do commit only for that page.
> -               print {*STDERR} "${n}/", scalar(@$revision_ids), ": R=
evision #$rev->{revid} of $commit{title}\n";
> +               print {*STDERR} "${n}/", scalar(@{ $revision_ids }), =
": Revision #$rev->{revid} of $commit{title}\n";
>                 import_file_revision(\%commit, ($fetch_from =3D=3D 1)=
, $n_actual, \%mediafile);
>         }
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
