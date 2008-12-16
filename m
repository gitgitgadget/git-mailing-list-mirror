From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv4 3/3] gitweb: link to patch(es) view from commit and log views
Date: Tue, 16 Dec 2008 11:14:34 +0100
Message-ID: <200812161114.35336.jnareb@gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com> <200812160203.29425.jnareb@gmail.com> <cb7bb73a0812160202n1f4f7f4fi7f71455eb42bcd31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 11:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCWy7-0002tW-I3
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 11:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYLPKOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 05:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbYLPKOl
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 05:14:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:12136 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbYLPKOl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 05:14:41 -0500
Received: by ug-out-1314.google.com with SMTP id 39so255429ugf.37
        for <git@vger.kernel.org>; Tue, 16 Dec 2008 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vrpycKYAmXWqtMPTR76zNiJl5giU88n9Qm4Gi9vO8ug=;
        b=W24DkissWiQpdwwPBqdHvVzl0J6OHuqV1lewKB1BnSazvfEe7X/SbboElC8hTZlbhY
         i+SMyYho2YLZk/t4clleMGM7X01TUBfR6tJYljvgZoSTl2f92ljADm8wEH7x1n0Mz7Yu
         265sLpCCUQmnUgKo0pjVx7OF7PN0HnrNjQPZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hQP//RWg4LiRoZCeWfLK+C9h7CxxSKM+tqUHyBqlASvvEQgHMWzt3D+//vWaJOYaLq
         0vONbSSI+DYZB0RXX7jHacgSWoSgpkhoedKQExlihtnyvQH4tKmxmiW4yNc1NJJkoh0+
         o/jU+X4NfvbiLP/5S6GalbIcYz7+HEM4f/upY=
Received: by 10.67.115.16 with SMTP id s16mr2561527ugm.47.1229422479292;
        Tue, 16 Dec 2008 02:14:39 -0800 (PST)
Received: from ?192.168.1.11? (abve222.neoplus.adsl.tpnet.pl [83.8.202.222])
        by mx.google.com with ESMTPS id p39sm1014456ugd.54.2008.12.16.02.14.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Dec 2008 02:14:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812160202n1f4f7f4fi7f71455eb42bcd31@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103268>

You lost CC, somehow...

On Tue, 16 Dec 2008, Giuseppe Bilotta wrote:
> On Tue, Dec 16, 2008 at 2:03 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > On Sat, 6 Dec 2008, Giuseppe Bilotta wrote:


>>> +     if ($patch_max) {
>>> +             if ($patch_max < 0 || @commitlist <= $patch_max) {
>>> +                     $paging_nav .= " &sdot; " .
>>> +                             $cgi->a({-href => href(action=>"patches", -replay=>1)},
>>> +                                     @commitlist > 1 ? "patchset" : "patch");

[...]
>> I wonder if it would make sense to pass
>>
>>   href(..., hash_parent => $commitlist[-1]{'id'}, ...)
>>
>> here. But I think having separate "patches" action, with intent being
>> displaying series of patches, is a better solution. This way you can
>> see in URL and in the page title (thus also in window title, or in
>> bookmark name) if it is single patch or patch series (perhaps consisting
>> of single patch).
> 
> I'm not sure I'm following you here. Do you mean as in manually adding
> the parent endpoint to the URL when it's not specified in the log view
> itself? I think that would change the behaviour for > 100 patches.

First, I meant here that having separate "patches" action is a good
idea in itself, whether we pass explicitly and always $hash_parent
parameter here or not.
 
Second, I haven't thought about interaction with (short)log
pagination; in $patch_max < 0, i.e. unlimited patches, and most
common case of running 'shortlog' action without 'hp' (hash_parent)
limiter used, one would make 'patches' limited to page size,
other unlimited.  On one hand side limiting to page size makes
"patches" be more of equivalent of current "shortlog" view; on the
other hand it makes 'unlimited' actually be limited to page size,
at least in this situation...

-- 
Jakub Narebski
Poland
