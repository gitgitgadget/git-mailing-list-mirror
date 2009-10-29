From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH I18N filenames v2 1/3] Add IO-wrappers for filenames encoding
 <local encoding> <-> UTF-8
Date: Thu, 29 Oct 2009 10:26:55 +0100
Message-ID: <4AE95FDF.7030601@viscovery.net>
References: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Timur Sufiev <timur@iris-comp.ru>
X-From: git-owner@vger.kernel.org Thu Oct 29 10:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3RHb-0006GS-GN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 10:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZJ2J0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 05:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbZJ2J0x
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 05:26:53 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54344 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbZJ2J0w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 05:26:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N3RHT-0008Mu-Pb; Thu, 29 Oct 2009 10:26:55 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7E02A4E4; Thu, 29 Oct 2009 10:26:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1256752900-2615-1-git-send-email-timur@iris-comp.ru>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131576>

Timur Sufiev schrieb:
> +#define opendir(a) opendir_i18n(a)
> +#define fopen(a, b) fopen_i18n(a, b)
> +#define chmod(a, b) chmod_i18n(a, b)
> +#define open open_i18n
> +#define stat(a, b) stat_i18n(a, b)
> +#define lstat(a, b) lstat_i18n(a, b)
> +#define readdir(a) readdir_i18n(a)
> +#define unlink(a) unlink_i18n(a)
> +#define link(a, b) link_i18n(a, b)

I doubt that such a whole-sale replacement is necessary. For example,
names of object files (in .git/objects/XX) need not be translated, nor ref
names.

Please review the infrastructure patch that Linus provided (as pointed out
by Jeff) and see how you can build on it. IIRC, there are a handful of
central places where path names must be massaged, and perhaps a few others
as fall-out.

Moreover, once you know what to change, it would be worthwhile to check
how the file name translation can be adjusted to use the UTF16 versions of
the functions on Windows to avoid the UTF8<->UTF16 conversion (that
happens on Windows behind the scenes). Perhaps MacOS can profit from this,
too.

-- Hannes
