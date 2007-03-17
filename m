From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Libification project (SoC)
Date: Sat, 17 Mar 2007 08:04:58 +0100
Message-ID: <e5bfff550703170004n3ab9075euf66a9e6dd56040d7@mail.gmail.com>
References: <20070316042406.7e750ed0@home.brethil>
	 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
	 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550703161120o4571769eq18c13ae29ac79957@mail.gmail.com>
	 <e5bfff550703161138x5ab1fe3anf7b2aaab81bb77e4@mail.gmail.com>
	 <alpine.LFD.0.83.0703161454280.18328@xanadu.home>
	 <e5bfff550703161407u6afefae9u4a23cf1cb49125ce@mail.gmail.com>
	 <Pine.LNX.4.63.0703170014130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Rocco Rutte" <pdmef@gmx.net>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 08:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSSyd-0003ZY-2w
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 08:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbXCQHFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 03:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626AbXCQHFD
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 03:05:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57053 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXCQHFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 03:05:00 -0400
Received: by ug-out-1314.google.com with SMTP id 44so881029uga
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 00:04:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NAATXDF9sH9gJsZ9+mcc131Naze7nVQ3SG5iez6k8hyNe0LSleJHqObX6BW5BQVGZ+FxFBYZmkxIWJp0cyQi/CKEafpy4y5Fsjfjt0dB9yExrNA2kWXqpuQwHg9WVCwnmDlIUwkdnB2Ye4B/q5UC4fy2wQaexf4m+q0ABqPIkwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FOw16a+wgKRfIwtGmRhjg/WbzJ2tpKEgk2Y3ZdGB8q4Wa/YJrWhsAfQ9B8eo5WK0cXzU2eg/D5c+fNChBcnnNzQKqTansH8/hn0B8ol5XLGprAe7S/q1Qq4b/5Zl5bY/w6M5BQ50RXstAOKhWOxUF6oyctKH0c7p0OEfWu52bjY=
Received: by 10.114.168.1 with SMTP id q1mr1032058wae.1174115098416;
        Sat, 17 Mar 2007 00:04:58 -0700 (PDT)
Received: by 10.114.60.16 with HTTP; Sat, 17 Mar 2007 00:04:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.63.0703170014130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42425>

On 3/17/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> We are talking about libgit. Which should make access to certain common
> functions on Git repositories easy. Nothing more than that.
>

Fair enough.

> If you need to do that asynchronously, do _not_ fiddle with libgit. Just
> imagine what this would involve: you'd have to have timeouts (since there
> is _NO_ other way to find out when to return with empty hands, instead of
> blocking), which is _not_ portable. You'd soon be in the same _mess_ we
> are talking about with respect to exceptions.
>
> Also, you would make _all_ operations expensive, since they _would_ have
> to store state to be restartable.
>
> The common solution for your problem _is_ to use threads.
>

I would say, the common solution to have non blocking libgit is to use
threads in the tool linked with libgit.

This is clearly a  design choice and I agree it's an important
statement to keep libgit simple and portable (otherwise you'd probably
need to use a thread library as pthread in libgit). Thread facility in
Qt is instead already portable and well integrated. Anyway it's a
design choice perhaps worth documenting.

> And you have to admit that _only_ viewers would need asynchronous access
> anyway. I doubt that other tools -- which could take their advantage of a
> libgit -- would need such an access.
>

Yes, and you have to admit ;-)  that viewers are the tools that mostly
will use libgit.

    Marco
