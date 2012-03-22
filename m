From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 13:55:34 +0100
Message-ID: <4F6B2146.8060408@in.waw.pl>
References: <4F6AC0FA.7040708@gmail.com> <4F6AFEC8.9090907@in.waw.pl> <4F6B16BE.1050003@viscovery.net> <03324BD2-116A-42EF-AB18-38F4A30A1115@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Hong Xu <xuhdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 13:55:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAhYR-0005OU-3d
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 13:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755460Ab2CVMzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Mar 2012 08:55:42 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:56064 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab2CVMzl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 08:55:41 -0400
Received: from optyk25.fuw.edu.pl ([193.0.81.79])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SAhYJ-0001Wi-Qu; Thu, 22 Mar 2012 13:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <03324BD2-116A-42EF-AB18-38F4A30A1115@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193652>

On 03/22/2012 01:48 PM, Hong Xu wrote:
>
>
> On Mar 22, 2012, at 20:10, Johannes Sixt<j.sixt@viscovery.net>  wrote=
:
>
>> Am 3/22/2012 11:28, schrieb Zbigniew J=C4=99drzejewski-Szmek:
>>> On 03/22/2012 07:04 AM, Hong Xu wrote:
>>>> Hello everyone,
>>>>
>>>> If my ssh key is encrypted, "git pull origin mas<tab>" will give a
>>>> unexpected result, something like this:
>>>>
>>>> git pull origin masEnter passphrase for key '/home/user/.ssh/id_rs=
a':
>>>>
>>>> I know maybe it is not possible to complete the "master", but mayb=
e it
>>>> is better to not complete anything than append something like that=
?
>>> It is ssh itself which emits this message. The completion script ca=
lls
>>> 'git ls-remote origin', which in turn invokes ssh. Typing the passw=
ord in
>>> actually works, but I understand that you are annoyed by the messag=
e.
>>>
>>> I don't think there's an easy way to silence this in git completion=
,
>>> without affecting other times when the key would be requested. E.g.=
 we
>>> would want ssh to ask for the key while doing 'git pull', but not w=
hen run
>>> automatically during completion.
>>>
>>> Maybe git-ls-remote should learn --quiet?
>>
>> No. IMHO, bash completion stretches too far by asking the remote for=
 the
>> refs that it has.
>>
>
> I agree with this rather than using silent mode. If a encrypted key i=
s found, I think we better drop the completion. I don't know whether th=
ere is a way to implement this yet, at least we can try to find it.
There's more than one reason why ssh would ask for a password. So just
checking for an encrypted key is pointless. Instead, ssh could be=20
invoked with -o BatchMode=3Dyes. ls-remote could pass this option if it=
=20
was invoked with --quiet.

Possible this is just not worth the trouble and Hong should enter the=20
run ssh-agent and enter the password beforehand.

Zbyszek
