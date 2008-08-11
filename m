From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 16:16:50 +0200
Message-ID: <237967ef0808110716l2a0a2a4je22c2a1b8c239f57@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Francis Moreau" <francis.moro@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 11 16:19:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSYDn-0003Cy-O3
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 16:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbYHKOQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 10:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYHKOQw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 10:16:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:50836 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYHKOQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 10:16:51 -0400
Received: by wa-out-1112.google.com with SMTP id j37so14100waf.23
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=324FLR/1UJgia5E64pkZVtGQNB4L7mgwi8iHxIhmhNU=;
        b=Agf4OUj9WiimtaToSPpUWmt5JNo7JLRqK+xmRgiWCg1QF+Jz21jwdahfazUqcxH9TD
         fhsGQepFAkJMx8aWotX6dMVbqx7AFXQJQ/NFij1/MWrv6KWNUyCYf6eap02qBHqSegpP
         2Re0i8+P0B4KUYvp76zUo0/V8XYDW0r03slXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lGSPvl9Xa9Ocr8jzfkeZOaORyh9/zIgIyx2Z0xBhbb9i5zAbrZ5QUD9aI4ZviNf3c9
         /YQA9JMqnGaBa+Xp1NQIjEpxOxhOuzsXuCwFodNP/uzDqSWzU5hcIR9DJLeEh9kpDuQW
         id71lo5/Cuf1ox2gYpIBBF4GAMnEDgyijKRqY=
Received: by 10.114.133.1 with SMTP id g1mr3355345wad.123.1218464210361;
        Mon, 11 Aug 2008 07:16:50 -0700 (PDT)
Received: by 10.114.112.17 with HTTP; Mon, 11 Aug 2008 07:16:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91938>

2008/8/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 11 Aug 2008, Francis Moreau wrote:
>
>> I found this in git bisect:
>>
>>               printf >&2 'Are you sure [Y/n]? '
>>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
>>
>> which looks very weird since read(1) returns a status and not the
>> string reads from std input.
>>
>> Am I missing something ?
>
> Yes.  "$()" does not return the status, but the output.

But there is no output, since read doesn't print anything...
case "$(read yesno; echo $yesno)" in [Nn]*) could work, but looks
a bit strange. read yesno; case $yesno in [Nn]*) would be the usual
way to do things i think?

-- 
Mikael Magnusson
