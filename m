From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 3/4] mingw: move common functionality to win32.h
Date: Mon, 29 Sep 2008 22:37:22 +0400
Message-ID: <20080929183722.GJ21650@dpotapov.dyndns.org>
References: <20080927084301.GB21650@dpotapov.dyndns.org> <200809272034.04931.johannes.sixt@telecom.at> <20080927215102.GF21650@dpotapov.dyndns.org> <200809281110.48256.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Marcus Griep <marcus@griep.us>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Sep 29 20:39:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkNeW-0004Q6-Fe
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 20:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYI2SiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 14:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYI2SiL
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 14:38:11 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:34226 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYI2SiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 14:38:10 -0400
Received: by gv-out-0910.google.com with SMTP id e6so131918gvc.37
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=NIDTp3YctArDdIyzIrrjgHSndHKc2a8WpNV5O/e0iYk=;
        b=feL7fDfk9157ZGg3Y8ceuV6zdLf2wbvTBZDX+Ly5tAOvtvC8s9Rh2ZfLayrBQn+Nr2
         AYQDGXIXgTc9Fhz/aiZlSA90cMcaugGwGjMJVHTZXpF7fNtk/liQM45Ndoce6p3N6pKX
         ETliabTUkQBNLNXEMbLIpsYIFWyZoYL2sK69I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j6LCc270vklDTgmPJNYHWVxiPkQx47wJmWksTekaR5h/s69aCoiibSn8vkaGYlhQzv
         FEa+h1+cq6NawN7Lb3+nyPNcBKGe5wKlLQ2eGj2yrtftj4/apSy5onzivvSljMjYfNEw
         L4mJNyPpXlWsJ3hY3l7f97XKFsnydSvFTCcvo=
Received: by 10.103.219.18 with SMTP id w18mr4007970muq.121.1222713487897;
        Mon, 29 Sep 2008 11:38:07 -0700 (PDT)
Received: from localhost (ppp85-141-239-245.pppoe.mtu-net.ru [85.141.239.245])
        by mx.google.com with ESMTPS id y2sm2935749mug.2.2008.09.29.11.37.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 11:37:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200809281110.48256.johannes.sixt@telecom.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97042>

On Sun, Sep 28, 2008 at 11:10:48AM +0200, Johannes Sixt wrote:
> On Samstag, 27. September 2008, Dmitry Potapov wrote:
> > win32_to_errno was the first thing that implemented but then released
> > that translation of Win32 errors to errno cannot be in general case.
> > For instance, ERROR_BUFFER_OVERFLOW means ENAMETOOLONG here, but it
> > can be translated to ETOOSMALL in other cases. How do you propose to
> > deal with that?
> 
> We deal with that when the need arises, in an evolutionary manner. The first 
> step is to *have* an error code translation routine.

Step to what? IMHO, the idea of win32_to_errno is deeply flawed, and, in
any case, refactoring handling of Win32 error in MinGW is not the
purpose of my series. If you want to introduce win32_to_errno in mingw,
you can send your own patch to that effect, and we can discuss that
separately. So far, I am not convinced that it will improve anything in
the existing code. As to avoiding duplication of Win32 specific code,
get_file_attr() fits better.  So, let's proceed step-wise, and first
finish one thing, namely, speed-up of Cygwin version of Git and then
discuss adding win32_to_errno to MinGW.


Dmitry
