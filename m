From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Extend "checkout --track" DWIM to support more cases
Date: Fri, 22 Aug 2008 11:08:01 +0200
Message-ID: <81b0412b0808220208i5de03604rec37081f0bc1cdd4@mail.gmail.com>
References: <20080820185028.GA16626@blimp.local>
	 <alpine.DEB.1.00.0808202151320.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080820200440.GF16626@blimp.local>
	 <alpine.DEB.1.00.0808202213340.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <20080820202952.GH16626@blimp.local>
	 <7vd4k3nx7m.fsf@gitster.siamese.dyndns.org>
	 <20080821172320.GA5119@blimp.local>
	 <7vy72pd278.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 11:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWSdp-00029o-KT
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 11:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbYHVJIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYHVJIF
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 05:08:05 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:17963 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYHVJIC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 05:08:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so23019ywe.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 02:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VdsWVn7inQNgLRm/IVoGv5GWDe09qGoowePiYHG3F70=;
        b=HVHVjtn0kPU1nSYbxLJHkHJlZX4234DZqX7xZhMGABBw8znv5flveoXA2KKIDrzj7m
         voekxXB8inN1QNiloRCHmK5DiyZXg5IkHAF/txjaR6OO/LJB5MSXhN6QzU+hBBnXUCKR
         aB+2ME8MWaVL4OuDV5tZ0WtH2ee/1LlEpXt08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U7fYlbktkkXD/f5wzXVm9UvFYJyp8ODS6sR3LIUEjAQMbB+MGImfQBlPr7URsvrL6O
         OuAvhQm8hxyZeXb8irgjfxtQSJpQzgT4nxXXtdSN3JbtC+3aDOkh2txd/v1B5F4hzDpV
         VOHlOxYSCK0QTfDYhcKHPPThC58Oph7GWp3pw=
Received: by 10.115.78.1 with SMTP id f1mr730041wal.150.1219396081312;
        Fri, 22 Aug 2008 02:08:01 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Fri, 22 Aug 2008 02:08:01 -0700 (PDT)
In-Reply-To: <7vy72pd278.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93278>

2008/8/22 Junio C Hamano <gitster@pobox.com>:
> I however wonder if this is clearer.

It is :)

>  * "enum branch_track" was unsigned; comparing equality with -1 was Ok but
>   we couldn't say 0 < opts.track;
>
>  * argv[] is an array of constant strings; cannot point into it with
>   opts.newbranch without making the latter also a constant string.

Cleanup, but it is unrelated, isn't it?

>  * the logic is to strip "refs/" if there is one, "remotes/" if there is
>   one after that, and then strip one level after that unconditionally.
>   No need to look explicitly for a slash while doing the first two steps.

Maybe that should go in documentation instead of the piece I wrote
