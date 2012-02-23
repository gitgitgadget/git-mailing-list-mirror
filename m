From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCHv3 1/5] refs: add match_pattern()
Date: Wed, 22 Feb 2012 16:59:32 -0800
Message-ID: <20120223005932.GF2410@tgrennan-laptop>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
 <1329874130-16818-2-git-send-email-tmgrennan@gmail.com>
 <7vobsrbcny.fsf@alter.siamese.dyndns.org>
 <20120222234733.GD2410@tgrennan-laptop>
 <7v62ey8ktp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 01:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0N26-0006P5-OW
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 01:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754109Ab2BWA7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 19:59:38 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:43635 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab2BWA7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 19:59:37 -0500
Received: by qafk1 with SMTP id k1so862394qaf.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 16:59:37 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.106.70 as permitted sender) client-ip=10.229.106.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.106.70 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.106.70])
        by 10.229.106.70 with SMTP id w6mr24462091qco.132.1329958777166 (num_hops = 1);
        Wed, 22 Feb 2012 16:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/AWQzhJMsUDqOTHquH8SZ29nHsrw+ZUTF4W0LFr4+dc=;
        b=pmK1+x0rqjAkuhbPs5JMk4HjLwcxGkHMcGE/CaVVMyhV+mlU0zpOAVEb1BLuiQmHm7
         M1DJqZcppD9g5KMMOBf3Wh7iAAEP07diCGvO/gL3pZOrV/bDuhoaUk30vYtSH85zGzST
         67PEXobORpFN3+mSXTALEY3SknF2DCxewyaqg=
Received: by 10.229.106.70 with SMTP id w6mr20685787qco.132.1329958776979;
        Wed, 22 Feb 2012 16:59:36 -0800 (PST)
Received: from localhost ([129.192.185.163])
        by mx.google.com with ESMTPS id i19sm44953211qad.19.2012.02.22.16.59.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 16:59:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v62ey8ktp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191317>

On Wed, Feb 22, 2012 at 04:17:22PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>> Yes, I tried to minimize change but the conversion of argv's to
>> string_list's won't add that much.
>
>How about _not_ using string_list?  After all, string_list is not just a
>collection of strings, but is a table to hold strings with attributes.  I
>thought argv_array is more appropriate abstraction for the purpose of your
>patch.

OK, It looks like I should also add a common parse_opt_argv_array() to
parse-options-cb.  Of course that would be in a separate, dependent
patch.

>>>	ref_match_pattern("refs/heads/master",
>>>        		  ["maste?", NULL],
>>>                          ["refs/heads/", NULL],
>>>                          (REF_MATCH_FNM_PATH|REF_MATCH_LEADING));
>>>
>>>Note that the above "ref_match_pattern()" gives the same "flags" for the
>>>call to match_one() for elements in both positive and negative array and
>>>it is very deliberate.  See review comment to [3/5] for the reasoning.
>>
>> OK, I think that I understand, but please confirm, you'd expect no output in
>> the above example, right?
>
>"maste?" would match with FNM_PATHNAME with "refs/heads/master" but
>the negative "refs/heads/" matches with it, so yeah, I expect that the
>function would return false.

thanks, that's a good test case.

-- 
TomG
