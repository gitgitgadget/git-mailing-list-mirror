From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Teach git-bundle to read revision arguments from stdin like git-rev-list
Date: Sun,  6 Jul 2008 10:28:56 -0400
Message-ID: <1215354538-1469-1-git-send-email-adambrewster@gmail.com>
References: <7v63rjrfqz.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, vmiklos@frugalware.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 16:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVFc-0003Td-IM
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756694AbYGFO3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbYGFO3F
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:29:05 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:28547 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019AbYGFO3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:29:02 -0400
Received: by an-out-0708.google.com with SMTP id d40so354225and.103
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 07:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=b6FBwI0munZluKWGj3Fcj66KuAGs5Hnic+vIKTMcdnY=;
        b=oGKU8y5RcP2/SY2ATEMfNc5OnM9aPZvZU+BReNzcJ4uKuM6cOJrv65pn42VIBqItQW
         AYt1oIbdd6Zl2cY+de6CYeAL4IMlFm96pf+yix1VrPBs7cL7XwIryU/k8LHmBJoCUuIZ
         E1FeZZOfJBEK+56qfoXXwzRyqVNIfHvln4/eo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JUpfeTNAfCtrqnZ0Cm+1LGxbFHzWvQ8iGaqbL/HCz2y9EfFvot1YFq4TyrSUMKmTxr
         CyKwfCjvWf+dp+iVxIyyvuymvvjPp7DGLemp8Jjqeib3nGkPGaWiQD6LqaiWsJIf7pIO
         R5jykR1iF3LRWAjoTkqezyO4e+yKT0d24YweY=
Received: by 10.100.201.9 with SMTP id y9mr2184153anf.60.1215354540934;
        Sun, 06 Jul 2008 07:29:00 -0700 (PDT)
Received: from MBE.internal ( [65.96.169.255])
        by mx.google.com with ESMTPS id 4sm3556136yxq.8.2008.07.06.07.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 07:28:59 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id 6FF8510499B; Sun,  6 Jul 2008 10:28:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <7v63rjrfqz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87530>


On Sat, Jul 5, 2008 at 8:57 PM, Junio C Hamano <gitster@pobox.com> 
>> +                     if (read_from_stdin++)
>> +                             die("--stdin given twice?");
>
> Hmm, do we deeply care about this case?  What bad things coulc happen 
if
> you call read_revisions_from_stdin() twice?
>

Presently, it'll actually try to read stdin twice and that won't work.

Also, if you want git-bundle to deal with --stdin --stdin, I'd say that 
git-rev-list should do the same.  I don't really care how this 
particular error case is handled, but I think git-rev-list and 
git-bundle should do the same thing for any given input.

If you prefer to be liberal in what you accept, then you might like 
these two patches that allow git-rev-list and git-bundle to deal with 
--stdin --stdin.

By the way, I'm not exactly sure on the format of these guys.  You said 
you queued some changes yesterday, so these go on top of those.  If 
you want me to start from scratch and give you the whole chain again, I 
can do that too.
