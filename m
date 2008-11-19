From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 13:13:46 +0100
Message-ID: <81b0412b0811190413s29644092y86d1c8840e10c28b@mail.gmail.com>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
	 <4923FE58.3090503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:15:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2lyN-00058X-Nt
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754627AbYKSMNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754624AbYKSMNs
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:13:48 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:13065 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757AbYKSMNr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:13:47 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1715936wah.21
        for <git@vger.kernel.org>; Wed, 19 Nov 2008 04:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=s0oU9RRXYsmcbIdQjvszXQgzp4XY82JT+ZJWTszXVRA=;
        b=u8+99mnWIgcLRsj/R6dOiwmnamdoRilmPEbupp38uZjKQE/r/vtZBb0mjfAdn2HRPa
         x6fEchR3pJ/073Nu1k+4pFnZxpiCUiuFQTWblhkt7/JTwk1VqqqKcIwsAH8KRaektc7Q
         TSgVmTqSpsXvBj2hiID0siRGZ65ruKoIOZdHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aA/qZrzGzVcOMGJtEk5XQg4Bib4xKls211I+2FS1TLrIqqHTsxEfWXMabfLtamb8hG
         I6aitIkcSXHa9ZlafnDGtfgXvYuAd7YzGX+3XvJWXqaXgaBI2yWqp1RCsAf6oOFOTPLL
         r5JvgRFhUryYXn7GNmnO8PJztsSf5H2k3NCOo=
Received: by 10.114.195.19 with SMTP id s19mr623083waf.123.1227096826486;
        Wed, 19 Nov 2008 04:13:46 -0800 (PST)
Received: by 10.114.157.9 with HTTP; Wed, 19 Nov 2008 04:13:46 -0800 (PST)
In-Reply-To: <4923FE58.3090503@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101329>

2008/11/19 Johannes Sixt <j.sixt@viscovery.net>:
> Alex Riesen schrieb:
>> The opened packs seem to stay open forever.
>
> In my MinGW port I have the patch below that avoids that t5303 fails
> because of a pack file that remains open. (Open files cannot be replaced
> on Windows.) I had hoped that your patch would help, but it does not.
> Something else still keeps the pack file open. Can anything be done about
> that?
>

Do this _and_ the other handle-leak-patch together help?
(I think the second should)

> From: Johannes Sixt <j6t@kdbg.org>
> Date: Mon, 17 Nov 2008 09:25:19 +0100

BTW, you better report such things. Even though it is typical
for this platform brokenness, leaking open files is never good.
