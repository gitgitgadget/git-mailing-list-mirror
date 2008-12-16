From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Tue, 16 Dec 2008 01:35:53 -0500
Message-ID: <d4bc1a2a0812152235l14ec80bbr130a7ab152ad6b8@mail.gmail.com>
References: <874p15x94i.fsf@jidanni.org>
	 <20081216005658.GB3679@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 16 07:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCTYO-00045D-9k
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 07:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbYLPGfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 01:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbYLPGfy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 01:35:54 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:39697 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbYLPGfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 01:35:53 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1452673wah.21
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 22:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3mUS1xdB9NbdfXDYIoyl+FiezX8EZq0pElpwGVqG0Ps=;
        b=deT+c+d5ad1lgh+687xoRYUXP0AcxGkYon2kHLBjTahG9VE9wOHdoZOZZuY1IYTZyu
         Agi55M5jLXi4S+mq/6qJWpFcDF/udt3nMeCGdW/gA8yqpYk7qlFKj0NuGXdSc/tgBbFz
         wpyi6NvrWGxSFqrn/E2LkVvYvVJxGzZphi3eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Wnv2G7lN7DMbgCAUJFiMORdtFnwgwg5RIA1SafvULKdxHupr99J/b8dVbLSdldU3ug
         qWneDGDPOZOiRDwoHpdjwXEJfX+QnfavFKyCYRxHqFqAlJANbDt/X8Borg1wQrAPwmk0
         ojAtPLKeQdpyAgpskPXph34g/udYTcfFrb/6M=
Received: by 10.114.161.11 with SMTP id j11mr4992038wae.164.1229409353382;
        Mon, 15 Dec 2008 22:35:53 -0800 (PST)
Received: by 10.114.134.5 with HTTP; Mon, 15 Dec 2008 22:35:53 -0800 (PST)
In-Reply-To: <20081216005658.GB3679@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103252>

> On Mon, Dec 15, 2008 at 7:56 PM, Jeff King <peff@peff.net> wrote:
>  2. detect EOF before starting the pager. We in fact already delay
>     running the pager in the forked process until we have some activity
>     on the pipe, but I don't know if there is a portable way of
>     detecting that that activity is EOF without performing an actual
>     read() call (which is undesirable, since it eats the first byte of
>     output that should go to the pager).

Wouldn't ungetc work? Or is that not portable enough? (It would only
work here because the EOF has to be the first character.)
