From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 08:10:01 +0100
Message-ID: <4D5CC9C9.60705@viscovery.net>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <7v62sjkbbi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 17 08:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppy0F-0005Ol-N0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 08:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226Ab1BQHKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 02:10:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42920 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab1BQHKK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 02:10:10 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ppy02-0005D2-F4; Thu, 17 Feb 2011 08:10:02 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 307591660F;
	Thu, 17 Feb 2011 08:10:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v62sjkbbi.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167047>

Am 2/16/2011 20:51, schrieb Junio C Hamano:
> Here is how to write the above more concisely, efficiently and portably.
> 
> 	case "$2;" in
>         *";$1;"*)
>         	echo yes ;;
>         *)
>         	echo no ;;
> 	esac
> 
> The trailing ';' takes care of the case where cloned_modules has only one
> element, in which case you have ";name" in "$2".  No need for a loop.

And while you are here, you could make this:

list_contains()
{
	case "$2;" in
	*";$1;"*)
		: yes ;;
	*)
		! : no ;;
	esac
}

and test for the exit code of this function rather than its output at the
call site.

-- Hannes
