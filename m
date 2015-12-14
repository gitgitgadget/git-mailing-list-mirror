From: Thomas Nyberg <tomnyberg@gmail.com>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 15:33:03 -0500
Message-ID: <566F277F.4070101@gmail.com>
References: <566EFF11.6010600@gmail.com>
 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
 <566F05B2.8080403@gmail.com> <1450120801.1678.13.camel@twopensource.com>
 <566F1F96.4060806@gmail.com> <1450124302.16044.1.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:33:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Zo0-0008V0-P8
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbbLNUdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:33:08 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36541 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbLNUdH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:33:07 -0500
Received: by qget30 with SMTP id t30so22478968qge.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=fHiZaYhCeBc7Q3PR4R5J5kr3H67NV1P4+mYsti9Hl3I=;
        b=A7f9YteUPiICp2w8yNCua6cz9Ns+YG8nJhhMAYNbud+6XrxNjt7ZT9m1jQ9irnRH8A
         kyg3+s6lJtgOH0sSzs+qhzSHOKcs1ERSiIZWVYRa3jeXjTtu5k/0tGprnTzlo/AYhgdg
         JkksLxfdnVJ4N5xkycOlntiUeYX0XTPxfoiJ7oBPFjQQnkeNCNs4s7LJqM1JNDedEXr+
         qjqbEchuBzSjEtdamf7JOpYauTPZqRG2dmccgklv0XsZ+eqa93A3HWRST1TNZqmq8ZJ/
         yasApMGPtpfkfvI9fZvFoYz6+M0PCFtCoMFePVPhEI6t1dcpJq23lq0Il0ApCfM2sEFd
         6yOQ==
X-Received: by 10.140.88.51 with SMTP id s48mr22161970qgd.48.1450125185629;
        Mon, 14 Dec 2015 12:33:05 -0800 (PST)
Received: from [128.59.76.160] (dyn-128-59-76-160.dyn.columbia.edu. [128.59.76.160])
        by smtp.googlemail.com with ESMTPSA id 81sm14492076qhx.15.2015.12.14.12.33.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Dec 2015 12:33:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1450124302.16044.1.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282401>

What exactly are you looking for? Here's the results of the following 
command:

$ git for-each-ref | grep frus
1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
refs/heads/frus_body_cleaning
3a1dbe48299f6eda1cc4b69cab35284c0f0355eb commit	refs/remotes/origin/frus
1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
refs/remotes/origin/frus_body_cleaning

Sorry if this isn't what you're looking for. I'm actually not very 
familiar with these different internal git commands...

Regardless this looks to me exactly like what I'd expect given the 
current situation...it's as if I never checked out the "frus" branch at 
all (which I suppose is true since this is a fresh copy and "git 
checkout frus" didn't do anything).

Btw after checking out explicitly with `git checkout -b frus 
origin/frus`, things look as I'd expect.

$ git for-each-ref | grep frus
3a1dbe48299f6eda1cc4b69cab35284c0f0355eb commit	refs/heads/frus
1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
refs/heads/frus_body_cleaning
3a1dbe48299f6eda1cc4b69cab35284c0f0355eb commit	refs/remotes/origin/frus
1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
refs/remotes/origin/frus_body_cleaning

Btw just to test things a little more I deleted both the frus and 
frus_body_cleaning branches and tried to recheck them out, but the 
problem still persists.

Cheers,
Thomas

On 12/14/2015 03:18 PM, Dennis Kaarsemaker wrote:
> On ma, 2015-12-14 at 14:59 -0500, Thomas Nyberg wrote:
>> I'm guessing you're looking for namecollisions of some kind?
>
> I was thinking the same. Can you share the (sanitised) output of
>
> git for-each-ref?
>
