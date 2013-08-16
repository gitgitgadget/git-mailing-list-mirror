From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] create_delta_index: simplify condition always evaluating
 to true
Date: Fri, 16 Aug 2013 08:40:16 -0400
Message-ID: <CAPig+cT7KcoVgxnDXUgYuxbpcTkUGqi8m56ArFbYxS5ubftxCw@mail.gmail.com>
References: <1376595460-6546-1-git-send-email-stefanbeller@googlemail.com>
	<20130816114346.GC5123@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Aug 16 14:40:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJKR-00067R-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 14:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3HPMkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 08:40:22 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:42964 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756196Ab3HPMkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 08:40:19 -0400
Received: by mail-la0-f50.google.com with SMTP id ek20so1439331lab.9
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=O4B7Y8QlJzWh04EWYL33vdvuiHpYF46N6G7X1ZbkVTk=;
        b=wg0vbHSJraCLJ7dzGNZkMR9wNG+gg9AEMUCxLFo4yEjKewGfRORXrcXsK3FX7hVPvY
         zDxPJ63nYvVa6bvEonLp5GIrEEXepJkwDEGiCELSquV8p77NNrk7RNAE//3A6Iy+E00+
         0NsahhfcUBq8O+uFIBFOQA8dx52mkd2YYzFX+CbsFT7KU4Pu+rSfGV2ooH9TOP2LQ6Dm
         9DxUNJLcpJgc+EwMYKGrXEwrjUAbsUMYxoC4ImhWxDEq4zGngOo66nxxqnwaImI1SLg2
         IFHDlbcC42hZttCah+jM05sEaEe2HWx4ZWsy5Vn8V7w3YlCyarD5e1nCOAyhRNRHby2H
         IRZw==
X-Received: by 10.152.45.106 with SMTP id l10mr1179481lam.12.1376656816881;
 Fri, 16 Aug 2013 05:40:16 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 05:40:16 -0700 (PDT)
In-Reply-To: <20130816114346.GC5123@vauxhall.crustytoothpaste.net>
X-Google-Sender-Auth: -joNxgXPO4ONrCyV9SCH6rSWrPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232421>

On Fri, Aug 16, 2013 at 7:43 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Aug 15, 2013 at 09:37:40PM +0200, Stefan Beller wrote:
>> When checking the previous lines in that function, we can deduct that
>> hsize must always be smaller than (1u<<31), since 506049c7df2c6
>> (fix >4GiB source delta assertion failure), because the entries is
>
> the entries are

'entries' is a variable name, thus singular. Stefan corrected it in v2
to say "because entries is capped..." (though it would have been even
a bit clearer to add quotes around 'entries').

>> capped at an upper bound of 0xfffffffeU, so hsize contains a maximum
>> value of 0x3fffffff, which is smaller than (1u<<31), so i will never
>> be larger than 31.
