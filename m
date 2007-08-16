From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Fix an unitialized pointer in merge-recursive.c
Date: Thu, 16 Aug 2007 10:11:00 +0200
Message-ID: <e5bfff550708160111n66b5ea94k26cf2fecc06fd84c@mail.gmail.com>
References: <e5bfff550708160100t5aa93430x6cbe83e6e7a61d73@mail.gmail.com>
	 <7vsl6jkila.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:11:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILaRj-0008EM-BL
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 10:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbXHPILH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 04:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXHPILG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 04:11:06 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:59076 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731AbXHPILB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 04:11:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so201783wah
        for <git@vger.kernel.org>; Thu, 16 Aug 2007 01:11:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eu7poG8ltXjTczbZxvBxt2Pmx+7bD9zfPLsBMiizLrB5PVe44OOiEKnEEEhIYKRI5i9+ta93GlbsoJbqBNSfDSZU58pHLnysYzsG2KATbFrl2wXX6SDnGI0imQPuW7RJQeIgZT/EYYdeW9Jau4iQ7F2KpaBqgt5t/rW3C+KvliM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rsiv9RWGELVbMazl3uew/Vxyhk7LHJWd7ZA8Lg4sW9HmWknOLm75FaOm+8rWDwyQK0Cm0IHI+uAfK5Bk93Qx06YMxekKpbnJ36cPrc5pSFi2wvghAvuyYDN9gec+B9/Py7Bn9myC+56QTrck88eez6lbPfsHiJFTVCcxMtNn4xw=
Received: by 10.114.199.1 with SMTP id w1mr1479113waf.1187251860421;
        Thu, 16 Aug 2007 01:11:00 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Thu, 16 Aug 2007 01:11:00 -0700 (PDT)
In-Reply-To: <7vsl6jkila.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55987>

On 8/16/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Indeed &mrtree is passed to merge_trees() that not always
> > seems to set the value, so on some paths mrtree could
> > return uninitialized.
> >
> > Spotted by a gcc 4.2.1 warning
>
> Are you sure that gcc is correctly seeing the codeflow?
>
> In merge(), mrtree is used only under index_only, and
> merge_trees() always sets *result under index_only.
>

Ok ;-)

Now two options:

- discard the patch

- change the title in 'silence a gcc bougus warning'
