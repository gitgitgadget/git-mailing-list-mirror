From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 15:11:30 +0300
Message-ID: <4F462CF2.5040502@gmail.com>
References: <4F46036F.3040406@gmail.com> <4F46122F.2040409@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:11:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0XWR-0000xu-QR
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab2BWMLh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 07:11:37 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46127 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab2BWMLg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 07:11:36 -0500
Received: by bkcjm19 with SMTP id jm19so939159bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 04:11:35 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.204.129.18 as permitted sender) client-ip=10.204.129.18;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.204.129.18 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.204.129.18])
        by 10.204.129.18 with SMTP id m18mr514328bks.115.1329999095366 (num_hops = 1);
        Thu, 23 Feb 2012 04:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Z+pjXQKEH4ev0g4z9wWEl5HKyBkzLsrhUW/pi+oDklM=;
        b=nYXTRje4dsYq5RezIp+ky9n7XNSanL4ExE42osnv5fJMS3RV8do6lPDClC/bwmxuii
         Zwq8iBYk9jTZs5qQyk5m70fgBN2NwC+hQdACcDF5g6+fb5ZXl2S2a0oH6kFxZpfTbxUS
         KD+chxeXUsVghV5AIa20z15QvIItmGbrH9ZLg=
Received: by 10.204.129.18 with SMTP id m18mr426096bks.115.1329999095264;
        Thu, 23 Feb 2012 04:11:35 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id x11sm2402542bkd.2.2012.02.23.04.11.33
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 04:11:34 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F46122F.2040409@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191355>

Hello.

You were right. I added parameter --max-args=3D1 to xargs command and t=
hat=20
started work as I wanted initially.
Thank you very much.

--
Nikolaj

23.02.2012 13:17, Johannes Sixt =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Am 23.02.2012 10:14, schrieb Nikolaj Shurkaev:
>> I wanted to generate several files with some statistics using "git l=
og
>> -z" command.
>> I did something like this:
>> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
>> --max-chars=3D1000000 ~/1.sh
>>
>> If I put
>> echo "started"
>> into the file  ~/1.sh I see that the file is called only once instea=
d of
>> multiple times.
> That is because xargs calls the program with as many arguments as
> possible, unless directed otherwise. Put this in the script:
>
> 	echo "started $*"
>
> and repeat. Then try this:
>
>   ... | xargs -0 -n 1 ~/1.sh
>
> -- Hannes
>
