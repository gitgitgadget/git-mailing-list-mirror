From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 12:43:29 -0700
Message-ID: <61B448FB-DB61-42B6-ACDF-181F76169061@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561B69AE.8050403@gmail.com> <BF182294-B896-4C2D-B371-74036BC522A2@gmail.com> <CAHGBnuOqVPHAhfN6qtt=VDODW9h+A1xMEnzaZfD61DCNyj_YOg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	tboegi@web.de, pw@padd.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:43:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlj0V-0002BP-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbJLTnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:43:35 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34186 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbbJLTnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 15:43:35 -0400
Received: by padhy16 with SMTP id hy16so161572700pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DMu7o5uno2tryIA9lBP1LLy69Pg5TmAcgqFBPfx3a3E=;
        b=i6PPRhbEQ+z1loEa3g+njRwrDrGCLoK25YxdrhdTlkdldLoaI5fX7HLrZZ+yZKydpW
         m+C8CHH4LOE1uB/do+WO7CfwoomhQwfZECrE9ojlwAncijG8cZ7SskNVnr5s1OY7uMzz
         RLwgZlY53MvVemCeFWQb0U24BvQaCa22LazykuYnen1eXXeQM52vdg9PYIHgCN9iYazW
         XBwl0+EtP1LM69wAdsuhwu+HCACWTldrol5dhXq4kq6BFElozOubBVFs74YtkgAZViSp
         ymMTNDlCCMSt6K7MnbWZ3wleFR2uF1Nffmar9wI6SnnUFEbkMpkSB224kep2g8o00lj4
         ZY0g==
X-Received: by 10.68.241.234 with SMTP id wl10mr36308121pbc.27.1444679014765;
        Mon, 12 Oct 2015 12:43:34 -0700 (PDT)
Received: from sfo99wgxz1.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id gt1sm19864317pbc.10.2015.10.12.12.43.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 12:43:34 -0700 (PDT)
In-Reply-To: <CAHGBnuOqVPHAhfN6qtt=VDODW9h+A1xMEnzaZfD61DCNyj_YOg@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279409>


On 12 Oct 2015, at 12:37, Sebastian Schuberth <sschuberth@gmail.com> wrote:

> On Mon, Oct 12, 2015 at 7:12 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> 
>>>> +install: make configure && ./configure
>>>> +
>>>> +before_script: make
>>>> +
>>>> +script: make --quiet test
>>> 
>>> Semantically, it does not seem correct to me that configuarion goes to the install step. As "make test" will build git anyway, I'd instead propose to get rid of "install" and just say:
>>> 
>>> before_script: make configure && ./configure
>>> 
>>> script: make --quiet test
>> 
>> I understand your point. I did this to make the "make" logs easily accessible (no option "--quite"). By default Travis CI automatically collapses the logs from all stages prior to the "script" stage. You can uncollapse these logs by clicking on the little triangle on the left border of the log. Therefore the "make" logs are available without noise.
> 
> To make this more clear, I guess what you're referring to is the
> visual difference between [1] and [2], correct?
correct!

> 
>> Do you see value in "make" logs?
>> 
>> If yes then we could also do:
>> before_script: make configure && ./configure && make
> 
> Reading through Travis' docs [3] again, "before_script" is documented
> to "return a non-zero exit code, the build is errored and stops
> immediately", while "script" is documented as "returns a non-zero exit
> code, the build is failed, but continues to run before being marked as
> failed". As it does not make much sense to continue the build or even
> start testing if the build failed, maybe it's indeed best to do:
> 
> before_script: make configure && ./configure && make
> 
> script: make --quiet test

Ok, then I will make it so :-)

Thanks,
Lars