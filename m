From: Andreas Ericsson <ae@op5.se>
Subject: Re: git on HP NonStop
Date: Thu, 23 Aug 2012 10:23:35 +0200
Message-ID: <5035E887.3030209@op5.se>
References: <001101cd79f2$f21b3bd0$d651b370$@schmitz-digital.de> <7vr4r98rfd.fsf@alter.siamese.dyndns.org> <004b01cd7a34$dbf2c160$93d84420$@schmitz-digital.de> <alpine.LNX.2.01.1208191824100.29175@frira.zrqbmnf.qr> <000701cd7ebf$af552aa0$0dff7fe0$@schmitz-digital.de> <503217F2.5070105@viscovery.net> <7vfw7hle6l.fsf@alter.siamese.dyndns.org> <001901cd7f15$98c6ab50$ca5401f0$@schmitz-digital.de> <7vy5l9f186.fsf@alter.siamese.dyndns.org> <002b01cd8084$8459abc0$8d0d0340$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Johannes Sixt' <j.sixt@viscovery.net>,
	'Jan Engelhardt' <jengelh@inai.de>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Shl-0007Xj-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933737Ab2HWIXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:23:46 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:61989 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933730Ab2HWIXl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 04:23:41 -0400
Received: by lbbgj3 with SMTP id gj3so284270lbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 01:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=kFYgT6dLl+NlI8iFPfDS1J0ONWEltFK8y1cbDrlndJg=;
        b=kLWGgWsiwYURWeKHvM8xCDDeKiRcCpTvVl0mL6BQOlQuKfVm73NEt3bVlRKdWCdrsH
         bgU2OQFCSreS4L5cTKvcmaJ0s5mtAmP7XQibtVHLVUNSDzbfggwjknfWB9MtmIAUvAgB
         GopAJ4J4Gsk+P28uQ3oTQ0kMDgKcOWveb4JF5LE+m4Ar1bXeexADhtSl0tKOJG65JIkT
         ntCuUTonjJKDAW1hhq3OMjYkFlMmMehPIOUCV1UlWGqsfjZ3cTVNg84BKRyeDvtckfdG
         /3JzONnzXbHctv33b1tZRp0K7YgCKuxwoz6BuAoeEvqFzO2Rd8PWqYzlqPJTcS2hg8tU
         4kRA==
Received: by 10.152.131.68 with SMTP id ok4mr749004lab.47.1345710219619;
        Thu, 23 Aug 2012 01:23:39 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id xx8sm6790379lab.10.2012.08.23.01.23.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 01:23:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <002b01cd8084$8459abc0$8d0d0340$@schmitz-digital.de>
X-Gm-Message-State: ALoCoQmZ7qk7nFU1mQ7yxzo9XaDr++QLfEx9/BKFpZnJf7+zxUuuwY688mWHFdjoOhuaJo+xwLw8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204134>

On 08/22/2012 06:38 PM, Joachim Schmitz wrote:
> 
> 
>> -----Original Message-----
>> From: Junio C Hamano [mailto:gitster@pobox.com]
>> Sent: Tuesday, August 21, 2012 4:06 AM
>> To: Joachim Schmitz
>> Cc: 'Johannes Sixt'; 'Jan Engelhardt'; git@vger.kernel.org
>> Subject: Re: git on HP NonStop
>>
>> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
>>
>>> OK, so let's have a look at code, current git, builtin/cat-file.c,
>>> line 196:
>>>          void *contents = contents;
>>>
>>> This variable is set later in an if branch (if (print_contents ==
>>> BATCH), but not in the else branch. It is later used always under the
>>> same condition as the one under which it is set.
>>> Apparently is is malloc_d storage (there a "free(content);"), so
>>> there's no harm al all in initializing it with NULL, even if it only
>>> appeases a stupid compiler.
>>
>> It actually is harmful.  See below.
> 
> Harmful to initialize with NULL or to use that undefined behavoir?
> 
> I checked what our compiler does here: after having warned about "vlues us
> used before it is set: it actually dies seem to have initializes the value
> to 0 resp. NULL.
> So here there's no harm done in avoiding undefined behavior and set it to 0
> resp NULL in the first place.
> 

There is harm in tricking future programmers into thinking that the
initialization actually means something, which some of them do.

It's unlikely that you're the one to maintain that code forever, and
the "var = var" idiom is used widely within git with a clear meaning
as a hint to programmers who read a bit of git code. If they aren't
used to that idiom, they usually investigate it in the code and
pretty quickly realize that what it means.


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
