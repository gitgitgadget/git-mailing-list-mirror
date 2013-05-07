From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH v3 5/9] revision.c: Make --full-history consider more
 merges
Date: Tue, 07 May 2013 17:46:16 +0300
Message-ID: <518913B8.5080302@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi> <1367767977-14513-6-git-send-email-kevin@bracey.fi> <7vtxmfq1ll.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:04:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjRc-000168-PD
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab3EGPEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 11:04:41 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:51493 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756460Ab3EGPEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 11:04:39 -0400
X-Greylist: delayed 1099 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 May 2013 11:04:39 EDT
Received: from mail628.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 6DAC2104EF9F
	for <git@vger.kernel.org>; Tue,  7 May 2013 16:46:18 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 7 May 2013 16:46:20 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 7 May 2013 16:46:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
In-Reply-To: <7vtxmfq1ll.fsf@alter.siamese.dyndns.org>
X-Ovh-Tracer-Id: 1421730108045889752
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500009/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223576>

On 06/05/2013 23:45, Junio C Hamano wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> +struct treesame_state {
>> +	unsigned int nparents;
>> +	unsigned char treesame[FLEX_ARRAY];
>> +};
> I have been wondering if we want to do one-bit (not one-byte) per
> parent but no biggie ;-)

I did start down that path, because I felt bad about bloat.

But then I realised how much I would be complicating and slowing the 
code down to only save a few bytes each time we walk a merge with at 
least 5 parents, and I came to my senses. :)

Kevin
