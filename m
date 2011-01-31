From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Disallow empty section and variable names
Date: Mon, 31 Jan 2011 08:48:31 +0100
Message-ID: <4D46694F.5070208@viscovery.net>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Libor Pechacek <lpechacek@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 31 08:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjoV7-0005ni-Bj
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 08:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab1AaHsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 02:48:36 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50263 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1AaHsf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 02:48:35 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PjoUx-000430-R9; Mon, 31 Jan 2011 08:48:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7DF911660F;
	Mon, 31 Jan 2011 08:48:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110130203445.GA9689@fm.suse.cz>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165721>

Am 1/30/2011 21:34, schrieb Libor Pechacek:
> It is possible to break your repository config by creating an invalid key.  The
> config parser in turn chokes on it.
> 
> $ git init
> Initialized empty Git repository in /tmp/gittest/.git/
> $ git config .foo false
> $ git config .foo
> fatal: bad config file line 6 in .git/config

Just a nit: Your example is misleading because it "only" shows that if you
shove in junk, and ask for junk, you get breakage. However, the breakage
is much more serious, and you could have demonstrated it, if you had
written your example like this:

$ git config .foo false
$ git config user.email
fatal: bad config file line 6 in .git/config

> +	test_must_fail git config . &&
> +	test_must_fail git config .foo &&
> +	test_must_fail git config foo. &&
> +	test_must_fail git config .foo. &&

Not a nit: These tests only show that 'git config' cannot be asked for
junk, but they do not show that you cannot insert junk into the config
file anymore using 'git config'.

-- Hannes
