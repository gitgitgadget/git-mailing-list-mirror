Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41836202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 19:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbdJ2Ttb (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 15:49:31 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:54722 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbdJ2Tta (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 15:49:30 -0400
Received: by mail-qt0-f170.google.com with SMTP id z19so13992142qtg.11
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DDyI63vevwn7aVqrT3Cp1psEgE9Q0ow00/OLxWxgBCA=;
        b=Ng42n6EJVlkngLHFdrQyHT2Z2k07NfA7dLMrVDLq/IJ8YMNw12i8vzr3SlAXA/7via
         JLTiXNmNTk8KQdMEWii+DGrTzaIjy+FJN9bsEhiOhX0HcIgDEZfo+24ekP1YLZORQWAq
         wqfEnvNCYFQkbPlmaRzkI9ngbBdj0Vt1FMl1IvIiiQTM4E8+bsQFirOEdVXsCdD98BZu
         mymrEePf5wUSwSj8woNAjQEXiPtcqgqwDcNOcp9Ab//gcrSLx7p9hHpB/yRIhZWq+LpZ
         bt9AciBvnJN47Dhd5PVmxVIP27S5OIpp55xeihSwlpzACGB/PhVdd/AM/EFQfjYDoPfZ
         TPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DDyI63vevwn7aVqrT3Cp1psEgE9Q0ow00/OLxWxgBCA=;
        b=c2ARIAlSdC6OoGh5QZcKWVfelYvh0yy1unlO8YI3nKvjRN7F4Sso+b79E5f+eCjViK
         P8g94tiMWYiynAddJ1BPKPkRJhKQqLA0s3tP4zz8d9iDTafNuH3KBIbFBN7DPdwoX/RN
         D4CnkljBzHrZPbLEW/WdiV7RIEp0u9PnjmQjyQaUO4UKg1nGF0aDytUoMP6WahV9FXWF
         n8xKF9aYWlz8OuE9/Vk/VBZCr93uecka/wTaxBm5dNqEVPT69noFCAFC+hIAXKkXpoLG
         7BekGPzoEPrOXezQSg5qO0+72/takhkQoOzssyYFe42OZGzfeIjToXLHdOQ/06pW3BFu
         LK9g==
X-Gm-Message-State: AMCzsaWL379Kq3gSxlBTpuW6+NLjwdC4lYY3cbeRzpOZaVYG9jkjwWEy
        vCUFbtheNcVjseRD1pBSP+DWJW9DJoO6s0jkGXA3og==
X-Google-Smtp-Source: ABhQp+SDDfbjvO3MkDIW2g4YWduBwhphkoEOG5OLJ+nTp6qnVFWBU0X00BlDqLyGVcnhmZNrqtcwzPCciC75/ssptOM=
X-Received: by 10.237.34.82 with SMTP id o18mr10330117qtc.19.1509306569331;
 Sun, 29 Oct 2017 12:49:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sun, 29 Oct 2017 12:49:28 -0700 (PDT)
In-Reply-To: <20171029160857.29460-5-anarcat@debian.org>
References: <20171029160857.29460-1-anarcat@debian.org> <20171029160857.29460-5-anarcat@debian.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 29 Oct 2017 15:49:28 -0400
X-Google-Sender-Auth: 1HT_WrY7m6dR1XaApAP6Y15fLrw
Message-ID: <CAPig+cSTp1Udo6xXk5-L6MpWBdiy4sPO__NcND03-89EvRgLHQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] remote-mediawiki: allow using (Main) as a namespace
 and skip special namespaces
To:     =?UTF-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 12:08 PM, Antoine Beaupr=C3=A9 <anarcat@debian.org>=
 wrote:
> Subject: remote-mediawiki: allow using (Main) as a namespace and skip spe=
cial namespaces

This patch is more difficult to review than it perhaps ought to be
since it is making multiple unrelated changes.

It's not clear from the description what special namespaces are and
why they need to be skipped. It's also not clear why (Main) is
special. Perhaps the commit message(s) could explain these issues in
more detail.

To simplify review and make it easier to gauge what it going on, it
might make sense to split this patch into at least two: one which
skips "special namespaces", and one which gives special treatment to
(Main).

More below...

> Reviewed-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> Signed-off-by: Antoine Beaupr=C3=A9 <anarcat@debian.org>
> ---
> diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-=
git/git-remote-mediawiki.perl
> @@ -264,16 +264,27 @@ sub get_mw_tracked_categories {
>  sub get_mw_tracked_namespaces {
>      my $pages =3D shift;
> -    foreach my $local_namespace (@tracked_namespaces) {
> -        my $mw_pages =3D $mediawiki->list( {
> -            action =3D> 'query',
> -            list =3D> 'allpages',
> -            apnamespace =3D> get_mw_namespace_id($local_namespace),
> -            aplimit =3D> 'max' } )
> -            || die $mediawiki->{error}->{code} . ': '
> -                . $mediawiki->{error}->{details} . "\n";
> -        foreach my $page (@{$mw_pages}) {
> -            $pages->{$page->{title}} =3D $page;
> +    foreach my $local_namespace (sort @tracked_namespaces) {
> +        my ($mw_pages, $namespace_id);
> +        if ($local_namespace eq "(Main)") {
> +            $namespace_id =3D 0;
> +        } else {
> +            $namespace_id =3D get_mw_namespace_id($local_namespace);
> +        }
> +        if ($namespace_id >=3D 0) {

This may be problematic since get_mw_namespace_id() may return undef
rather than a number, in which case Perl will complain. Since the code
skips the $mediawiki query altogether when it encounters "(Main)", you
could fix this problem and simplify the code overall by simply
skipping the bulk of the foreach loop body instead of mucking around
with $namespace_id. For instance:

    foreach my $local_namespace (sort @tracked_namespaces) {
        next if ($local_namespace eq "(Main)");
        ...normal processing...
    }

> +            if ($mw_pages =3D $mediawiki->list( {
> +                action =3D> 'query',
> +                list =3D> 'allpages',
> +                apnamespace =3D> $namespace_id,
> +                aplimit =3D> 'max' } )) {
> +                print {*STDERR} "$#{$mw_pages} found in namespace $local=
_namespace ($namespace_id)\n";

The original code did not emit this diagnostic but the new code does
so unconditionally. Is this just leftover debugging code or is
intended that all users should see this information all the time?

> +                foreach my $page (@{$mw_pages}) {
> +                    $pages->{$page->{title}} =3D $page;
> +                }
> +            } else {
> +                warn $mediawiki->{error}->{code} . ': '
> +                    . $mediawiki->{error}->{details} . "\n";

I guess this is the part which "skips special namespaces". The
original code die()'d but this merely warns. Aside from these "special
namespaces", are there genuine cases when the $mediawiki query would
return an error, and which should indeed die(), or is warning
appropriate for all $mediawiki query error cases?

> +            }
>          }
>      }
>      return;
