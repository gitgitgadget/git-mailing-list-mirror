Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A72320A40
	for <e@80x24.org>; Sat,  2 Dec 2017 17:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbdLBRLt (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 12:11:49 -0500
Received: from mail-yb0-f181.google.com ([209.85.213.181]:44622 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbdLBRLq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 12:11:46 -0500
Received: by mail-yb0-f181.google.com with SMTP id b188so5167186ybg.11
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 09:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bu0sln7xSIRbOHl1pYpLc0HRTDXowCVX7dtahjmAAoU=;
        b=q1eAzadt450A6j5zPKfyjAvowBY60gCLC5Za0wwVSaNYFvYKeHdptf1ZXtpK7W9eUn
         11dW54CH/Q8FB/+NMoY1KSCSnMJmoq3gXEkyab6u/qI9Lrf/xTS+ss4d/Eh4HeTrkBJ/
         7BwcVCsdPV+MPVVJO4ZcdwFDJmrL8zYwFXKQiU9D1TAEYY36q1BCEiQA95HvlpI6YHlD
         hEBoosOfRSuIrpQ8RbhTPKRnFE1TVS7vQORJ+AIZjWEM735qgAYWp5kbeAxSMNkORAqC
         hJIB06cv+cCKK58w2pEokQn1hZ4ZIp2qx7DBCNRjy1c40W87SG4a2dY45/v7/X8GL80+
         MWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bu0sln7xSIRbOHl1pYpLc0HRTDXowCVX7dtahjmAAoU=;
        b=JwNJk3TmGK4sS/N6qeBlmkREeKQwJGexpgk1O8fI4F5gclvU54e4TtPZo76kqEAFIq
         +EAkc9iXpq/FLOryoQEyuBtTDAAG64lM4FtiNt83rF/kCLr86MOoDnIr4EUC7MgWXzVU
         qTTmdZk1/8trVtFt2CdcyNxU9BYl4SpsG6YOManejLsQjj5PcK0F8vJv1RrRU9Ylb5Hx
         gAsxF6PdrrkZJFvJpv0/k0vhoBTBEywZgYydwGXyCMlJWiXpsQugiwy+397KQJPOWygg
         GNDGctrhFaUDXTrJm79G6BXZeElufML41fosLgIvVlFPS8+PI1/EuznZBsjizhpjNWQh
         7hGg==
X-Gm-Message-State: AJaThX4UbTHQx1Z+JtBP6wdtRQ80jAtq8hnogsBZ7+2dqdY8Gjl6G3SV
        0m1cDFA3IO68zvgUftUm+ppUhnJ8qLBkYT49OwXklw==
X-Google-Smtp-Source: AGs4zMa26UAM2aEjRCxIiF+ijHcP3Xu9DjY2RUIirPoy2h+wdmPL5yfJwYGVE2iM7zUNiRcFviNNPV6dRW7WpxcZIu8=
X-Received: by 10.37.124.71 with SMTP id x68mr6390609ybc.278.1512234705868;
 Sat, 02 Dec 2017 09:11:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.135.70 with HTTP; Sat, 2 Dec 2017 09:11:45 -0800 (PST)
In-Reply-To: <20171202170220.10073-1-second.payre@gmail.com>
References: <20171202170220.10073-1-second.payre@gmail.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Sat, 2 Dec 2017 18:11:45 +0100
Message-ID: <CAGb4CBUiOGUio=DY4Atm+4E=FqMn-aV3_vRCUKV_enjkUk4A_w@mail.gmail.com>
Subject: Re: [PATCH] send-email: extract email-parsing code into a subroutine
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Ryan Anderson <ryan@michonline.com>, e@80x24.org,
        Junio C Hamano <gitster@pobox.com>,
        Nathan Payre <second.payre@gmail.com>,
        Nathan Payre <nathan.payre@etu.univ-lyon1.fr>,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found a mistake in my signed-off-by, please replace
<nathan.payre@etu.univ-lyon1.fr.> by <second.payre@gmail.com>

Excuse me.

2017-12-02 18:02 GMT+01:00 Payre Nathan <second.payre@gmail.com>:
> From: Nathan Payre <second.payre@gmail.com>
>
> The existing code mixes parsing of email header with regular
> expression and actual code. Extract the parsing code into a new
> subroutine 'parse_header_line()'. This improves the code readability
> and make parse_header_line reusable in other place.
>
> Signed-off-by: Nathan Payre <nathan.payre@etu.univ-lyon1.fr>
> Signed-off-by: Matthieu Moy <matthieu.moy@univ-lyon1.fr>
> Signed-off-by: Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
> Signed-off-by: Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
> ---
>
> This patch is a first step to implement a new feature.
> See new feature discussion here: https://public-inbox.org/git/20171030223444.5052-1-nathan.payre@etu.univ-lyon1.fr/
>
>  git-send-email.perl | 106 +++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 80 insertions(+), 26 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 2208dcc21..98c2e461c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -715,41 +715,64 @@ EOT3
>         if (!defined $compose_encoding) {
>                 $compose_encoding = "UTF-8";
>         }
> -       while(<$c>) {
> +
> +       my %parsed_email;
> +       while (<$c>) {
>                 next if m/^GIT:/;
> -               if ($in_body) {
> -                       $summary_empty = 0 unless (/^\n$/);
> -               } elsif (/^\n$/) {
> -                       $in_body = 1;
> -                       if ($need_8bit_cte) {
> +               parse_header_line($_, \%parsed_email);
> +               if (/^\n$/i) {
> +                       while (my $row = <$c>) {
> +                               if (!($row =~ m/^GIT:/)) {
> +                                       $parsed_email{'body'} = $parsed_email{'body'} . $row;
> +                               }
> +                       }
> +               }
> +       }
> +       if ($parsed_email{'from'}) {
> +               $sender = $parsed_email{'from'};
> +       }
> +       if ($parsed_email{'in_reply_to'}) {
> +               $initial_reply_to = $parsed_email{'in_reply_to'};
> +       }
> +       if ($parsed_email{'subject'}) {
> +               $initial_subject = $parsed_email{'subject'};
> +               print $c2 "Subject: " .
> +                       quote_subject($parsed_email{'subject'}, $compose_encoding) .
> +                       "\n";
> +       }
> +       if ($parsed_email{'mime-version'}) {
> +               $need_8bit_cte = 0;
> +       }
> +       if ($need_8bit_cte) {
> +               if ($parsed_email{'content-type'}) {
> +                               print $c2 "MIME-Version: 1.0\n",
> +                                        "Content-Type: $parsed_email{'content-type'};",
> +                                        "Content-Transfer-Encoding: 8bit\n";
> +                       } else {
>                                 print $c2 "MIME-Version: 1.0\n",
>                                          "Content-Type: text/plain; ",
> -                                          "charset=$compose_encoding\n",
> +                                        "charset=$compose_encoding\n",
>                                          "Content-Transfer-Encoding: 8bit\n";
>                         }
> -               } elsif (/^MIME-Version:/i) {
> -                       $need_8bit_cte = 0;
> -               } elsif (/^Subject:\s*(.+)\s*$/i) {
> -                       $initial_subject = $1;
> -                       my $subject = $initial_subject;
> -                       $_ = "Subject: " .
> -                               quote_subject($subject, $compose_encoding) .
> -                               "\n";
> -               } elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> -                       $initial_reply_to = $1;
> -                       next;
> -               } elsif (/^From:\s*(.+)\s*$/i) {
> -                       $sender = $1;
> -                       next;
> -               } elsif (/^(?:To|Cc|Bcc):/i) {
> -                       print __("To/Cc/Bcc fields are not interpreted yet, they have been ignored\n");
> -                       next;
> -               }
> -               print $c2 $_;
>         }
> +       if ($parsed_email{'body'}) {
> +               $summary_empty = 0;
> +               print $c2 "\n$parsed_email{'body'}\n";
> +       }
> +
>         close $c;
>         close $c2;
>
> +       open $c2, "<", $compose_filename . ".final"
> +               or die sprintf(__("Failed to open %s.final: %s"), $compose_filename, $!);
> +
> +       print "affichage : \n";
> +       while (<$c2>) {
> +               print $_;
> +       }
> +
> +       close $c2;
> +
>         if ($summary_empty) {
>                 print __("Summary email is empty, skipping it\n");
>                 $compose = -1;
> @@ -792,6 +815,37 @@ sub ask {
>         return;
>  }
>
> +sub parse_header_line {
> +       my $lines = shift;
> +       my $parsed_line = shift;
> +
> +       foreach (split(/\n/, $lines)) {
> +               if (/^From:\s*(.+)$/i) {
> +                       $parsed_line->{'from'} = $1;
> +               } elsif (/^To:\s*(.+)$/i) {
> +                       $parsed_line->{'to'} = [ parse_address_line($1) ];
> +               } elsif (/^Cc:\s*(.+)$/i) {
> +                       $parsed_line->{'cc'} = [ parse_address_line($1) ];
> +               } elsif (/^Bcc:\s*(.+)$/i) {
> +                       $parsed_line->{'bcc'} = [ parse_address_line($1) ];
> +               } elsif (/^Subject:\s*(.+)\s*$/i) {
> +                       $parsed_line->{'subject'} = $1;
> +               } elsif (/^Date: (.*)/i) {
> +                       $parsed_line->{'date'} = $1;
> +               } elsif (/^In-Reply-To:\s*(.+)\s*$/i) {
> +                       $parsed_line->{'in_reply_to'} = $1;
> +               } elsif (/^Message-ID: (.*)$/i) {
> +                       $parsed_line->{'message_id'} = $1;
> +               } elsif (/^MIME-Version:$/i) {
> +                       $parsed_line->{'mime-version'} = $1;
> +               } elsif (/^Content-Type:\s+(.*)\s*$/i) {
> +                       $parsed_line->{'content-type'} = $1;
> +               } elsif (/^References:\s+(.*)/i) {
> +                       $parsed_line->{'references'} = $1;
> +               }
> +       }
> +}
> +
>  my %broken_encoding;
>
>  sub file_declares_8bit_cte {
> --
> 2.15.1
>
