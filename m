From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default
 encoding.
Date: Thu, 18 Sep 2008 18:29:26 +0200
Message-ID: <48D281E6.1070204@viscovery.net>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <1221685659-476-2-git-send-email-angavrilov@gmail.com> <20080918150238.GC21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMOt-0000cu-0Q
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbYIRQ3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYIRQ3a
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:29:30 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51424 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYIRQ3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:29:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgMNj-0006cK-0j; Thu, 18 Sep 2008 18:29:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BA51A4FB; Thu, 18 Sep 2008 18:29:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080918150238.GC21650@dpotapov.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96213>

Dmitry Potapov schrieb:
> On Thu, Sep 18, 2008 at 01:07:32AM +0400, Alexander Gavrilov wrote:
>> The rationale for this is Windows support:
>>
>> 1) Windows people are accustomed to using legacy encodings
>>    for text files. For many of them defaulting to utf-8
>>    will be counter-intuitive.
>> 2) Windows doesn't support utf-8 locales, and switching
>>    the system encoding is a real pain. Thus the option.
> 
> I don't care much what is the default for Windows, but I wonder whether
> this rationale is good enough to change the default for other platforms.

"The default" should not be hardcoded in the tool.

By setting the encoding to "system", "the default" is taken from whatever
the system's current locale is. If you are on modern Linux, your locale is
most likely set to UTF8, and everything is fine; you won't observe a
change in behavior.

But if you are on a system whose locale was not set to UTF8, then you very
likely did *not* produce UTF8 data, and the display in git-gui was screwed
because it assumed UTF8. With this change it uses the system's encoding,
and it is an improvement.

> If you have systems configured with utf-8 and others (usually old ones)
> with legacy encoding, you will store files in utf-8 in your repo, thus
> having utf-8 as the default makes sense for non-Windows platforms.

How can you know? For example, I've to work with systems that use "legacy
encodings", and I can't use UTF8 in my data. Hence, the default of UTF8
was not exactly useful. With this patch series there's now a mechanism
that allows me to state the encoding per file, and all platforms should be
able to show the data in the correct way.

-- Hannes
