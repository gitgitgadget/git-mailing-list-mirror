From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 14:19:48 -0500
Message-ID: <32541b131002151119o2f528ddv147d71d12d9d11fe@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> 
	<20100214011812.GA2175@dpotapov.dyndns.org> <alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> 
	<20100214024259.GB9704@dpotapov.dyndns.org> <alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de> 
	<37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com> 
	<32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com> 
	<alpine.LFD.2.00.1002142252020.1946@xanadu.home> <32541b131002142101i226663cfk90d1ba14f1031788@mail.gmail.com> 
	<alpine.LFD.2.00.1002150016110.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 20:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh6UT-0005xJ-HY
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 20:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157Ab0BOTUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 14:20:10 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:62805 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab0BOTUJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 14:20:09 -0500
Received: by qw-out-2122.google.com with SMTP id 5so554829qwi.37
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=3Ufef26JSFekkC/Hnj/HpV/K+C6J3iqGkAUAdg/jGQA=;
        b=ZGwGSaS3n56/KKuCwE3m52PoF8/lMjxW2rg5NOjZX+tKs+4mYE4AFGt0X5cqtiOKKD
         5NnQxsHQZMCJSXeRKRiIJMTMf9nSA40Z0hQGY0QiomMMdP3CkYiha/qDDXrkBd5ZgW4t
         IqGTuOl3ZwnUU3R91AiCSgPNQd4s/bzIp5sYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AUvgfyumPKCE5RaPncaQ+Lh6X0bRTD/8i6B0LMp6JN7aDEVyge4EpIMmIZhrFDG0Td
         LlD4xc6wftUHgM8+CK8fqBSJFYK4Ae/i6xubx2oWk3RQp5yEsyJWdFKKMOXGqtzGXJZp
         1u+1UZ+kojx12zfJlqmb14501wIF3wHSFPsUo=
Received: by 10.220.122.156 with SMTP id l28mr114211vcr.123.1266261608148; 
	Mon, 15 Feb 2010 11:20:08 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002150016110.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140022>

On Mon, Feb 15, 2010 at 12:48 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> Ideally you don't keep volatile objects into huge packs. =A0That's wh=
y we
> have .keep to flag those packs that are huge and pure so not to touch
> them anymore.

Of course the problem here is that as soon as you import a single
(possibly volatile) 2GB file, your pack becomes "huge."  So these
heuristics stop working very well and start to need some revision.

Thanks for the clarification on packing and repacking.  I might be
able to use this method to come up with a better repacking/pruning
algorithm in bup, and from there to perhaps forward it on to git.

Have fun,

Avery
