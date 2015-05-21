From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/2] pull: handle git-fetch's options as well
Date: Thu, 21 May 2015 16:29:53 +0800
Message-ID: <CACRoPnQTTj-ve-gJ2-prTtgB8jzYk_dLTeQRYVKZoC4wXYOx2w@mail.gmail.com>
References: <1431955855-16228-1-git-send-email-pyokagan@gmail.com>
	<1a102d8dabff79207c0d7e3bf434bd6f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 21 10:30:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvLre-0002ZZ-GK
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 10:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbEUI36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 04:29:58 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:35407 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbbEUI3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 04:29:55 -0400
Received: by wgfl8 with SMTP id l8so77713393wgf.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kcVvP+Vt9WftjI68O+DpWpEb7972NZluhjmAzYFHXQU=;
        b=LBeOc1FFCrxmOJbBzxdOVmvbbQslw5il/9TXgbL2ZFlm/NUalMBAV3TX/J08dGMGar
         3t0KLIr4LbxZ53a1Lretq1+kttDoV5ru5CE3kLrzdCmxo5apD0gOQMX2ihCBRLPBbi7g
         7b1eGFjUS4AKv06sVYZNksPYiZiWes51LDIzjdUnINpsRJVyPBQNrupFJGIussC95AXv
         1dM9gLGh03m1yMzSfg4vbgzrJMElGp4pBdelif/p7C8At8Y6TJfzddkOD0pzFGci2rYZ
         jegi6q8VV6urcZRxkBnKDopC56w3Ca6+2uxWNDWh63AoHR6UnMavMbKvMFJLCw+B2Iav
         VbHg==
X-Received: by 10.180.85.161 with SMTP id i1mr3972560wiz.45.1432196993822;
 Thu, 21 May 2015 01:29:53 -0700 (PDT)
Received: by 10.194.85.113 with HTTP; Thu, 21 May 2015 01:29:53 -0700 (PDT)
In-Reply-To: <1a102d8dabff79207c0d7e3bf434bd6f@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269570>

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
