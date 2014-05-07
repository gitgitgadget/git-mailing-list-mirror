From: Timo Teras <timo.teras@iki.fi>
Subject: Re: git fast-import: how to prevent incremental commit with no
 changes
Date: Wed, 7 May 2014 08:01:37 +0300
Message-ID: <20140507080137.64c94037@vostro>
References: <20140505115320.395edd2e@vostro>
	<xmqqwqdyemx3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 07:01:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whtz5-0001OY-H9
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 07:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbaEGFBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 01:01:31 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:38306 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbaEGFBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 01:01:31 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so590971lbi.1
        for <git@vger.kernel.org>; Tue, 06 May 2014 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BaFMDVuPqdUx7lJ84Ln/42jW2PtH14yh4vh/ThJJXQ8=;
        b=MC8EMzyyneHU9351gc0HIC8BNjGt/qZKfOLNweDyovG6mAaje52ef3GNd+9Wt2PzR0
         fHPx5Q9AY4tqYIvO1HkfpjFU6dP+GaNXScgij/iQpDY51zwnbWC+ic5NKB0KZl2q2Qe/
         8Ou1jnx4HXvQX6bp7qgFmEMsueLsD3hUtV13kNya/1YbgaW/UlV5pxMNDmXNffnmWK67
         PZU5ij/32v+LwVvA9pzu56ot2Zfvw228Ga6h3KEPCFEsH5ErPguTx4qfMusESczph5Jd
         /R1Y2DsJMtuKL3EFUx6lYIU8Eqm85A9fRlkV4i/jDj1t+mbWlPHPrgsz2myRoEvExmqS
         aCtA==
X-Received: by 10.112.132.2 with SMTP id oq2mr13866826lbb.33.1399438889415;
        Tue, 06 May 2014 22:01:29 -0700 (PDT)
Received: from vostro ([83.145.235.199])
        by mx.google.com with ESMTPSA id ms3sm15901371lbb.17.2014.05.06.22.01.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 22:01:29 -0700 (PDT)
In-Reply-To: <xmqqwqdyemx3.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; i486-alpine-linux-musl)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248282>

On Tue, 06 May 2014 12:18:16 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Timo Teras <timo.teras@iki.fi> writes:
> 
> > I'm trying to script a setup that would periodically import a
> > tarball to git with fast-import. But things do not always change,
> > so I'd like fast-import to be able to not do the commit in case
> > there is no change.
> >
> > That is, I'm constructing the commit with "deleteall" + importing
> > each object by mark after that. Now, in case nothing changed,
> > fast-import will happily create an empty commit for me.
> >
> > Would it be possible to add some flag that would make commit fail in
> > case nothing changed?
> >
> > Any suggestions how to do this?
> 
> I am not sure if such a conditional logically belongs to what
> fast-import does.  Would it be an option for your script to rewind
> the HEAD after the import is done and it finds that the tarball did
> not have anything interesting new?

Yes, this is what I ended up with for now. I wanted to avoid this mostly
so that I would not need to run "git gc --prune=now" or similar after
each import (or at least not "often").

Thanks.
