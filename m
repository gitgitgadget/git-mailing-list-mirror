From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 0/2] bisect--helper: rewrite of check_term_format()
Date: Wed, 4 May 2016 10:55:41 +0530
Message-ID: <CAFZEwPMGaUfVJXn2Wdzy+R=YfYfP_1_O5ixbnLdkyQjFg9E-3g@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<CAP8UFD1k4N_qeVYrbJhetKX75ynLSSvQogccR9=nQSR6XwTRVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 07:25:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axpJk-000453-8T
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbcEDFZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:25:42 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34183 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbcEDFZm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:25:42 -0400
Received: by mail-yw0-f179.google.com with SMTP id j74so58483084ywg.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=o7+RP6PCHnlFM6F87HIBQ1A1BQDtygVbBxaD3awWjqE=;
        b=hb3UX8G/VOqHPV9+zoMORFEwRSjqg/A5zTKp5cSP9RPvQCFwYEJfLZorkoeGXWhh4r
         yC9An/NNsDX0vxKlM1tPjO/NLurSWRJ2wfr8nxwR8YoVP9E4rCVM4W0NKKuXhlwNsXZ8
         luj0QikNy7l8W22zh/l3SSzG39BAuZtRFWgcdVbdBmoaDBTNhPEJdriElG32g0wKH8tu
         aIr2ldbpeZBWXNYHyeXv6lKSDuMIWkgWdvoipFvLpSDFxYrVVqDpRY5ymjKxLkDv9XBI
         LsO4mA3tt+VKhWBZj5Ejz/9roUL/0sB7YzBXtgoxTbywHWWbCR6EYy3aGNDiiSaKYznc
         aROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=o7+RP6PCHnlFM6F87HIBQ1A1BQDtygVbBxaD3awWjqE=;
        b=cjHmSh2AN0m25gE/+VY45QsfJBoLUUlSesj5l+5dwBf2pYxXmJpHIbjtqPFZHi2+Zn
         ulYIR1UODkURlC3sXbfl25C8PfGL9lIiOz8CXG1PEYJFMF19nnimRdkt+QUhay92KVgi
         uYlV5Mr9q0Mg89bVMScmD6shV5Gb2uvGi7IaqjnuWNZL1OGunGgVA+L+1CXylPmQ6e2z
         8eCZDgnmzNvpMS4iRD4RKUgOcVCKeuXg6wHpOo/c6ua81nFjXGLFwCDH65OM7cOmVEq0
         P1WLOwDcIPOhSYMQTUj03SAzafP9kHud3FHVUapYReyjOIthTTTmYIafnIN13vL+vxub
         rz8g==
X-Gm-Message-State: AOPr4FUO2iawfPchDcvSq3WMGi+dzS09T44XyV8mPD67OFO90boQwUPc4uB7mgPK9kLrP09rvt05AFOle0nt7A==
X-Received: by 10.13.198.5 with SMTP id i5mr4208434ywd.263.1462339541371; Tue,
 03 May 2016 22:25:41 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Tue, 3 May 2016 22:25:41 -0700 (PDT)
In-Reply-To: <CAP8UFD1k4N_qeVYrbJhetKX75ynLSSvQogccR9=nQSR6XwTRVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293491>

On Wed, May 4, 2016 at 10:52 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Pranit,
>
> My gmail address is "christian.couder@gmail.com", not
> "christain.couder@gmail.com". ('i' and 'a' are in the wrong oder in my
> first name).
>
> Thanks,
> Christian.

Sorry. It was a typo.
