From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] test-lint-duplicates: check numbering in contrib/remote-helpers
Date: Wed, 3 Apr 2013 00:00:17 -0400
Message-ID: <CAPig+cTCTbbA+sqJSc00OOhyxwQ-jPJ3SSGF=Hi8+P+OG=wEkQ@mail.gmail.com>
References: <201304021853.48643.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Antoine Pelisse <apelisse@gmail.com>,
	felipe.contreras@gmail.com, Git List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 03 06:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNEsT-0002rP-Em
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 06:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841Ab3DCEAU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Apr 2013 00:00:20 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:33382 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3DCEAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Apr 2013 00:00:19 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so1045231lab.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 21:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=APxg1fRhS9ey/fXmr2VoY+Z2qUEA/SdFOtv2AYNSNNw=;
        b=svGVVVoRlUJH5Tn3t9LwAcMtm5w7hEnZ8REisK2OYLUYvCdYAAj4C7wleth3XDUZzb
         SEE+uL4kYnutXatwjz2727qNLxd5HwPaSPZ2c+8i95jWFaaDNFikHwC8NqZyNXji72SO
         ERVKyzvRHwewICe71fmEz3Rfun8ZK/Fih3rm/8LpKenWYYmQDIXcCSAUdjm9gwsew7XE
         zoEqwifOxU+6EElz51MWBOXgWrszS8RL8sTWOvfP45NzERVVUC6+QL1qf2+FecFSNW3b
         LR9co9jJySSZxJ1wxc9dttodPqNPWob9L1rpA1Qk/eEPrFuBL+ysYxaXr7Bb1XQCAFa2
         ur0A==
X-Received: by 10.112.139.36 with SMTP id qv4mr219778lbb.82.1364961617663;
 Tue, 02 Apr 2013 21:00:17 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Tue, 2 Apr 2013 21:00:17 -0700 (PDT)
In-Reply-To: <201304021853.48643.tboegi@web.de>
X-Google-Sender-Auth: fXZ5QwDG8HPm8gdvi_8kZx_cV0k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219913>

On Tue, Apr 2, 2013 at 12:53 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> Running make inside contrib/remote-helpers failes in "test-lint-dupli=
cates"

s/failes/fails/

> This was because the regexp to check for duplicate numbers strips eve=
rything
> after the first "-" in the filename, including the prefix.
>
> As a result, 2 pathnames like
> "xxxx/contrib/remote-helpers/test-bzr.sh" and
> "xxxx/contrib/remote-helpers/test-hg-bidi.sh"
>
> are both converted into
> "xxxx/contrib/remote", and reported as duplicate.
>
> Improve the regexp:
> Remove everything after tNNNN- (where X stand for a digit)
>
> Rename the tests in contrib/remote-helpers into
> t5810-test-bzr.sh,
> t5820-test-hg-bidi.sh,
> t5821-test-hg-hg-git.sh,
> t5830-test-hg.sh
>
> Feed the numbers used in contrib/remote-helpers into t/Makefile
> and check that numbering is unique across both directories
