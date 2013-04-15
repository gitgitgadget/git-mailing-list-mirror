From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Mon, 15 Apr 2013 23:20:01 +0200
Message-ID: <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org> <7v4nf7qzkd.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 23:20:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URqpT-000525-Nk
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935120Ab3DOVUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:20:43 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:59235 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935074Ab3DOVUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:20:42 -0400
Received: by mail-ia0-f178.google.com with SMTP id w21so2905361iac.37
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VEE7v0YRQnz3M0x9iDOH7I4DG1VjlmHlFmOIwluuDPU=;
        b=o/EDJaHcnvHZ/6ZS2zyqZTBDz0zcWNCNBoyLDHPxPfbwhmj14TliR42R8d6ferFHbP
         lA/A1it+PjNwW7rl6ngcgAF9wqaMCWbB8LklalsHNqU88YGvzODti7Saofnh0pF5+YnP
         9w26EiFduu2CKyGNZCO24p9n91vX7A0bYlonHqxnLZwM0qw37aLJRl5b/6uLyg76nZi3
         PChFHwPc4VE9DFbeYFLy9boQUHlaYR5+tJ+e6dV7ec2IKp/cSmQ6zPnMiQffMkTtG2T6
         5sfANb/bMNAuKKKqbZ6E8eCCjYo8TTz8HkylwB/Ub6gi7qyi25jp0AZgqbsn4ZBLQ1u7
         UhaQ==
X-Received: by 10.50.77.110 with SMTP id r14mr6381685igw.85.1366060841853;
 Mon, 15 Apr 2013 14:20:41 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Mon, 15 Apr 2013 14:20:01 -0700 (PDT)
In-Reply-To: <7v4nf7qzkd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221317>

On Mon, Apr 15, 2013 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> If you try this:
>>>
>>>  1. Install Git for Windows (from the msysgit project)
>>>  2. Put
>>>
>>>      [core]
>>>              autocrlf = false
>>>              eol = native
>>>
>>>     in your .gitconfig.
>>>  3. Clone a project with
>>>
>>>      *.txt text
>>>
>>>     in its .gitattributes.
>>>
>>> Then with current git, any text files checked out have LF line
>>> endings, instead of the expected CRLF.
>>>
>>> Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> Cc: Johannes Sixt <j6t@kdbg.org>
>>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>>> ---
>>> Eyvind Bernhardsen wrote:
>>>
>>>> Introduce a new configuration variable, "core.eol", that allows the user
>>>> to set which line endings to use for end-of-line-normalized files in the
>>>> working directory.  It defaults to "native", which means CRLF on Windows
>>>> and LF everywhere else.
>>>
>>> The following fixup has been sitting in my tree (but not tested on
>>> Windows) for a couple of weeks.  Sensible?
>>>
>>> I don't know what the right choice for Cygwin is; probably LF unless
>>> there is some way to detect the systemwide setting at run time.
>>
>> Has anybody in Windows land any input?  I don't think what I do before
>> 1.7.3 in my tree would matter much, so I am not applying this myself.
>
> Pinging MsysGit folk again ...
>
>

This is absolutely the right thing to do. However, stuff have changed
a bit since the patch was written; this change now needs to go in
config.mak.uname instead of config.mak.
