From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: check-ref-format: include refs/ in the argument or to strip it?
Date: Fri, 22 Aug 2014 11:45:15 -0700
Message-ID: <20140822184515.GL20185@google.com>
References: <gerrit.1408574889668.Iac983fc86f7edd2a0543779d85973c57bf068ca4@code-review.googlesource.com>
 <047d7b624d36142d46050131f336@google.com>
 <20140822154151.GK20185@google.com>
 <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 20:45:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKtpz-00079K-U8
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 20:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbaHVSpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 14:45:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:53266 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbaHVSpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 14:45:19 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so17165930pab.1
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 11:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8zan9Q+EnjM64CQzeKWs/B4PJ3gIoQHN4t2Y/ACGdxs=;
        b=QBjmIK5JSxLMJ7VoPIi8Wqbnn0G9Qzh9ni2k5g+f/aPol1P9avjAI73md6sC+eeJzD
         CSlqexv5YBTiMEyBd3GlgEkijteTNM/huoWg141t9AE3UGVhCwypO6qdWRWtR6RDBgtA
         9mm6LWareNs5MrV7RGbFh+u24EyJlpe3SaMJlxL7+d1g4KdHDHMF4USooDFyzWcPW4Pb
         4UERoqVkmKuZOyMJYcB29/9iQz+YcIM2g1epXLJl1MiDHY1ftH7munJ4Xa/ldaVAWFWf
         ryaQrohDEnNnTtpiF85SNfTgwpbVIk5xHVTzYCutlNCoM/uEHJ1shv73iwBc9eXvScB9
         efOg==
X-Received: by 10.68.253.34 with SMTP id zx2mr8472952pbc.152.1408733118444;
        Fri, 22 Aug 2014 11:45:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c57b:d378:4566:1b8f])
        by mx.google.com with ESMTPSA id ex1sm44758432pdb.26.2014.08.22.11.45.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 11:45:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqmwawnzfk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255693>

Junio C Hamano wrote:

>                implication of which is that the 'at least one slash'
> rule was to expect things are 'refs/<anything>' so there will be at
> least one.  Even back then, that <anything> alone had at least one
> slash (e.g. heads/master), but the intention was *never* that we
> would forbid <anything> that does not have a slash by feeding
> <anything> part alone to check-ref-format, i.e. things like
> "refs/stash" were designed to be allowed.

Now I'm more confused.  Until 5f7b202a (2008-01-01), there was a
comment

		if (level < 2)
			return -2; /* at least of form "heads/blah" */

and that behavior has been preserved since the beginning.

Why do most old callers pass a string that doesn't start with refs/
(e.g., see the callers in 03feddd6, 2005-10-13)?  Has the intent been
to relax the requirement since then?

Jonathan
