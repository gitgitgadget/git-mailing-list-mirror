From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] remote-curl: Add sanity check for url
Date: Wed, 31 Mar 2010 08:13:08 +0530
Message-ID: <u2tf3271551003301943sf703e66fz4274135efd991430@mail.gmail.com>
References: <f3271551003301308y683173f6y6a4fadb01b791049@mail.gmail.com> 
	<7voci5qspr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 04:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwnu4-0005MM-5Y
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 04:43:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756659Ab0CaCna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 22:43:30 -0400
Received: from mail-yx0-f195.google.com ([209.85.210.195]:51899 "EHLO
	mail-yx0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab0CaCn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 22:43:29 -0400
X-Greylist: delayed 26664 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Mar 2010 22:43:29 EDT
Received: by yxe33 with SMTP id 33so969407yxe.15
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 19:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Z5DfLbxf6uBof2hsxmcxjQg4v51Y/4nFOTbqBmR/QOo=;
        b=l2hp11aD5TIj4D77QHymTnII6q4UHsHjQpDhAcf5tOnUYIYKsDzuYnVe6ZbrKptcve
         fhY/U5UXx0aqbJFauFpRZLAsFE8mCmUABLorXt6ymqLmdTwwLtiBUCKHaYdt2/v15Y0h
         +OriCCme/vR62+WeF/oPFcouKRbmn/cxV+rxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eYyTxBtbTYl5IrW3MO2HsMOq9CZe1xBxIKCKqpuWnwQwW438M04Zx3GiifOMtJgswQ
         y7qpN2nm/grzDtTuTSlJ/ZQfzU6tNyf2whyihoQtzZ7uYWXjl/ru+hRYacqBrNeVGR78
         OZ1Zcv/xw/FDIMNL23Sy1sTO+G2xxN/zJu3hs=
Received: by 10.90.69.14 with HTTP; Tue, 30 Mar 2010 19:43:08 -0700 (PDT)
In-Reply-To: <7voci5qspr.fsf@alter.siamese.dyndns.org>
Received: by 10.90.19.37 with SMTP id 37mr963738ags.2.1270003408319; Tue, 30 
	Mar 2010 19:43:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143637>

Hi,

> I may be being slow but I do not see the point of this patch.

Agreed, it's not a bug that any end-user would normally bump into. I
bumped into this myself when I assumed that the remote `foo` exists,
and invoked `git-remote-http foo`. Since remote_get() transparently
creates a remote when one does not exist, remote-curl doesn't know if
the remote `foo` ever really exists. Going off to fetch a HTML page
when an expected remote doesn't exist is really ugly, so I thought I'd
prepare this patch. Plus, it doesn't hurt to make sure that the remote
helper conforms to the documentation- useful when a developer is
calling it independently.

-- Ram
