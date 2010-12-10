From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Fri, 10 Dec 2010 15:11:56 -0800
Message-ID: <64905EED-F368-4D3F-9D2D-C08D9B460D67@sb.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com> <201012090254.24999.jnareb@gmail.com> <20101209015926.GA31119@burratino> <7vsjy7h3db.fsf@alter.siamese.dyndns.org> <AANLkTimg4Cy83gjzgC3fwg+t=B57b6gzOE98p-=2AR+K@mail.gmail.com> <20101210190332.GA6210@burratino> <66D6F30D-4707-4057-BB46-57B2DF01F479@sb.org> <7vipz1b4zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 11 00:12:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRC8D-00014Z-9M
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 00:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab0LJXL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 18:11:59 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56661 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab0LJXL7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 18:11:59 -0500
Received: by pwj3 with SMTP id 3so811280pwj.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 15:11:58 -0800 (PST)
Received: by 10.142.194.21 with SMTP id r21mr937648wff.342.1292022718611;
        Fri, 10 Dec 2010 15:11:58 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm4654050wfc.5.2010.12.10.15.11.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 15:11:57 -0800 (PST)
In-Reply-To: <7vipz1b4zm.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163448>

On Dec 10, 2010, at 3:08 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> On Dec 10, 2010, at 11:03 AM, Jonathan Nieder wrote:
>> 
>>> - What is the intended use for this family of modifiers?  I sort
>>>  of understand ^{:i/... } for people that forget what case they
>>>  have used, but why the :nth and others?
>> 
>> In my particular case, I was glancing through the logs, and I wanted to grab
>> the second branch that someone else had made that was merged into pu. I would
>> have loved to be able to run something like
>> 
>>  git merge origin/pu^{:nth(2)/nd/}
>> 
>> While we're speaking of modifiers, could we use one that says "only search
>> the first parent hierarchy", e.g. something equivalent to git log's --first-parent
>> flag?
> 
> Both feels like a very made-up example to me.

And yet the example I gave is pretty much precisely what prompted me to start
this discussion in the first place.

> The reason you can so sure that you can to give nth(2) not nth(3) nor
> nth(1) and run "merge" in the example is probably because you looked at
> the output from "git log --first-parent --oneline origin..origin/pu", no?
> 
>  d414638 Merge branch 'rj/msvc-fix' into pu
>  e5f5e49 Merge branch 'ak/describe-exact' into pu
>  439932d Merge branch 'jn/svn-fe' into pu
>  d60b33b Merge branch 'pd/bash-4-completion' into pu
>  09cbbde Merge branch 'tf/commit-list-prefix' into pu
>  1b2ea00 Merge branch 'mg/cvsimport' into pu
>  c6d41f4 Merge branch 'nd/maint-relative' into pu
>  81f395e Merge branch 'ab/i18n' into pu
>  9f5471f Merge branch 'nd/setup' into pu
>  06f74a4 Merge branch 'yd/dir-rename' into pu
>  d8a2ec8 Merge branch 'en/object-list-with-pathspec' into pu
> 
> After looking at this output, do you really want to say ":nth(2)/nd/"
> instead of 9f5471f?

Yep. Doing the latter either requires me to swap over to my mouse, copy the sha1,
and paste in, or requires me to peer at the sha1 and re-type enough characters.
It's a lot easier to just glance at that list, realize the 2nd one is the one I
want, and type `git merge :^{nth(2)/nd/}`. It may not necessarily be faster than
retyping the sha1, but it's a lot less prone to transcription errors.

-Kevin Ballard