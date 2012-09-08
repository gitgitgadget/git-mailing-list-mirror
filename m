From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] daemon: restore getpeername(0,...) use
Date: Sat, 8 Sep 2012 21:20:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209082119320.18369@frira.zrqbmnf.qr>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <1347124173-14460-2-git-send-email-jengelh@inai.de> <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:20:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQaP-0001gv-31
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781Ab2IHTUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:20:50 -0400
Received: from seven.inai.de ([5.9.24.206]:40963 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593Ab2IHTUt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:20:49 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id 5A98596A11C6; Sat,  8 Sep 2012 21:20:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 3A1CE96A1084;
	Sat,  8 Sep 2012 21:20:48 +0200 (CEST)
In-Reply-To: <7v1uicuyqi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205031>


On Saturday 2012-09-08 20:59, Junio C Hamano wrote:
>> diff --git a/daemon.c b/daemon.c
>> index 4602b46..eaf08c2 100644
>> --- a/daemon.c
>> +++ b/daemon.c
>> @@ -1,3 +1,4 @@
>> +#include <stdbool.h>
>>  #include "cache.h"
>>  #include "pkt-line.h"
>>  #include "exec_cmd.h"
>
>Platform agnostic parts of the code that use "git-compat-util.h"
>(users of "cache.h" are indirectly users of it) are not allowed to
>do platform specific include like this at their beginning.
>
>This is the first use of stdbool.h; what do you need it for?

For the use in setenv(,,true). It was not entirely obvious in which .h 
to add it; the most reasonable place was daemon.c itself, since the 
other .c files do not seem to need it.
