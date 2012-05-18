From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] Add convenient function to do automatic garbage collection
Date: Fri, 18 May 2012 15:37:30 -0700
Message-ID: <xmqqvcjt15g5.fsf@junio.mtv.corp.google.com>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
	<1337171377-26960-1-git-send-email-pclouds@gmail.com>
	<1337171377-26960-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Fernando Vezzosi <buccia@repnz.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 00:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVVnm-0001Pq-LH
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 00:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909Ab2ERWhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 18:37:33 -0400
Received: from mail-wg0-f74.google.com ([74.125.82.74]:57155 "EHLO
	mail-wg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563Ab2ERWhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 18:37:32 -0400
Received: by wgbdt11 with SMTP id dt11so220048wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 15:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=JwOsgWaao3eN1MsD60R8yi2XbypFVOq0b1WE24ia6pc=;
        b=fUCc1Ik359ru21Q0zVDu3GAq9i368t0icGJTSArEgeDNzW4jA7H+Be5yFRthXSHv5l
         5iVleQSGwa6IqchnXzrCB2sxHhVZ7+k2I/TR4Myx7z53T06Rum/Amos7RwEfyYNYpciu
         BhwQ7UKCC0amKSSLnLPR7BlA9jmmsRVI4Xxi118/eeRQflt1EPK5fMHB7gkdDKZq2KmT
         2JvTfdziYclhxQFmHyqgPaG/hcoCoQMbchd8Uar7dK+N3XIlW3FLIIo+rMlXii1FNZaY
         xUHLbf3nuOR6P1LB1Z4dfGgyaRhKZnX8yz4eTlyoqulcgIGyNO2l72nMF76ony98p7Fe
         9tsg==
Received: by 10.14.99.208 with SMTP id x56mr2726570eef.1.1337380651219;
        Fri, 18 May 2012 15:37:31 -0700 (PDT)
Received: by 10.14.99.208 with SMTP id x56mr2726557eef.1.1337380651117;
        Fri, 18 May 2012 15:37:31 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id d52si9967461eei.1.2012.05.18.15.37.31
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 15:37:31 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id E50965C0141;
	Fri, 18 May 2012 15:37:30 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4429EE1772; Fri, 18 May 2012 15:37:30 -0700 (PDT)
In-Reply-To: <1337171377-26960-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:29:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmOUXyfeG6FnCk7LDCxwYqhw0KYSIbBx9EBlMUyx8A9hS5pnxN09kIRSnN7izh+OA0OW5p85U7ZO3vhW1NudIsud+waKP8OgQ2thGF+sOEdG3VZGVx1PFsOh2UbSfFH2LxA5Y9ab32n+lgpLEwB6qfxkdrwHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197980>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This function also avoids forking most of the time by performing some
> check in process.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ...
> @@ -64,6 +66,10 @@ static int gc_config(const char *var, const char *=
value, void *cb)
>  		}
>  		return git_config_string(&prune_expire, var, value);
>  	}
> +	if (cb && !strcmp(var, cb)) {
> +		auto_gc =3D git_config_bool(var, value);
> +		return 0;
> +	}

This does not look like "add convenient function for auto-gc" nor "avoi=
d
forking"; it is something else that is not explained.

> +int gc(const char *cmd, int flags)

Don't call this "gc".

It is hardcoded to perform a cheaper version "gc --auto" and nothing
else, and it may not even do that when configured not to.

I do not think the first parameter to this function is "cmd"
(abbreviation of "command") either.  Isn't it a configuration key to
tell if auto-gc is allowed, or something?

Other than that, it seems to be a nice change.
