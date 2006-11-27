X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git: how to produce context diffs?
Date: Mon, 27 Nov 2006 10:19:49 -0500
Message-ID: <BAYC1-PASMTP01B6529D1821EEBC0A6E6FAEE60@CEZ.ICE>
References: <200611271516.30425.bruno@clisp.org>
	<ekesgt$6jq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 15:20:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061127101949.565b1f3c.seanlkml@sympatico.ca>
In-Reply-To: <ekesgt$6jq$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Nov 2006 15:19:50.0776 (UTC) FILETIME=[7B7ED780:01C71237]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoiGx-0004IL-2L for gcvg-git@gmane.org; Mon, 27 Nov
 2006 16:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758260AbWK0PTv convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 10:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262AbWK0PTv
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 10:19:51 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:26974 "EHLO
 bayc1-pasmtp01.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1758260AbWK0PTv convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>);
 Mon, 27 Nov 2006 10:19:51 -0500
Received: from linux1.attic.local ([65.93.43.74]) by
 bayc1-pasmtp01.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Mon, 27 Nov 2006 07:19:50 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GohKl-0006fG-Pm; Mon, 27 Nov 2006 09:19:47 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 27 Nov 2006 15:27:20 +0100
Jakub Narebski <jnareb@gmail.com> wrote:

> Bruno Haible wrote:
>=20
> > Is this a bug in git-diff? The git-diff-files.html says:
> >=20
> > =A0 " When the environment variable GIT_EXTERNAL_DIFF is not set ..=
=2E
> > =A0 =A0 For example, if you prefer context diff:
> > =A0 =A0 GIT_DIFF_OPTS=3D-c git-diff-index -p HEAD =A0"
> >=20
> > This doesn't work for me with git-1.4.4:
>=20
> Yes, the bug in documentation, I think. There is an option '-c' to gi=
t-diff,
> but it means "combined diff" (for merges), not "context diff".

Indeed.  That documentation predates built-in diff completely.

It appears the only valid options now are "-u XX" and "--unified=3DXX".
These options are never passed to diff, but rather used to control
the internal diff.  Strangely, it appears that gitk is even passing
incorrect parameters via GIT_DIFF_OPTS.

Unless i've really missed something, the above documentation should be
reworked to remove mention of running diff altogether, and should menti=
on
that the GIT_DIFF_OPTS only has two valid settings.

