From: Dmitry Ilin <dmitry@mylovecompany.com>
Subject: Re: Textconv
Date: Mon, 11 Mar 2013 14:31:15 +0400
Message-ID: <513DB273.2090007@mylovecompany.com>
References: <513DA7E1.7050206@mylovecompany.com> <vpqtxoicl2l.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 11:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF01E-0003Wt-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 11:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889Ab3CKKbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 06:31:21 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:58081 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab3CKKbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 06:31:20 -0400
Received: by mail-la0-f41.google.com with SMTP id fo12so3726785lab.0
        for <git@vger.kernel.org>; Mon, 11 Mar 2013 03:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mylovecompany.com; s=google;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=YI/W6WC9GAqvu8Yp/8mLCDRt9wo9mSJHyibCAHVRnXc=;
        b=KCZGc5ICI41NinaG+bVi2w7yjmds3W85bQ0rR6K0E0gGUGkSjlGbkN43qwUF7yxqh+
         +83pw8mKFcN7y9IpSrKDb0y0LanUTbJwrxinPhhs//J0nvuoEGfWTlJwjw1o9sqUusLW
         FFfBbzocLAqmPAtZnEUuSxc7ruORQXFTd5XM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=YI/W6WC9GAqvu8Yp/8mLCDRt9wo9mSJHyibCAHVRnXc=;
        b=Kyg+WYolYL8yHQO7JUm8xGsq28xeJf5XH6Mpv03a9hftFRNuc49KEIk12H/dMKbCVr
         KYALYluUZ5hIFPFlC79pOiknyUK97ExbyI2ZTqWcb9GtANCl9sVTUb7+1ybOeroahqzr
         186UJSP7a06oCxoUag1Hnscu+1V92X3mDkFPo4TWM/w3EFLhfPIEeiZQaVuhL2uGBhnl
         xoQuDJZ8WZBZmO7KEFOTPDgpHx0AlC2tKeKObSGvk9lBNgoHQ4tSUxOGW75aX0OII28Z
         yszoqke9FPQgxCRjynPKtDjwOzGtcGQHXq+LXIJxmKCqBWhgIaByXVgbUCbUx2R6Belh
         0l1A==
X-Received: by 10.152.133.67 with SMTP id pa3mr9560002lab.44.1362997878593;
        Mon, 11 Mar 2013 03:31:18 -0700 (PDT)
Received: from [192.168.1.11] (broadband-178-140-233-175.nationalcablenetworks.ru. [178.140.233.175])
        by mx.google.com with ESMTPS id e9sm4368957lbz.1.2013.03.11.03.31.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Mar 2013 03:31:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <vpqtxoicl2l.fsf@grenoble-inp.fr>
X-Gm-Message-State: ALoCoQltbpbSuSgZfWH0MaMFdITu9SY8/fbWcHoChpAicyWpwfOXMhTsXe3yZ219E7TXRJIKosLs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217865>

I mean that our filter doesn't work with 'git show' and I need to enable 
it for this command.

This is part of my git config file:

[filter "openssl"]
    smudge = openssl enc -d -base64 -aes-256-ecb -k 'abcde' 2> /dev/null 
|| cat
    clean = openssl enc -base64 -aes-256-ecb -S '12345' -k 'abcde'
[diff "openssl"]
    textconv = openssl enc -d -base64 -aes-256-ecb -k 'abcde' -in "$1" 
2> /dev/null || cat "$1"
[merge]
    renormalize = true


And content of '.git/info/attributes':

* filter=openssl diff=openssl


How can I deal with it?


On 03/11/2013 02:00 PM, Matthieu Moy wrote:
> Dmitry Ilin <dmitry@mylovecompany.com> writes:
>
>> Hello!
>>
>> Most of GUI for Git using 'git show' command to show differences
>> between versions. For example: WebStorm IDE. But for now there is no
>> way to specify text conversion command in git config for 'show' as it
>> done for 'diff'.
> Do you mean, to enable it, or to disable it?
>
> By default, "git show" does use the textconv filter to compute the diff,
> at least if you specified the textconv driver in your .gitattributes
> file.
>
