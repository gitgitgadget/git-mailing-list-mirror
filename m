From: Phil Hord <hordp@cisco.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 30 May 2012 19:40:19 -0400
Message-ID: <4FC6AFE3.5070805@cisco.com>
References: <4FBD4904.9090000@cisco.com> <7vipfmzfel.fsf@alter.siamese.dyndns.org> <7vehqazf9d.fsf@alter.siamese.dyndns.org> <4FBD6EC2.3000804@cisco.com> <7v62bmzdmy.fsf@alter.siamese.dyndns.org> <7vipfe1ihg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 31 01:40:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZsVE-0006E5-V1
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 01:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab2E3XkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 19:40:21 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:43690 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab2E3XkU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 19:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=970; q=dns/txt;
  s=iport; t=1338421220; x=1339630820;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=JB2PoECbQ6+tBC46W5t6UqLS4KKqf9fpZ3Qpy7AZdKg=;
  b=KjJJlx9ym1XSMjGfMW9Xw0rVDCM+zP1sIP5fRNij4bpKdQh9CAtuqaSB
   gY9dkkiaZCPfJi9FsDd9OcD8fwFdvhSdvY93WzrqmbL001rZetc4GCVDN
   y6LROrnrXgjpO/Jz8LITJdMSOf3VytpXatodOR+InCaJ4TIXHYZa1YCLD
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av8EADqvxk+tJV2d/2dsb2JhbABEtBOBB4IXAQEBAwESAWUBBQsLIRYPCQMCAQIBRQYNAQcBAR6HZAWZPJ9okEsDlRiFT4g+gWaCfA
X-IronPort-AV: E=Sophos;i="4.75,686,1330905600"; 
   d="scan'208";a="88118773"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-7.cisco.com with ESMTP; 30 May 2012 23:40:19 +0000
Received: from [64.100.104.83] (dhcp-64-100-104-83.cisco.com [64.100.104.83])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id q4UNeIoI026922;
	Wed, 30 May 2012 23:40:19 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <7vipfe1ihg.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.1
X-TagToolbar-Keys: D20120530194019452
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198851>

Junio C Hamano wrote:

> Instead of reverting the entire thing, perhaps we can fix the
> regression like this.
>
> With this, we no longer unconditionally give "--allow-empty" when we
> run "git commit", when --allow-empty (which is only about commits
> that are originally empty) is given to cherry-pick; specifically,
> when the user did not ask for --keep-redundant-commit, we do not
> give "--allow-empty" if the original commit is not.
>
> Thinking about it again, I _think_ we do not even have to check if
> the result is an empty commit ourselves ("git commit" will do that
> for us anyway), so we might want to rip "is_empty_commit()" out of
> the problematic patch and keep only "is_index_unmodified()" bit, but
> for now I think this may be good enough.
>
> Phil, does it fix your issue?
Yes, it appears to fix my issue.  I don't have the original condition in
play anymore, but it fixes the test case I cooked up earlier.

Thanks,
Phil
