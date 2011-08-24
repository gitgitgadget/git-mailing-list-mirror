From: Brian Harring <ferringb@gmail.com>
Subject: Re: [PATCH] get_indexed_object can return NULL if nothing is in that
 slot; check for it
Date: Wed, 24 Aug 2011 13:40:21 -0700
Message-ID: <20110824204021.GA28157@beast>
References: <20110824054717.GA16512@localhost>
 <7vmxeypudw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:40:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKFS-0006yR-Va
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab1HXUk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:40:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51107 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab1HXUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:40:25 -0400
Received: by ywf7 with SMTP id 7so1166235ywf.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 13:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9HuBkKLu83FrPczygmBVzgNeC2pYINSrrQImYVWG/Lk=;
        b=kg9tP5t6mY2nL9MyFT6KkNcV+JbMNWu+Kab7eLoR8HkLReStSGt7KhbIjAbeNrwqUj
         mxIb4dcHojUW7qXKVOyWZnhQdH+9Wy6cR9SdQMoT1uwBwqaUJv0JBFqAAh4xyAJiH73j
         zvasxkP5pPL8aQaOJrLk8e/UXrku8lOdupfDI=
Received: by 10.236.177.66 with SMTP id c42mr12947559yhm.14.1314218425344;
        Wed, 24 Aug 2011 13:40:25 -0700 (PDT)
Received: from smtp.gmail.com (74-95-192-101-SFBA.hfc.comcastbusiness.net [74.95.192.101])
        by mx.google.com with ESMTPS id s62sm415317yhn.75.2011.08.24.13.40.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 13:40:24 -0700 (PDT)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Wed, 24 Aug 2011 13:40:21 -0700
Content-Disposition: inline
In-Reply-To: <7vmxeypudw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180038>

On Wed, Aug 24, 2011 at 10:54:51AM -0700, Junio C Hamano wrote:
> Thanks for a fix.
> 
> It is both interesting and disturbing to see that these small mistakes are
> discovered a week after the topics hit 'master', even though it has been
> cooking in 'next' for a week before that happened (in the case of this
> topic, it also hit 'maint' yesterday).

I'll admit I'm slightly surprised it slipped past for initial 
development- that said, you have to explicitly trigger the race to 
trigger the segfault.  And that's not easy w/out building out a 
custom setup- even w/ that setup, you need to go digging in server 
logs to realize the previous serverside failure just converted to a 
segfault.  Clientside, it hung just the same.

Bit nonobvious.  Plus, shit happens. ;)

Either way, I was poking at the source trying to figure out how to get 
some unittests for an end to end testing of the http/smartserv; that 
said I was having a helluva time finding a way to do it without 
bundling a stub of a webserver.  Suggestions would be welcome on that 
one.

~brian
