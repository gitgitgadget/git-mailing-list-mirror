Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A9C2055E
	for <e@80x24.org>; Sat, 28 Oct 2017 17:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdJ1RhS (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 13:37:18 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:39121 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdJ1RhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 13:37:17 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 8V2peRJXU3CyH8V2perSBi; Sat, 28 Oct 2017 18:37:16 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Zo+dE5zG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=2wRI5O-rPnk49kq2GYAA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=wPNLvfGTeEIA:10
Message-ID: <3655514352684AD398D17E83FF47F986@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Sergey Organov" <sorganov@gmail.com>, <git@vger.kernel.org>
References: <87wp3g61ez.fsf@javad.com>
Subject: Re: How to re-merge paths differently?
Date:   Sat, 28 Oct 2017 18:37:14 +0100
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
X-Antivirus: AVG (VPS 171028-0, 28/10/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfCRYq/7/pm1h8+73dNd7JliYKSCSZ/beKG4cXWrtzfUALPX0sHnhOrU7/jNemkbM/KQcnHLfW6L0nVMFhfx+xpxe2bj/HfAiyIFgeYPyoep82uoIcnfY
 gvDC1WmGjkdMZZR1s4E8TNYkZMHKAbvnfydkkf3I1B0UvpFuOBANA89xadcS4eOWYGcnJJxfdaTQPT+TR+en5DxaAJO7IB+gmT8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Sergey Organov" <sorganov@gmail.com>
> Is there anything like this:
>
> $ git merge b
> [... lot of conflicts ...]
> $ git re-merge -X ours -- x/   # Leaves 0 conflicts in x/
> $ git re-merge -X theirs -- y/ # Leaves 0 conflicts in y/
> [... resolve the rest of conflicts manually ...]
> $ git commit
>
> [*] I do mean '-X' above, not '-s'.
>

By this I presume you mean that you have paths x and y that ate the ones 
with conflicts within them following the `git merge b`.

You then want a variant of the `git merge` command that will apply the `-X 
ours` policy *specifically to path x* so that its particular set of 
conflicts is fully resolved in favour of 'ours'.

You then want to repeat those path specific resolutions, on a path by path 
basis, to either `-X ours` or `-X theirs` until they are done.

You are also expecting that one or two conflicts will require to be fully 
manually resolved, until finally you can commit the result.

Would that be right?

Also, how do you intend to identify the 'x' and the 'y' paths, so that you 
can chose the ours/theirs/manual selection? (e.g. do you pre-know a 
regex/blob expansion)

The answer for individual paths is probably in the mergetool of your choice.
--
Philip 

