From: David Soria Parra <dsoria@gmx.net>
Subject: Re: [PATCH 2/2] Improve portability: Avoid SS constant as it is already
 defined
Date: Thu, 28 Aug 2008 02:34:37 +0200
Message-ID: <48B5F29D.3040306@gmx.net>
References: <1219858743-4476-1-git-send-email-sn_@gmx.net> <1219858743-4476-2-git-send-email-sn_@gmx.net> <1219858743-4476-3-git-send-email-sn_@gmx.net> <7vwsi2p9qk.fsf@gitster.siamese.dyndns.org> <7vod3ep8sn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Soria Parra <dsp@php.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 02:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYVUI-00073p-Vu
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 02:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927AbYH1Ael (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 20:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754963AbYH1Aek
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 20:34:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:47030 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754120AbYH1Aek (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 20:34:40 -0400
Received: (qmail invoked by alias); 28 Aug 2008 00:34:37 -0000
Received: from p57AEED44.dip.t-dialin.net (EHLO [192.168.1.116]) [87.174.237.68]
  by mail.gmx.net (mp015) with SMTP; 28 Aug 2008 02:34:37 +0200
X-Authenticated: #235172
X-Provags-ID: V01U2FsdGVkX198JC994Px8pLbin6ecNMcK8ozRNrYMGCPls52EXT
	8QPJWLLfAlbHD1
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vod3ep8sn.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94003>

Should be fine as well.

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> David Soria Parra <sn_@gmx.net> writes:
>>
>>> From: David Soria Parra <dsp@php.net>
>>>
>>> Constants that have the names of CPU registers are already defined
>>> in OpenSolaris's sys/regset.h. This causes a warning as we try to
>>> (re)define SS in ctype.c. So we just use another name.
>> I do not mind this _particular_ workaround per-se, but I have to wonder
>> what happens the next time some random other platform has "SP" defined in
>> a random header file.
> 
> If we are doing an workaround, how about doing it this way instead?
> 
>  ctype.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git i/ctype.c w/ctype.c
> index ee06eb7..d2bd38e 100644
> --- i/ctype.c
> +++ w/ctype.c
> @@ -5,6 +5,11 @@
>   */
>  #include "cache.h"
>  
> +/* Just so that no insane platform contaminates the namespace with these symbols */
> +#undef SS
> +#undef AA
> +#undef DD
> +
>  #define SS GIT_SPACE
>  #define AA GIT_ALPHA
>  #define DD GIT_DIGIT
