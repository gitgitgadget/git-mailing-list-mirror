From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: allow configurations that change with each
 request
Date: Mon, 2 Aug 2010 16:01:57 -0500
Message-ID: <20100802210121.GA3072@burratino>
References: <4C4D152A.7050505@gmail.com>
 <201007261623.05850.jnareb@gmail.com>
 <20100731030159.GD906@burratino>
 <201008022135.58287.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julio Lajara <julio.lajara@alum.rpi.edu>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:03:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2AR-0004RX-UB
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab0HBVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 17:03:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50371 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0HBVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:03:21 -0400
Received: by wyb39 with SMTP id 39so3709083wyb.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zrL4fNHM8AwM4h0DSN/qfkZaeytLxWB2aMWXbjFbUZU=;
        b=aEAFbKeuaiOsKwdImtIgHven7GXW/FguXr7l4TQwr79C7Zhwtwmn67IeJSxvozzToS
         57lRtgkwM2u1WaB1oFn3llbInqeLBrm5HKHXbb2xCCl4PHWskVA2nY1WaGNEzr22MQe5
         B8Rsmr6thObMDpPJTyCSbrzN+nOtbARk5Po+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Vrwd7QJkBvJRen1NngVTJHhX5XTlL/2+TgvuxYGFCQT/mORAlFoR8i0sjh2tb+mEow
         zETH9ixjysk2GUt4wqKMUfkgyrOFQwHGuzAdBbV2JKDM96lbNHcwgs/NyED9I0dQcPiP
         ofZ0aBwMm6UuWcKfpm8Xt8/rjnBMMvnvgkasQ=
Received: by 10.227.156.143 with SMTP id x15mr4924004wbw.39.1280783000002;
        Mon, 02 Aug 2010 14:03:20 -0700 (PDT)
Received: from burratino ([66.99.2.25])
        by mx.google.com with ESMTPS id u32sm3138176weq.11.2010.08.02.14.03.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 14:03:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008022135.58287.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152458>

Jakub Narebski wrote:

> One solution I can think of (still backwards incompatibile) would be to
> provide $per_request_config variable, which would hold anonymous sub
> with parts of config that need to be done per request (this should work
> with global variables (our), but I think it wouldn't work with lexical
> variables (my)).  For example gitolite's contrib/gitweb/gitweb.conf would
> then include:
> 
>   $per_request_config = sub {
>   	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
>   }

How would that interact with caching?  i.e., how would whatever caching
engine is used learn that $cgi->remote_user is part of the key needed to
uniquely determine a response?
