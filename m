From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Thu, 18 Apr 2013 19:30:34 -0500
Message-ID: <CAMP44s0bQ588w91aX9Df-89L+2Ax4X0caB+Uh-C-_B4=JX=G8A@mail.gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cRp7J+HYBA=2OL-CdA3NiQFjuUMZEjE+i+SnNrrPBAZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 02:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USzDs-000895-HX
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 02:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967671Ab3DSAag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 20:30:36 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:65259 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967617Ab3DSAaf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 20:30:35 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so3256732lbh.18
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=BKqgqX2uCg04YPbtim3LLelNbcDl+95yt+HTIK+eqk0=;
        b=uioWQDvszpNTiISxKf2KoXQmfHsCaisxOHdAOSdIcX2V/wH/fzJCBIClCfadjQDE+T
         9SIMOfGstIVzQ4FUMczrK2mtWAtm5SrfDkmPss4c4xwXQ8NRdEEWXUgzscANoKfP7SVr
         cWsdGshMyOWcPcdbj7t9JOGxZcy3BCD4hnrLOhK31roJfLKL+Cnq5I6tDw5zqn3Rp35T
         84hFBK93jJbNfhpdqrIDdpTfHb+LBjAQDEpv2ACttFknFth/x+Ied9IBnZAE9+yiprRc
         +bMd4+Yw9DIPwoXVDzBsLC0i6i9/6hlFQK5hp8Ry6XQkQ4Xwh4Tj5EnN4tLF4zCTUTAC
         HYhQ==
X-Received: by 10.152.3.137 with SMTP id c9mr7022161lac.5.1366331434094; Thu,
 18 Apr 2013 17:30:34 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 17:30:34 -0700 (PDT)
In-Reply-To: <CAPig+cRp7J+HYBA=2OL-CdA3NiQFjuUMZEjE+i+SnNrrPBAZ6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221722>

On Thu, Apr 18, 2013 at 7:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Apr 18, 2013 at 12:14 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
>> index cd1873c..3eeb309 100755
>> --- a/t/t5801-remote-helpers.sh
>> +++ b/t/t5801-remote-helpers.sh
>> @@ -111,13 +111,13 @@ test_expect_success 'pulling without refspecs' '
>>         compare_refs local2 HEAD server HEAD
>>  '
>>
>> -test_expect_failure 'pushing without refspecs' '
>> +test_expect_success 'pushing without refspecs' '
>>         test_when_finished "(cd local2 && git reset --hard origin)" &&
>>         (cd local2 &&
>>         echo content >>file &&
>>         git commit -a -m ten &&
>> -       GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
>> -       compare_refs local2 HEAD server HEAD
>> +       GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2> ../error) &&
>> +       grep "remote-helper doesn.t support push; refspec needed" error
>
> Is "doesn.t" intentional? It certainly works by accident in grep, but
> did you mean s/doesn.t/doesn't/ ?

In all git test cases we are already inside single quotes; can't do that.

-- 
Felipe Contreras
