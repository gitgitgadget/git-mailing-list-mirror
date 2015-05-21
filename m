From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Thu, 21 May 2015 16:29:08 +0800
Message-ID: <CACRoPnQ31xQ6n--EkraCXw3i-rTR5wMLyMP7+xi=d6w4eG2Y0g@mail.gmail.com>
References: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
	<1a102d8dabff79207c0d7e3bf434bd6f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 10:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvLqv-00028t-5A
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbbEUI3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:29:12 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34555 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbEUI3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:29:09 -0400
Received: by lbcmx3 with SMTP id mx3so12572262lbc.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kcVvP+Vt9WftjI68O+DpWpEb7972NZluhjmAzYFHXQU=;
        b=SmtBqxb1xoLcF6xwuHRCAUHcCL8cz60VIzf/S8ERaICJKoYYc5Blixo1UjmNF1Ca9Y
         0zEVF/qbWaIhUsMXhlJ8ZZ6Q/DP5HAxH8Ok79mUuCLDJstTfcj03v+GSwuG6sJuMtOdl
         QRSaMPYCN7c57EoarN6YqmchrjcfTekPHV19P97Q66s+a9EWSf3CJZovw9cssLxWg2sp
         l30yba/sGDLYE6dAQhFjDak2hUJFVngOVB0MHZ1tsPAc4c/nDmMkEoEn5wQNhvH3/n48
         ructSFj8QyMRUQa6fnYHhkmW8/mmFdwU/vGTA0QPORW7WAjbmuaG370lKz70NuEKjHpf
         BF/w==
X-Received: by 10.152.4.72 with SMTP id i8mr1296016lai.32.1432196948410; Thu,
 21 May 2015 01:29:08 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 21 May 2015 01:29:08 -0700 (PDT)
In-Reply-To: <1a102d8dabff79207c0d7e3bf434bd6f@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269569>

Hi,

On Mon, May 18, 2015 at 10:37 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> On 2015-05-18 15:30, Paul Tan wrote:
>> t5520: failing test for pull --all with no configured upstream
>> t5521: test pull --all --dry-run does not make any changes
>>
>> error_on_no_merge_candidates() does not consider the case where "$#"
>> includes command-line flags that are passed to git-fetch.
>>
>> As such, when the current branch has no configured upstream, and there
>> are no merge candidates because of that, git-pull --all erroneously reports
>> that we are pulling from "--all", as it believes that the first argument
>> is the remote name.
>>
>> Add a failing test that shows this case.
>>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>>  git-pull.sh             | 34 ++++++++++++++++++++++++++++++++--
>>  t/t5520-pull.sh         | 20 ++++++++++++++++++++
>>  t/t5521-pull-options.sh | 14 ++++++++++++++
>>  3 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-pull.sh b/git-pull.sh
>> index 9ed01fd..28d49ab 100755
>> --- a/git-pull.sh
>> +++ b/git-pull.sh
>> @@ -163,11 +163,39 @@ do
>>       --d|--dr|--dry|--dry-|--dry-r|--dry-ru|--dry-run)
>>               dry_run=--dry-run
>>               ;;
>> +     --all|--no-all)
>> +             all=$1 ;;
>
> I *think* you also want to add a corresponding "all=" line just below the "dry_run=" line, to ensure that "all=blablabla git pull" does not interfere with this command-line setting.

Fixed, thanks.

Regards,
Paul
