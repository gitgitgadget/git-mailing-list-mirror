From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: GC of alternate object store
Date: Fri, 31 Aug 2012 15:18:03 -0400
Message-ID: <CAPBPrnvrQx2SeyNM_nxnn7bB=Sakj6X=dbH2va+O-TnspY=Bpw@mail.gmail.com>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
	<loom.20120827T233125-780@post.gmane.org>
	<hbf.20120828vnfp@bombur.uio.no>
	<20120829074249.GA14408@ugly.local>
	<7v3935y9tw.fsf@alter.siamese.dyndns.org>
	<20120830095314.GA29038@troll08.europe.nokia.com>
	<7vbohstlih.fsf@alter.siamese.dyndns.org>
	<20120831162629.GA18215@troll08.europe.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 21:18:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7WjO-0001Ap-7X
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 21:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2HaTSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 15:18:06 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62594 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab2HaTSF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 15:18:05 -0400
Received: by eaac11 with SMTP id c11so1021415eaa.19
        for <git@vger.kernel.org>; Fri, 31 Aug 2012 12:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LF71OUDC5UflNjPI/eybqXYf9gFDw80qjWPgqnPS6hI=;
        b=NUCotrVGM/dgETd6J11gisBrZYeVpyi2r6wS0cDdMwECIk/p2061Z8ct02H5IQdPKL
         c5fRTRZRdcRNbBjHpz8hoKCZJnHqA1uBb8wbIaR5JHuzyFKxXzOSSG5DMPKXHHZOyUsj
         d6q+lsGSzPuJdvROpPCEVU1M4ZCIwWKKYulXmlVRpP96NGGrBBIA8YerU+BTI9I/8rwb
         Xd1tBECeyH5PFbo98NEjkYzvY1oDOtBSkw5bHVDH8F4MrZJ0YUwwwIQ8xS29tbR+bLcg
         whZzgiUK3wCjYBK+h2MiiYBPltaS9ttsqRYChunOinabZyb3ptDDvG1xY78E77Yy/WMM
         ZlAA==
Received: by 10.14.4.201 with SMTP id 49mr12611529eej.0.1346440683446; Fri, 31
 Aug 2012 12:18:03 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Fri, 31 Aug 2012 12:18:03 -0700 (PDT)
In-Reply-To: <20120831162629.GA18215@troll08.europe.nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204605>

On Fri, Aug 31, 2012 at 12:26 PM, Oswald Buddenhagen <ossi@kde.org> wrote:
> On Thu, Aug 30, 2012 at 09:03:34AM -0700, Junio C Hamano wrote:
>> Oswald Buddenhagen <ossi@kde.org> writes:
>>
>> >> Doesn't
>> >>
>> >>    git push $over_there 'refs/*:refs/remotes/mine/*'
>> >>
>> >> push your tag v1.0 to refs/remotes/mine/v1.0 over there?  The
>> >> version of git I ship seems to do this just fine.
>> >>
>> > as i wrote before, i'm pulling, not pushing,...
>>
>> You would need to decline the automatic tag following with --no-tags
>> (which in hindsight is misnamed; it really means "do not auto-follow
>> tags"), like so:
>>
>>       cd $over_there &&
>>         git fetch --no-tags $my_repository 'refs/*:refs/remotes/mine/*'
>>
>> Otherwise, you will also get tags in refs/tags/.
>>
> git seems to be happily ignoring that flag.
>   git fetch --prune --all --no-tags
> still re-populates the tags after i delete them manually.

I believe that is bad interaction with "--all" (probably a bug). If I
am remembering correctly, --no-tags is internally a per-remote
setting, so I'm guessing it's not getting set on all remotes here.

I'll look into this more a bit later tonight. Does fetch --no-tags
work when you specify a remote?

-- 
-Dan
