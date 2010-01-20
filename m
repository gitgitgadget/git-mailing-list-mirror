From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: [PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem
 generator
Date: Wed, 20 Jan 2010 12:57:28 -0800
Message-ID: <4B576E38.5080604@pcharlan.com>
References: <4B575838.2010504@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, sschuberth@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jan 20 21:57:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXhcN-0004SK-U5
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 21:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636Ab0ATU5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 15:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565Ab0ATU5c
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 15:57:32 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:49482 "EHLO
	swarthymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752413Ab0ATU5b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 15:57:31 -0500
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a3.g.dreamhost.com (Postfix) with ESMTP id 5172C7F05A;
	Wed, 20 Jan 2010 12:57:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B575838.2010504@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137577>

On 01/20/2010 11:23 AM, Ramsay Jones wrote:
> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
> index d506717..245af73 100644
> --- a/contrib/buildsystems/engine.pl
> +++ b/contrib/buildsystems/engine.pl
> @@ -135,6 +135,11 @@ sub parseMakeOutput
>              }
>          } while($ate_next);
>  
> +        if ($text =~ /^test / && $text =~ /|| rm -f /) {

That test on the right needs to escape its pipes or it will always match.

--Pete

> +            # commands removing executables, if they exist
> +            next;
> +        }
> +
>          if($text =~ / -c /) {
>              # compilation
>              handleCompileLine($text, $line);
