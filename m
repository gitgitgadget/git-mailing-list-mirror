From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix resource leaks in wrapper.c
Date: Tue, 27 Oct 2009 08:13:43 +0100
Message-ID: <4AE69DA7.6030704@viscovery.net>
References: <1256615635-4940-1-git-send-email-djszapi@archlinux.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Laszlo Papp <djszapi@archlinux.us>
To: Laszlo Papp <djszapi2@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 08:13:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2gFb-0006Qc-DO
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 08:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbZJ0HNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 03:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756481AbZJ0HNk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 03:13:40 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4338 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756463AbZJ0HNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 03:13:40 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N2gFT-0007XI-G5; Tue, 27 Oct 2009 08:13:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 45EF1A4A1; Tue, 27 Oct 2009 08:13:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1256615635-4940-1-git-send-email-djszapi@archlinux.us>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131313>

Laszlo Papp schrieb:
> @@ -266,7 +266,7 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
>  	fd = mkstemp(template);
>  	if (0 <= fd)
>  		return fd;
> -
> +	close(fd);

Sorry, where is here a resource leak? You are "closing" something that was
never opened because fd is less than zero.

Ditto for the other case.

-- Hannes
