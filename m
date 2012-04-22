From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revert: add missing va_end
Date: Sat, 21 Apr 2012 22:20:02 -0700
Message-ID: <xmqqd370mjgd.fsf@junio.mtv.corp.google.com>
References: <20120421211520.2797.87418.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 22 07:20:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLpDd-0002wD-O3
	for gcvg-git-2@plane.gmane.org; Sun, 22 Apr 2012 07:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab2DVFUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Apr 2012 01:20:11 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:40319 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2DVFUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2012 01:20:10 -0400
Received: by lbol12 with SMTP id l12so325580lbo.1
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 22:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=Sz3qr5Z1slCVyEGUwiFH3RlbcDQJ/nFZg2LSFroFIA0=;
        b=kEiLcu1Ico/PQ1tNpdj74Iinri2B0lLnecy1c9aK4MB0aA2nRW29Nsml5WuMfP7xgg
         4bD5ZwIAduvaC7wROap7J0O+LdVWKmevH8zd4PC74ZeEr4nx7soMI/ev5AIWT+yYs2FA
         ZjwoiEoayqCxeoKdmkKX1Oxd/38V7rgbSaI3p9lB06+Txa3W/qGZIbiYEP6qpAA8lI31
         vKxgtxwSgy2JxMmno2JgCU8cW/Pkw2XIxGBpIYOo5IB7enrq69CcQqbQVh8y67GvMhb7
         goLIIBv4o7GApK2302oDLF6JSRibUq+i6CHOgObkEzeJQeSNuCyOQp9yMY6D7touEIdV
         GJQg==
Received: by 10.14.101.16 with SMTP id a16mr3006736eeg.0.1335072008573;
        Sat, 21 Apr 2012 22:20:08 -0700 (PDT)
Received: by 10.14.101.16 with SMTP id a16mr3006720eeg.0.1335072008475;
        Sat, 21 Apr 2012 22:20:08 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si5728538eef.1.2012.04.21.22.20.08
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sat, 21 Apr 2012 22:20:08 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 4AC6C5C0060;
	Sat, 21 Apr 2012 22:20:08 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 95550E120A; Sat, 21 Apr 2012 22:20:02 -0700 (PDT)
In-Reply-To: <20120421211520.2797.87418.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 21 Apr 2012 23:15:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQlyCevMKYPMHLwtiq/QVWsOv+6pnC4SaTvC0SiwM2PkgsnjOEPr59mZPLxzTCSLqB06jXJA+s2YyV/+FXB07Rh6QWfZyK9ji5DUmy5YH3e4skWKkvWFIZ5dZ8hPFvKUGgQN5loF2y2Nusfwgb/nSs0epPcbinFM+coCkJzOUIQf1aRWr9o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196075>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/revert.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index e6840f2..e4ed023 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -86,6 +86,7 @@ static void verify_opt_mutually_compatible(const char *me, ...)
>  				break;
>  		}
>  	}
> +	va_end(ap);

Yeah, the original from v1.7.8-rc0~141^2~2 is obviously wrong.  Thanks.
