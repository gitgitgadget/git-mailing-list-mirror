From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [msysGit] [PATCH v4 7/8] mingw: enable OpenSSL
Date: Wed, 21 Oct 2009 14:15:41 +0200
Message-ID: <4ADEFB6D.9050501@viscovery.net>
References: <1255966929-1280-1-git-send-email-kusmabite@gmail.com> <1255966929-1280-7-git-send-email-kusmabite@gmail.com> <1255966929-1280-8-git-send-email-kusmabite@gmail.com> <200910192020.44890.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Oct 21 14:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0a6X-00024n-7k
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 14:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbZJUMPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 08:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZJUMPj
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 08:15:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:42565 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbZJUMPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 08:15:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N0a6Q-0005E4-Bn; Wed, 21 Oct 2009 14:15:42 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1EC556D9; Wed, 21 Oct 2009 14:15:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <200910192020.44890.j6t@kdbg.org>
X-Spam-Score: 0.1 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130908>

Johannes Sixt schrieb:
> On Montag, 19. Oktober 2009, Erik Faye-Lund wrote:
>> Since we have OpenSSL in msysgit now, enable it to support SSL
>> encryption for imap-send.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> 
> Acked-by: Johannes Sixt <j6t@kdbg.org>

I seem to have ack'ed this one too early. After testing in my environment,
I get:

imap-send.o: In function `ssl_socket_perror':
D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_get_error'
D:\Src\mingw-git/imap-send.c:241: undefined reference to `ERR_error_string'

I need this patch in addition, and perhaps something similar is also
needed with MSVC:

diff --git a/Makefile b/Makefile
index c4b91d8..7e6a1c3 100644
--- a/Makefile
+++ b/Makefile
@@ -932,6 +932,7 @@ else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
