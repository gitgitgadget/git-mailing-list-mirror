From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: Git doesn't detect change, if file modification time is restored
 to original one
Date: Thu, 23 Jul 2015 17:16:13 +0200
Message-ID: <55B1053D.7030006@gmail.com>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>	<55B09E95.4000700@gmail.com>	<CABEDGg_R49K61wiV9SsTnLS9SztHDjEQhOHjwzYn2JJwrrb-KA@mail.gmail.com> <20150723175342.77f635820fb9f1b69a73d39a@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>,
	=?UTF-8?B?S29ucsOhZCBMxZE=?= =?UTF-8?B?cmluY3pp?= 
	<klorinczi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 17:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIIES-0000bu-48
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 17:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbbGWPQU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2015 11:16:20 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36363 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbGWPQS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 11:16:18 -0400
Received: by wicgb10 with SMTP id gb10so147765850wic.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=WTroUVQGe3Vc/zd/nEufKumBcN/RHFdfxjeSpQbe9X8=;
        b=gkBpYRUx9JdfDyvWuoTtMZbsq2x1kgK2cjZ/D0s8FZSR8cC1TbikTx2L31FJiYlm6x
         8WP3z/gzkYecwLFOsYaG6L/uyoZjkLGMeHeNsMP1ZwcQJtTToahs87iNdiqVUqwxnov1
         DFu7dWbrn0mljm9qy6A3Ysl6O70sED3geQji5RAWeYGqAkbDS8wVbJLu7NV+FVWIoJKg
         e7zx6EZg/HVT33KIT6GTfl11wjjky17pQYs2Z1eSx8lMOm/IxgTdA36fV15yp+1UK2Cg
         BZeuqLQ+VFbfKA56t9zpWjzh2vHxazZ0WGXLn2eXaJgYWCZiYS0AwucUXAaMvbOfkawt
         kBbw==
X-Received: by 10.194.187.51 with SMTP id fp19mr16074211wjc.67.1437664577461;
        Thu, 23 Jul 2015 08:16:17 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id nb9sm9035051wic.10.2015.07.23.08.16.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jul 2015 08:16:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <20150723175342.77f635820fb9f1b69a73d39a@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274500>

Am 23.07.2015 um 16:53 schrieb Konstantin Khomoutov:
> On Thu, 23 Jul 2015 11:14:11 +0200
> Konr=C3=A1d L=C5=91rinczi <klorinczi@gmail.com> wrote:
>=20
> [...]
>> I accept these solutions as workarounds, but the real solution would
>> be: Dev suggestions:
>> 1) Add a --force-reread option to git status, so user can force
>> reread tree. git status --force-reread
>>
>> 2) Add status.force-reread (true or false) option to .git/config so
>> user can set this variable permanently for a repo.
>> status.force-reread =3D false (should be default)
>>
>> Could be possible to implement 1) and 2) features to next git releas=
e?
>=20
> Could you explain what's your real use case with preserving mtimes
> while changing the files?  I mean, implementing "mtime-stability"
> in your tools appears to be a good excersize in programming but what
> real-world problem does it solve?
>=20

I'd like to add that this is not a git-specific problem: resetting mtim=
e
on purpose will fool lots of programs, including backup software, file
synchronization tools (rsync, xcopy /D), build systems (make), and web
servers / proxies (If-Modified-Since requests).

So you would typically reset mtime if you *want* programs to ignore the
changes.
