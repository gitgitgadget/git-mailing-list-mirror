From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 19:07:11 -0400
Message-ID: <51E9C69F.7080309@gmail.com>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com> <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> <7vtxjqwlj2.fsf@alter.siamese.dyndns.org> <51E982D0.5040505@gmail.com> <7vtxjquzqm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 01:07:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Jlh-0003wo-GF
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 01:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab3GSXHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 19:07:15 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:38486 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab3GSXHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 19:07:14 -0400
Received: by mail-qe0-f45.google.com with SMTP id w7so2704198qeb.32
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 16:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=t34q4IedII2yxBI+cgiKmJYPcAQ4THr0kA7wJvOcVug=;
        b=ce5+GquMYZpRAbzL3kiKdfe0YQeDSYyW6CG9F5rNmeHhkSb7flyC82kQSE9K4JotIG
         Zl1IYkReiqDADq7N0DTmzn0iewbdlLtC4BwCmtaE+dEE8Zuxayd4YBzH9nYh+Tu401S1
         /yLxIa3GUcoGwKavIwr8r6BUr/t/NiRuL4DEOH1bv1PTwPj5x80HOboQQQJBk93WAhOM
         f8AQGVn7of0MB8/yRlobQtBCvRRe3hmtXjLnWDUwieKCgpEo8M2pAtjWceuDQ/3Hj3OX
         hHc7bav1N4KVgpXkpL2af4bC1sKNjVZCm51Ry38WMsY2+ehhcf7W36wS2IS6mlVUPBsG
         fMXg==
X-Received: by 10.49.98.138 with SMTP id ei10mr19649555qeb.3.1374275233544;
        Fri, 19 Jul 2013 16:07:13 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id w2sm22483562qec.8.2013.07.19.16.07.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 16:07:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <7vtxjquzqm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230858>

On 07/19/2013 03:16 PM, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> Related: Should we have separate settings for 1.5 and 1.7 for several
>> variables? Conflicts I see not reflected in config.mak.uname on pu:
>>      trustable filemode   (1.7 has, 1.5 does not)
>>      MMAP/Pread (1.7 pread is thread safe, 1.5 I dont think was, MMAP
>> utility is convolved in this)
>>      regex - 1.7 is broken, per Ramsay 1.5 works
>>
>> If you think its worth it, I'll create a patch series with the above
>> and justifications for the different settings that I know.
> I'd say that would be a sensible thing to do, given that the
> alternative seems to be "let's drop 1.5 support right now, because
> otherwise we cannot run Git on 1.7".
>
>
Ok, the following sequence builds up options for Cygwin 1.7 while 
leaving Cygwin 1.5 as-is. This series should replace

dad577f Cygwin has trustable filemode
174bb98 Use compat/regex on Cygwin

After merging the following into current pu, all tests that run by 
default pass on Cygwin 1.7, i.e.
     prove -j 8 t[0-9]*.sh
reports "All tests successful."
I've *never* had this happen on Cygwin before.

Mark


Mark
