Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D500AC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB995610C7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 18:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347728AbhIXSC1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 24 Sep 2021 14:02:27 -0400
Received: from elephants.elehost.com ([216.66.27.132]:26728 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347774AbhIXSCW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 14:02:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18OI0gBa041092
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Sep 2021 14:00:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Russell, Scott'" <Scott.Russell2@ncr.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>
Cc:     <git@vger.kernel.org>
References: <BN6PR15MB1426A342CBA9D993C0C49E55CBA49@BN6PR15MB1426.namprd15.prod.outlook.com> <CAJoAoZ=DuqHe2brN8Y2Ts0_afEhUNrdasRBb1O8HHomLKRJ4PA@mail.gmail.com> <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
In-Reply-To: <BN6PR15MB14261D1A350398C0C26793E1CBA49@BN6PR15MB1426.namprd15.prod.outlook.com>
Subject: RE: pull failed - why should I receive this message.
Date:   Fri, 24 Sep 2021 14:00:37 -0400
Message-ID: <000401d7b16e$17ea02d0$47be0870$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGWcii2WKBFANC2DS0vdPx70Z6ntAIBtWyzApdZ7ESsES7psA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 24, 2021 1:34 PM Scott Russell wrote:
>
>Thanks for your answer.   Is there not an option on the pull to have git to overwrite the existing files?
>
>-----Original Message-----
>From: Emily Shaffer <emilyshaffer@google.com>
>Sent: Friday, September 24, 2021 1:29 PM
>To: Russell, Scott <Scott.Russell2@ncr.com>
>Cc: git@vger.kernel.org
>Subject: Re: pull failed - why should I receive this message.
>
>*External Message* - Use caution before opening links or attachments
>
>On Fri, Sep 24, 2021 at 10:08 AM Russell, Scott <Scott.Russell2@ncr.com> wrote:
>>
>> Files not previously in git were added to git.   Why should I have to manually delete them?
>> Why can git put not replace them?  They were untracked files that are now tracked  and so the git copy is desired.
>> We can't always know ahead of time what files may have been added elsewhere.
>
>To turn it around on you, you can't always know ahead of time what files may have been added elsewhere, so you can't be sure that your
>newly added untracked file locally will be safe from being overwritten during a pull. How upsetting if you sink 30 hours into newlib.cpp
>and then your teammate checks in their own newlib.cpp, and yours is overwritten without asking when you run 'git pull'.
>
>You might have some luck with the '--autostash' option, which would at least prompt you whether to get rid of things when trying to
>merge them back together during the automatic 'git stash pop' at the end. Or you could run 'git clean --force' to automatically delete any
>untracked files you might have - you could even alias yourself a command like 'git dangerous-pull' which runs 'git clean -f && git pull'.
>
>>
>>
>> We need the pull to work automatically.
>>
>> error: The following untracked working tree files would be overwritten by merge:
>>         Staging/CADDApps/CADDUIHelper/Source/Release/CADDUIHelper.exe
>>         Staging/CADDApps/CADDUIHelper/Source/Release_Unicode/CADDUIHelper.exe
>>         Staging/CADDApps/InstallDriversPackage/Release/InstallDriversPackage.exe
>>         Staging/Common/NCRCommonCCLib/Source/Release/NCRCommonCCLibMsg.dll
>>         Staging/Devices/NFC/Elatec_RFIDReader/Bin/Director.exe
>>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/AppBlaster.exe
>>         Staging/Devices/NFC/Elatec_RFIDReader/Firmware/flash.exe
>>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DIFxAPI.dll
>>         Staging/Utilities64/SSPSWDriverInstaller/Bin/DriverForge.v4.5.4.exe
>>         Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriverInstaller.exe
>>         Staging/Utilities64/SSPSWDriverInstaller/Source/Release/SSPSWDriverInstallerMsg.dll
>>
>> Staging/Utilities64/SSPSWTaskMgr/Source/Release/SSPSWTaskMgr.exe
>
>Or better yet, you could avoid checking in compiled binaries like these and instead add them to your .gitignore, unless you really mean to
>update them every time someone makes some change. When checking in binaries, you should be aware of the additional disk overhead
>needed to do so and take a look at some options Git has to mitigate that overhead, like partial clone. However, in many cases the easiest
>way to mitigate that overhead is to simply not check in binaries unless you absolutely need them to be version controlled.
>
>- Emily

If you are scripting this, try using git clean -dxf and git reset --hard before running the pull.  That will clean the objects out of your working directory.

-Randall

