From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] launch_editor(): read the file, even when EDITOR=:
Date: Thu, 08 Nov 2007 13:33:38 +0100
Message-ID: <47330222.7000206@viscovery.net>
References: <Pine.LNX.4.64.0711081213580.4362@racer.site> <Pine.LNX.4.64.0711081215360.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 13:34:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq6aX-0004D0-L5
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 13:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXKHMdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 07:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbXKHMdq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 07:33:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10062 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXKHMdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 07:33:45 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iq6ZK-00056H-Pv; Thu, 08 Nov 2007 13:33:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 93FB66B7; Thu,  8 Nov 2007 13:33:38 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711081215360.4362@racer.site>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64009>

Johannes Schindelin schrieb:
> +		struct child_process child;
> +		memset(&child, 0, sizeof(child));
> +		child.argv = args;
> +		args[0] = editor;
> +		args[1] = path;
> +		args[2] = NULL;
>  
> +		if (run_command(&child))

You can shorten this to

		const char *args[] = { editor, path, NULL };
		if (run_command_v_opt(args, 0))

(and possibly remove 'args' that is in the surrounding block).

-- Hannes
