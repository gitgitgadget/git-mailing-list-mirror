From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-svn: refuse to dcommit non-UTF-8 messages
Date: Fri, 29 May 2009 09:11:22 -0500
Message-ID: <6I7Qq-BKaJmSe6FJkYgjMpNqo6RFAVB0STpL09QJO1skOCB2ezM6mA@cipher.nrlssc.navy.mil>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>	<20090528080706.GA9239@dcvr.yhbt.net>	<20090528081804.GB9239@dcvr.yhbt.net> <7v3aaoe40j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 16:14:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA2rC-000434-Dn
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 16:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906AbZE2OOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 10:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756531AbZE2OOe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 10:14:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52990 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZE2OOe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 10:14:34 -0400
Received: by mail.nrlssc.navy.mil id n4TEBNk7005525; Fri, 29 May 2009 09:11:23 -0500
In-Reply-To: <7v3aaoe40j.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 29 May 2009 14:11:23.0548 (UTC) FILETIME=[58F515C0:01C9E067]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120280>

Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
>>  t/t9139-git-svn-non-utf8-commitencoding.sh |   47 ++++++++++++++++++++++++++++
> 
> Hmm.
> 
>> +# Copyright (c) 2009 Eric Wong
>> +
>> +test_description='git svn refuses to dcommit non-UTF8 messages'
>> +
>> +. ./lib-git-svn.sh
> 
> This passes when merged to 'master', but together with bc/old-iconv branch
> cooking in 'next' it breaks.

Yeah, it's the second for loop which accesses the files in t/t3900/.
bc/old-iconv replaces each occurrence of ISO-8859-1 with ISO8859-1
and EUCJP with eucJP since old Solaris didn't know both names and
modern platforms handle either name.  The text files in t/t3900/
were renamed accordingly.

It would be nice to use these older names here too, even though I
won't be able to test it since svn is not installed on the older
platforms I have access to.

-brandon
