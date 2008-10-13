From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] correct verify_path for Windows
Date: Mon, 13 Oct 2008 08:18:01 +0200
Message-ID: <81b0412b0810122318h15e8f5bue9b8ee8da71a7c33@mail.gmail.com>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com>
	 <20081004233945.GM21650@dpotapov.dyndns.org>
	 <B985AE98-F6E2-4C23-8D34-5A22A9F89FA7@gmail.com>
	 <20081007032623.GX21650@dpotapov.dyndns.org>
	 <48EAFF23.1020607@viscovery.net>
	 <20081011163310.GZ21650@dpotapov.dyndns.org>
	 <81b0412b0810111558vb69be00if4842fa91d777c3b@mail.gmail.com>
	 <20081012135048.GC21650@dpotapov.dyndns.org>
	 <20081012181836.GA10626@steel.home> <48F2E410.2080504@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Joshua Juran" <jjuran@gmail.com>,
	"Giovanni Funchal" <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 08:19:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpGly-0003Ia-0E
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 08:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbYJMGSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 02:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752981AbYJMGSF
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 02:18:05 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:20700 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbYJMGSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 02:18:03 -0400
Received: by yx-out-2324.google.com with SMTP id 8so374310yxm.1
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KkMuOaElPIJVYrhlTdo1HSQeJPCXuQdhXEpzXEXrUI0=;
        b=a0Oyzz/ylEnwrdnjZ+UXnLXvrq2ZIZNygyD2qhhW67a+L0IOFG7OffnPEVyL3/HpL2
         JWQge8WAWjleEOdh1dkzw4DeDXtltVqQEQHhbVieuZ/QixBcssLDRN/6VpFOasG51FzB
         fa1hgxDFlGfGzlfJ1M+JiHILKSWBaxfLJYq90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AzbTpt5CelH4AZAfJ3JJBF+Tu1IJVOeuLUdmYrK7oqGycH9pZOGD9JexGfQDjZcR1H
         +VNG5htn/tpMrsDnRo3YbIkoR78URjAoXhmjbuwVhdM7ICz6GfwIEv5IGzwpyprFGHdd
         d5fPaHxtx4Q/xiroHTSNI8On8MTY3wdswTQ3o=
Received: by 10.100.190.15 with SMTP id n15mr5173998anf.124.1223878682034;
        Sun, 12 Oct 2008 23:18:02 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sun, 12 Oct 2008 23:18:01 -0700 (PDT)
In-Reply-To: <48F2E410.2080504@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98086>

2008/10/13 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> I looked at the callers (briefly). Performance could be a problem: add
>> and checkout can work with real big file lists and long pathnames.
>> So ok, than. It is critical.
>
> You are kidding, aren't you? What you win by a few CPU instructions here
> is dwarfed by the time that the stat() implementation requires. Dmitry,
> please use the more readable tolower().

It is called for every element in a path, not just for every filename.
And maybe it is dwarfed, but they both are part of the same operation.
And this code makes it more CPU intensive.
