From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 21/44] refs.c: ref_transaction_commit should not free
 the transaction
Date: Thu, 15 May 2014 17:20:29 -0700
Message-ID: <20140516002029.GB11011@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-22-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 02:20:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl5tD-0000YU-Kl
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 02:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbaEPAUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 20:20:36 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64927 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaEPAUg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 20:20:36 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1778403pbb.33
        for <git@vger.kernel.org>; Thu, 15 May 2014 17:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5Lx7GrGDjvo/O3JjJGILowoFq/uAUwH45vZ1DCNEVPw=;
        b=UDr4a2ehNjcUKn9eRikb4ung2A7fZq7nHztZnCzdQJ5I3WON31/2SXHaDkSFsgKQ9E
         hTcRsJLDFRZwIsLkXgeowJ6snjgJUjXN5FrPWz/NXG65J+kqTPvQ/6kLaPqfflIXzhlt
         Y3ksnEWUwBegS7hoMDOfRDKHaiiNo1elU5r9G0F9isWWszpxKXFFRz+eDTZLCkDW1dUj
         tnd73ARANd60i35dFBaKrsskagnp9SKM3BAiUpQV94nxqvsaI8wHla3IoP9v1T2aIPXm
         mfofsntUhfQPajrebfAnTPqSA+VJ3LWf6lknhH/SSMKjusj9jqeyLEXe6ecf1vLDwpg3
         499Q==
X-Received: by 10.66.192.225 with SMTP id hj1mr16529440pac.142.1400199635416;
        Thu, 15 May 2014 17:20:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id h5sm11194017pbw.81.2014.05.15.17.20.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 17:20:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-22-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249268>

Ronnie Sahlberg wrote:

> Change ref_transaction_commit so that it does not free the transaction.
> Instead require that a caller will end a transaction by either calling
> ref_transaction_rollback or ref_transaction_free.

Can I always use ref_transaction_rollback instead of ref_transaction_free?
It would be convenient if my cleanup code could always call _rollback
instead of having to do something different for success and errors.

Another way to ask the question: what is it valid to do with a
transaction after commiting?

Thanks,
Jonathan
