X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH 1/4] add generic, type aware object chain walker
Date: Mon, 25 Feb 2008 08:26:58 +0100
Message-ID: <20080225072658.GB15761@auto.tuwien.ac.at>
References: <12038642373342-git-send-email-mkoegler@auto.tuwien.ac.at> <20080225030404.GL8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 25 Feb 2008 07:27:12 +0000 (UTC)
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Content-Disposition: inline
In-Reply-To: <20080225030404.GL8410@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1JTXkO-0002BH-Q0 for gcvg-git-2@gmane.org; Mon, 25 Feb 2008
 08:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751750AbYBYH1A convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 02:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbYBYH1A
 (ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 02:27:00 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45458 "EHLO
 thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1750820AbYBYH07 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 25 Feb
 2008 02:26:59 -0500
Received: from localhost (localhost [127.0.0.1]) by thor.auto.tuwien.ac.at
 (Postfix) with ESMTP id 637E1680B59A; Mon, 25 Feb 2008 08:26:58 +0100 (CET)
Received: from thor.auto.tuwien.ac.at ([127.0.0.1]) by localhost
 (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 N-jYqjCgamnw; Mon, 25 Feb 2008 08:26:58 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001) id
 3F7BB68018E5; Mon, 25 Feb 2008 08:26:58 +0100 (CET)
Sender: git-owner@vger.kernel.org

On Sun, Feb 24, 2008 at 10:04:04PM -0500, Shawn O. Pearce wrote:
> Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> Hmm.  Don't you need to get commit->parenst *after* it is parsed,
> and not before?

Thanks, fixed.

> > @@ -0,0 +1,10 @@
> > +#ifndef GIT_FSCK_H
> > +#define GIT_FSCK_H
> > +
> > +#define OBJ_ANY OBJ_BAD
>=20
> Its unclear why this macro is necessary.

There are cases (eg. a tag->tagged), where the object type does not
matter. In this case, the callback gets this value for the expected
type.

The value of OBJ_BAD (-1) is not used anywhere in git, so its
free. OBJ_ANY is just a better name.

If somebody has a better idea, please tell me.

