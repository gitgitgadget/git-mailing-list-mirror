Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1661F424
	for <e@80x24.org>; Sun, 22 Apr 2018 15:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755297AbeDVPQI (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 11:16:08 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:14871 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753567AbeDVPQE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 11:16:04 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id AGief23LV4ZqzAGieflOhK; Sun, 22 Apr 2018 16:16:02 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=E/fjW5Vl c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=BCjA09oAAAAA:8
 a=0zTjWcKL_tudQvJF1igA:9 a=wPNLvfGTeEIA:10 a=jYKBPJSq9nmHKCndOPe9:22
Message-ID: <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <johannes.schindelin@gmx.de>,
        <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>,
        "Jakub Narebski" <jnareb@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Christian Couder" <christian.couder@gmail.com>
References: <cover.1524125760.git.johannes.schindelin@gmx.de> <cover.1524262793.git.johannes.schindelin@gmx.de> <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 09/11] technical/shallow: describe the relationship with replace refs
Date:   Sun, 22 Apr 2018 16:16:05 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180422-0, 22/04/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfGsD86sZDeK74oyiv59a3Vlph4snlstcVUaoZtbMZCxaIjQR1KsaqjkniUfWSMIXIgvLRU+pmdkbtQwz7HjmuAleeRmx85Zz80pat4hR8kxZ0i8YLVRD
 8fyZfvO+jrZxMJb7jFldkH7V3zODLcxDtL9+cWs6XSCYCIEeVxzEVeKFapZyONTZivrhaAD9/Qh3KCJZoVPzjQG5T2pR9/SeaOVpqIuC0OlHLbJbXwD8wSIY
 aybrWoXWJQPFsNKa3x8nhBJdeMdIEMWq7T6YVOty4EaOZeddxZ1wYttoAP711uydRJwFpMVPHgGnsh8VW3qz4NXrEECoFibOKUQ1h38PY2B2s9cdljTx/eIw
 pOcq7qnbxhfmHIztYxR6sM0f5vyuxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> Now that grafts are deprecated, we should start to assume that readers
> have no idea what grafts are. So it makes more sense to describe the
> "shallow" feature in terms of replace refs.
>
> Suggested-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Documentation/technical/shallow.txt | 19 +++++++++++--------
> 1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/technical/shallow.txt 
> b/Documentation/technical/shallow.txt
> index 5183b154229..b3ff23c25f6 100644
> --- a/Documentation/technical/shallow.txt
> +++ b/Documentation/technical/shallow.txt
> @@ -9,14 +9,17 @@ these commits have no parents.
> *********************************************************
>
> The basic idea is to write the SHA-1s of shallow commits into
> -$GIT_DIR/shallow, and handle its contents like the contents
> -of $GIT_DIR/info/grafts (with the difference that shallow
> -cannot contain parent information).
> -
> -This information is stored in a new file instead of grafts, or
> -even the config, since the user should not touch that file
> -at all (even throughout development of the shallow clone, it
> -was never manually edited!).
> +$GIT_DIR/shallow, and handle its contents similar to replace
> +refs (with the difference that shallow does not actually
> +create those replace refs) and

If grafts are deprecated, why not alse get rid of this mention and simply 
leave the 'what it does' part.

>                                               very much like the 
> deprecated
> +graft file (with

>                           the difference that shallow commits will
> +always have their parents grafted away, not replaced by
s/their parents grafted away/no parents/ (rather than being replaced..)

> +different parents).
> +
> +This information is stored in a special-purpose file because the
> +user should not touch that file at all (even throughout
> +development of the shallow clone, it was never manually
> +edited!).
>
> Each line contains exactly one SHA-1. When read, a commit_graft
> will be constructed, which has nr_parent < 0 to make it easier
> -- 
> 2.17.0.windows.1.15.gaa56ade3205
>
>
> 

