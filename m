From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH nd/attr-match-optim-more 2/2] attr: more matching optimizations
 from .gitignore
Date: Tue, 09 Oct 2012 08:10:38 +0200
Message-ID: <5073BFDE.60707@viscovery.net>
References: <1349749445-25397-1-git-send-email-pclouds@gmail.com> <1349749445-25397-2-git-send-email-pclouds@gmail.com> <7vd30si665.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 08:11:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLT2L-00014Z-Pg
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 08:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421Ab2JIGLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 02:11:13 -0400
Received: from so.liwest.at ([212.33.55.24]:5249 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab2JIGLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 02:11:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TLT1z-0005FQ-Dg; Tue, 09 Oct 2012 08:11:03 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0D7891660F;
	Tue,  9 Oct 2012 08:11:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vd30si665.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207301>

Am 10/9/2012 7:08, schrieb Junio C Hamano:
> Imagine if we allowed only one attribute per line, instead of
> multiple attributes on one line.
>     
>  - If you want to unset the attribute, you would write "path -attr".
> 
>  - If you want to reset the attribute to unspecified, you would
>    write "path !attr".
> 
> Both are used in conjunction with some other (typically more
> generic) pattern that sets, sets to a value, and/or unsets the
> attribute, to countermand its effect.
> 
> If you were to allow "!path attr", what does it mean?  It obviously
> is not about setting the attr to true or to a string value, but is
> it countermanding an earlier set and telling us to unset the attr,
> or make the attr unspecified?

If I have at the toplevel:

  *.txt  whitespace=tabwidth=4

and in a subdirectory

  *.txt  whitespace=tabwidth=8
  !README.txt

it could be interpreted as "do not apply *.txt to REAME.txt in this
subdirectory". That is, it does not countermand some _particular_
attribute setting, but says "use the attributes collected elsewhere".

-- Hannes
