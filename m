From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 11:28:24 +0100
Message-ID: <4F6AFEC8.9090907@in.waw.pl>
References: <4F6AC0FA.7040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hong Xu <xuhdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 11:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAfG0-0000J2-Se
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 11:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab2CVK2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 06:28:31 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56050 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881Ab2CVK2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 06:28:30 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAfFt-0000wu-Rr; Thu, 22 Mar 2012 11:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <4F6AC0FA.7040708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193642>

On 03/22/2012 07:04 AM, Hong Xu wrote:
> Hello everyone,
>
> If my ssh key is encrypted, "git pull origin mas<tab>" will give a
> unexpected result, something like this:
>
> git pull origin masEnter passphrase for key '/home/user/.ssh/id_rsa':
>
> I know maybe it is not possible to complete the "master", but maybe it
> is better to not complete anything than append something like that?
It is ssh itself which emits this message. The completion script calls 
'git ls-remote origin', which in turn invokes ssh. Typing the password 
in actually works, but I understand that you are annoyed by the message.

I don't think there's an easy way to silence this in git completion, 
without affecting other times when the key would be requested. E.g. we 
would want ssh to ask for the key while doing 'git pull', but not when 
run automatically during completion.

Maybe git-ls-remote should learn --quiet?

Zbyszek
