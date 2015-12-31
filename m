From: Mostyn Bramley-Moore <mostynb@opera.com>
Subject: Re: [PATCH/RFC v2 0/2] add regex match flags to git describe
Date: Thu, 31 Dec 2015 11:07:29 +0100
Organization: Opera Software
Message-ID: <5684FE61.4010701@opera.com>
References: <cover.1451298323.git.mostynb@opera.com>
 <xmqqy4cejoz4.fsf@gitster.mtv.corp.google.com> <5681D02C.1040609@opera.com>
 <xmqqk2nxi002.fsf@gitster.mtv.corp.google.com> <5684702C.3040802@opera.com>
 <xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 11:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEa9R-0006Ad-Nw
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 11:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbbLaKHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 05:07:35 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37850 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247AbbLaKHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 05:07:33 -0500
Received: by mail-wm0-f51.google.com with SMTP id f206so106450148wmf.0
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 02:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jiueVd2vkS1NYhhrbwD8E7VqhpKKlopG1LN00UP8lrQ=;
        b=tGv2SFj/RZ/eHr3bY7lhSzF65vNF3qhrQrpSujqgNpMbmg77fOPoN5mjQuNnXghzBX
         DYMAsGeITYmMBH7+afthV7WIxkJgfNAEK2lb3aPBXgylzj18yLBGjDO7/M9rYJoqiYQZ
         0cgbTKCtD9bQyTqTb02R5dRBB51GnWSAN1lY66BJI2xHthgdFkbcuGL6uI3McFmiPhlL
         5MvUxjXQq3yTAuC15k4erNtFJUAqHVUECSxoYrrYapPCbqn4QOMYKmFMwR05JjcKlZGl
         XlE/AcYkrBH9gRV9Mlvb+WKnCsj6pEVDk1MS/EqCy9FPQB/BiITSXIwcMB7vFJJEeud9
         6jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jiueVd2vkS1NYhhrbwD8E7VqhpKKlopG1LN00UP8lrQ=;
        b=MOd0BK0QOKbo3MRbEyUUZrM+tdb63JEWyB2KUgnAKh5sIQ+J18ZxQFa7hXtldgU+w2
         PG5Ka3syprUCY5yn8QdynMff3ZiXSTq/YuK074R/PNwR7YYbVfXs7r+qcWepFnKeFjf1
         /dIBpOms/fySHOU+lf0QtcIZbqdHBcRuJ7qnCIBrST81AjT/h7VHRIgnSOKIeOmpUYEJ
         FFb2WxeEIyij6DPvPdUr+IbAoWOyht8HZZOsddRrpo4ZiB8On9G0B+SHLxEZY2SypOYP
         0zef9MSGBf2EGrCQc53MSgPp5lYvyVVrw77OmBRVbW8WekxYWnSophrehG2fdpgVCoLB
         AoFA==
X-Gm-Message-State: ALoCoQmBiUzUEGR2MxKKj7sxHd8NhDt0lwJZH0nY/zlAlOm7G+6pSlbseh1OOtfzGCMrnqgw/URqjrvcoh/DEaGLGV9bDgpW+A==
X-Received: by 10.194.143.104 with SMTP id sd8mr29028495wjb.35.1451556451945;
        Thu, 31 Dec 2015 02:07:31 -0800 (PST)
Received: from [10.0.0.50] (h151n12-g-kt-d2.ias.bredband.telia.com. [213.64.207.151])
        by smtp.gmail.com with ESMTPSA id df10sm54330516wjb.44.2015.12.31.02.07.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2015 02:07:30 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <xmqqy4cbbh5e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283233>

On 12/31/2015 01:23 AM, Junio C Hamano wrote:
> Mostyn Bramley-Moore <mostynb@opera.com> writes:
>
>> OK, brainstorming a bit, how about either of these:
>>
>> 1)
>> --match-pattern-type=<glob|fixed-strings|basic-regexp|extended-regexp|perl-regexp>
>>
>> It's a bit lengthy (maybe --match-type would be sufficient), but I
>> like that the value names are shared with git grep etc option names.
>> And it seems future-proof- if we ever need to support different
>> pattern types for other arguments, a --foo-pattern-type flag could be
>> added and make obvious sense.
>
> Swapping the option key and value may not be a bad idea, but one
> problem that the above does not solve, which I outlined in the
> message you are responding to, is that "match-pattern-type" does not
> give any hint that this is about affecting the match that is done to
> "refs", e.g. you cannot tell in
>
>    $ git mgrep --match-pattern-type=perl-regexp -e foo --refs 'release_*'
>
> if the perl-regexp is to be used for matching branch names or for
> matching the strings the command looks for in the trees of the
> matching branches.

There is a hint: --foo-pattern-type applies only to --foo.

In your mgrep example --match-pattern-type would apply to --match 
patterns only, and if we choose to implement it then --refs-pattern-type 
would apply to --refs patterns only.

eg:
$ git mgrep --match '^foo' --match-pattern-type=perl-regexp --refs 
'release_*' --refs-pattern-type=glob

> Magic pattern annotation like we do for pathspecs Duy raised may not
> be a bad idea, either, and would probably be easier to teach people.
> Just like in Perl "(?i)$any_pattern" is a way to introduce the case
> insensitive match with $any_pattern, we may be able to pick an
> extensible magic syntax and decorate the pattern you would specify
> for matching refnames to tell Git what kind of pattern it is, e.g.
>
>    $ git mgrep -P -e foo --refs '/?glob/release_*'
>
> I am not suggesting that we must use /?<pattern type name>/ prefix
> as the "extensible magic syntax" here--I am just illustrating what
> I mean by "extensible magic syntax".

I hadn't seen the pathspec magic patterns before- interesting.  We could 
possibly share syntax with pathspecs, ie
:(?pattern-options...)pattern

Would this be confusing for commands that already have --perl-regexp 
etc?  What should happen if you specify both --perl-regexp and and a 
different type of pattern like :(glob)foo (error out, I suppose)?


-Mostyn.
-- 
Mostyn Bramley-Moore
TV and Connected Devices
Opera Software ASA
mostynb@opera.com
