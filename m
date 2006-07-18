From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Tue, 18 Jul 2006 20:49:48 +0200
Message-ID: <81b0412b0607181149k74165724pa0a513d14704ce73@mail.gmail.com>
References: <20060706055729.GA12512@admingilde.org>
	 <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de>
	 <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org>
	 <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com>
	 <Pine.LNX.4.64.0607171431010.2478@evo.osdl.org>
	 <f36b08ee0607180238i34cde4deib17426f121ae269e@mail.gmail.com>
	 <Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Yakov Lerner" <iler.ml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 18 20:50:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2udl-0001yH-RE
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 20:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGRStv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 14:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGRStv
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 14:49:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:36123 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932359AbWGRStu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jul 2006 14:49:50 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2385785ugc
        for <git@vger.kernel.org>; Tue, 18 Jul 2006 11:49:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWUODhYW4OC4wcZZssiFoFRCtT4r44nqajlLZq6L4XL4+TQ/Q23Ws+byIVblo6FWWLj1yVhfg/b90sSZ3G6TtEdHGktC/HveuGu2hNRSkEGdmYVrPwEMw2eCkXfNYPZxqOjBpxZ//KRnT75f3QHAlxBb53pSXw+1DdphhNLv1Bw=
Received: by 10.78.156.6 with SMTP id d6mr1705744hue;
        Tue, 18 Jul 2006 11:49:49 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Tue, 18 Jul 2006 11:49:48 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607180837260.3386@evo.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23998>

On 7/18/06, Linus Torvalds <torvalds@osdl.org> wrote:
> So I really think we should just basically always mmap the pack-files (it
> should work everywhere), and make NO_MMAP just trigger on the other cases.

And while we are at it make a mental note about avoiding platforms with
broken mmap. For instance, QNX6 mmap with MAP_PRIVATE _always_
makes a copy of the whole! file, the stupid thing (they even documented it so!).
The alternative flag, MAP_SHARED, does not work on some filesystems at all.
