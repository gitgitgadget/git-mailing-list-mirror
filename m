From: Adam Williamson <awilliam@redhat.com>
Subject: Re: 'simple' push check that branch name matches does not work if
 push.default is unset (and hence implicitly simple)
Date: Wed, 26 Nov 2014 14:38:20 -0800
Organization: Red Hat
Message-ID: <1417041500.12457.79.camel@redhat.com>
References: <1417040968.12457.78.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 23:38:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtlEB-00047f-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 23:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbaKZWiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 17:38:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbaKZWiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 17:38:23 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAQMcMlP025436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 17:38:22 -0500
Received: from mail.happyassassin.net (ovpn-113-42.phx2.redhat.com [10.3.113.42])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id sAQMcLjB010031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 26 Nov 2014 17:38:21 -0500
Authentication-Results: mail.happyassassin.net; dmarc=none header.from=redhat.com
In-Reply-To: <1417040968.12457.78.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260317>

On Wed, 2014-11-26 at 14:29 -0800, Adam Williamson wrote:
> Hi, folks. Ran into an unfortunate issue with git which helped me mess
> up a Fedora package repo today :/
> 
> The problem can be reproduced thus:

Whoops, I missed step 0:

0. Ensure push.default is not configured globally

> 1. Create an empty repo, clone it
> 2. Push its master branch with something in it (just to get started)
> 3. git branch --track moo origin/master
> 4. git checkout moo
> 5. echo moo >> moo && git commit -a -m "create moo"
> 6. git push
> ** BUG HAPPENS - CHANGES ARE PUSHED TO origin/master **
> 7. git config --local push.default simple
> 8. echo moo2 >> moo && git commit -a -m "update moo"
> 9. git push
> ** PUSH IS CORRECTLY REJECTED **
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | XMPP: adamw AT happyassassin . net
http://www.happyassassin.net
