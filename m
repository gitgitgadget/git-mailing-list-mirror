From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Sun, 19 Jul 2015 09:37:53 +0200
Organization: gmx
Message-ID: <fadc4ff7e755913a4c6076165556b56c@www.dscho.org>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
 <55AB49C1.8010105@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bdwalton@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jul 19 09:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGjB5-0005Uu-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 09:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbbGSHiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 03:38:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:56442 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbbGSHiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 03:38:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LoKHN-1Yja8o126b-00gHoa; Sun, 19 Jul 2015 09:37:55
 +0200
In-Reply-To: <55AB49C1.8010105@kdbg.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:nC2XGudEITZ0Ah2OUXkfjnBxFT9/IeI+4kswEBOS0tG3dPCXj85
 brwcn8FjiKleI7yAzNYPUeTBJR43Hu/Wk6E4vJleT7P52EVqAYkc3gZqSuxqv+Vh2eY4B2U
 W/2YpuYBQeZc5GjTNwwIk6pPAeUfkQsnRwj9LcqJBHYdnptcZT78y+04JPrbK4+9AmSiZGg
 ndCZT09YDNBybYpSGDv6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NjDE6P/J/tI=:c9lGfvIUsiB0Gsi1Gmimos
 HhE5pweo5xUdC8BaiuwKwmLcz6CTsBob0FDMYTCLkQDzUhq/ybkXHlUs2PM2h40XqQhnik3uH
 p6wxYRYECAB1YtWbT8iQQeJKdkZaAHNfiOqd0cMhjXejL5UoBJr/lbYoyh8KpfEugovSLV0Yu
 QTwhfazddO9A2QChrtoAXYeSSLG1qLNSgwclZI/Nv+k1zkuPqQ1ujRfNEVXNNL7qVgczIxtLx
 FkLRwqqA6zkW9P+xsX3WHx4a3rU7+Z2dLYYKk6kWUCjasxtOW3+JxbMWOQfJs/djrTNkpGcVO
 cDi0xPnc8ycO6bSEZIdZs1gMZwP3m8lNlU3+XTCY7yuDkQxtatWmUtCN8o05z5AxfN/KtSNA+
 LY6vDP928s6Y9fIIRHr6p1sDZbbpuPWLnknFZMEc9MZoi85tmfOnD9GB1UcG5CHL1U5Wt/xDf
 SJFoz9CrPN3F8N7BRjwpNnpMFDJpi1RLgCm1Ejsmfm7+/AOKahUk5Kop3DDWUMeh7WfemBJrR
 inHw6qBXY5wESi77uxd9NlKYdOqP11jWn9OKLUy0P4LM0MANVPzmzC4dy3iucU0KYJONeeJnZ
 6q+6kyISBfZ8jXhfwDDOuBZwrNq/ZrE+eEObND/6cZ7jkSnKebZi7zUYzckGiNonH8lE1ZgXs
 7a7KHHo/dmfn0rPQUz9YLyhSnUuq/ygb75fi7DjgKtJfhibTLdaL6cH0ftFofIYvW+Hs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274203>

Hi,

On 2015-07-19 08:54, Johannes Sixt wrote:
> Am 18.07.2015 um 17:21 schrieb Ben Walton:
>>   	test_expect_success "clone ssh://$tuah/home/user/repo" "
>>   	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>>   	"
>> diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
>> index e94b2f1..eb264f9 100755
>> --- a/t/t9500-gitweb-standalone-no-errors.sh
>> +++ b/t/t9500-gitweb-standalone-no-errors.sh
>> @@ -290,8 +290,7 @@ test_expect_success 'setup incomplete lines' '
>>   	echo "incomplete" | tr -d "\\012" >>file &&
>>   	git commit -a -m "Add incomplete line" &&
>>   	git tag incomplete_lines_add &&
>> -	sed -e s/CHANGE_ME/change_me/ <file >file+ &&
>> -	mv -f file+ file &&
>> +	perl -pi -e "s/CHANGE_ME/change_me/" file &&
> 
> This is problematic. On Windows, perl -i fails when no backup file
> extension is specified because perl attempts to replace a file that is
> still open; that does not work on Windows.

Let's qualify this a bit better: it actually works with the SDK of Git for Windows 2.x. It is therefore incomplete and partially incorrect to say "that does not work on Windows". It is true that Git for Windows 1.x' perl bails out with "Can't do inplace edit".

> This should work, but I haven't tested, yet:
> 
> 	perl -pi.bak -e "s/CHANGE_ME/change_me/" file &&

This works, of course, but it leaves an extra file behind.

I really wonder why the previous ">file+ && mv -f file+ file" dance needs to be replaced?

Ciao,
Johannes
