From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Fix sparse checkout not removing files from index
Date: Fri, 30 Jul 2010 20:04:40 -0500
Message-ID: <20100731010439.GB5817@burratino>
References: <1280135310-2347-1-git-send-email-pclouds@gmail.com>
 <20100730013534.GB2182@burratino>
 <AANLkTi=3pX=k=Pf5SnWt8s=hbvwAXcZdmcqP_+kgCyE5@mail.gmail.com>
 <20100730195022.GB2448@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 03:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0WY-00067s-IU
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 03:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab0GaBF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 21:05:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64587 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab0GaBF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 21:05:57 -0400
Received: by iwn7 with SMTP id 7so1853795iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jUzhuJCKwl0QK778Nf7f2mdo0+NCM0GnugcaYIlvLKk=;
        b=oHNWiKiU9fPrtwLLUe6suy1X1KOoB2tjOsX+WvvckzajdfF0CVEYuj7MzGZS6NSJ8m
         NZKJkTW9l3IcDifzbe+p0sc80QjpVpvBxyhiLABeTx5ItPKSm6pCgAk3jAPbXjPBAyCr
         DXnzPvfDyGp6wRUKetg9lZplgq9w53Fww75hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JWzX6n0BHZD59pIKU3WYiFrgSPfJovUomyeC3S0kxspNIeU4qEk4UVk/QF1dwpBDd7
         Db8cfuAnjEoUfErS7Mud+VxRhGLUgR89H5cFIZ6qREvKtTHnw95nbXuDu5hYTVBb+UB5
         7cq+5DGjdqpATYUmH1sAQYsaiHU2bFZp+4L/A=
Received: by 10.231.35.199 with SMTP id q7mr2636296ibd.47.1280538355855;
        Fri, 30 Jul 2010 18:05:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2461337ibk.21.2010.07.30.18.05.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 18:05:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100730195022.GB2448@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152278>

Jonathan Nieder wrote:

> What happens if an index entry is removed at the same time as the
> checkout is narrowed?

Hm, maybe something like this would help.

Jonathan Nieder (2):
  t1011 (sparse checkout): style nitpicks
  read-tree -m -u: always remove relevant files when narrowing checkout

 cache.h                              |    3 +-
 t/t1011-read-tree-sparse-checkout.sh |  129 +++++++++++++++++++++-------------
 unpack-trees.c                       |   42 +++--------
 3 files changed, 94 insertions(+), 80 deletions(-)
