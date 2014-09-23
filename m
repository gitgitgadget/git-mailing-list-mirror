From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Tue, 23 Sep 2014 04:05:51 -0400
Message-ID: <CAPig+cQE2hKU0Q+8nMRyC3V1YgKVJDkyJCAR-gBh0UoawFAoUA@mail.gmail.com>
References: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
	<xmqqk34vlfhz.fsf@gitster.dls.corp.google.com>
	<CAPig+cTAFaG5H8rmf1jrvFwr_OOH7u19JMKDUE12UddokUmfaQ@mail.gmail.com>
	<20140923060407.GA23861@peff.net>
	<CAPc5daUbXtNXSn8_tspvdF+SH5aeX+jVJTramtOm96Dc1wCqtg@mail.gmail.com>
	<20140923075146.GA11104@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 23 10:06:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWL6q-0001bR-F4
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbaIWIF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 04:05:58 -0400
Received: from mail-yh0-f52.google.com ([209.85.213.52]:50815 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbaIWIFw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 04:05:52 -0400
Received: by mail-yh0-f52.google.com with SMTP id a41so2051389yho.11
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uk15gLGXEkwd90lnbC5XZC/1n7+pETmtnGrs8qSbYIY=;
        b=fJyH7+xasSpguOTQBGg4S5p6PSpCYTSS4/43lLgAn8UGCvYwHD60Axis2F/k8llw08
         yU8UJ5EJ3BTeoydXEgQQzF4BTBB+wj3lRPIeWQyLtG93qs4hGSN9CqBIb4xU+2V1TKiK
         J26DpDMuWyDt0uH0lNS+fLirHcM524HudtCbpgsEn7DpycFvtOFg/X8N5YVrAMogfxkk
         edPzri3N7Nzj6hNJaFVUtkOyRAq+qefpablDtqMQyfZufu/ca87fZESk46LuIr6ToEi+
         LT1SVmLP33yWTQlSP4VNCo48t6rI8k1J/MDoTkD89eHeQwFKozmyknx/iMstiXsMnHnk
         lVDQ==
X-Received: by 10.236.102.235 with SMTP id d71mr7692311yhg.88.1411459551498;
 Tue, 23 Sep 2014 01:05:51 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Tue, 23 Sep 2014 01:05:51 -0700 (PDT)
In-Reply-To: <20140923075146.GA11104@peff.net>
X-Google-Sender-Auth: abaikh316UhVS2vh59AWIW9rJjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257402>

On Tue, Sep 23, 2014 at 3:51 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 22, 2014 at 11:26:14PM -0700, Junio C Hamano wrote:
>
>> On Mon, Sep 22, 2014 at 11:04 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > I don't mind silencing this one warning (even though I find it a little
>> > ridiculous). I'm slightly concerned that more brain-damage may be coming
>> > our way, but we can deal with that if it ever does.
>> >
>> > Like Junio, I prefer keeping strlen() rather than switching to sizeof,
>> > as it is less error-prone (no need for extra "-1" dance, and it won't
>> > silently do the wrong thing if the array is ever converted to a
>> > pointer).
>>
>> I actually do not mind losing the sample[] array too much.
>>
>> But personally, I think the way it is coded is much easier to read,
>> and is much harder to get it wrong while maintaining it.  So...
>
> I agree. I was going to suggest switching to a static const array
> instead of a string literal, but retaining strlen()...but I see you
> already queued that in pu. So if what is there works for Eric (I do not
> have the compiler in question to test with), that seems reasonable.

What is queued in 'pu' is the same as my patch [1] minus the
superfluous strlen() => sizeof() change, so it works fine for me.
Thanks.

[1]: http://article.gmane.org/gmane.comp.version-control.git/257345
