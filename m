From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH 1/2] http.c: fix compiling with libcurl 7.9.2
Date: Thu, 18 Jun 2009 17:26:11 +0100
Message-ID: <e2b179460906180926h47070d2aw4a50e3a8547cfb61@mail.gmail.com>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
	 <7v63eyp10m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Mark Lodato <lodatom@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
	Daniel Stenberg <daniel@haxx.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHKRm-00019q-Un
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 18:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283AbZFRQ0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZFRQ0c
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 12:26:32 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45710 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbZFRQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 12:26:31 -0400
Received: by bwz9 with SMTP id 9so1208163bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tTt57Uwbsc3A+3y+leiWMDO1Ci40kuUFCLBJMGcFnDM=;
        b=Gdg+twwRnwB/onzOnFQyFNNk30SH0+uE611EgypBMbcXk0uVb3pefeZcjKa0fi0ivG
         Fntlm3HEFhf7LYrJKb1N8Oixk8btNckZyQK9FLon/xdnrsQpXNDjeWs01UZ8cyVlifrA
         Un62yAU+UF91Attv7+NY7rBA8xIT87jEaDSQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fXAtpFw0LHol64375+ITy3UK35rrtgrN25Ftiqj4xWtljkvGHSwQcHh67tA1IVFaC/
         XKCnR4bIjizHy4YfqoXzDTNpv9rI4ujbK+TXVXQbyF63ViFLQLZQStyqfRFYb/Y0+g2M
         GdDh1eXDbljBPxDwIhTam7uODyyJnsh2VtEZw=
Received: by 10.223.126.69 with SMTP id b5mr1398754fas.54.1245342372427; Thu, 
	18 Jun 2009 09:26:12 -0700 (PDT)
In-Reply-To: <7v63eyp10m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121854>

2009/6/15 Junio C Hamano <gitster@pobox.com>
>
> Mark Lodato <lodatom@gmail.com> writes:
> > Note that git still does not compile on libcurl before 7.9.1 or below,
> > since CURLOPT_FTP_USE_EPSV (http.c:236) is defined in libcurl 7.9.2.
>
> I think we didn't quite follow an old thread through, then.
>
> Cf. http://thread.gmane.org/gmane.comp.version-control.git/113985/focus=114014
>
> Both Mike's in the thread Cc'ed.

Yep, apologies for having dropped the ball on this. I had got back to
it but parked it again while Ray Chaun's series was in flight.

Will be offline for a couple of weeks around solstice / Glastonbury
but able to pick it up again after that if no-one beats me to it. I've
noted Daniel's point below also:

2009/6/12 Daniel Stenberg <daniel@haxx.se>:
> On Thu, 11 Jun 2009, Junio C Hamano wrote:
>
>>   #if !defined(CURLOPT_KEYPASSWD)
>>   # if defined(CURLOPT_SSLKEYPASSWD)
>>   #  define CURLOPT_KEYTPASSWD CURLOPT_SSLKEYPASSWD
>>   # elif defined(CURLOPT_SSLCERTPASSWD
>>   #  define CURLOPT_KEYTPASSWD CURLOPT_SSLCERTPASSWD
>>   # endif
>>   #endif
>
> Just note that these CURLOPT_* symbols provided by libcurl are enums, not
> defines, so unfortunately you can't do it this exact #ifdef way.

Mike
