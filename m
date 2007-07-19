From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Thu, 19 Jul 2007 11:58:36 +0100
Message-ID: <200707191158.37713.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site> <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net> <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 12:58:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBTih-0004bH-Lj
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 12:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbXGSK6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759499AbXGSK6n
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 06:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:3980 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757126AbXGSK6m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 06:58:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so382685ugf
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 03:58:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZxIYwr0nsxEQ3MkGPjzsorL5n7Fsa9ktz4Ae56dnT44unhgxiatH50kbKuDtu9GuXgHwXnJcy3DVJIWA13th6xYz0lBqSF4qOQCqmNp2BAI+q9RCO3I6KwURu+NKyuWwR5bRndzgXmJdKChzpNWJjlFkfBQktTcCokHM2poj2ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hYj0k9KnTNa0z1A3AOOK46SeW6p9sdliBn9oQ0L9gKyldb9sXtcmSrVsu95M2lt2rnTjjgs//j4Ws2M4AUqi1c2eHuuF4C+mXUoqrcFy2OJvjt00TWJWFAyedRQqvdD+71tCyUq9kbQsEDpMHZW/43n/e/+EVU2xp/ILsDcjmGs=
Received: by 10.67.119.9 with SMTP id w9mr1088272ugm.1184842721180;
        Thu, 19 Jul 2007 03:58:41 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z37sm3414554ikz.2007.07.19.03.58.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2007 03:58:40 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <7vodi83fg7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52966>

On Thursday 2007 July 19, Junio C Hamano wrote:

> I've long time ago concluded that if we care about reliability
> (and we do very much), a bisectable tree without breaking
> backward compatibility is impossible.  I was hoping to find a
> "hole" in tree object format so that I can place an extended

In the case of the notes system, is there not a big hole available because the 
layout is under tight control?

100644 blob 24631df5c6fceef7f0859903397d81f99a723197    __notes_index
040000 tree dd3f40129c8731b1bdce1d3939de3cdc24a87783    00
040000 tree 2b25612b5d8ee9ef469e72bbf74eab0ec00ae87f    01

In fact, this technique would work for normal tree objects too, except that 
you'd have to be willing to pick some blob name that would always be the 
first entry in every tree object, and would never clash with a real file in 
the tree.  Speaking off the top of my head, anything with "/" in it would be 
an invalid name so

100644 blob 24631df5c6fceef7f0859903397d81f99a723197    /tree_index
040000 tree dd3f40129c8731b1bdce1d3939de3cdc24a87783    00
040000 tree 2b25612b5d8ee9ef469e72bbf74eab0ec00ae87f    01

Would be an easy one to special case, and would be guaranteed not to clash 
with a file in the tree.

Just an idea.  I would imagine it's as daft as all my others :-)



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
