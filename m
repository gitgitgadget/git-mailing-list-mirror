From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2 v2] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add   strbuf_initf()
Date: Thu, 06 Mar 2008 17:38:37 +0100
Message-ID: <47D01E0D.1090801@viscovery.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>  <7vir00lski.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>  <alpine.LSU.1.00.0803061153400.15786@racer.site> <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com> <alpine.LSU.1.00.0803061319590.15786@racer.site> <alpine.LSU.1.00.0803061727120.3941@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Reece Dunn <msclrhd@googlemail.com>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 17:40:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJ86-0006pK-Mg
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760184AbYCFQin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbYCFQin
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:38:43 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54151 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbYCFQim (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 11:38:42 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JXJ6U-0002zy-90; Thu, 06 Mar 2008 17:37:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E88CC6D9; Thu,  6 Mar 2008 17:38:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LSU.1.00.0803061727120.3941@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76397>

Johannes Schindelin schrieb:
> The most common use of addf() was to init a strbuf and addf() right away.
> Since it is so common, it makes sense to have a function strbuf_initf() to
> wrap both calls into one.
> 
> To do that, we implement a (really minimal) vaddf() lookalike to
> vsprintf().
> 
> At the moment, it only handles %u, %i, %d, %l, %o, %x and %X with size
> indicators '<number>', ' <number>' and '0<number>', as well as %c and %s,
> the latter with size indicators '.*' in addition to the same size
> indicators as for numbers.

WTF?

You did not cater for PRIuMAX, which is %llu except on Windows, where it
is %I64u. We can make it %llu on Windows only if we can ensure that none
of its uses ends up in a regular *printf function!

-- Hannes

