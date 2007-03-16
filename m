From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 22:07:43 +0100
Message-ID: <e5bfff550703161407u6afefae9u4a23cf1cb49125ce@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
	 <20070316060033.GD31606@spearce.org>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
	 <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
	 <alpine.LFD.0.83.0703161454280.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Rocco Rutte" <pdmef@gmx.net>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 22:08:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSJed-00032i-Ah
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 22:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965939AbXCPVHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 17:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965949AbXCPVHu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 17:07:50 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:33228 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965941AbXCPVHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 17:07:48 -0400
Received: by ik-out-1112.google.com with SMTP id c21so534725ika
        for <git@vger.kernel.org>; Fri, 16 Mar 2007 14:07:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GL5nL2qtHWqrS9NqUjA3DdpEuNjpeGjDN1IZ30jMea7m+Si1USLcSInenqraPF6nZpxLiRWtWJUCJJf3BPAKpONoa5lV/3/TJAnJNwTPOx8MRsKmzypwG3XTCOasUxcvvwSrs5vfoE8HNwTRTR+iZk1GLPtwW8CNssihbVqiMNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XHy9WHh+cGRxPGo5KELnT737Z4hLUKIbP3/5P0Ef9IBrBO07nFrJ2L+nDXp5iL+x2V3nuVB5TaI7Q4lQclmSGC5fPg2B8cuQ44oJR8bCSKXx9cNJI61Qn8i+3GFOhYXdi6h8Z/E0DRXjA0SzdE8F3U2X7emrxd210qhKV+kqKYI=
Received: by 10.114.205.1 with SMTP id c1mr900252wag.1174079263415;
        Fri, 16 Mar 2007 14:07:43 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Fri, 16 Mar 2007 14:07:43 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.83.0703161454280.18328@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42398>

On 3/16/07, Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 16 Mar 2007, Marco Costalba wrote:
>
> > On 3/16/07, Marco Costalba <mcostalba@gmail.com> wrote:
> > >
> > > *The most important thing for a libgit to be used by qgit is reentrancy*
> > >
> >
> > Another crtitical feature is that this call to git-rev-list-like
> > function MUST be non-blocking.
>
> I'm not sure I agree.
>
> The non-blockingness can be (and probably should be) handled at a higher
> level with your own threading facility of choice.  Making GIT
> restartable has the potential for making the core code much too complex.
>

The fact is that the solution is complex anyway, moving the complex
code at higher level doesn't simplify the whole issue, it just *moves*
the issue somewhere else.

BTW now qgit is single-threaded (as gitk), you suggest that linking
with libgit it will involve to go on the multi threading side and I
think you are right. But it will be not that easy.

Currently we have both single threaded GUI tools and blocking git
commands and it works nicely not because it's simple but because the
'complex code' is hidden inside the OS process handling and scheduling
stuff.

Linking with a synchronous libgit it means, roughly speaking, take the
'complex code' out from the OS and put somewhere in user space, or in
libgit or in the user GUI tool linked with the library.

Now, it happens that Qt has a good multi thread support, but this is
just incidental and of course cannot be taken as granted by a git
library that aims to be broadly and possibly easily used.

Because we are just speaking (well, writing ;-) ) about a possible
library I think we could take in account what would involve to
foreseen a callback mechanism in the API, at least for the slowest
ones.

    Marco
