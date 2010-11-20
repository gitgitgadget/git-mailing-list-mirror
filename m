From: Dowlin Yang <dowlin0820@gmail.com>
Subject: Re: how git pull works?
Date: Sat, 20 Nov 2010 09:18:53 +0800
Message-ID: <BBB0EEDC-25DC-4DB6-8923-762986FC07B0@gmail.com>
References: <4CE3FBA5-3DF0-493F-9600-6D424B5CBA2F@gmail.com> <20101119212729.GH30870@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Nov 20 02:19:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJc79-0005jw-5a
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 02:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756067Ab0KTBTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 20:19:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42045 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755894Ab0KTBT3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 20:19:29 -0500
Received: by gyb11 with SMTP id 11so338210gyb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 17:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=ukAOlhkbEuBcVn2KscLibJbYhxDTQh3bI4ClExugArw=;
        b=NiMEWAJ723yPeLO1nT9jtfsnrbBwFhCwm6/fm/p0Rrmw3c8qZNATOQ1Rp/bvrNm1kN
         umRy5lPQ1SlyB70UG7pcSMXNbcLUiOETsbIMlRsn5M9/mHRS4ApdVmHyu1szc0UdJVw9
         bMCDJSupRe4VspqSSmRpsiO0muzRtExim7/+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=AhE2OGlFjhIO5rIRAwIFBIk3kNoVI2nCwtGcfNHoSm9upxGb2zWI0pYqdSmuRKN2EX
         FMNOzmaqZGqAphaXEYmKw/u3bSwb7xGhac/MG40AOancwg6q1Q7pBTKMPtmmE+/qU6n5
         NZgVhgdzNrW8qwiLRjQPQHr1Abhf6y0ZX9VsA=
Received: by 10.91.17.30 with SMTP id u30mr3557352agi.180.1290215968569;
        Fri, 19 Nov 2010 17:19:28 -0800 (PST)
Received: from [192.168.1.103] (114-37-163-86.dynamic.hinet.net [114.37.163.86])
        by mx.google.com with ESMTPS id r25sm1461457yhc.0.2010.11.19.17.19.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 17:19:27 -0800 (PST)
In-Reply-To: <20101119212729.GH30870@efreet.light.src>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161816>

Hi Bulb

Now I totally got it. Thanks very much for the explanation!

Huiting

On Nov 20, 2010, at 5:27 AM, Jan Hudec wrote:

> On Fri, Nov 19, 2010 at 23:15:51 +0800, Dowlin Yang wrote:
>> I sent an email earlier but it seems rejected. I resent again with plain
>> text format. I am sorry for any inconvenience if you receive my messages
>> twice, and please read the new one.
> 
> If it was HTML it was rejected by the list software and nobody ever saw it.
> HTML is not accepted by any of the lists on vger.kernel.org.
> 
>> Suppose A had a branch b1 and B had a branch b2. They work on their own
>> branch separately but b1 and b2 share the same file f1. Suppose A made
>> a few changes to f1 on Nov 5th.
> 
> Dates are irrelevant. What is the most recent common ancestor?
> 
> Note, that most recent common ancestor is such commit, that is reachable from
> both branches ("common ancestor") and it is not reachable from any other
> common ancestor ("most recent"). No mention of dates anywhere -- just
> parent-child relation between commits.
> 
>> Here are A's changes:
>> [snip]
>> A removed one line and added a few lines to f1 and then committed on Nov
>> 5th.
>> 
>> On the other hand, B made a few changes to f1 too on the next day Nov 6th.
>> Here are B's changes:
>> [snip] 
>> B removed a few lines and then committed on Nov 6th.
>> 
>> They kept updating other files in the following days. After a few days, we
>> decide to merge A's branch b1 with B's branch b2. So A did git pull origin
>> b2 in b1, and the expected resultant file is sth like this:
>> [snip]
> 
> Now git -- and for that matter any other version control system out there
> that ever had a merge command -- looks for the most recent common ancestor.
> Let's call it 'a'(1).
> 
> Now git applied both changes from a to b1 and changes from a to b2. It uses
> the 3-way merge algorithm, which is basically:
> - match up all lines that are the same in all three versions
> - for lines where a and b1 is the same, take b2
> - for lines where a and b2 is the same, take b1
> - for lines where b1 and b2 are the same, take b1 (== b2)
> - for lines where a, b1 and b2 all differ, declare conflict
> 
> You can equally think about this algorithm as applying diff from a to b1 to
> b2 or applying diff from a to b2 to b1. All should give the same results(2).
> 
> For adding/removing files, just think of the tree as file listing what files
> are included (where order is ignored, so the same name is always matched up).
> 
> The individual changes are not considered, ever. Only the sum of changes
> since most recent common ancestor on one and the other side.
> 
>> Aren't newer changes supposed to be applied? Why older changes are the
>> final results?
> 
> No. All changes since branch point or last merge are applied.
> 
>> B's b2 branch had com/category_bar.js added earlier than A's b1. A manually
>> added the same changes to b1 on Nov 5th, but later B decided to remove
>> com/category_bar.js from b2 on Nov 6h as I described.
> 
> b2 had category_bar.js added and removed again, so in the end it had no
> changes in category_bar.js
> 
> b1 had category_bar.js added
> 
> No change (between a and b2) versus addition (between a and b1) is addition.
> So category_bar.js is added in the result.
> 
> If you didn't add category_bar.js independently on b1, but instead pulled
> from b2, the pulled revision would have been most recent common ancestor, so
> b1 would see no further change and b2 would see deletion and result would be
> deletion.
> 
> Footnotes:
> ~~~~~~~~~~
> 1) You can query most recent common ancestor with 'git merge-base b1 b2'.
>   You can view/list all commits from common ancestor to b2 with 'b1..b2'
>   refspec to gitk/git log. You can view/list all commits from common
>   ancestor to both b1 and b2 with 'b1...b2' refspec to gitk/git log. You can
>   get the cumulative diff from common ancestor to b2 with 'git diff
>   b1...b2'.
> 
> 2) Unless there are conflicts or a repeated text, in which case patch
>   application (with limited context) would not have enough information on
>   where to apply while 3-way merge would.
> 
> -- 
> 						 Jan 'Bulb' Hudec <bulb@ucw.cz>
