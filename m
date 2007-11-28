From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: ok for git to delete temporary packs on write error?
Date: Wed, 28 Nov 2007 15:48:36 +0000
Message-ID: <e1dab3980711280748s53bf23f4j11be8c0472b7a216@mail.gmail.com>
References: <e1dab3980711272342x7afad721m113fe21f6879a886@mail.gmail.com>
	 <alpine.LFD.0.99999.0711281000590.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:49:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxP9p-0002ce-St
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550AbXK1Psj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757121AbXK1Psj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:48:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:55288 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbXK1Psi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:48:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1782138wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LP02vpAzhc2SgZM9978ByQMLkRMBtHbBw2zyOOyU6Ac=;
        b=bSqpYRWb2ZnTDA0fgs0tQBn+kHn3Iin7OtctdWo9n299Z1S7ur2akU0i2xBQyeNSU5P61gwbVi6cpxSWEXgeco8Ef4ThOjqzCTBt9yWsafhvqVAzxxzFdlsen895RJ9GErM4tCzdohfT7E0XMIidoOwbIj8y/NWZU4rKrKNfQas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DsigssaVwh+vwvdE86jNduLTR+hk7wMg+y5Hj+6/aSQh8aVEfRAxdJFaU9KplO/I5cmcnyFT7iEoF80YabCEDO9EL49XdwNsKv9mQf2OP8fDmzqMQU/+N38YREFZgWXTXlrl8fDFft95+pFf8R7ZK1rshvbWV7rXkfIpY0La9qE=
Received: by 10.114.160.1 with SMTP id i1mr410358wae.1196264916497;
        Wed, 28 Nov 2007 07:48:36 -0800 (PST)
Received: by 10.114.200.3 with HTTP; Wed, 28 Nov 2007 07:48:36 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711281000590.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66358>

On Nov 28, 2007 3:01 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 28 Nov 2007, David Tweed wrote:
>
> > Hi, I'd like to check if there's any reason in the overall design of
> > git which would make deleting tmp_pack's that have suffered
> > write errors a bad idea? (Before I look further into this I may be missing
> > a good reason why they shouldn't be auto-deleted.)
[snip]
> I'd suggest they get removed a part of the prune command.

Mmm, I hadn't looked at the source and spotted the prune
is actually a separate process to the repack. From a policy
POV is it ok to assume any tmp_pack*'s existing when
prune is run can be deleted? (I know you're not supposed
to be having any other git ops going on whilst git gc works.)

Now I know they aren't being kept around for, say, "emergency
error recovery" I may look to see if I can come up with
an acceptable patch. (Don't hold your breath waiting.)

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
