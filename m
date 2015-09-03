From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Thu, 3 Sep 2015 11:07:19 +0100
Message-ID: <CAE5ih79Zjg7Rk0OQ0VkTc+KGJ26dEk_iyOWWhT2qSGePRTDqog@mail.gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
	<9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com>
	<CAE5ih7-w5ZjO=QUE45yBvwyqdqKCADczrLt7=4W8X6BR+cy4PA@mail.gmail.com>
	<1D65DD68-EE3F-4C87-9B5F-E436BA13704E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 12:07:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXRQe-0002gn-1a
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 12:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbICKHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 06:07:23 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36045 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbbICKHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 06:07:20 -0400
Received: by oibi136 with SMTP id i136so24648111oib.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9iCRCBTqqmR4ADhdsJa3+0xzAwJGpVe6CHE1jNVgCgs=;
        b=IXzYC7L8z/4713tNuu3zltWurdebLlx8KglGSiyJ0VYeSZDnhoQGqWNqQw1vA0Z/UC
         o4EmPos8gj84M+8IeUq7e2vCZ8aP8wUceyLr/vpPJGCtxJSW+xIs32aehSERWwWXXebS
         PNFYd7+VeoaepVDGeXLOF2zze3avvjyUHAn9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9iCRCBTqqmR4ADhdsJa3+0xzAwJGpVe6CHE1jNVgCgs=;
        b=WcHaKp2eG2uOpbrEtUwYFCevJ9SEGCgFcrNcKBEa/7AEaC/K4YC6fwXOPeLI+78z//
         VnxuHEzoAJagArD5+DI+qyUB72BNqZeeUK5KHyfZB93EhtB45zzRRZ1VnlgbSwliDyhX
         4poZlsB8gt/ER0PGnj4X8P9iSm/lJEqgU7ODDo+uxZccl5tCulMpXReXQIeenTJZxKXx
         DoHQ4nhLRiosXgBUjHpyyajEf6Zi9X+DVqpQxhRLMbb6Sv+l9BJGVtRvqoBx7h3P1jsW
         up6QNVea+OKHn74fmfyYoA3eqRdrFsoVRbraDJ+81h8HyxUGrCSROU+g75yH0Ab2PhaY
         tGCw==
X-Gm-Message-State: ALoCoQlYZfllNWYcQIXhvqgINKffYU/JFaVfcFfMuWDPN8G3m/FciyZljNTSr09bogslkyeiNneb
X-Received: by 10.202.79.11 with SMTP id d11mr7719065oib.113.1441274839373;
 Thu, 03 Sep 2015 03:07:19 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Thu, 3 Sep 2015 03:07:19 -0700 (PDT)
In-Reply-To: <1D65DD68-EE3F-4C87-9B5F-E436BA13704E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277195>

>>>
>>> Regarding Python 3:
>>> Would you drop Python 2 support or do you want to support Python 2/=
3 in parallel? I would prefer the former=E2=80=A6
>>
>> For quite some time we would need to support both; we can't just hav=
e
>> a release of git that one day breaks git-p4 for people stuck on Pyth=
on
>> 2. But it might not be that hard to support both (though converting
>> all those print statements could be quite tiresome).
> Agreed. However supporting both versions increases code complexity as=
 well as testing effort. Would a compromise like the following work? We=
 fork =E2=80=9Cgit-p4.py=E2=80=9D to =E2=80=9Cgit-p4-python2.py=E2=80=9D=
 and just apply important bug fixes to that file. All new development h=
appens on a Python 3 only git-p4.py.

I'm not a python expert, but I think we're quite a way from that point
anyway. I think we'd want to run 2to3 on it and make it work - at that
point it should work on both python 2.7 (and earlier? I don't know)
and python 3.x. By the time that's done, we may well find that we
_can_ just drop python2 support, or fork, as you suggest.

Running 2to3 also includes adding test cases for all the code that is
in there that's not currently covered so that end-users don't find out
the hard way that we've missed bits. That's why I think it's a fairly
long-term goal.

Regardless, I think we'd want to have a wider discussion about the
best way forward, and there doesn't seem much point having that
discussion now when there's no actual code!
