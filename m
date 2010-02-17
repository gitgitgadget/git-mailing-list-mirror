From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] gitweb: Protect escaping functions against calling on undef
Date: Wed, 17 Feb 2010 17:26:53 +0100
Message-ID: <201002171726.53418.jnareb@gmail.com>
References: <20100207204539.11146.36972.stgit@localhost.localdomain> <20100207205130.11146.30664.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 17:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhmkE-0005Hm-JS
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 17:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0BQQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 11:27:08 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:54144 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab0BQQ1G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 11:27:06 -0500
Received: by fxm7 with SMTP id 7so8897705fxm.28
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1Pin3gfm8yFI2P8RHzmHnPdy2pJCoRBft886fxu0Z9s=;
        b=wG1ZFs5ohyODcqAp4bOhqrnLPN+oJXiGNtT088q7hbg0oTiZBvu83hkvuUFaoCMsN3
         6vMNoSEUOvstP08WqEGVahZKSorpRwtEyYj75X9ZX/lQ2AkZLiGeeBGOkxaNsFC9q5ug
         2OSNaQgAYbLTzd1aThGDpsi52Ga7Rk60FX4dY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=vHYZcBlA2RTZygera/bOmbMqlWs8QFQYp9h7RHCOWzAM45NqONN6FVJvFwUgXVt+2z
         NKJg7S9VWvzZDjirbiIINxsKtr2OZ72W7kOfW2ga9HdcKYz7y8gjF7YV74Me1lHQUghf
         f2Dn+Yah8MzY7ebO5yH6oRpM6KDZ0KJvPEkUE=
Received: by 10.87.70.31 with SMTP id x31mr14755614fgk.19.1266424022676;
        Wed, 17 Feb 2010 08:27:02 -0800 (PST)
Received: from ?192.168.1.13? (abuz209.neoplus.adsl.tpnet.pl [83.8.197.209])
        by mx.google.com with ESMTPS id e20sm6560565fga.10.2010.02.17.08.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 08:27:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20100207205130.11146.30664.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140238>

On Sun, 7 Feb 2010, Jakub Narebski wrote:

> This is a bit of future-proofing esc_html and friends: when called
> with undefined value they would now would return undef... which would
> probably mean that error would still occur, but closer to the source
> of problem.
> 
> This means that we can safely use
>   esc_html(shift) || "Internal Server Error"
> in die_error() instead of
>   esc_html(shift || "Internal Server Error")
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Without the second part (i.e. the change in die_error) those two
> patches would be totally independent.

Ping!

All but last chunk (last chunk depends on PATCH 1/2) are a bit of
hardening / defensive programming... although currently not necessary
(gitweb doesn't pass undef to its escaping subroutines... I think).

-- 
Jakub Narebski
Poland
