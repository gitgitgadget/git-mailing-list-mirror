From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 10:12:51 -0700
Message-ID: <BF182294-B896-4C2D-B371-74036BC522A2@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561B69AE.8050403@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlgei-0005hi-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbJLRM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:12:56 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36811 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbbJLRMz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 13:12:55 -0400
Received: by ignr19 with SMTP id r19so20248355ign.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y1UuMSVwqCYk+no1B91dXpEEtrFzbVPa6VzJnPnBEXE=;
        b=tkUDB9iwOnrkjb0WpKv9C+xmu68dsUjGkxmKGvJCZf40n3UXgAw6Y5vMx+HihvUSsQ
         O+iWYR+ny/ArILG6K3uIcOneFTVzkXOjFiKTSgY31qQhVEwMEfQaM4mNV5OHQeQpZIOI
         AxV5c8jAQ/JGx+NMrO/ogIFInj/hTbhERisb9gD4WkIUsRirwb5XfNx+oN1feq3s0Ry0
         88yD5HLm2NLR+O4Vy6ylMoCasD+sQrASYFiP82cDZPigtCz2sL8+D2k5bPeAB79mvnBD
         ZF38mWylCNuV2dH7oZ1S8G6Omt98MTrpXWyh80ma8btIa4V6Qb62QN1Kgb+7NcGoPEnj
         xWUw==
X-Received: by 10.50.18.44 with SMTP id t12mr6371288igd.48.1444669974975;
        Mon, 12 Oct 2015 10:12:54 -0700 (PDT)
Received: from sfo99wgxz1.ads.autodesk.com (adsk-nat-ip12.autodesk.com. [132.188.71.12])
        by smtp.gmail.com with ESMTPSA id f19sm2224983iof.7.2015.10.12.10.12.53
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 10:12:54 -0700 (PDT)
In-Reply-To: <561B69AE.8050403@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279386>


On 12 Oct 2015, at 01:05, Sebastian Schuberth <sschuberth@gmail.com> wrote:

> On 10/11/2015 19:55, larsxschneider@gmail.com wrote:
> 
>> +      sudo apt-get update -qq
>> +      sudo apt-get install -y apt-transport-https
>> +      sudo apt-get install perforce-server git-lfs
> 
> Why no "-y" also in this line, or append these to the previous line?
> 
> Or maybe even better, like [1] does, also use "--qq" (which implies "-y") for "apt-get install"?
Agreed!

> 
>> +install: make configure && ./configure
>> +
>> +before_script: make
>> +
>> +script: make --quiet test
> 
> Semantically, it does not seem correct to me that configuarion goes to the install step. As "make test" will build git anyway, I'd instead propose to get rid of "install" and just say:
> 
> before_script: make configure && ./configure
> 
> script: make --quiet test

I understand your point. I did this to make the "make" logs easily accessible (no option "--quite"). By default Travis CI automatically collapses the logs from all stages prior to the "script" stage. You can uncollapse these logs by clicking on the little triangle on the left border of the log. Therefore the "make" logs are available without noise.

Do you see value in "make" logs? 

If yes then we could also do:
before_script: make configure && ./configure && make

If no then I will take your suggestion.

Thanks,
Lars