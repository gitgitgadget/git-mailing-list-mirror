From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 13/18] Remove "unless" statements and replace them by
 negated "if" statements
Date: Thu, 6 Jun 2013 23:41:50 -0400
Message-ID: <CAPig+cT_ce0yB3QHVTK8LhkJ+V9Urv4P_Q1EBns2+_dHwChD9A@mail.gmail.com>
References: <1370547263-13558-1-git-send-email-celestin.matte@ensimag.fr>
	<1370547263-13558-14-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 05:41:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UknYr-0001XB-4R
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 05:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157Ab3FGDlx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 23:41:53 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:65110 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3FGDlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 23:41:52 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so3737111lbd.6
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GpzOZmtIRUKxp3Lyho8EGgXSaEN0dqi2qIupdgObUDA=;
        b=hcUr5htHHl2+a1VfoKaJJGFHRjTI3HX21lLenSU32UCFE0B67gNGHHygJmADuKO76Q
         SwBJfQ/Ci+nFa1820vNG23enzrFkr/GbHIwk7vLfKtGUlTZ8oBq0dVFsHe6An+17yRVK
         hyCsuV89NlwsaDf++Mu4+NdastjPhZwGa76QIvMWpgv0MimwS7TJVc4D2YDCSxYmX96y
         Si+Jc148rKTz11ohaBDwVJc3h33PqvZOMAAOUqLu87aLQBMJy++XYvNV1dmozQ/g7Qpv
         Y9lbEdH885439WeYiLnyPIh43xIP+5aKBMWeMNceddnrD+3MoO7NAnfQU9oVgovLWda+
         +g2w==
X-Received: by 10.152.1.230 with SMTP id 6mr19134427lap.21.1370576510856; Thu,
 06 Jun 2013 20:41:50 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 20:41:50 -0700 (PDT)
In-Reply-To: <1370547263-13558-14-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: UMKNg4oyDLinEzdowoPX3iUH-3g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226583>

On Thu, Jun 6, 2013 at 3:34 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> Signed-off-by: C=E9lestin Matte <celestin.matte@ensimag.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
>  contrib/mw-to-git/git-remote-mediawiki.perl |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index 757a7a3..b7a7012 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -87,11 +87,11 @@ $shallow_import =3D ($shallow_import eq 'true');
>  # - by_rev: perform one query per new revision on the remote wiki
>  # - by_page: query each tracked page for new revision
>  my $fetch_strategy =3D run_git("config --get remote.${remotename}.fe=
tchStrategy");
> -unless ($fetch_strategy) {
> +if (! $fetch_strategy) {

Minor style nit: Existing code in git-remote-mediawiki.perl does not
have whitespace following '!'. This nit applies to this entire patch,
so: s/! /!/g

>         $fetch_strategy =3D run_git('config --get mediawiki.fetchStra=
tegy');
>  }
>  chomp($fetch_strategy);
> -unless ($fetch_strategy) {
> +if (! $fetch_strategy) {
>         $fetch_strategy =3D 'by_page';
>  }
>
> @@ -113,7 +113,7 @@ my %basetimestamps;
>  # deterministic, this means everybody gets the same sha1 for each
>  # MediaWiki revision.
>  my $dumb_push =3D run_git("config --get --bool remote.${remotename}.=
dumbPush");
> -unless ($dumb_push) {
> +if (! $dumb_push) {
>         $dumb_push =3D run_git('config --get --bool mediawiki.dumbPus=
h');
>  }
>  chomp($dumb_push);
> @@ -668,7 +668,7 @@ sub fetch_mw_revisions_for_page {
>                         push(@page_revs, $page_rev_ids);
>                         $revnum++;
>                 }
> -               last unless $result->{'query-continue'};
> +               last if (! $result->{'query-continue'});
>                 $query->{rvstartid} =3D $result->{'query-continue'}->=
{revisions}->{rvstartid};
>         }
>         if ($shallow_import && @page_revs) {
> @@ -1240,7 +1240,7 @@ sub mw_push_revision {
>                                 die("Unknown error from mw_push_file(=
)\n");
>                         }
>                 }
> -               unless ($dumb_push) {
> +               if (! $dumb_push) {
>                         run_git(qq(notes --ref=3D${remotename}/mediaw=
iki add -f -m "mediawiki_revision: ${mw_revision}" ${sha1_commit}));
>                         run_git(qq(update-ref -m "Git-MediaWiki push"=
 refs/mediawiki/${remotename}/master ${sha1_commit} ${sha1_child}));
>                 }
> @@ -1320,7 +1320,7 @@ sub get_mw_namespace_id {
>         my $ns =3D $namespace_id{$name};
>         my $id;
>
> -       unless (defined $ns) {
> +       if (! defined $ns) {
>                 print {*STDERR} "No such namespace ${name} on MediaWi=
ki.\n";
>                 $ns =3D {is_namespace =3D> 0};
>                 $namespace_id{$name} =3D $ns;
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
