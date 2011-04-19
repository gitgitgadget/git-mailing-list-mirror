From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 00/11] gitweb: Change timezone in dates using JavaScript
Date: Tue, 19 Apr 2011 03:26:28 +0200
Message-ID: <201104190326.29922.jnareb@gmail.com>
References: <1302878645-458-1-git-send-email-jnareb@gmail.com> <7vei4z6omh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 03:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBziG-0005Xw-G9
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 03:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753804Ab1DSB0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 21:26:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61298 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab1DSB0i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 21:26:38 -0400
Received: by fxm17 with SMTP id 17so3024405fxm.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 18:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=e7SiHwMxjKHuHTmGtg9DXxiRzXUnkSsWENsmgNkeERQ=;
        b=tlYOnLOYG7Hufu3mSmrpIjQT+69GODjDagoEQPrJAtAUkuxS6gI11c41lBnQj1noVW
         2v6OHUsyhuFoDorHOatLNdL0dBYGManMBgaFIUrEcVv3FhTNKIPdByiJT4kHkjThJ9Pp
         1JqNOgcVcLcLiqtA38XHw2ww9mjhd/fa6JqZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D51ev2z1inFCwXBHyMUfjbJgNDz32M6eraznNEVE2aSUTC7mPEBq6Mecs+04YK/UH6
         q+GzielPuRBd1v6fRJyDuCWFS/hKGUoXRXY6xr2QFrP8tDSc5ASt5Us9vAo6mcltc20Z
         3DyD8VvnJGRqhBnSn0+plbgplBXNKzW9yyu3Q=
Received: by 10.223.9.137 with SMTP id l9mr161158fal.25.1303176397645;
        Mon, 18 Apr 2011 18:26:37 -0700 (PDT)
Received: from [192.168.1.13] (abvc126.neoplus.adsl.tpnet.pl [83.8.200.126])
        by mx.google.com with ESMTPS id j18sm1749912faa.18.2011.04.18.18.26.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 18:26:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vei4z6omh.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171770>

Junio C Hamano wrote:

> This seems to break the build like this, by exposing a lack of dependency
> somewhere in the Makefile:
> 
>     ...
>     SUBDIR gitweb
> make: *** No rule to make target `gitweb/static/gitweb.js', needed by `git-instaweb'.  Stop.
> make: *** Waiting for unfinished jobs....
> 

Ah, thanks for report. and sorry for the bug.

This bug is caused by the fact that main Makefile doesn't know (as it should)
that gitweb.js is now generated file.

The trouble is how to write rule for gitweb/static/gitweb.js, proxying it
to gitweb/Makefile, without having to repeat its dependencies...
-- 
Jakub Narebski
Poland
