From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] compat/fopen.c: avoid clobbering the system defined fopen macro
Date: Thu, 8 May 2008 08:27:48 +0100
Message-ID: <e2b179460805080027pf9ff518xf4fcbb248ecac4bf@mail.gmail.com>
References: <7vfxsudrt0.fsf@gitster.siamese.dyndns.org>
	 <4821E81A.4030600@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu May 08 09:28:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju0YR-0002oP-TA
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbYEHH1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 03:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbYEHH1u
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:27:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:37622 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755423AbYEHH1s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:27:48 -0400
Received: by rv-out-0506.google.com with SMTP id l9so814874rvb.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i/WNhRBhRtnRLd2dZiwUFD4iBvLvLstgz23m7eaDjuM=;
        b=pIRHJ2kr87CyHwuHqG714YppMzGFI4j9+/495/hpTvHCGSohwo+TvqYy2F5Xt/opUKvsTVtP0HpDDvCriPUyjtl5hFk9YhUFArSzw3oalPzy2u2pCcqqHhhwQSv+8goQ0kFlfW89GmesZtZb0syQRcsQx8t8dUIPm3Dz/0Hsyts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uBTkUGZxLcQt80yJWg2sf/BZ8AH0CH5QrpKhchRgTfDUCmcWugC0IgJd2+QMoQcp5EwZmz20FhT+MvRRW8TxNtMMqd6ibANCHw6fSNvQ39v1Xm1KvD/dK7xyXUq+Te2+7SjorMwoXZ0qTHXLDKd82WXufZSa/heObydqMb+F6G0=
Received: by 10.141.176.13 with SMTP id d13mr1379913rvp.196.1210231668371;
        Thu, 08 May 2008 00:27:48 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Thu, 8 May 2008 00:27:48 -0700 (PDT)
In-Reply-To: <4821E81A.4030600@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81509>

2008/5/7 Brandon Casey <casey@nrlssc.navy.mil>:
>
> Some systems define fopen as a macro based on compiler settings.
> The previous technique for reverting to the system fopen function
> by merely undefining fopen is inadequate in this case. Instead,
> avoid defining fopen entirely when compiling this source file.
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
>

Tested-by: Mike Ralphson <mike@abacus.co.uk>

Both with and without -D_LARGE_FILES. Many thanks.

H.Merijn, is this change also ok for your HP-UX?

I guess there may still be a case for not defining _LARGE_FILES by
default on AIX as all the warnings may be off-putting or mask other
issues. Maybe instead having a comment for those who need large
pack-file support? Will submit amended Makefile patch if there's
interest.

Mike
