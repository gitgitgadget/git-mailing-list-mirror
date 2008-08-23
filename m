From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 1/2] git-submodule: replace duplicated code with a module_list
 function
Date: Fri, 22 Aug 2008 20:36:48 -0400
Message-ID: <48AF5BA0.5050001@gmail.com>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com> <7vpro064qz.fsf@gitster.siamese.dyndns.org> <48AF533E.9020102@gmail.com> <7v8wuo619x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 02:37:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWh8e-0000oZ-BS
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 02:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbYHWAgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 20:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYHWAgx
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 20:36:53 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:36336 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbYHWAgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 20:36:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so110723and.103
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=OHoVeZpFG6aqaH248OaCgQsmGuO4hnCKLEM7KMpV5MQ=;
        b=UCxyT+Zg8a88JIZrRCP+Gpa5X4Hra9YvBYpKbSbVWX6tZ3kYCtpBT/mPC8dv9LATyB
         4OXOUOjZ79r8JeiqIpzzZdg9iTZ4EqGBbkjnfqmCGjI57/mQAb3l+V/ZM01dCZiAqbMW
         xamwtgOk8OhVvWE4Xv5lMSUAfLlrB67u2PfNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=IdLqUeC8c59WRrSYLMMx8b+q9a2suUznUMM1mdMvfsFYLyKZm3efR9Ht7yazpiFOTb
         KiGZVJexABv2ttx3+V1ZoIfoGsWbmsuj9QoihNqAXtG+XiRGdP2YX5Uh3hBQNqDaOLeX
         FTcAXLQUKEIpD8vKCu8TZe9O0ce/KUhgiR8xM=
Received: by 10.100.136.15 with SMTP id j15mr2221434and.62.1219451811417;
        Fri, 22 Aug 2008 17:36:51 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.163.41.46])
        by mx.google.com with ESMTPS id c9sm3248183ana.9.2008.08.22.17.36.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 17:36:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7v8wuo619x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93411>

Junio C Hamano wrote:
>> a)  What specific option or options to git ls-files makes sense here?
>> b) How do we distinguish the ls-files options from the command to be
>> executed?
>>     
>
> Ah, I was blind.  For (a) I do not see any need for "option" but
> pathspecs; and (b) I agree is a real problem.  We of course could do
> something like:
>
>     $ git submodule foreach -c 'your command here' your pathspec here
>
>   
As the command is required, while pathspec is optional, the latter 
should require the option, not the former. How about...

    $ git submodule foreach [-l pathspec] 'command'

or

    $ git submodule foreach [<pathspec> --] 'command'

Mark
