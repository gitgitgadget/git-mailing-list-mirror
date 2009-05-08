From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Disallow '\' in ref names
Date: Fri, 08 May 2009 09:46:11 +0200
Message-ID: <4A03E343.4020000@op5.se>
References: <1241760757-26068-1-git-send-email-robin.rosenberg@dewire.com> <4A03D776.6070309@op5.se> <4A03DC9C.2050204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, gitster@pobox.com,
	git@vger.kernel.org, spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 08 09:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Kmh-0003kN-JM
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 09:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbZEHHqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 03:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757215AbZEHHqP
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 03:46:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:17950 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632AbZEHHqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 03:46:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so68035fga.17
        for <git@vger.kernel.org>; Fri, 08 May 2009 00:46:13 -0700 (PDT)
Received: by 10.86.59.2 with SMTP id h2mr3334672fga.73.1241768773315;
        Fri, 08 May 2009 00:46:13 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id l19sm542790fgb.22.2009.05.08.00.46.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 00:46:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A03DC9C.2050204@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118577>

Johannes Sixt wrote:
> Andreas Ericsson schrieb:
>> Robin Rosenberg wrote:
>>> This is asking for trouble since '\' is a directory separator in
>>> Windows and thus may produce unpredictable results.
>>>
>> NAK. We allow / on unixy systems, and that's the path separator there.
>> Junio even makes extensive use of it to create per-contributor
>> namespaces for topic-branches.
>>
>> Are you guessing this might be a problem in the future, or have you
>> actually run into it?
> 
> This is not possible on Windows:
> 
> $ git update-ref refs/heads/foo\bar HEAD
> fatal: Unable to create '.git/refs/heads/foo\bar.lock': No such file or
> directory
> 
> The problem is that git doesn't create the directory .git/refs/heads/foo
> because the ref handling only mkdir()s directories that were split off
> from the ref at forward-slashes.
> 

Ok. Isn't the slash -> backslash conversion thing supposed to be done by
a macro? I seem to remember something about PATH_DELIM.

> The decision not to mangle command line arguments that are refs (on
> Windows) was intentional. (We do mangle pathspec, i.e. we convert '\' to
> '/'.) But back then I did not think about what should happen if a ref
> contains a backslash.
> 

But what about when locating directory cutoffs for mkdir() stuff?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
