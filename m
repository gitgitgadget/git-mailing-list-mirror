From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Sun, 17 Jun 2012 08:36:22 +0200
Message-ID: <4FDD7AE6.6000000@web.de>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?ISO-8859-1?Q?Torsten_B=F6?= =?ISO-8859-1?Q?gershausen?= 
	<tboegi@web.de>
To: vfr@lyx.org
X-From: git-owner@vger.kernel.org Sun Jun 17 08:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sg9BG-0005Qt-6a
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 08:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab2FQGlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 02:41:35 -0400
Received: from mout.web.de ([212.227.15.4]:54111 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab2FQGlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 02:41:31 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2012 02:41:31 EDT
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MTPit-1SWQAC025f-00SIUb; Sun, 17 Jun 2012 08:36:23 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <1339441313-5296-1-git-send-email-vfr@lyx.org>
X-Provags-ID: V02:K0:+AAJO+u5ShtMoyQlzugyG5R3K07uy84s5XJifdeeEky
 YZ6tR8H7Nyu3u+tro3LQ1LRLOrM3rQFvSUpbUGtyYgIHcgzP8T
 z3wSveG8I9f9u5FCKXSUuLZ/yZ77jQ1j/VFT+SqVBr/A+wwvQe
 5c7m0oaeIz/vXbVnrXUJtQq4Kz/3eMYE/8YcMqSzc5TMIlIdpg
 MMqIWomYp5JYtpN/4vtsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200118>


Hej,
Does this work for you?

None of the 2 patches found on pu do work here:
> a3428205e6d74542d6441baaa29d1cb1d1064d95
>Author: Vincent van Ravesteijn <vfr@lyx.org>
>Date:   Mon Jun 11 19:01:53 2012 +0000
>    t: Replace 'perl' by $PERL_PATH

[165c0e8f0b04b8573e91ead2890870d9e36bb39c] tests: enclose $PERL_PATH in duoble quotes

t4030 seems to be broken.
When I try to debug it, the $PERL_PATH seems to be empty:

------------------
./t4030-diff-textconv.sh  --verbose | less

The ok 2 - file is considered binary by porcelain

expecting success: 
        git diff-tree -p HEAD^ HEAD >diff &&
:/Users/tb/projects/git/git.git/t/trash directory.t4030-diff-textconv/hexdump: line 2: -e: command not found
------------------
And the hexdump line 2 uses $PERL_PATH, which is empty: 
--------------------
t/trash directory.t4030-diff-textconv> cat  hexdump 
#!/bin/sh
$PERL_PATH -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
tb@birne:~/projects/git/git.git/t/trash directory.t4030-diff-textconv> 
-------------------
Can anybody help to find out what is going on?
