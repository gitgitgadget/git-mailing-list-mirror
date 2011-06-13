From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Make $prevent_xss protection for 'blob_plain' more usable
Date: Mon, 13 Jun 2011 23:49:59 +0200
Message-ID: <201106132350.00161.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <201106101401.19108.jnareb@gmail.com> <7v8vt5ptj4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matt McCutchen <matt@mattmccutchen.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 23:50:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWF1Q-0008QR-Fn
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 23:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1FMVuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 17:50:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42069 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab1FMVuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 17:50:06 -0400
Received: by bwz15 with SMTP id 15so4053071bwz.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=xbmkoIef5bKzyOgKEBVOKS0+JwX1cm9cO5qK59ksWsw=;
        b=owqdVlVndw9fSEIvz3hYwuNslw0vXU9iENBYsDE08bZsXOzJkHZv7LyRns2sDINkeT
         yeRjamRP38059CxV+DeTcZIdQALVVTuPEovyMHn0nSxkf50FLc4Jr9Nrl+OxB/Z62QgI
         BXYKrDY+vuhDpoP9r8lpHMkdPeHSntb0pEesA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=bywi4DYtzomnUKM9ghqmP3kUd7AV98e1efz/eUJsHsGO/eu1XdCzOCM4qGdpdJN4jX
         2NeAsXct37nYNIypl5wE+qUp4R4+vZhj6IcNITkt/Ch4kIMCavjRpndQUeyQpSXVbHQf
         +kEfuAWZK/xgNl2PNNacr4QjbJ2GDMPQ/iRRc=
Received: by 10.204.66.67 with SMTP id m3mr1196315bki.182.1308001805289;
        Mon, 13 Jun 2011 14:50:05 -0700 (PDT)
Received: from [192.168.1.15] (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id w5sm807835bkf.23.2011.06.13.14.50.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 14:50:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v8vt5ptj4.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175733>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > +	# serve text/* as text/plain
> > +	if ($prevent_xss &&
> > +	    $type =~ m!^text/([a-z]+)\b(.*)$!) {
> > +		my ($subtype, $rest) = ($1, $2);
> > +		$rest = defined $rest ? $rest : '';
> > +		$type = "text/plain$rest" if ($subtype ne 'plain');
> 
> Hmph, wouldn't it be more straightforward if you dropped the statement
> modifier?  I.e.
> 
> 	my ($subtype, $rest) = ($1, $2);
> 	$rest = '' unless defined $rest;
> 	$type = "text/plain$rest";

Yes, of course.

I don't know why I decided that avoiding rewriting 'text/plain; 
charset=utf-8' case was important.  It cretainly is not worth making 
code harder to follow.
 
Can you fix it during applying, or should I resend it?

> Other than that, looks good to me.

Thanks.
-- 
Jakub Narebski
Poland
