From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Stream very large blobs directly to pack
Date: Mon, 1 Feb 2010 07:23:24 -0800
Message-ID: <20100201152324.GD8916@spearce.org>
References: <20100129012350.GD20488@spearce.org> <fabb9a1e1001291035l5cd09cb6q1f12037f96dce8a1@mail.gmail.com> <20100129183705.GB22101@spearce.org> <7vockc45ut.fsf@alter.siamese.dyndns.org> <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 16:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nby7i-0005my-3q
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 16:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab0BAPX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 10:23:29 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:37164 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab0BAPX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 10:23:28 -0500
Received: by ywh3 with SMTP id 3so1647297ywh.22
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 07:23:28 -0800 (PST)
Received: by 10.150.127.1 with SMTP id z1mr2666812ybc.177.1265037808008;
        Mon, 01 Feb 2010 07:23:28 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm1802004ywh.18.2010.02.01.07.23.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 07:23:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmxzw15dt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138614>

Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >> I was intentionally slating this for maint, to fix a bug a user
> >> reported when handling large streams.
> >
> > I personally see that as adding a new feature (especially with new option
> > and config).
> 
> Sorry, but I take it back.  The new codepath triggers even without any
> explicit request and _fixes_ the situation where old code simply failed,
> so it is worth queuing for the maintenance track.

Thanks.
 
> Do you want to do the deflatebound thing, or are we Ok without?

No, I think we're OK without it.  The pack size limit stuff is only
a rough guess anyway.  I never meant for us to be sticking to it to
within a byte.  It was only meant to keep us from shoving a 100 MiB
blob onto the end of a pack once we got close to the size requested
by the user.

-- 
Shawn.
