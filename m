From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Sat, 11 Dec 2010 02:40:31 +0100
Message-ID: <201012110240.32854.jnareb@gmail.com>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net> <201012110115.16225.jnareb@gmail.com> <4D02D0C4.2020207@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Sat Dec 11 02:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRES7-00041u-Os
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 02:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580Ab0LKBkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 20:40:40 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:40273 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab0LKBkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 20:40:39 -0500
Received: by bwz16 with SMTP id 16so4716538bwz.4
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 17:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tcOSjkOSo+TNWpFhhotsTfw9bHnwqF/H6w/sKi0DRFk=;
        b=AqCnk8KQ189JNCW8UZQCMzJxY2nBDCY5CE9GnRu1yRvzgeOZ8FX3cjCSJVS8i47WxR
         MG1f83qJiPjk7TH9uI+1B0B3knAvz54gAFl+rmRTyFXFZu8VmZwIxzvQvmpDYGEZ+sSV
         0ivzbMIV//w8xbdpJq4P3VP7JFh2zpfxwW8dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hAgUI+ttXbh+lixZxwIkjoddUP1IITvhAl0I2hEItnSkU7C/CtwfL526bvyuql0lBo
         UWIRjr/tyEVeWe3qmQF7ZlLO4xAsavNPr6exnRT4dEljuYkzbKqUsRMo2jcj8/uRBfXr
         gNMbsVcYYsWQVmVBguilHfrJwRYtOFKg+FpQM=
Received: by 10.204.75.155 with SMTP id y27mr1339234bkj.125.1292031638329;
        Fri, 10 Dec 2010 17:40:38 -0800 (PST)
Received: from [192.168.1.13] (abvg16.neoplus.adsl.tpnet.pl [83.8.204.16])
        by mx.google.com with ESMTPS id v1sm1835707bkt.17.2010.12.10.17.40.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 17:40:37 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4D02D0C4.2020207@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163455>

On Sat, 11 Dec 2010, J.H. wrote:
> On 12/10/2010 04:15 PM, Jakub Narebski wrote:
>> Junio C Hamano wrote:
>>> "J.H." <warthog9@eaglescrag.net> writes:
>>>
>>>> My initial look indicated that perl-http-browserdetect wasn't available
>>>> for RHEL / CentOS 5 - it is however available in EPEL.
>>>>
>>>> However there are a couple of things to note about User Agents at all:
>>>> 	- They lie... a lot
>>>> 	- Robots lie even more
>>>>
>>>> Blacklisting is still the better option, by a lot.  I'll re-work this
>>>> some in v9, as I'm fine with the added dependency.
>>>
>>> Thanks, both.  I sense that we finally are going to get a single version
>>> of gitweb that can be used at larger sites ;-)
>> 
>> I wouldn't be so optimistic.  While we borrow features and ideas from
>> each other, the difference still remains that J.H. patches are bit hacky
>> but are tested, while my rewrite is IMHO cleaner but untested (well, 
>> untested on real life load).
> 
> At this point I'm not sure there is a way to rectify the two patch
> series, and while we may borrow ideas from each other it's becoming
> clear that we are both, generally speaking, heading in different
> directions for what we want and need out of gitweb.  Jakub's patches for
> the admin page are indicative of that.

Actually the cache administration page was just proof of concept.  Perhaps
a better solution would be to provide script that can be run to safely
clean cache (or just heavily outdated entries).


What I want from caching series is a clean separation between capturing
(so it can be replaced in the future e.g. by Capture::Tiny, or capturing
to mmapped fragment for Cache::FastMmap-like cache, or simple capturing
to memory for Memcached), caching engine (so it can be replaced by some
good and tested caching engine, like Cache::Cache, Cache, Cache::Memcached,
Cache::FastMmap, CHI and its drivers and options like cache levels), and
caching output module.  Modular build makes it easier to catch errors
and allows for unit testing each component separately.  And you can simply
use 'require <Package>' instead of doing manual error handling and 
protecting against redefine errors / multiple include via 'do <file>'.

What I don't like is caching engine guts strewn all over the gitweb.
I'd rather capturing engine was not tied too tightly with gitweb.  The
least controversial is "output caching" part...

Anyway I'd try to keep my rewrite feature-compatibile with J.H. series,
including (from v7) also backward compatibility with cache config option
names, including $cache_enable.  (Grrr... API/ABI backwards compatibility).

> 
>> Anyway the main issue that was discovered by PATCHv6 by me, and v8 by J.H.
>> is that die_error sucks... well, at least if background caching is enabled.
> 
> I'd agree with that, and as such I'm working on a complete re-work of
> error handling in gitweb for v9.  Things are looking pretty good so far,
> but to claim that it's a non-invasive patch would be akin to selling
> someone the Brooklyn bridge.

Hmmm... I am also thinking about changing the way error handling is done
in gitweb, but I don't think it would be very invasive: for a non-cached
case it would be simply one "eval" in run_request() or run(), and "die"
instead of "goto DONE_XXX" in die_error().
 
Now if only there were HTTP::Server::Simple::FCGI so I would be able to
test fastCGI support without need to install mod_fcgi / mod_fastcgi for
Apache... (local::lib and cpanm for the win!).

> That said, the way Gitweb handles it's errors and things like exit are
> appalling and this has been something that's needed doing for a while
> anyway.  Guess now's the time to do it.  Might be a few days for me to
> get far enough for any of it to be worthwhile sharing, late next week
> maybe.  That said I hit vacation starting on the 20th so it might be
> next year before that is finalized.

I also don't think that output caching can be done before end of this year,
sorry.

Hmmm... I guess that in shortened minimal version of my rewrite of output
caching for gitweb (without zero-size check, adaptive cache lifetime, 
perhaps even without support for alternate caching engines) I should also
include minimal improvement to die_error-handling.  Just like there is
"gitweb: Prepare for splitting gitweb" there.

-- 
Jakub Narebski
Poland
