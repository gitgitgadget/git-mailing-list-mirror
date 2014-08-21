From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: [BUG] resolved deltas
Date: Thu, 21 Aug 2014 20:25:39 +0200
Message-ID: <53F639A3.80805@redhat.com>
References: <53F5D98F.4040700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 20:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKX3R-0002ym-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 20:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbaHUSZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 14:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53230 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbaHUSZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 14:25:41 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7LIPblw000612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 21 Aug 2014 14:25:37 -0400
Received: from [10.34.4.169] (unused-4-169.brq.redhat.com [10.34.4.169])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7LIPd0U022600
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Aug 2014 14:25:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
In-Reply-To: <53F5D98F.4040700@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255627>


> <snip>
> Bug is reprodusible since git version 1.8.3.1 (may earlier 1.8.xx, but 
> I don't test it) to actual upstream version.
> This problem "doesn't exists" in version 1.7.xx - or more precisely is 
> not reproducible. "May" this is reproducible
> since commit "7218a215" - in this commit was added assert in file 
> "builtin/index-pack.c" (actual line is 918), but I didn't test this.
Ok so this is reproducible since this commit because of assert().

> Here I am lost. I don't know really what I can do next here, because I 
> don't understand some ideas in code. e.g. searching of child - 
> functions find_delta(), find_delta_children(). Calculation on line 618:
> ----
>     int next = (first+last) / 2;
> ----
> I still don't understand. I didn't find description of this searching 
> algorithm in tech. documentation but I didn't read all yet. However I 
> think that source of problems could be somewhere in these two 
> functions. When child is found, its real_type is set to parent's type 
> in function resolve_delta() on the line 865 and then lasts wait for 
> failure. I don't think that problem is in repository itself [1], but 
> it is possible.
I read history of commits and my idea seems to be incorrect. It seems 
more like some error in repository itself. But I'd rather get opinion 
from someone who knows this code and ideas better.

Regards,
Petr

> [0] https://bugzilla.redhat.com/show_bug.cgi?id=1099919
> [1] git clone https://code.google.com/p/mapsforge/ mapsforge.git
