From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 24/25] worktree move: accept destination as directory
Date: Thu, 12 May 2016 07:58:51 +0200
Message-ID: <57341B9B.9010600@kdbg.org>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
 <1460553346-12985-25-git-send-email-pclouds@gmail.com>
 <CAPig+cRtajkynLFj5Fknd72QQ=Eqevh1T9i9MvApwXfNmtMAFQ@mail.gmail.com>
 <CACsJy8CCAan9ALxULPFeGSU7wsfwbrywRWFr4Hsjx3=PGwosLA@mail.gmail.com>
 <CAPig+cTB8tdPo=wd5UdB84owKJ6c5hj6H9d4_YGDRecBdUE0vA@mail.gmail.com>
 <57337ACF.3020402@kdbg.org> <xmqqbn4cjn2g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 07:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0jeE-0008VV-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbcELF6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:58:55 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:32043 "EHLO bsmtp2.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbcELF6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:58:54 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 3r52Nr0jmtz5tlM;
	Thu, 12 May 2016 07:58:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 86E4E5282;
	Thu, 12 May 2016 07:58:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqbn4cjn2g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294392>

Am 11.05.2016 um 23:34 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> As this path is read from a file git itself creates, and if we know
>>> that it will always contain forward slashes, then I agree that it
>>> could be potentially confusing to later readers to see
>>> git_find_last_dir_sep(). So, keeping it as-is seems correct.
>>
>> Please allow me to disagree. There should not be any assumption that a
>> path uses forward slashes as directory separator, except when the path
>> is
>>
>> - a pathspec
>> - a ref
>> - a path found in the object database including the index
>
> I think standardising on one way for what we write out would give
> less hassle to users.  The human end users should not be opening
> these files in their editors and futzing with their contents, but
> there are third-party tools and reimplementations of Git.  Forcing
> them to be prepared for input with slashes and backslashes does not
> make much sense to me.

It is the opposite: We would force other tools to write slashes even 
though on Windows both types of slashes are allowed as directory separators.

> Is there an upside for us to accept both slashes in this file?

Obviously, yes: We can accept what third-party tools write.

BTW, we also have to accept absolute paths in the file, no? Then we 
cannot assume that the path begins with a slash on Windows; absolute 
paths would come in drive letter style on Windows.

-- Hannes
