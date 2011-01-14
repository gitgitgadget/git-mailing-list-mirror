From: Jonathan Nieder <jrnieder@gmail.com>
Subject: small downloads and immutable history (Re: clone breaks replace)
Date: Fri, 14 Jan 2011 14:53:08 -0600
Message-ID: <20110114205308.GA15286@burratino>
References: <4D262D68.2050804@cfl.rr.com>
 <201101112048.57326.j6t@kdbg.org>
 <20110111195107.GA18714@sigill.intra.peff.net>
 <201101112100.32083.j6t@kdbg.org>
 <4D2CBC1A.9000302@cfl.rr.com>
 <20110111205043.GA19928@burratino>
 <4D2CFD0A.1060901@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Phillip Susi <psusi@cfl.rr.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 21:53:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdqeR-0001rg-Eq
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 21:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab1ANUxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 15:53:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61171 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab1ANUxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 15:53:32 -0500
Received: by qwa26 with SMTP id 26so3135687qwa.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 12:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ubf3QOAEXzHOMmM1asFgciyhiMs57mxRsiFqGzKmtvo=;
        b=UJwgBydVprrRwN/XMl/Tcc7rpJ46n7uJ7lDsM46OV/TkxqHf00PLthxzTG/81F5p0b
         U0MUpxixs3QM2rAOtzL83s0B+bzENTNl1LD9k6le8UEgn2VQ2NMtIdlS2riVZhlvotqq
         w29Q5F2Q2igbfnVT6PvDeroFuar6+OIMU1Rrg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q4+pEIC6clfa7Zh4OKbWHl+D0ySKnCBX2kL1H4fJrk7nJ7455OKe9f5EZXxe0gLb/9
         WWBBdtYRmAQPtP5DANZV10zjYtk1AuLpP+V+4f0aP7AmQ8rjL8x9DE9zcbAW5GexGcKZ
         YoAo84OBOlVUuNyDIhtZ2Hq07nCHuk4xnReoU=
Received: by 10.224.74.68 with SMTP id t4mr1043279qaj.325.1295038411614;
        Fri, 14 Jan 2011 12:53:31 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id l12sm1056085qcu.19.2011.01.14.12.53.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 12:53:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2CFD0A.1060901@cfl.rr.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165121>

Phillip Susi wrote:
> On 01/11/2011 03:50 PM, Jonathan Nieder wrote:

>> Yes, except for "Using filter-branch is bad".  Using filter-branch is
>> not bad.
>
> It is bad because it breaks people tracking your branch, and
> violates the immutability of history.

Ah, I forgot the use case.  If you are using this to at long last get
past the limitations (e.g., inability to push) of "fetch --depth",
then yes, rewriting existing history is bad.

So what's left is some way to make the "have" part of transport
negotiation make sense in this context.  I'll be happy if it happens.

Thanks for clarifying.
Jonathan

[note: if you occasionally use

 git commit; # new commit
 git tag tmp
 git checkout --orphan newroot
 git replace newroot tmp
 git tag -d tmp

so the history without replacement refs is short, no rewriting of
history has to take place.  Some testing and tweaking might be
required to make "git pull" continue to fast-forward.]
