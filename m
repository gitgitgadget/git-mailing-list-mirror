From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 6/7] Modify setup_path() to only add git_exec_path() to PATH
Date: Sun, 17 Aug 2008 22:28:14 +0200
Message-ID: <200808172228.14424.johannes.sixt@telecom.at>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <1218977083-14526-6-git-send-email-prohaska@zib.de> <1218977083-14526-7-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUosN-00079b-4y
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbYHQU2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbYHQU2T
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:28:19 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:36506 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbYHQU2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:28:18 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 8F2EA10A7C7;
	Sun, 17 Aug 2008 22:28:15 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 08FEA1D2A0;
	Sun, 17 Aug 2008 22:28:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218977083-14526-7-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92626>

On Sonntag, 17. August 2008, Steffen Prohaska wrote:
> Searching git programs only in the highest-priority location is
> sufficient.  If the user explicitly overrides the default location
> (by --exec-path or GIT_EXEC_PATH), we can safely expect that the
> required programs are there.
...
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -114,9 +114,7 @@ void setup_path(void)
>
>  	strbuf_init(&new_path, 0);
>
> -	add_path(&new_path, argv_exec_path);
> -	add_path(&new_path, getenv(EXEC_PATH_ENVIRONMENT));
> -	add_path(&new_path, system_path(GIT_EXEC_PATH));
> +	add_path(&new_path, git_exec_path());
>  	add_path(&new_path, argv0_path);
>
>  	if (old_path)

I thought about a change like this, too. But I recall that this area has been 
changed several times. One thread I found here:

http://thread.gmane.org/gmane.comp.version-control.git/62472

See also the commit message of 77cb17e940, which introduces exec_cmd.*.

But probably the points raised there are already moot, and your change is 
good.

-- Hannes
