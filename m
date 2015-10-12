From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 10:05:02 +0200
Message-ID: <561B69AE.8050403@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
 <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: johannes.schindelin@gmx.de, tboegi@web.de, pw@padd.com
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 10:05:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlY6c-0006Ww-Jk
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 10:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbbJLIFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 04:05:08 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37672 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996AbbJLIFG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 04:05:06 -0400
Received: by wijq8 with SMTP id q8so45227287wij.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 01:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=HN2kEcd/tDG4t5R7Stxu9fMREn1wiyKV9rrArgHzv6k=;
        b=AyDQm4iQKcBCfePQnPnDSGOXX27E2c40+b4PF07cO8ieYwaO9dxmHM/lDMT/8sE8ZN
         C++R5945bkN8TkT40//wqYiPQUP+vzvPNeGMq6HWY86wQroMb+Ue7BzsjMEBPes0jqTh
         SvV9EU8kAcAfjPKieXWgmaP5PEeF80l9sGw/E3iDVo46NYFFY3hVSO7TkPYTN8xXiYUr
         rcYnYWFsXtjD3EMrE17t2wafoZzuqNRsfDt+HbxfZ9+dM5/H/dKcn3HHmXK1kyOf4VCK
         JGetdoXabGs/45QnVRRemPLfQ2P+GANQgiUhJAjCwDERw4w2hj3RyLccI9n6E14T3DEk
         Ulpg==
X-Received: by 10.194.22.69 with SMTP id b5mr27654000wjf.157.1444637104349;
        Mon, 12 Oct 2015 01:05:04 -0700 (PDT)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id ld5sm18273987wjc.18.2015.10.12.01.05.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2015 01:05:03 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279365>

On 10/11/2015 19:55, larsxschneider@gmail.com wrote:

> +      sudo apt-get update -qq
> +      sudo apt-get install -y apt-transport-https
> +      sudo apt-get install perforce-server git-lfs

Why no "-y" also in this line, or append these to the previous line?

Or maybe even better, like [1] does, also use "--qq" (which implies 
"-y") for "apt-get install"?

> +install: make configure && ./configure
> +
> +before_script: make
> +
> +script: make --quiet test

Semantically, it does not seem correct to me that configuarion goes to 
the install step. As "make test" will build git anyway, I'd instead 
propose to get rid of "install" and just say:

before_script: make configure && ./configure

script: make --quiet test

[1] https://github.com/git/git/pull/154/files

Regards,
Sebastian
