From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 1/3] submodule: add test to demonstrate that shallow
 recursive clones fail
Date: Sun, 20 Mar 2016 14:27:36 -0700
Message-ID: <56EF15C8.9060309@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
 <1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
 <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
 <0767AEDB-36D6-45BE-A1CC-944ECAFC00FB@gmail.com>
 <20160320194049.GA6288@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 22:27:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahksy-0003fA-Hv
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 22:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbcCTV1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 17:27:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35284 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbcCTV1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 17:27:39 -0400
Received: by mail-pf0-f194.google.com with SMTP id u190so26852573pfb.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 14:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=moeq9gG1usRqY1uls/2FBo5g5eHIGZIY+7xWWT+z590=;
        b=bOGRVdP1P39d2RKnDjRw123S/0AxViSdJ/q6Lw+PUXFrzfFvcnl4EXqgHOQ47tvdLf
         yjcS/Gf1BlMZA/GGm1ubLIfr3/FMmH4+4OTqTCuFOBYIDUBYPlIoCGdPPSWPD5QQbtsX
         njdxfyBtSQu3tP3cavhUj+4OUYTW9jYO2+h2A5CTHGmTBwY60qrZAVgPWYz9qUsFXWyh
         B2hLDd7jAju42R2/WuAjAom8qaJjoxvSvzTQO2YxZC8PiR6+vr6WokgGkxGjNm3oJkjh
         11w36s15XcTdDHY/1/95lgz5YcCFsiIb6/r0Eqawsqw1qVLaYssMVDXbL0j83OujF51D
         AcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=moeq9gG1usRqY1uls/2FBo5g5eHIGZIY+7xWWT+z590=;
        b=mthhzKtfiw85GzjuCGz2buqOyA/EABCPSF8gknn8Vkg8uTl65NZDV5OAZnugBkukjr
         JfkaXAxLO/EUAGcvlEEjkfaspb7+VFGdJ0XN0vTCAA9WFop1R36BT4f90VaTV3fOxWF0
         mj0vc98P9WTxuZpeBZiyTx6u+THt44hipcga9jMb9RpOohIYOUrIadRT1Fu84+4zl+M+
         NhUs2wKRBWl1XQI8nlFsd2NnQozjoRGq0TMeloNnad80qJsEgReu0QgjmUkK1iHpulp9
         rZrv0WV3jes8mQ0tK0J1/PR5/8NFxIA9y/8jhoBPkgtewgUMZikyeCm/+XWypU2YsJfT
         eT6Q==
X-Gm-Message-State: AD7BkJKH+bhFYOETEa9skeBq4QTewzlj3FyvpYHnZL/aVrR3Nm8M/mpAM1/bnfC0NF0BrQ==
X-Received: by 10.66.55.70 with SMTP id q6mr39643584pap.126.1458509258738;
        Sun, 20 Mar 2016 14:27:38 -0700 (PDT)
Received: from [192.168.2.6] (c-73-252-161-196.hsd1.ca.comcast.net. [73.252.161.196])
        by smtp.googlemail.com with ESMTPSA id q85sm35369524pfq.81.2016.03.20.14.27.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 14:27:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160320194049.GA6288@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289385>

On 20.03.2016 12:40, Jeff King wrote:
> On Sun, Mar 20, 2016 at 06:05:34PM +0100, Lars Schneider wrote:
> 
>>>> +test_expect_failure shallow-clone-recursive '
>>>> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
>>>
>>> This would break if the test suite is in a path containing any other white space
>>> than U+0020 such as a tab? (Not that I am encouraging using such paths...)
>> True. I wonder if we really need to use the "file://" URL format here. Maybe
>> a relative would be easier?!
> 
> I did not look closely at the patch or the tests, but generally we skip
> shallow-cloning for local-path repositories, as we don't do a regular
> object transfer at all (and we turn that optimization off for file://
> URLs). So presumably it would defeat the purpose of the test.
> 
> -Peff

Please see proposed patches at $gmane/288940

By passing along the --[no-]local option we can have tests, without
using file:// explicitely.

Thanks,
Stefan
