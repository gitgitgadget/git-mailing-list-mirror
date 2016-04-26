From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] clone: add `--shallow-submodules` flag
Date: Tue, 26 Apr 2016 10:51:18 -0700
Message-ID: <CAGZ79kan6bBH236nBvTUdV2KiaB9hW6KOCz_rWqk513CGN30mg@mail.gmail.com>
References: <1461633147-23131-1-git-send-email-sbeller@google.com>
	<xmqqtwiogt4y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 19:51:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av78w-0006Aa-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 19:51:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbcDZRvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 13:51:20 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33643 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcDZRvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 13:51:19 -0400
Received: by mail-io0-f171.google.com with SMTP id f89so23429773ioi.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=efhxs9xVbOwBUhVGHWquNbw3Ek9yT5CFQ2d81G7c9Ko=;
        b=fvff1HFZabukms05I38E+s+2BznXCtc8MINROL5Z0O7C8pdgvZI9yutp0x4S9uafUF
         nROHmuaDacOn3bLvY9hXTULre5yY9QvLWccFW4g46X/l5adAdwIz/OQDXH8YBZFp/b2/
         lWzYFccTP5+GUEzSSVCC/FO0zut2x0b0kPMYhTk1RQ3FChe4MKbH2x5xPiLMPANaJIZA
         rmtQdIl1AGAn2/X2CaCYpnxfe5GDohwLW8ef/OwH3bG5PnGZJhof0xbRNuBUbAFtafa+
         NI+b+OCeT02Wg3lVB/UyIDSbEdWjvmBArVhIf4J+MvIG9jDZbG6XoXRGhTkw5FNNfE65
         TL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=efhxs9xVbOwBUhVGHWquNbw3Ek9yT5CFQ2d81G7c9Ko=;
        b=aK0Rvs+KkcwSbrwI4R9+uMtbc1qi125wfmBLvabJlmJGqzJTDd3oytVb5MBEpptntu
         yBAC7ImYazX2P5GgnO7CBu9hp7dlUb35MWGcysU45+Xzzaw4GaIH5buWJ268rT/nr5RH
         xNCXezmrTnyA704vgj2WRVke5kUlnN8sv/FOnedSTr161cmyRJYmLLFLD7T03g3WFqjd
         4DjRSWsMT7DgK0vmmShDA3AK+Xnr0nzl5AsghkWAmYfDUpqKyB2XCbyTvoCNjCRGVDQH
         wkPZ+WuaJ/KlRA2IlgcYp6/+CovtaESLryBg/tj4kaVvVZMZACHyyZnHcfmXKEneo7My
         ojyg==
X-Gm-Message-State: AOPr4FVRatrwOyQ8YGa/nGRHJMjXqoeUTSju/jZ9oOptJzx4+JrqtzP9syCk+c255bB1otpowxZC9QEZxwP5qDyp
X-Received: by 10.107.53.200 with SMTP id k69mr4964521ioo.174.1461693078339;
 Tue, 26 Apr 2016 10:51:18 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 10:51:18 -0700 (PDT)
In-Reply-To: <xmqqtwiogt4y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292629>

On Tue, Apr 26, 2016 at 10:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  I did not rebase this on 85705cfb (Merge branch 'ss/clone-depth-single-doc',
>>  2016-01-20) or later, but worked on it with the base unchanged.
>
> Thanks, will replace.
>
>> diff --git a/t/t5614-clone-submodules.sh b/t/t5614-clone-submodules.sh
>> new file mode 100755
>> index 0000000..62044c5
>> --- /dev/null
>> +++ b/t/t5614-clone-submodules.sh
>> @@ -0,0 +1,85 @@
>> +#!/bin/sh
>> +
>> +test_description='Test shallow cloning of repos with submodules'
>> +
>> +. ./test-lib.sh
>> +
>> +pwd=$(pwd)
>> +
>> +test_expect_success 'setup' '
>> +     git checkout -b master &&
>> +     test_commit commit1 &&
>> +     test_commit commit2 &&
>> +     mkdir sub &&
>> +     (
>> +             cd sub &&
>> +             git init &&
>> +             test_commit subcommit1 &&
>> +             test_commit subcommit2 &&
>> +             test_commit subcommit3
>> +     ) &&
>> +     git submodule add "file://$pwd/sub" sub &&
>> +     git commit -m "add submodule"
>> +'
>> +
>> +test_expect_success 'nonshallow clone implies nonshallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules "file://$pwd/." super_clone &&
>
> All of these "$path/." made me wonder one thing.  I know these URLs
> that ends with slash-dot ought to work, but shouldn't they work
> without them, too?  The "consistency" in this test that ends
> anything that would have ended with "$pwd" with "$pwd/." somewhat
> bothered me.
>

Another case of me not thinking it through. There used to be just '.'
in the former
series with the --no-local option. And to make it a file url I just
prefixed that dot
without thinking if the dot is still needed.

In case another reroll is needed, I'll fix that up, too.

Thanks,
Stefan
