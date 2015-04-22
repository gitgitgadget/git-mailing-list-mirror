From: =?windows-1252?Q?David_Rodr=EDguez?= <deivid.rodriguez@gmail.com>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute
 path
Date: Wed, 22 Apr 2015 08:36:00 -0300
Message-ID: <553787A0.40707@gmail.com>
References: <5536C319.4000402@gmail.com> <20150422054737.GA11889@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 13:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykswu-0004az-GX
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 13:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbbDVLgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 07:36:08 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34068 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbDVLgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 07:36:06 -0400
Received: by qkgx75 with SMTP id x75so218701264qkg.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 04:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h7kCn5vFf1eWO3nFswmMV5i7g84mOWyDTfHIaSrJ38Y=;
        b=JlY0NZIS7RrT5fwJSNKWLDbTi/qTT2RJQa/P2HoKTZSkmk5d8RGXCImG982BSFhgIR
         iRkcjMVrEGktLp/9Gbd6vav/GkDVfREJiolWK6LSgZhG197b5DW/nYGVHn4wx45jSg28
         EsaSkKREt1/CWLN4K0WraAqrcn5TatEdTaawXK8fsK/lpHp2CKot/6CxLSf+yJkq2+zm
         MCpx3+vy9KmY2nAGtD0MvpJealkqr6OhLH6aJu5PndU1aBR1D6VbOfeck5hp5H9yiM4r
         NHDx6Ogb66wTUXIvwEYiZ0N/R43fDB6pUE3N8oEUl2a2nWAQClwUuJTY/2HjRptE8Zfs
         skXw==
X-Received: by 10.140.164.214 with SMTP id k205mr29908671qhk.61.1429702566057;
        Wed, 22 Apr 2015 04:36:06 -0700 (PDT)
Received: from [192.168.1.103] ([186.237.38.30])
        by mx.google.com with ESMTPSA id 197sm3463466qhq.23.2015.04.22.04.36.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2015 04:36:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150422054737.GA11889@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267587>

On 22/04/15 02:47, Andreas Krey wrote:
> On Tue, 21 Apr 2015 18:37:29 +0000, David Rodr=EDguez wrote:
> ...
>> This causes issues with Ruby git hooks, because Ruby version manager=
s
>> rely on custom settings in PATH to select the Ruby executable,
> Even if git wouldn't modify PATH this is still a broken way to do tha=
t.
> What ruby to execute a hook with is a property of the hook, not of th=
e
> user context invoking it.
>
> Andreas
>
I probably shouldn't have mentioned Ruby version managers since they ar=
e=20
not directly related to this issue. I'll try to elaborate on the issue:

* User is relying on a custom path to select their Ruby version. For=20
example, let's say the first folder in path is "~/.rubies/2.2.2/bin".
* User runs "/usr/bin/git commit" and a pre-commit hook is triggered.
* The pre-commit hook starts with "#!/us/bin/env ruby" to select the=20
Ruby to be used in the hook, but since the path has been changed by=20
"/usr/bin/git", the selected ruby will be "/usr/bin/ruby" and not=20
"~/.rubies/2.2.2/bin/ruby" as the user would expect.

What's the proper way to do whatever you're saying is done in "a broken=
=20
way"?
