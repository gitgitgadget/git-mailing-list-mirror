From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/3] git over TLS (gits://) support (part 2)
Date: Mon, 03 May 2010 11:44:04 +0200
Message-ID: <4BDE9AE4.9010908@op5.se>
References: <1272733791-11341-1-git-send-email-ilari.liusvaara@elisanet.fi> <1272733791-11341-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Mon May 03 11:44:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8sCH-0005Gn-RI
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751719Ab0ECJoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 05:44:13 -0400
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:46570 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751428Ab0ECJoM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 05:44:12 -0400
Received: from source ([72.14.220.155]) by na3sys009aob110.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS96a6kBiix7xXGW8h0Sp8vebzROqhHnW@postini.com; Mon, 03 May 2010 02:44:11 PDT
Received: by fg-out-1718.google.com with SMTP id e21so1021418fga.12
        for <git@vger.kernel.org>; Mon, 03 May 2010 02:44:07 -0700 (PDT)
Received: by 10.87.40.31 with SMTP id s31mr9760693fgj.60.1272879847380;
        Mon, 03 May 2010 02:44:07 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 4sm9589122fgg.12.2010.05.03.02.44.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 02:44:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <1272733791-11341-3-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146225>

On 05/01/2010 07:09 PM, Ilari Liusvaara wrote:

A monster-patch, if ever I saw one, yet without a sensible commit message.
What is it this patch actually does?

> +#include "base64.h"
> +#ifdef USE_COMPAT_H
> +#include "compat.h"
> +#else
> +#include "git-compat-util.h"
> +#endif
> +

This would be better moved to compat.h, so the entire file is excluded
and git-compat-util.h is included instead if we're supposed to use that
one. That way you won't have to remember this in every file you use.

> +void encode_uint32(unsigned char *ptr, unsigned long value)
> +{
> +	ptr[0] = (unsigned char)(value>>  24);
> +	ptr[1] = (unsigned char)(value>>  16);
> +	ptr[2] = (unsigned char)(value>>  8);
> +	ptr[3] = (unsigned char)(value);
> +}
> +

The second parameter should be uint32_t, obviously.

Reviewing the rest of the patch will have to wait until there's a
proper commit message describing what it's supposed to do, as I
have nowhere near enough time to try to analyze 100k worth of
code to figure out why it's necessary to add it to git.git.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
