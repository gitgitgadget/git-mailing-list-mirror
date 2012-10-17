From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH 3/3] Change colors to be based on git status -sb in color
 mode
Date: Wed, 17 Oct 2012 09:17:44 +0200
Message-ID: <507E5B98.2020006@xs4all.nl>
References: <7vvceatnn4.fsf@alter.siamese.dyndns.org> <20121016193405.GA12073@simaj.xs4all.nl> <7vtxtuqf3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git@drmicha.warpmail.net, spearce@spearce.org,
	artagnon@gmail.com, schwab@linux-m68k.org, soosthoek@nieuwland.nl,
	junio@pobox.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TONtI-0007me-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 09:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924Ab2JQHR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 03:17:57 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:2127 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab2JQHR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 03:17:57 -0400
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id q9H7HiLx062573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Oct 2012 09:17:45 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <7vtxtuqf3z.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207898>

On 16/10/12 23:30, Junio C Hamano wrote:
> Simon Oosthoek <s.oosthoek@xs4all.nl> writes:
> 
>> Hi
>>
>> Fixed the mistakes of the last one, and I'm now using the symbolic names "ok_color" and "bad_color".
>> The test for headless state is now more direct, and I hope it is still correct.
>>
>> /Simon
> 
> Will apply with a bit more readable log message.

Ok

> 
> I think it would be a good idea to squash something like the
> attached into this patch, though.

I tried the patch and it works when you switch the color assignments in
the if statement you added...

> @@ -264,7 +264,7 @@ __git_ps1 ()
>  			fi
>  
>  			b="$(git symbolic-ref HEAD 2>/dev/null)" || {
> -
> +				detached=yes
>  				b="$(
>  				case "${GIT_PS1_DESCRIBE_STYLE-}" in
>  				(contains)
> @@ -335,8 +335,7 @@ __git_ps1 ()
>  				local flags_color="$c_lblue"
>  				local branchstring="$c${b##refs/heads/}"
>  
> -				if git symbolic-ref HEAD 2>/dev/null 1>&2
> -				then
> +				if [ $detached = yes ]; then
-  					branch_color="$ok_color"
+  					branch_color="$bad_color"
>  				else
-  					branch_color="$bad_color"
+  					branch_color="$ok_color"

if detached = yes, then bad_color should be applied, else use ok_color.

Cheers

Simon
