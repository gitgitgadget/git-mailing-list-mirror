From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/3] run-command: Be more informative about what failed
Date: Thu, 31 Jan 2013 10:05:09 -0800
Message-ID: <510AB255.40302@codeaurora.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org> <1359597666-10108-3-git-send-email-sboyd@codeaurora.org> <7vfw1hiami.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0yVx-0001jP-Qr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab3AaSFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:05:11 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:37927 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3AaSFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:05:10 -0500
X-IronPort-AV: E=Sophos;i="4.84,578,1355126400"; 
   d="scan'208";a="23263601"
Received: from pdmz-ns-snip_114_130.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.130])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jan 2013 10:05:09 -0800
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id A2FDB10004C7;
	Thu, 31 Jan 2013 10:05:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vfw1hiami.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215135>

On 01/31/13 08:24, Junio C Hamano wrote:
> Stephen Boyd <sboyd@codeaurora.org> writes:
>
>> While debugging an error with verify_signed_buffer() the error
>> messages from run-command weren't very useful:
>>
>>  error: cannot create pipe for gpg: Too many open files
>>  error: could not run gpg.
>>
>> because they didn't indicate *which* pipe couldn't be created.
> For the message emitted here with your update (or without for that
> matter) to be useful, it has to hold that there is a single leaker,
> that leaker fails in this codepath, and that there is nobody else
> involved.  Otherwise, you may be able to tell that one caller could
> not create its stdin, but the reason it couldn't may be because
> somebody else consumed all the available file descriptors.
>
> I am not opposed to this change per-se, but I am not sure that
> saying "stdin" etc. makes the message more useful for the purpose of
> debugging.

It helped me avoid firing up gdb, but if you don't see much use feel
free to ignore this patch.

>
>> For example, the above error now prints:
>>
>>  error: cannot create stderr pipe for gpg: Too many open files
>>  error: could not run gpg.
> I'd prefer to see these names spelled out (e.g. "standard error")
> in any case.

Sure, I can do that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
