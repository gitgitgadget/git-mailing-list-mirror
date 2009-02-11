From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not  author
Date: Wed, 11 Feb 2009 10:18:38 +0100
Message-ID: <200902111018.39699.jnareb@gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com> <86d4c5e00902101910k5512efel2c9165f75d61ba53@mail.gmail.com> <cb7bb73a0902110102k5b7e5a21vd7d0932c6b6ba20e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBGQ-0008DQ-DX
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbZBKJSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754080AbZBKJSq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:18:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:18940 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbZBKJSp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:18:45 -0500
Received: by fg-out-1718.google.com with SMTP id 16so25711fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=kzV5qzXMGVaYK4FzdWo8CcpnVbEFJE/hUVXCkstE1iY=;
        b=kyPf9VgKfN2+C6lQ8T4fsWd/rBfJzHQBShxaSYRDsXt4QMqEZTgvwDyUyHRbjh3We6
         25l6XoWe6A+8J25TnflGA58sfMiMlJTcJt8t7JY4EYfbcAbbMKyrzwH+V5/e+VQgq7v0
         hZudVWsi6cl17Tk73TuLbBosqDajm0EZ2Ddts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KpgPlBuKCfIqLb4liljwG95jK1/SWMBHv2W97SLfdbRkQ4HGWBmbNTwIMrUa+HA9rs
         oyStzmNBS8MBshlFVD6cZl5/AmVcP9KIoNSn2XQNSS4Z3X7bB2jo3cfBiIl5WLb6lSQF
         9hk+SVhiB0QRY7fx4vJZeMHTpldzHQNFcfe9E=
Received: by 10.86.89.20 with SMTP id m20mr30608fgb.71.1234343923387;
        Wed, 11 Feb 2009 01:18:43 -0800 (PST)
Received: from ?192.168.1.13? (abvk36.neoplus.adsl.tpnet.pl [83.8.208.36])
        by mx.google.com with ESMTPS id 4sm3633143fgg.55.2009.02.11.01.18.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 01:18:42 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0902110102k5b7e5a21vd7d0932c6b6ba20e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109387>

On Wed, 11 Feb 2009, Giuseppe Bilotta wrote:
> On Wed, Feb 11, 2009 at 4:10 AM, Deskin Miller <deskinm@gmail.com> wrote:
>> On Fri, Feb 6, 2009 at 18:00, Giuseppe Bilotta
>> <giuseppe.bilotta@gmail.com> wrote:
>>>
>>> The real question is: _how_ do you get the (branch) update time?
>>>
>>
>> Sorry the topic's cold, but...
>>
>> git reflog?
>>
>> Seems like one could find the oldest time the commit appears in the
>> reflog, for the branch one is interested in.  You can use the commit
>> time to limit the search through the reflog, but there would be clock
>> skew concerns.
> 
> Bingo! Thanks a lot
> 
> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
> --since="two days ago" master | cat
> 7324b32... master@{0}: push
> e2dc08d... master@{1}: push
> oblomov@rbot ~ $ GIT_DIR=/var/git/rbot.git/ git reflog show
> --since="yesterday" master | cat
> oblomov@rbot ~ $
> 
> I'll try to work it in the next review for this patchset.

Assuming that you have reflog enabled (yes, it is default now)...
So you would have to provide fallback in the case there is no reflog.

BTW. "git reflog" is porcelain; it would be better to parse reflog
directly, I think.
-- 
Jakub Narebski
Poland
