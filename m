From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-new-workdir: add windows compatibility
Date: Fri, 29 May 2015 11:53:04 +0200
Message-ID: <55683700.3010201@drmicha.warpmail.net>
References: <CADBZQ5iAKsSrdvBnFcdPcm9psaJo5B-H1zqJj0aRc+xx6cCFMQ@mail.gmail.com> <xmqqfv6k7zp3.fsf@gitster.dls.corp.google.com> <cbfbf842705637b52cde9c6b61f89a75@www.dscho.org> <1432642835.17513.22.camel@mad-scientist.net> <1fb8315dfaffb91ec4925bcc458e12a2@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Smith <dansmith65@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Richard Hartmann <richih@net.in.tum.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	paul@mad-scientist.net, Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:53:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyGyb-0007gj-AT
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 11:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbbE2JxN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 05:53:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45153 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751763AbbE2JxL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2015 05:53:11 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D230320D85
	for <git@vger.kernel.org>; Fri, 29 May 2015 05:53:06 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Fri, 29 May 2015 05:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=TOLooeSmUPGHtuNjVWDEUDWC51w=; b=Iy4nc5
	9qYLdk4Y6753sEWTpa30zKPkTkm1l5qEqcOH5N/2uXxNH0lefQUAJH0+CDT7Xz5T
	jBSFwWa8P/iMvkXxwv4I3CV6iwgjUPuJ0nswLkSOnV40mmp2P3I9gaj0BUb/yg9I
	7vowcQACQ1qiw/HpyogRvtlt1cppre9z2Mi+s=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=TOLooeSmUPGHtuN
	jVWDEUDWC51w=; b=o2qvs2RpfRH5H2x4wciB72q+5yxN4eZ9w80zedSgCOhmtdX
	uhUTkHPY3mYqeR3dhY32AWQ6Zr6sAQO/ChTOSC+C8SA3PrrSOd2kTmy2JROnDU3m
	PkeBZVyAMdUTRYkoEd+YrokcX4TwOZwbxpp+9krNkaAmIVgnmO9UINUJMSOg=
X-Sasl-enc: mdys/rdr+f1XexT0wzIhHBdqDSszJsex1oGzlH8xMdlR 1432893186
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4401FC00015;
	Fri, 29 May 2015 05:53:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1fb8315dfaffb91ec4925bcc458e12a2@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270218>

Johannes Schindelin venit, vidit, dixit 26.05.2015 14:35:
> Hi Paul,
> 
> On 2015-05-26 14:20, Paul Smith wrote:
>> On Tue, 2015-05-26 at 11:53 +0200, Johannes Schindelin wrote:
>>> The biggest problem with `mklink` is that it is only supported on
>>> Windows Vista and later, while I really like to keep Windows XP
>>> support in Git for Windows.
>>
>> No, the biggest problem with mklink is that you have to have
>> administrative privileges to use it... from wikipedia:
>>
>> http://en.wikipedia.org/wiki/NTFS_symbolic_link
> 
> It is even worse than that, as you pointed out below: administrators *can* permit non-administrators to create and use of symbolic links.
> 
> However, from a maintainer's perspective (which is my role in this thread), the compatibility problem is an even worse problem than the permissions.
> 
>>> The default security settings in Windows Vista/Windows 7 disallow
>>> non-elevated administrators and all non-administrators from creating
>>> symbolic links. This behavior can be changed running "secpol.msc" the
>>> Local Security Policy management console (under: Security Settings
>>> \Local Policies\User Rights Assignment\Create symbolic links). It can
>>> be worked around by starting cmd.exe with Run as administrator option
>>> or the runas command.
>>
>> Except even that is not so simple, as various StackOverflow questions
>> and answers will show (I have to run so I can't look them up now).  I
>> did try to get this to work a year or so ago, and although I'm in no way
>> a Windows person (so maybe someone else would have better luck) I
>> couldn't get it to work.
> 
> For what it is worth, I tried my hand a couple of years ago at the project to move git-new-workdir to use the `.git` *file* and alternates mechanisms, but that does not work because you really need a separate `.git/HEAD`.
> 
> Ciao,
> Johannes
> 

Isn't that basically the approach that "git checkout --to" is taking? Is
that one "Windows proof"? I've lost track of its status, though.

Michael
