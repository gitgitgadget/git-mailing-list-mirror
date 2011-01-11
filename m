From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Applying .gitattributes text/eol changes
Date: Tue, 11 Jan 2011 15:02:07 +0100
Message-ID: <4D2C62DF.20706@syntevo.com>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 15:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcenh-0003SK-Ur
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 15:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144Ab1AKOCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 09:02:13 -0500
Received: from syntevo.com ([85.214.39.145]:53426 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755970Ab1AKOCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 09:02:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id EE65C174006
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4D2C4902.4010705@drmicha.warpmail.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164946>

On 11.01.2011 13:11, Michael J Gruber wrote:
> Marc Strapetz venit, vidit, dixit 03.01.2011 18:18:
>> I'm looking for an unobtrusive way to apply (committed) changes for
>> text/eol attributes to the working tree. For instance, after having
>> changed "*.txt eol=crlf" to "*.txt eol=lf", all *.txt files should be
>> converted from CRLF to LF endings. The only advice I found so far is to
>> remove .git/index and do a reset --hard. The disadvantage of this
>> approach is that every file will be touched:
>>
>> - although the content does not change, timestamps will be changed. This
> 
> The bytewise content does change.

The content has only changed for *.txt files, but the timestamps of
*all* files are updated. I guess (but didn't verify from code), that in
case of missing .git/index, Git freshly writes all working tree files,
ignoring already existing files which already have the correct content.
Maybe this behavior is by intention and makes sense in some cases. In my
case it has adverse effects on IDEs and probably other tools which are
monitoring the file system.

>> One solution I could think of which might be helpful in other situations
>> as well would be to have an "--unobtrusive" option for reset which would
>> only replace a file if the content has actually been changed.
> 
> How about
> 
> git ls-files \*.txt | xargs touch -a
> git ls-files \*.txt | git checkout

That won't be helpful as it requires me to know what has changed.

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
