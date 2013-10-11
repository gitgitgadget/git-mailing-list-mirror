From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] Update documentation for http.continue option
Date: Fri, 11 Oct 2013 16:50:52 -0700
Message-ID: <20131011235052.GV9464@google.com>
References: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
 <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 01:51:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUmU1-0002LV-Ph
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 01:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab3JKXu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 19:50:57 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:37290 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab3JKXu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 19:50:56 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so4961313pdi.14
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KtCG/KKfRacCcqxMYOfBfR+B9NrfwT4zz/10wnMp438=;
        b=HJG8aaE2qMDHcyjgeAFqadL9+Hy1YqEs79e7haMcDen/SxobVGiqeIiYumabpW9pNE
         vEiBoso+VixlLIKYKQc91ZJhji5FNJJTLTrMiQzZD1KFS2l15/VPP76XeqIvoFxh1xVi
         NCLLAWGoXT0Lt6xmom1/pxTFv/NWsy3nM1U0G/uHwcqkQWQLYWFR/fllwZBBa/nMRjfc
         nokKR9nIs44Ty7YENgSwBwkN0A2UQvMHBVHQr/D7ptq0uQbIW43K+snjKcnfrSawzzPD
         0GMKdMfeK5R8e4/7flxAR7VGNKNbQTQlQCN97JQrUhMtBjoSInbv3WQ2NUZqMCJZvlJd
         t45A==
X-Received: by 10.66.251.1 with SMTP id zg1mr17613307pac.160.1381535456273;
        Fri, 11 Oct 2013 16:50:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xe9sm73196927pab.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 16:50:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381530945-90590-3-git-send-email-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235927>

brian m. carlson wrote:

> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1516,6 +1516,15 @@ http.postBuffer::
>  	massive pack file locally.  Default is 1 MiB, which is
>  	sufficient for most requests.
>  
> +http.continue::
> +	Ensure that authentication succeeds before sending the pack data when
> +	POSTing data using the smart HTTP transport.  This is done by
> +	requesting a 100 Continue response.  For requests larger than
> +	'http.postBuffer', this is required when using GSS-Negotiate
> +	(Kerberos) authentication over HTTP.  However, some proxies do not
> +	handle the protocol exchange gracefully; for them, this option must be
> +	disabled.  Defaults to disabled.

It's not only your company's proxy that might mishandle 100-continue
but the target server's reverse proxy (or from the point of view of
the user, the target server), right?

I think the wording could be clearer about the impact of the setting
("some proxies and reverse proxies" or something).

Perhaps this should be conditional on the authentication method used,
so affected people could still contact broken servers without having
different configuration per server and without having to wait a second
for the timeout.

Thanks,
Jonathan
