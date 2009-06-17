From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: use compat regex on Solaris
Date: Wed, 17 Jun 2009 14:15:54 +0100
Message-ID: <e2b179460906170615u46a71241wf012d98020ef91e0@mail.gmail.com>
References: <20090616190550.GA22905@coredump.intra.peff.net>
	 <20090616190821.GB23197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, John Bito <jwbito@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 15:16:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGuzj-0000AV-FD
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 15:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbZFQNPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 09:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbZFQNPy
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 09:15:54 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:44613 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbZFQNPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 09:15:53 -0400
Received: by bwz9 with SMTP id 9so308558bwz.37
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 06:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IAx51WxBvDXG2y+v8SXjHn9WqS000qPjpcE9GTZ3C84=;
        b=HdUsCfcvVBtSKFCXNPWf21pZz1Rxzx868BHLImAtoPsR0pE1A7W6w8bI1XThdMS67o
         3a3d2PO7jFGyiaMjBVYwCQnO4RrbNVkC3MhCj2YBnaokAFAVoTC1wiZodkUmJus39HAD
         tNV//HoUtq7Rmq4lIACY/wsKgtT4bq0KXECxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AQYUiBlY1lFNopYJPT81woi/6Kj/XAHa+o2bsp0ois7A585b5f219EZdB4jTobZ2GG
         8fM165A3G2dQdGsmNF9i21Ioh7KmqtsBV71CCkWCLueWF0V8whdMf69P1MahnftfVe+7
         lJiOBL31LcVTH08+fzV7piv5HEm0lZKonyvLU=
Received: by 10.223.110.11 with SMTP id l11mr209060fap.50.1245244554630; Wed, 
	17 Jun 2009 06:15:54 -0700 (PDT)
In-Reply-To: <20090616190821.GB23197@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121742>

2009/6/16 Jeff King <peff@peff.net>
>
> The system regex is either slow or buggy for complex
> patterns, like the built-in xfuncname pattern for java
> files.

Also required on AIX (5.3). I thought this was a major performance
regression somewhere else, but my 'old stable' version dates from a
time when we were briefly using compat/regex on this platform before
we reverted that change and switched over to extended regexes.

With the above:
3m33.399s

Without:
... manually aborted after 58m !

git 1.6.0.2.229.g1293c
3m21.645s

Could you squash

+       NO_REGEX = YesPlease

in ifeq ($(uname_S),AIX) please? Shout if follow-up patch preferred.

Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Mike

PS Pound to a penny INTERNAL_QSORT would be a win on Solaris too...
