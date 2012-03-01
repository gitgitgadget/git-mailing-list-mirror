From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Thu, 01 Mar 2012 11:18:45 +0100
Message-ID: <4F4F4D05.8080201@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es><878vjn8823.fsf@thomas.inf.ethz.ch> <7v62eqzrqm.fsf@alter.siamese.dyndns.org><4F4E003C.1050301@seap.minhap.es> <7vlinltsja.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	peff@peff.net, sam.vilain@catalyst.net.nz, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:21:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S32C5-0005By-Cj
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 10:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965695Ab2CAJUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 04:20:55 -0500
Received: from luthien1.mpt.es ([213.9.211.102]:4401 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965582Ab2CAJUu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 04:20:50 -0500
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id C0C8924E9D;
	Thu,  1 Mar 2012 10:20:07 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 5B3E7180107;
	Thu,  1 Mar 2012 10:20:03 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7vlinltsja.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: C0C8924E9D.A16FA
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331198408.38026@MYlKx4yNWxJQtj0MqZS4cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191911>

On 02/29/2012 07:15 PM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> On 02/28/2012 08:24 PM, Junio C Hamano wrote:
>>
>>> I've heard rumors that libcurl on some versions/installations of Mac OS X
>>> deliberately ignores the environment. For those who agree with Apple, it
>>> would be a regression if we suddenly start the environment ourselves and
>>> using it.
>>
>> Hi Junio, what did you mean by "we start the environment and using it"?
>> I didn't understand what you mean there..
> 
> The reason you didn't understand is because the statement does not parse
> X-<.  Thanks for pointing it out.
> 
> What I meant was that on these platforms, allegedly (note that I do not
> have a first-hand experience with them), user's http_proxy environment
> setting did not affect libcurl based applications and that is a deliberate
> platform decision to give precedence to proxy settings the platform has
> elsewhere.  The users who agree with this platform decision are happily

I googled for that but didn't find any info, anyway if that's true did they 
do this by 1) removing http_proxy from environment or by 2) patching
libcurl not to read them ? if it's the first case, we are safe as they will 
also remove the vars and we won't read them, if it's second case, it's silly
on their part as any other console program will be reading env vars as they
would need to patch every program..

The normal thing os's do (as gnome used to do) is to automatically set the
http_proxy env vars when you set a proxy on the GUI..

> using the proxy settings stored elsewhere in the platform with git, but
> may have http_proxy environment pointing at a proxy that they do not want
> to use for git.
> 
> If we suddenly start reading from http_proxy environment ourselves and
> explicitly telling libcurl to use the proxy specified, it will change the
> behaviour for these users, i.e. a regression.
