From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat/mingw.h: Set S_ISUID to prevent a fast-import
 test failure
Date: Tue, 01 May 2012 07:30:41 -0700
Message-ID: <7vhaw0as8e.fsf@alter.siamese.dyndns.org>
References: <4F8DAFA4.2050502@ramsay1.demon.co.uk>
 <4F8F2268.8020803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 01 16:30:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPE6L-0004yn-1g
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 16:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab2EAOao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 10:30:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045Ab2EAOao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 10:30:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1BBC77C9;
	Tue,  1 May 2012 10:30:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CGFB9H9qwbS9MtzGt+d1MT+b6tE=; b=EvKx2+Uo1H9zddw28JGs
	koET2ltmwsY05JTIZbNZiSjSsj+3DpUIYniTI7yfHlcRCpA4TCjP4PL3NuiKIMYA
	myIPj9fkmUA9v5Tas/A5Ow+vlypD9EJfJdCdmu/y/PlWp5rvrksRb2NZmaqKKl8t
	rNBapL/Z+8rZYA/AxGIaEIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mx6zVgDpB8MCMAWMqo8x4kz+VeTG/foQ9a4Gey/EDaxn/3
	sK2CBSgLMeAVAYfWGcNWmDKHYaVDVdy1xSQJ0n7NlDKAXZJW2HTTUBmrDqNE583l
	v+N3j9Yvz5tpWPvwIQ0PLNW+wrhj0BGPdasccetfv27Ct6FSgUYU01aPT0MNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8E7377C8;
	Tue,  1 May 2012 10:30:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9061077C7; Tue,  1 May 2012
 10:30:42 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B3E6DBC-939A-11E1-B50E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196683>

Johannes Sixt <j6t@kdbg.org> writes:

>> ...
>> -#define S_ISGID 0
>> -#define S_ISVTX 0
>> +
>> +#define S_ISUID 0004000
>> +#define S_ISGID 0002000
>> +#define S_ISVTX 0001000
>>  
>>  #define WIFEXITED(x) 1
>>  #define WIFSIGNALED(x) 0
>
> I've submitted a similar patch, but it was suggested to solve the
> inherent problem in a cleaner way, but no patch came forward.

I think this patch should be fine, either as the final solution, or the
first step for "solving the inherent problem in a cleaner way" (if msysgit
folk care very deeply about it, that is).
