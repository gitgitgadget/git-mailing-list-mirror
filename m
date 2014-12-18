From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-compat-util: suppress unavoidable Apple-specific
 deprecation warnings
Date: Thu, 18 Dec 2014 09:03:25 -0500
Message-ID: <CAPig+cT+VUDNRgdWw9F4RLP63wvh8H=waCv5shpV-gxcwKU3bg@mail.gmail.com>
References: <1418771976-15060-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 15:03:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1bfx-0006HP-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 15:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaLROD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 09:03:28 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:61545 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbaLRODZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 09:03:25 -0500
Received: by mail-yk0-f179.google.com with SMTP id 19so531544ykq.38
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oVYeNVQR6MyKrh/4Xi/eT7JTMNMbbvnE2KVa/4RvrwI=;
        b=INdxHo1FNvc8ef7datg4QbiKwXcR0U+k/sO6UK5vvu3JMgbpYz9BQqnWqow1qcEx9N
         57hlhzXcxFO6JAu4Afa7VlOlVWpG1YtPtA+H+sIKfpigqUV8F1fLHNpywDP21iOBVSMR
         OFkti6/MAmMljHlnbsxkz5HWJDs9OvrUJf/SolFRTK3QRtm9EE5oTOomte1OYUYS2XS2
         rpc67iQsFH55uvLd0DKI7NyY4eAWoBAfq5CmmDpoGvJrWRtFQ7qXsZgZ072h/9tnbd01
         CBxKXtBSzmSEyc6MP/vNUUBJ6ZdJ+3BdQnQea65BYGC93McgjIjxtdsaCASBjwsVVOid
         39HQ==
X-Received: by 10.236.105.210 with SMTP id k58mr1861734yhg.52.1418911405081;
 Thu, 18 Dec 2014 06:03:25 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 18 Dec 2014 06:03:25 -0800 (PST)
In-Reply-To: <1418771976-15060-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: AmCEqfU26nlZDyIInxAi6MZrxMs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261525>

On Tue, Dec 16, 2014 at 6:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> With the release of Mac OS X 10.7 in July 2011, Apple deprecated all
> openssl.h functionality due to OpenSSL ABI (application binary
> interface) instability, resulting in an explosion of compilation
> warnings about deprecated SSL, SHA1, and X509 functions (among others).
>
> 61067954ce (cache.h: eliminate SHA-1 deprecation warnings on Mac OS X;
> 2013-05-19) and be4c828b76 (imap-send: eliminate HMAC deprecation
> warnings on Mac OS X; 2013-05-19) attempted to ameliorate the situation
> by taken advantage of drop-in replacement functionality provided by

s/taken/taking/

(despite proof-reading multiple times)

> Apple's (ABI-stable) CommonCrypto facility, however CommonCrypto
> supplies only a subset of deprecated OpenSSL functionality, thus a host
> of warnings remain.
>
> Despite this shortcoming, it was hoped that Apple would ultimately
> provide CommonCrypto replacements for all deprecated OpenSSL
> functionality, and that the effort started by 61067954ce and be4c828b76
> would be continued and eventually eliminate all deprecation warnings.
> However, now 3.5 years later, and with Mac OS X at 10.10, the hoped-for
> CommonCrypto replacements have not yet materialized, nor is there any
> indication that they will be forthcoming.
>
> These Apple-specific warnings are pure noise: they don't tell us
> anything useful and we have no control over them, nor is Apple likely to
> provide replacements any time soon. Such noise may obscure other
> legitimate warnings, therefore silence them.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
