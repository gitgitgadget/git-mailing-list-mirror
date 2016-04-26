From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/83] builtin/apply: move 'check' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 09:31:17 -0700
Message-ID: <CAGZ79kauQU6B2EUcHyWck+ZP4G2OUAKrCkW3-PfsNZdijyF-TA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-10-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYUr9wQ--898OeyqVw_upqxfVNRsOveUAPSn=PtXZ4xBQ@mail.gmail.com>
	<CAP8UFD2rD5qo7TBPFdP5BifOGuWHAtZA2BNGDqnY_feoCfmKeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:31:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5tW-0006Dy-7q
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656AbcDZQbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:31:20 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:32894 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbcDZQbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:31:18 -0400
Received: by mail-io0-f178.google.com with SMTP id f89so21187773ioi.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LpRwZXkOzwf8BEVpIusG3UnaSsNjNQ3UuaZBwpq37PU=;
        b=JaiwnkujpxUm2BNc6+KYMF0dMYwSQY/ibh8pNrNeDvc+3uQ2L9TO+8VoI7pUzlSg92
         97EAIeTgVGYSItB5TUDVHh7NtbgNT6sylc1+G/0PmuKx19b5+ch5BxBHB72aChcZNBJb
         SaDHFRvIDnHVTkdbCanGivxl5A6sLyKHtDeR9VVLeDKzk2p/GT7f8nvC+4mERhDUXSlu
         VeQNxhFmQY9x5z4mSWNNmhXk/W3xEwVNyHDjmDl/Az209Q9QwC7YRwMwd5XeKik/3apL
         0UNHkh2SVky830OADoxDEhhyDxNnS2Z5HReB3B+l/pvrdlMAOK/CbBUqA1fDwVaLFfj5
         MMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LpRwZXkOzwf8BEVpIusG3UnaSsNjNQ3UuaZBwpq37PU=;
        b=CWWw5rM6f7DCVQvfdecHwdHitGPCRVfmZwvOKg16IHSUu73mgP+PGbITkfq5go6XkV
         LDidp3j7XHLWd66LBwTfqwTx3losFXPLuw8dGDA26/s8Xat7KifTR/ebgSdC8P0DVi1M
         RydgUHT7KRbm0Vh0GTvhxZY7hDu67qAxS+lJdVcCKeKT1LGXHKVgW+7dSGNH94FXDgrO
         3h2WigjWubQQEvyDQIzbYBquMa9xo18bO8OjR9KUt0s+z45p+hESzvF1nYL2cxSws6bk
         7POrRVqHHkqYk0I8OYcz2eSTpAB3rWdPa6DZB8pz9Rrid2MIE9CTvdPFAcV/+qP845jD
         BySw==
X-Gm-Message-State: AOPr4FVpAizjIGNkNl3TMgW9OVNk4qRlEMC3gXdZVNvn2tKaqmd8qz9kAgwLGZ0cBD2/9G/6guEKB2Qj3q8la2j0
X-Received: by 10.107.174.205 with SMTP id n74mr4572478ioo.96.1461688277235;
 Tue, 26 Apr 2016 09:31:17 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 09:31:17 -0700 (PDT)
In-Reply-To: <CAP8UFD2rD5qo7TBPFdP5BifOGuWHAtZA2BNGDqnY_feoCfmKeQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292612>

On Tue, Apr 26, 2016 at 9:26 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>>
>>>  /*
>>> - *  --check turns on checking that the working tree matches the
>>> - *    files that are being modified, but doesn't apply the patch
>>
>> Oh I see it was moved from here. Not sure if we want to rename
>> comments along the way or just keep it in this series.
>
> I kept the existing comments when they were still relevant.
> It could be a cleanup to change them to something like what you
> suggest, but as it is not important for this series which is already
> long, I prefer to leave it for now.

Yeah that was my conclusion as well after some thought.

Thanks,
Stefan
