From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result
 when writing out objects
Date: Mon, 22 Feb 2010 09:27:13 +0300
Message-ID: <20100222062713.GD10191@dpotapov.dyndns.org>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 08:42:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjRlM-0001g3-2S
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 07:27:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab0BVG1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 01:27:19 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:36796 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0BVG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 01:27:18 -0500
Received: by fxm19 with SMTP id 19so2101406fxm.1
        for <git@vger.kernel.org>; Sun, 21 Feb 2010 22:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=2GSyaSM3FsHhXgNFVEesyiIKqY2wYM98Ik0KQm4uoXk=;
        b=a0EIW1J6m3qeK8r8+Pd7u3A1N/mvLX+W83+s5oTadHkJuez7GoDlUF22PpBzLPXOMU
         lxa/KkBBqPiCR+hOitK90LB7qQ1UqLRnpUTaecS6kTV36bpzCtZ8r3oPYRS8oTNT7DLS
         1rcb7eNnkUUqM6PsxoK0u0QtaMGwU2ZVeViuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=phlMSsa4U1RTr2OWDTL7b7z5cclq0S01+ZTnY9HVpS9vei/N2/w32TSpa9fChnPRsm
         zTj7k7dqj1RIZmQ/GtM6VKgttHQKAer5Bs9gkHiaN2DLhOflkLUYkHQUhft6eQ+WGKmB
         2i++tSitE1bijySsvIKnGUMnR7EOs7pnriYaU=
Received: by 10.86.106.7 with SMTP id e7mr5757773fgc.1.1266820035964;
        Sun, 21 Feb 2010 22:27:15 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id l12sm7587156fgb.2.2010.02.21.22.27.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Feb 2010 22:27:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140638>

On Mon, Feb 22, 2010 at 12:50:18AM -0500, Nicolas Pitre wrote:
> 
> And what real life case would trigger this?  Given the size of the 
> window for this to happen, what are your chances?

If some process changes just one byte (or one word) back and forth
then the possibility of this is 25%. Whether such a process can
exist, I don't know... I could not imagine that anyone would want
to change the file when we add it to the repository. In any case,
it is wrong to call it a _paranoic_ mode if there is even a small
(but practically feasable) chance of this to happen.


Dmitry
