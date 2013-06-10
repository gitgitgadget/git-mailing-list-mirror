From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 22/28] git-remote-mediawiki: Modify strings for a
 better coding-style
Date: Sun, 9 Jun 2013 20:50:40 -0400
Message-ID: <CAPig+cQWQ842-ZG3_JQxZ=-2qLPpijx9z3vtXns+G3xxp6PsyQ@mail.gmail.com>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr>
	<1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, benoit.person@ensimag.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 02:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlqJt-0001iE-8w
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 02:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab3FJAup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 20:50:45 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35996 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab3FJAun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 20:50:43 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so5197645lab.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qeb7ayeZ+HezJzMXi9DqXoHWDNDpgl15K9t5U3xx0Ns=;
        b=HjKBYj5+AzcE6N2pKlNrDLnOEI8SGIM22qIY3dK1tvxuHhFIJO+lBEyEmTj1V79jPy
         Q0fKT0ds4rOSFvaphnQRbpfcrlnZfym3YEdgvTY3I20dmsaSLptpRP9sh3aEDa3z8m0t
         4/o6ga+MZwjwMVPJnZcrv5HmQdiu6bhzkAoFuDLtSK8G07I0i6njjkUzY7USDDaFJWLi
         D+0iWJAckXwokg+kBTyC1PYSAAyl7zQbOqpAyRXSPCss9ehx8FQLZwCxAmG5oEDifa/a
         bQzoyR6/TEris9XmM0vzRJC8Yd7TJwysOAmMO1f89xSIkim4ZjnuERmb3t1lZwr5/8XB
         SPiw==
X-Received: by 10.112.204.231 with SMTP id lb7mr5198807lbc.4.1370825440230;
 Sun, 09 Jun 2013 17:50:40 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 17:50:40 -0700 (PDT)
In-Reply-To: <1370816573-3808-23-git-send-email-celestin.matte@ensimag.fr>
X-Google-Sender-Auth: lNtjUxjVPQOriSGiIpS2lo3uA6U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227220>

On Sun, Jun 9, 2013 at 6:22 PM, C=E9lestin Matte
<celestin.matte@ensimag.fr> wrote:
> - strings which don't need interpolation are single-quoted for more c=
larity and
> slight gain of performance
> - interpolation is preferred over concatenation in many cases, for mo=
re clarity
> - variables are always used with the ${} operator inside strings
> - strings including double-quotes are written with qq() so that the q=
uotes do
> not have to be escaped
> ---
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw=
-to-git/git-remote-mediawiki.perl
> index a66cef4..efc376a 100755
> --- a/contrib/mw-to-git/git-remote-mediawiki.perl
> +++ b/contrib/mw-to-git/git-remote-mediawiki.perl
> @@ -200,10 +200,10 @@ sub mw_connect_maybe {
>                                lgdomain =3D> $wiki_domain};
>                 if ($mediawiki->login($request)) {
>                         Git::credential \%credential, 'approve';
> -                       print STDERR "Logged in mediawiki user \"$cre=
dential{username}\".\n";
> +                       print STDERR qq(Logged in mediawiki user "$cr=
edential{username}".\n);

Given this patch's intention to use ${} within strings, should this be
${credential{username}}?

(I don't have a preference, but it's a genuine question since it's not
clear if this was an oversight or intentional.)

>                 } else {
> -                       print STDERR "Failed to log in mediawiki user=
 \"$credential{username}\" on $url\n";
> -                       print STDERR "  (error " .
> +                       print STDERR qq(Failed to log in mediawiki us=
er "$credential{username}" on ${url}\n);

Ditto: ${credential{username}}

> +                       print STDERR '  (error ' .
>                                 $mediawiki->{error}->{code} . ': ' .
>                                 $mediawiki->{error}->{details} . ")\n=
";
>                         Git::credential \%credential, 'reject';
> @@ -347,10 +347,10 @@ sub get_mw_pages {
>  #        $out =3D run_git("command args", "raw"); # don't interpret =
output as UTF-8.
>  sub run_git {
>         my $args =3D shift;
> -       my $encoding =3D (shift || "encoding(UTF-8)");
> -       open(my $git, "-|:$encoding", "git " . $args)
> -           or die "Unable to open: $!\n";
> -       my $res =3D do {
> +       my $encoding =3D (shift || 'encoding(UTF-8)');
> +       open(my $git, "-|:${encoding}", "git ${args}")
> +           or die "Unable to fork: $!\n";
> +       my $res =3D do {

The whitespace-only change to line "my $res =3D do {" is effectively
noise. The reviewer has to stop and puzzle out what changed on the
line before continuing with review of the remaining _real_ changes. It
is a good idea to avoid noise changes if possible.

In this particular case, it's easy to avoid the noise since the
trailing space on that line could/should have been removed in patch
18/28 when the statement was split over multiple lines.

>                 local $/ =3D undef;
>                 <$git>
>         };
> @@ -475,26 +475,26 @@ sub download_mw_mediafile {
>                 return $response->decoded_content;
>         } else {
>                 print STDERR "Error downloading mediafile from :\n";
> -               print STDERR "URL: $download_url\n";
> -               print STDERR "Server response: " . $response->code . =
" " . $response->message . "\n";
> +               print STDERR "URL: ${download_url}\n";
> +               print STDERR 'Server response: ' . $response->code . =
q{ } . $response->message . "\n";

To meet the goals of this patch, would you want to do this instead?

    "Server response: @{[$response->code]} @{[$response->message]}\n";

Whether this is easier or more difficult to read is a matter of
opinion. (Again, this is a genuine question rather than a show of
preference on my part.)

>                 exit 1;
>         }
>  }
> @@ -691,8 +691,7 @@ sub fetch_mw_revisions {
>         my $n =3D 1;
>         foreach my $page (@pages) {
>                 my $id =3D $page->{pageid};
> -
> -               print STDERR "page $n/", scalar(@pages), ": ". $page-=
>{title} ."\n";
> +               print STDERR "page ${n}/", scalar(@pages), ': ', $pag=
e->{title}, "\n";

Similarly:

  "page ${n}/@{[scalar(@pages)]}: @{[$page->{title}]}\n"

>                 $n++;
>                 my @page_revs =3D fetch_mw_revisions_for_page($page, =
$id, $fetch_from);
>                 @revisions =3D (@page_revs, @revisions);
> @@ -706,7 +705,7 @@ sub fe_escape_path {
>         }
> -       print STDOUT "N inline :$n\n";
> -       literal_data("mediawiki_revision: " . $commit{mw_revision});
> +       print STDOUT "N inline :${n}\n";
> +       literal_data("mediawiki_revision: $commit{mw_revision}");

As questioned earlier, do you want ${commit{mw_revision}}?

>         print STDOUT "\n\n";
>         return;
>  }
> @@ -911,8 +910,8 @@ sub mw_import_revids {
>                 my $page_title =3D $result_page->{title};
>
>                 if (!exists($pages->{$page_title})) {
> -                       print STDERR "$n/", scalar(@$revision_ids),
> -                               ": Skipping revision #$rev->{revid} o=
f $page_title\n";
> +                       print STDERR "${n}/", scalar(@$revision_ids),
> +                               ": Skipping revision #$rev->{revid} o=
f ${page_title}\n";

Same question as above regarding formatting via "@{[...]}".

>                         next;
>                 }
>
> @@ -937,14 +936,14 @@ sub mw_import_revids {
>                 # If this is a revision of the media page for new ver=
sion
>                 # of a file do one common commit for both file and me=
dia page.
>                 # Else do commit only for that page.
> -               print STDERR "$n/", scalar(@$revision_ids), ": Revisi=
on #$rev->{revid} of $commit{title}\n";
> +               print STDERR "${n}/", scalar(@$revision_ids), ": Revi=
sion #$rev->{revid} of $commit{title}\n";

Ditto.

>                 import_file_revision(\%commit, ($fetch_from =3D=3D 1)=
, $n_actual, \%mediafile);
>         }
