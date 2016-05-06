From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 14:15:38 +0100
Organization: OPDS
Message-ID: <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net> <17E04501C9474282B87758C7998A1F5B@PhilipOakley> <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com> <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 15:15:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayfbh-0000Dm-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 15:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757971AbcEFNPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 09:15:40 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:14412 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcEFNPk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 09:15:40 -0400
Received: from PhilipOakley ([92.22.46.244])
	by smtp.talktalk.net with SMTP
	id yfbVaf93eUaZtyfbVatSEQ; Fri, 06 May 2016 14:15:37 +0100
X-Originating-IP: [92.22.46.244]
X-Spam: 0
X-OAuthority: v=2.2 cv=M4MPEG4s c=1 sm=1 tr=0 a=mT+4QNHrLP0fZcn6BgyYDQ==:117
 a=mT+4QNHrLP0fZcn6BgyYDQ==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=g9tvPM0NrmyYqqtw0H4A:9
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDOJ0Epm995nX7Zu9eykpthSgYHhRGPXxLzLq7dqoLEbktCgGYPnOqOjdeWW80dHNoHW3aqr0mAZbe2F5AfWcRDEiY/2t8Yv+S/uQS2nStmGbzXaMu6R
 M/mCQGvAjLJ7UZslRRjLRmWzNinxdxePaUat4Q18rZM2ESfmWThWBYYRI9gtR1E7gt+oj+ontugWA+wCZsO43KU/+3z9V0LiWOjrlrdBqnbQ6ZIRCYC3DcUh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293776>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Fri, May 6, 2016 at 4:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>>     int saved_namelen = saved_namelen; /* compiler workaround */
>>>
>>> Which then becomes an MSVC compile warning C4700: uninitialized local
>>> variable.
>>>
>>> I'm wondering what was the compiler workaround being referred to? i.e. 
>>> why
>>> does it need that tweak? There's no mention of the reason in the commit
>>> message.
>>
>> That was a fairly well-known workaround for GCC that issues a false
>> warning that variable is used before initialized.  I thought we
>> stopped using it several years ago in new code after doing a bulk
>> sanitizing
>
> I guess that's 803a777 (cat-file: Fix an gcc -Wuninitialized warning -
> 2013-03-26) and more commits around that time. The split-index commit
> is in 2014. I must have missed the trend.
>
>> (I think the new recommended workaround was to initialise
>> such a variable to the nil value like '0' for integers).
>
> Yep. First Jeff removed the " = xxx" part from "xxx = xxx" then Ramsay
> added the " = NULL" back. So we probably just do "int saved_namelen =
> 0;" in this case.
> -- 
Thanks,

I'll try and work up a patch - probably next week as I'm away for the 
weekend.

--
Philip 
