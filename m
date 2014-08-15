From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 11:51:11 -0700
Message-ID: <3463C0CF-5E65-4934-A6C2-D466AB7B1144@gmail.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de> <53ED0257.3070505@jump-ing.de> <xmqqppg21wyk.fsf@gitster.dls.corp.google.com> <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c> <xmqqbnrl1ya1.fsf@gitster.dls.corp.google.com> <FF233C51-7AEA-4A10-8446-D8233F55E89B@gmail.com> <xmqqy4upzl1s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 20:51:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIMb8-0007iM-PB
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 20:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaHOSvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 14:51:18 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57733 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaHOSvR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 14:51:17 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so3794228pde.32
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=wPvIik+IpCxMk7tTVNUCPKRwhpK3jfx6bMppIUeGNnQ=;
        b=Al4JdsXyW9C4h5gF2+XkbIp5CtaXQK9EyyiL0R32uMufJ2oh2zoE/dIuhpPuW/EU2X
         nX19a+pG8UJN381wL8I05tnXds8RKo65Nn4GE1AG9GcwGacH2rWcBinUQO1GVN01rn7D
         mnv4xFLTShUZev6U0cKpXtp9M+mQnOpVZ+a6H/bHpKJ2anirnoq9kl+EUIy+vHLSncWw
         TuQ3Yy7MAVbvda9Sj0HqsPdFQK+VlMw0hiNCpaIHlg0iNc3w3LRBkEdsCnySGqzDzkEH
         YTAlEEYhPMvNZKtah4Afiss+BPxZjQNdb/bA7CfYoNrHllk4JHjkX4lKRn9Ll+tdOqOo
         8xNw==
X-Received: by 10.68.179.66 with SMTP id de2mr14657949pbc.31.1408128674536;
        Fri, 15 Aug 2014 11:51:14 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id x9sm12972298pdi.88.2014.08.15.11.51.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Aug 2014 11:51:13 -0700 (PDT)
In-Reply-To: <xmqqy4upzl1s.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255300>

On Aug 15, 2014, at 11:04, Junio C Hamano wrote:

> The 10.1.0 anomaly actually was bothering me, too.  How
> about doing it this way?
>
> -- >8 --
> Subject: [PATCH v2] config.mak.uname: add hint on uname_R for MacOS X
>
> I always have to scratch my head every time I see this cryptic
> pattern "[15678]\."; leave a short note to remind the maintainer
> and the reviewers.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> config.mak.uname | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index f8e12c9..414760f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -86,6 +86,10 @@ ifeq ($(uname_S),Darwin)
> 	NEEDS_CRYPTO_WITH_SSL = YesPlease
> 	NEEDS_SSL_WITH_CRYPTO = YesPlease
> 	NEEDS_LIBICONV = YesPlease
> +	# Note: $(uname_R) gives us the underlying Darwin version.
> +	# - MacOS 10.0.* and MacOS 10.1.0 = Darwin 1.*
> +	# - MacOS 10.x.* = Darwin (x+4).* for (1 <= x)
> +	# i.e. "begins with [15678] and a dot" means "10.4.* or older".
> 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
> 		OLD_ICONV = UnfortunatelyYes
> 		NO_APPLE_COMMON_CRYPTO = YesPlease
> -- 
> 2.1.0-rc2-283-g1433d67
>

Very nice.
