From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] Avoid double exec() in execv_git_cmd()
Date: Sun, 2 Dec 2007 12:24:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712021221410.27959@racer.site>
References: <1196579005-5662-1-git-send-email-gitster@pobox.com>
 <1196579005-5662-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 13:25:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iynsd-0002Gj-Pk
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 13:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752427AbXLBMYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 07:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbXLBMYn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 07:24:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:57966 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752199AbXLBMYm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 07:24:42 -0500
Received: (qmail invoked by alias); 02 Dec 2007 12:24:40 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp010) with SMTP; 02 Dec 2007 13:24:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Q+KElhwHQ3HXyXeuh3oWRu65x5eAbr0S21M7j2X
	TgbQOXYXyi1Hw+
X-X-Sender: gene099@racer.site
In-Reply-To: <1196579005-5662-2-git-send-email-gitster@pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66774>

Hi,

On Sat, 1 Dec 2007, Junio C Hamano wrote:

> This avoids double exec() when execv_git_cmd() is used to spawn an
> external git command.
> 
> For this, execv_git_cmd() needs to be able to tell what's built-in.
> This is done by introducing a new function git_builtin_command() that
> checks the list of built-in commands and returns a pointer to the
> cmd_struct if found.  The same function is used from the git potty.

IMNSHO this does not buy us anything, compared to my patch series.  Your 
patch is larger, distributes the responsibility for the builtins to two 
files instead of one, and since we control what is builtin and what not, 
is not really less fragile with respect to what needs to be initialised.

Besides, we lose a great opportunity to go in the direction of 
libification.

Ciao,
Dscho
