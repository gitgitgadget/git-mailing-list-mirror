From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 02/11] remote.c: add infrastructure for parsing --prune
 options
Date: Wed, 04 Dec 2013 18:04:38 +0100
Message-ID: <529F60A6.90309@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu> <1386135890-13954-3-git-send-email-mhagger@alum.mit.edu> <CACsJy8DwfXPn6vJXuMyNP7W3tKe2w_mzxdw53kL=-T+0YU5wCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 18:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoFzJ-0001rK-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 18:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693Ab3LDRLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 12:11:45 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:56775 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932576Ab3LDRLp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 12:11:45 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2013 12:11:44 EST
X-AuditID: 12074412-b7fc96d0000023d5-7e-529f60a922a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CE.84.09173.9A06F925; Wed,  4 Dec 2013 12:04:41 -0500 (EST)
Received: from [192.168.69.148] (p57A25858.dip0.t-ipconnect.de [87.162.88.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB4H4dT9013813
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 12:04:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <CACsJy8DwfXPn6vJXuMyNP7W3tKe2w_mzxdw53kL=-T+0YU5wCw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLsyYX6QwY7PShZdV7qZLBp6rzBb
	dE95y+jA7LFz1l12j4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7oOPORsWAaW8W951fZGxgn
	sHQxcnJICJhInD50lQnCFpO4cG89WxcjF4eQwGVGiR29u6Ccs0wShw8eA+rg4OAV0JR4uV4S
	pIFFQFViwsyJrCA2m4CuxKKeZrBBogJBEo8OPWQHsXkFBCVOznwCtkxEQEniTcc2ZhCbWcBP
	4vuZXWD1wgLBEgeuT2CE2HWIUeL6001sIAlOgUCJX/OeMoLslRAQl+hpDAIxmQXUJdbPE4IY
	Iy+x/e0c5gmMgrOQbJuFUDULSdUCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbpmermZJXqp
	KaWbGCHhLLSDcf1JuUOMAhyMSjy8CZzzgoRYE8uKK3MPMUpyMCmJ8srGzQ8S4kvKT6nMSCzO
	iC8qzUktBrqdg1lJhHdyIFCONyWxsiq1KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoaD
	Q0mCd0Y8UKNgUWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KHrji4HxC5LiAdpbCNLO
	W1yQmAsUhWg9xajLMe/Lh2+MQix5+XmpUuK800CKBECKMkrz4FbAktcrRnGgj4V5d4JU8QAT
	H9ykV0BLmICWND+YB7KkJBEhJdXAWG6yvbheVnmFQP/cfb22j/R0lkgonvypvHViywnRtsIn
	wWzGub1TT889uGNeUtdbXeGb//s2HP63rCV5ztGQN4H7eixmr+FgVeuYd0ewv1eA 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238790>

On 12/04/2013 01:57 PM, Duy Nguyen wrote:
> On Wed, Dec 4, 2013 at 12:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> +void argv_push_prune_option(struct argv_array *argv,
>> +                           struct prune_option *prune_option)
>> +{
>> +       if (prune_option->prune != -1)
>> +               argv_array_pushf(argv,
>> +                                prune_option->prune
>> +                                ? "--prune"
>> +                                : "--no-prune");
>> +}
> 
> Nit. I think argv_array_push() is enough for this case?

Yes, you're right.  Thanks for noticing.

If people want this patch series I will fix the problem in the next round.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
