From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 20:09:43 -0400
Message-ID: <CAPig+cR989yU4+JNTFREaeXqY61nusUOhufeBGGVCi29tR1P5w@mail.gmail.com>
References: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
	<20160531225628.GA4585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 01 02:09:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7tjI-0006Rw-FG
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 02:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550AbcFAAJo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 20:09:44 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35681 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbcFAAJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 20:09:44 -0400
Received: by mail-io0-f196.google.com with SMTP id k19so918387ioi.2
        for <git@vger.kernel.org>; Tue, 31 May 2016 17:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=emMe4gZtgzV0W1bgvakyiZIGmXFiVEP659veJT8N//s=;
        b=JDN1PdHAvE5j1utdy2Gm9gONIU3UEsjEqCOhxsD0gT4hWxIf4CFvOTCvbganZcdmRI
         pUqZz6IVXyY0nR2V4ExALvpJRZmYrItpaB2IWzH6HhOUREHyI8GTonjScAW0ftlmxman
         TYew+J6bB/GNR+uTdC7EWV3mmI4TMEeJENFWLuUIAQFDWJlPzNURLVpf5ncKvtO8+lrf
         PtNOF2wglL2UWCq41WiIHByoN23tEiKRLAwILDf+JJfmLoelyYtBTpxYqsVC/6Chbevh
         sb4Zj7zlXbrhUYJ5a4aIfNYUWJzrFxZxmsu1fodJLTnYr3/Yd3VLQ4329ljhOZuRSvCh
         uu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=emMe4gZtgzV0W1bgvakyiZIGmXFiVEP659veJT8N//s=;
        b=SM3Es6hdsUuYmowZ7nOvaVvprh2gwWGzOJ7/fQ6d3oFcq37W/abh9b3Z9/TXshFjen
         zb4MKbGjvcmuY5hRr/Zpp8h5M3QPulNSNDdIkrC5zQEaUm3JLGv2PApcUpf42s6D/8Q8
         unT48jtl9RGV4DDXUYnvQRhTBozQPgvWvFLJMReLNXEZsSDxiUybGio1tPgwRQhYfxdT
         g22S0i/yCZDg6B6nkhZrmlrAaY6bccF+R5Bu20Aivn5EBc6Rjtj3eeS4sGZGhLg5zyyS
         rxJ63R/Hnuqby0LVYv8KFBhm+RFCF8TImZCUGaNLYX17Zj43N32xrFKxzztmHta3LSyF
         7Rxg==
X-Gm-Message-State: ALyK8tLnUurVNODrAFDqvq4y4/J+RHtR1S1AZKwqAnT4WP1iTW2zdQAuFURARCt25c/13wcN3mBNsRYQWlaxSQ==
X-Received: by 10.107.47.98 with SMTP id j95mr1530995ioo.168.1464739783188;
 Tue, 31 May 2016 17:09:43 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Tue, 31 May 2016 17:09:43 -0700 (PDT)
In-Reply-To: <20160531225628.GA4585@sigill.intra.peff.net>
X-Google-Sender-Auth: Khe6IkCcvFAvThXV4SpZc8PgFxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296042>

On Tue, May 31, 2016 at 6:56 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 31, 2016 at 03:53:15PM -0700, Junio C Hamano wrote:
>> One-shot assignment to an environment variable, i.e.
>>
>>       VAR=3DVAL cmd
>>
>> does not work as expected for "cmd" that is a shell function on
>> certain shells.  test_commit _is_ a helper function and cannot be
>> driven that way portably.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> @@ -1072,7 +1072,7 @@ test_expect_success '--from omits redundant in=
-body header' '
>>  test_expect_success 'in-body headers trigger content encoding' '
>> -     GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &=
&
>> +     (export GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc"; test_commit=
 exotic) &&

Isn't "export FOO=3Dval" unportable?

> Thanks. This one is my fault. There's another use of the same name
> elsewhere, but it's to call "git commit" directly, so it's OK.

I was under the impression that the project was moving toward 'env' to
deal[1] with this sort of issue.

[1]: 512477b (tests: use "env" to run commands with temporary env-var
settings, 2014-03-18)
