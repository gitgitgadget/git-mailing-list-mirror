From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH try2 7/8] push: add --set-publish option
Date: Sun, 13 Oct 2013 05:15:42 -0500
Message-ID: <CAMP44s2FihCyAJKLYqMzQSPOz7FgR_hh7EMwmS-socR0Zn8O_w@mail.gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
	<1381561561-20459-2-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cQ=RkFWssANKQ=mca1jD6MGQuPxAV-SyM8rfHMLYoDHfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 12:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIiC-0004iS-0f
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 12:15:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754233Ab3JMKPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 06:15:44 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46720 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab3JMKPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 06:15:43 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so4695850lbd.40
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 03:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YlqO2o+EL9CPw+J9AMJ1hYlD2Jbque+f8ZxYX8vKgBI=;
        b=otp1TvKMy9RQrQXz/zDA9lQkFCIKeLtctKYpYLBnPig2oO0KyaOr0mm/mYyt/AFPiN
         r0ODX3EBytpD4Dvs37ExR0sNk44euKTHv6hUnn5whaSpuJA0f9mPBnxwckt/0Fgw273W
         k4Gt8bFg53YaC97f4trTd7tIgojjUEzmDt5AJW1r0+PAlU/6iRjXwaOn6EbHcu+lkANo
         vWD9nARBqrdqREt7zsEe8qt5vmkgJ8WPl40wLorVvqWpO6Z+hmf2pYkmuB2EGSqGZjKR
         2K/byfeb8orth+ZAWYg5CQd16DuaDOxqtM7E0Y4GrhqkKeMF6p61oU4EkA/dHs1RtOhO
         pcIA==
X-Received: by 10.112.14.102 with SMTP id o6mr1409096lbc.28.1381659342341;
 Sun, 13 Oct 2013 03:15:42 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 13 Oct 2013 03:15:42 -0700 (PDT)
In-Reply-To: <CAPig+cQ=RkFWssANKQ=mca1jD6MGQuPxAV-SyM8rfHMLYoDHfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236071>

On Sun, Oct 13, 2013 at 5:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 12, 2013 at 3:05 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> diff --git a/t/t5529-push-publish.sh b/t/t5529-push-publish.sh
>> new file mode 100755
>> index 0000000..2037026
>> --- /dev/null
>> +++ b/t/t5529-push-publish.sh
>> @@ -0,0 +1,70 @@
>> +#!/bin/sh
>> +
>> +test_description='push with --set-publish'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup bare parent' '
>> +       git init --bare parent &&
>> +       git remote add publish parent
>> +'
>> +
>> +test_expect_success 'setup local commit' '
>> +       echo content >file &&
>> +       git add file &&
>> +       git commit -m one
>> +'
>> +
>> +check_config() {
>> +       (echo $2; echo $3) >expect.$1
>> +       (git config branch.$1.pushremote
>> +        git config branch.$1.push) >actual.$1
>> +       test_cmp expect.$1 actual.$1
>> +}
>
> Do you want to maintain &&-chain in this test?

As much as we want to do it in t/t5523-push-upstream.sh, which has
this exact function.

-- 
Felipe Contreras
