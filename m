From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Wed, 13 Jun 2012 18:33:58 +0200
Message-ID: <4FD8C0F6.8060609@lsrfire.ath.cx>
References: <20111022001704.3115.87464.reportbug@hejmo> <20120610090516.GA30177@burratino> <4FD78EA0.2090306@lsrfire.ath.cx> <20120612202953.GG9764@burratino> <20120612210003.GA16816@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?RWR1YXJkbyBUcsOhcGFuaQ==?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 18:34:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeqWX-0007cI-FX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 18:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab2FMQeU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 12:34:20 -0400
Received: from india601.server4you.de ([85.25.151.105]:58238 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab2FMQeT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 12:34:19 -0400
Received: from [192.168.2.105] (p4FFDA3B2.dip.t-dialin.net [79.253.163.178])
	by india601.server4you.de (Postfix) with ESMTPSA id 5041A2F8050;
	Wed, 13 Jun 2012 18:34:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120612210003.GA16816@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199897>

Am 12.06.2012 23:00, schrieb Jonathan Nieder:
> Jonathan Nieder wrote:
>> Ren=C3=A9 Scharfe wrote:
>
>>> How about this instead?
>>
>> Looks good to me.
>
> Oh, hold on a second.  Won't this get confused by
>
> 	ssh://[::1]/foo/bar/baz:80/qux
>
> ?

It shouldn't, because the host part is NUL-terminated before get_port()=
=20
is called.  Let's see (with the patch):

	$ git clone ssh://[::1]/foo/bar/baz:80/qux
	Cloning into 'qux'...
	ssh: connect to host ::1 port 22: Connection refused
	fatal: The remote end hung up unexpectedly

Ren=C3=A9
