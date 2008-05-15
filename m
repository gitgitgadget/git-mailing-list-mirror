From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: How can I tell if a SHA1 is a submodule reference?
Date: Thu, 15 May 2008 16:12:10 -0400
Message-ID: <32541b130805151312p7a08a0b7id7c12bc8a04e2aca@mail.gmail.com>
References: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Robin Luckey" <robin@ohloh.net>
X-From: git-owner@vger.kernel.org Thu May 15 22:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwjp9-0004VT-25
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 22:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940AbYEOUMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYEOUMP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 16:12:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:51465 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbYEOUMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 16:12:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so453282fgg.17
        for <git@vger.kernel.org>; Thu, 15 May 2008 13:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Zx9XQRl53P96MO348hILjIV4R9EotZvkwWUluOLU4J8=;
        b=TDO+EUtbkGL5XcyorOEVgMteee7dniasWhiSILXEOUh16SV6JX2vABDUlhZ+rcOhwWW0ipF3/CCYOIFuyZhquohAF0sJAj6sMvfYZWwySs+O2cnYhRSmItVLk3fjfxiNphLvIsl3WMRQ01I+NzrKY7OGWS82d1UehIAr20Mm9TE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T/r/gOThbKnaFR32HbadNevd0ACMQgXzeXzLTizmHsVdnfeu6v1SCjPQOUTc+Mc20eW4Ac3kflLiF9t4L/ZfG7EIRb5daiQ8WIWgx26le65/zTgBj1OEm+DMmMwxgmQgyDpvZKYPTqd/7j2G9ED6whbFf1xVjJ+/W545wg+DBZ0=
Received: by 10.82.107.3 with SMTP id f3mr385866buc.87.1210882330649;
        Thu, 15 May 2008 13:12:10 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Thu, 15 May 2008 13:12:10 -0700 (PDT)
In-Reply-To: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82227>

On 5/15/08, Robin Luckey <robin@ohloh.net> wrote:
>  However, is there a simple and reliable way for me to know which SHA1
> hashes refer to such submodule objects? I'd like to simply ignore them.

I don't think there's a straightforward way to do this given *just*
the SHA1, in the same way that you can't know the path corresponding
to a blob given just its SHA1.

However, if you're looking at a tree that refers to a SHA1, the tree
will reference a submodule object as a "commit" instead of a "tree" or
"blob".  git-ls-tree output looks something like this:

160000 commit ba75ff608fabafeaafeb48d55b125440b5a665bc	my_subdir

I think it's reasonable to say that if it's type commit, then it's a
submodule.  (Note that simply being a submodule doesn't *necessarily*
imply that it'll be unavailable; some people like to store all the
submodule objects in the local repository.)

Have fun,

Avery
