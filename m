From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Surprising interaction of "binary" and "eol" gitattributes
Date: Wed, 11 Mar 2015 06:54:34 +0100
Message-ID: <54FFD89A.9050306@web.de>
References: <54F88684.3020905@alum.mit.edu>	<xmqqwq2v14iv.fsf@gitster.dls.corp.google.com>	<54F9422D.2020800@web.de> <54F9E907.4040703@alum.mit.edu>	<54FA1C7B.3040906@web.de> <54FF450F.7040506@alum.mit.edu>	<xmqq385c1v13.fsf@gitster.dls.corp.google.com>	<54FF6D23.4060301@alum.mit.edu> <xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:54:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVZba-00088l-4x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 06:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbbCKFyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 01:54:50 -0400
Received: from mout.web.de ([212.227.15.3]:62373 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbbCKFyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 01:54:49 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MOj14-1YPVri3KvG-00651J; Wed, 11 Mar 2015 06:54:41
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqsidcxy2q.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:Tw/meOgDJ78icJAQ/8npIs/p418RZ4ASWskeH8IxJ9jqWNcf++2
 ujB4BXSH3tAebGIDSBnCfLeAjyjzzMl31AvOIdYJ8Ji3NG5YdS60NmfPWMFZHZfxIJ+0rFs
 ITQaOiPUIBuJNf+s0vsdW5LeQkHZvdSARn57FYJLbnAOTTddMAwZTnArqiLHmljQyaplzkf
 NscdVls6UZYyjMSoRCWsQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265302>

On 03/10/2015 11:54 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Well, that's true, but the "eol" attribute can regain its effect if
>> "binary" is followed by "text" or "text=auto". So I guess the simplest
>> question is as follows. Suppose I have the following .gitattributes:
>>
>>      a.foo eol=crlf
>>      a.foo binary
>>      a.foo text
>>
>> It is obvious in this case that a.foo should be treated as a text file.
>> Should it be processed with "eol=crlf", or should the intervening
>> "binary" imply "-eol"?
> I would say former.  You find out what attributes apply to a path
> and then consider the collective effect of these attributes that
> survived.
>
> So the second "No it is not text" which is overruled by the "oops,
> no that is text" later should not get in the picture, I would say.
>
> As binary is not just -text and turns other things off, those other
> things will be off after these three.
Not sure if I follow:
Whenever you specify -text, the eol doesn't matter, or what do I miss ?

Specifying "*.txt eol=crlf" includes "*.txt text",
but with the following it should be possible to turn on "text=auto"

cat .gitattributes
* eol=crlf
*.sh eol=lf
* text=auto
*.png -text
