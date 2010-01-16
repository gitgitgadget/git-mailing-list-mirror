From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 13/14] daemon: use select() instead of poll()
Date: Sat, 16 Jan 2010 09:06:26 +0100
Message-ID: <201001160906.26270.j6t@kdbg.org>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com> <40aa078e1001151508j208fa50boc5565a3be6bef893@mail.gmail.com> <40aa078e1001151523o538b44c7x95def3447650eea4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 09:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW3gx-0000i1-9T
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 09:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0APIH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 03:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628Ab0APIH1
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 03:07:27 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:56649 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751539Ab0APIH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 03:07:27 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0AB3F2C4002;
	Sat, 16 Jan 2010 09:07:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5517719F5EC;
	Sat, 16 Jan 2010 09:06:26 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e1001151523o538b44c7x95def3447650eea4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137207>

On Samstag, 16. Januar 2010, Erik Faye-Lund wrote:
> +static inline void mingw_fd_set(int fd, fd_set *set)
> +{
> +	FD_SET(_get_osfhandle(fd), set);
> +}
>  #undef FD_SET
> +#define FD_SET(a,b) mingw_fd_set(a,b)
> +
>  #undef FD_ISSET
>  #define FD_ISSET(fd, set) __WSAFDIsSet(_get_osfhandle(fd), (fd_set
> *)(set))

Ah, yes, how obvious ;) You are going to do the same with FD_ISSET as well, 
aren't you?

-- Hannes
