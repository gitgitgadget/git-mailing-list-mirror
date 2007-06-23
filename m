From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sat, 23 Jun 2007 23:04:51 +0200
Message-ID: <81b0412b0706231404hc8b4bc4xd5bc51c733d8ea69@mail.gmail.com>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de>
	 <11826268772950-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jun 23 23:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2Cmt-0006yJ-3e
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 23:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbXFWVEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 17:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbXFWVEx
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 17:04:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:49404 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbXFWVEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 17:04:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1038446ugf
        for <git@vger.kernel.org>; Sat, 23 Jun 2007 14:04:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RJtb2HaneIsURlIsFryO0V+r+DFO0qPy1SILjeiMy/ndcxCxKkAo/xt3wkL6FGZyWRrsV6JzRzQsgSARurz2gImwOg9n66OMKuuhh0Tm1qI/zsXW4cXVSCl+F7hvQH9dCuD7xL/RMdheYfPl1CUwt4Ld8oBdcQC68P5iBn7qGHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mv70XY9HViA4Shrmy3HUiDTFTl+nWyIouV+LXkvVjN2pSnXcRCvXppeGTmfJ+uGZfINzBKqXIhe80rhuUNy9yd1dd89LFxp4IIZl3IM269lN07taiyk+f95cH74O38w3+e07RpQRo/AOpRoCifulUx3MmNjwKmGs4eMG6btLl9Y=
Received: by 10.78.83.15 with SMTP id g15mr2050453hub.1182632691368;
        Sat, 23 Jun 2007 14:04:51 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Sat, 23 Jun 2007 14:04:51 -0700 (PDT)
In-Reply-To: <11826268772950-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50753>

On 6/23/07, Steffen Prohaska <prohaska@zib.de> wrote:
> git-transplant.sh <onto> <from> <to>
>
> transplant starts with the contents of <onto> and puts on top of
> it the contents of files if they are touched by the series of
> commits <from>..<to>.  If a commit touches a file the content of
> this file is taken as it is in the commit. No merging is
> performed. Original authors, commiters, and commit messages are
> preserved.
>
> Warning: this is just a quick hack to solve _my_ problem.
> - No error checking is performed.
> - Removal of files is not handled.
> - Whitespace in filename is not handled.
> - The index is left in dirty state.
> - No branch is created for the result.
> - The script is not integrated with git's shell utilities.

# detached head
git checkout $(git rev-parse onto) && git format-patch --stdout
--full-index from..to|git am -3
