From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/9] Makefile: Do not install a copy of 'git' in $(gitexecdir)
Date: Mon, 28 Jul 2008 06:41:06 -0400
Message-ID: <488DA242.3000508@gmail.com>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <488D104F.8080005@gmail.com> <7vabg2v83o.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNQBA-0007Ke-0Z
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 12:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbYG1KlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 06:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753381AbYG1KlK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 06:41:10 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:16884 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbYG1KlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 06:41:09 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2979341waf.23
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 03:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=TCkmpUVLM2vcT5BJYHKtmBU/7bxGN+zF2exaEvmaHxA=;
        b=uep7VDenG38oJ2/pyeljMhU+/ZgJt/lhf5DzIkTms+tOJWo2q/zwLv8lTTQA77zgnt
         YY9auoWvlLL21cGFB5JFIS7nR/k4UTQsWoP4A4fkxX8hlgZvKf2jjYlAQgj2hrUEz9J3
         rFqsrFw4VKl4UNbIjPD86uencAIkg8pbAlPoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=hw1uYjLkG0faJEibrb9iiCM5c1x/iEHkBzzOY3sCgwh/mPKptcMcteEk5RXhL/4GFw
         68TG0XXKBIO3xKzENdKvL3QrQkkAL9MX/mDyqHPNDiSDZOOQiOO8pZUSvRTHngKkAGfe
         gLYSnKIGJU4swGBVt99KaRvDUKk1Lc9X5ld30=
Received: by 10.115.59.2 with SMTP id m2mr4659837wak.197.1217241668567;
        Mon, 28 Jul 2008 03:41:08 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id 34sm14619456yxm.0.2008.07.28.03.41.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jul 2008 03:41:07 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vabg2v83o.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90433>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> Johannes Sixt wrote:
>> [...]
>>> diff --git a/Makefile b/Makefile
>>> index 551bde9..cbab4f9 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -1335,6 +1335,7 @@ endif
>>>  			'$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'; \
>>>  	fi
>>>  	$(foreach p,$(BUILT_INS), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
>>> +	$(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
>>>  ifneq (,$X)
>>>  	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p';)
>>>  endif
>> This new action needs to be in a conditional to keep it from removing
>> the ONLY git executable when bindir and execdir are the same dir.
> 
> Heh, I love bug reports that come immediately after I tag the tip of
> 'master' as -rc1.
> 

Well, I'm currently about a week behind on all things git so this is as 
timely as I could make it. ;-)
