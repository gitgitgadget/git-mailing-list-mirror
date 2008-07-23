From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 10:47:02 -0400
Message-ID: <76718490807230747w5d0350b8v6feba00fb8837617@mail.gmail.com>
References: <20080723130518.GA17462@elte.hu> <20080723131736.GA9100@elte.hu>
	 <20080723134926.GA12888@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ingo Molnar" <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfdS-0006GH-QY
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYGWOrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 10:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYGWOrH
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:47:07 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:62104 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYGWOrE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:47:04 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1043546ywe.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SQ248eCBjYBBE8M5n61y0bnUjhLDZGsm7AzcSdW4v9k=;
        b=JjVGrGYRbhxO3FvC37ZasRZAZyJSBdsl1U2nvvjAv+aFghr3wAsZvk2n16jrZKdQ6z
         3if0uus3+8YaOINP7cO/iHLJQOIUBsH+mXBoBjvrbDCDTzpd8bWdz2bVWOEvLISNWldV
         rVbOfb6yYmZCj1VkkajwA9lC7eC2ArgmJQRmM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o2ZJWmXLCzJt9yAE6Y5S5TXoajBiBb3OrJQ5al/LtgmRrjUijPBIZRvkiohXxEzkVK
         vBWPf/P+AZetQQphlztCxs+Or/iTiSyVdMC/3n+aNdnE+BKfO5B201iW6TyfrPFJzxfH
         gcCPoASkppvjuOimLRiriMxfIABgL0PEYQ6NM=
Received: by 10.150.57.5 with SMTP id f5mr254997yba.60.1216824422407;
        Wed, 23 Jul 2008 07:47:02 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Wed, 23 Jul 2008 07:47:02 -0700 (PDT)
In-Reply-To: <20080723134926.GA12888@elte.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89665>

On Wed, Jul 23, 2008 at 9:49 AM, Ingo Molnar <mingo@elte.hu> wrote:
> #!/bin/bash
>
> usage () {
>  echo 'usage: git-fastmerge <refspec>..'
>  exit -1
> }
>
> [ $# = 0 ] && usage
>
> BRANCH=$1
>
> MERGECACHE=.git/mergecache
>
> [ ! -d $MERGECACHE ] && { mkdir $MERGECACHE || usage; }
>
> HEAD_SHA1=$(git-log -1 --pretty=format:"%H")
> BRANCH_SHA1=$(git-log -1 --pretty=format:"%H" $BRANCH)
>
> CACHE=$MERGECACHE/$HEAD_SHA1/$BRANCH_SHA1
>
> [ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH_SHA1 ] && {

Shouldn't this be:

[ -f "$CACHE" -a "$CACHE" -nt .git/refs/heads/$BRANCH ] && {

?

j.
