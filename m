From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: fc046a75d539a78e6b2c16534c4078617a69a327 fails on OpenBSD 3.8
Date: 30 Jun 2006 09:57:03 -0700
Message-ID: <86wtayy42o.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 30 18:57:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMIm-0007Tf-SI
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 18:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbWF3Q5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 12:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWF3Q5F
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 12:57:05 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:10253 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751462AbWF3Q5E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 12:57:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 1BFE38F2B8
	for <git@vger.kernel.org>; Fri, 30 Jun 2006 09:57:04 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22462-01-27 for <git@vger.kernel.org>;
 Fri, 30 Jun 2006 09:57:03 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 631DC8F2D9; Fri, 30 Jun 2006 09:57:03 -0700 (PDT)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.7.14; tzolkin = 4 Ix; haab = 7 Tzec
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22998>


gcc -o upload-pack.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR upload-pack.c
In file included from /usr/include/sys/poll.h:54,
                 from upload-pack.c:9:
/usr/include/ctype.h:67: error: syntax error before ']' token
/usr/include/ctype.h:68: error: syntax error before ']' token
/usr/include/ctype.h:70: error: syntax error before ']' token
/usr/include/ctype.h:75: error: syntax error before ']' token
/usr/include/ctype.h:78: error: syntax error before '(' token
/usr/include/ctype.h:79: error: syntax error before '(' token
/usr/include/ctype.h:93: error: syntax error before "c"
In file included from /usr/include/sys/poll.h:54,
                 from upload-pack.c:9:
/usr/include/ctype.h:91:1: unterminated #if
/usr/include/ctype.h:40:1: unterminated #ifndef
In file included from upload-pack.c:9:
/usr/include/sys/poll.h:53:1: unterminated #ifndef
/usr/include/sys/poll.h:28:1: unterminated #ifndef
gmake: *** [upload-pack.o] Error 1

The lines in ctype.h that are probably relevant are:

    #if defined(__GNUC__) || defined(_ANSI_LIBRARY) || defined(lint)
    int	isalnum(int);
    int	isalpha(int);
    int	iscntrl(int);
    int	isdigit(int);
    int	isgraph(int);
    int	islower(int);
    int	isprint(int);
    int	ispunct(int);
    int	isspace(int);
    int	isupper(int);
    int	isxdigit(int);
    int	tolower(int);
    int	toupper(int);

Line 67 is "int isalnum(int)"

Are you defining a macro when you shouldn't be in upload-pack?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
