From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] bundle: fix wrong check of read_header()'s return value & add tests
Date: Thu, 8 Mar 2007 14:58:01 +0100
Message-ID: <81b0412b0703080558ye4cff44l88eb88d4911222a0@mail.gmail.com>
References: <Pine.LNX.4.63.0703062256200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0703070613530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vslchio4f.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703081405310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:58:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPJ8P-0001VQ-Ip
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 14:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXCHN6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 08:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXCHN6E
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 08:58:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:54289 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbXCHN6D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 08:58:03 -0500
Received: by nf-out-0910.google.com with SMTP id o25so642833nfa
        for <git@vger.kernel.org>; Thu, 08 Mar 2007 05:58:02 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A4nBNHPSNiIIGMnno4xhfHsT/Nm43kVZou2/5a216kz0ZaYsaBKgY2dHNR1gePOVzqQ38KUaThst3m0/14QslFpU834ZQaFfQR3GFm3iNnjbqqQEJ4Jlxj7AXgUoSr8mBOvRxPdDrg+1AMaj9dEqc2el6498l2ID3OG6/IZ/nUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GkJ8ZIN60OteNngHL+X7KzNMFrDSUCTT/4c2Vb2brAfc0/ZNs4wjN3xb3snOZFB5WaM/wcNUD92L55Eeeo32J3jspPOnA74eXUvwkGVyYHzV7fspzAqVNBLuO1BE5TRJ2KmzmgnpIalO0GCwaa11iGckhpyXFJ/I05iQf5qQ12c=
Received: by 10.78.201.15 with SMTP id y15mr52381huf.1173362281499;
        Thu, 08 Mar 2007 05:58:01 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Thu, 8 Mar 2007 05:58:01 -0800 (PST)
In-Reply-To: <Pine.LNX.4.63.0703081405310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41743>

On 3/8/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 6 Mar 2007, Junio C Hamano wrote:
> > +     (
> > +             while read x && test -n "$x"
> > +             do
> > +                     :;
> > +             done
> > +             cat
> > +     ) <bundle1 >bundle.pack &&
>
> I tried to avoid that, because it was mentioned that this does not work on
> Cygwin for some reason I forgot.
>

Can't think of a reason why it would not. Just tried: works.
It works even with \r\n line endings (which I don't understand).
