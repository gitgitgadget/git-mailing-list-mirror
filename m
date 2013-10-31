From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] shortlog: add missing declaration
Date: Thu, 31 Oct 2013 13:07:21 -0700
Message-ID: <xmqqvc0d432e.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
	<xmqqk3gt5kht.fsf@gitster.dls.corp.google.com>
	<CAMP44s2zTFKeHxp0G1imLXdHfzao_DSY+mkm7awYedwYafFZ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 21:07:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbyWg-0004bK-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 21:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab3JaUH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 16:07:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52443 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080Ab3JaUH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 16:07:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D64CE4E7CB;
	Thu, 31 Oct 2013 16:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mYn+5lY6IDFIlb3SALaFON2z3i8=; b=e7udtL
	zJHy+EEp1EAEW1xGjjPrKyGqif3XQ47/yEBmMlwgRw245pLNBEXDjNVPK+Jd0Y8X
	RHYwMoMnuKXeLz0b8F1R5JqFvXWF4LqlmB9a1iXwJNkY5M9dCVud0CSBQn0kmfmC
	HCvxgr3O+tTLUnAHS057ea0GcLpAxAMa2uu64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROlpuginumWthZrT/zHEyd2oCHoFSZlK
	4CmchC5YNHW8pWDyGgB+suTABtaONzTSEqlieJIuCr8anGSYuzQg2KYslt4QqD7P
	RKgrDBIYbO02qMS0KOKxFM+o7kW0/FmFIEXB6W58GxMJA328B3W/x8HN6KSMCrdf
	P7TFPkbGLEw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C24014E7C9;
	Thu, 31 Oct 2013 16:07:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D36B4E7C6;
	Thu, 31 Oct 2013 16:07:25 -0400 (EDT)
In-Reply-To: <CAMP44s2zTFKeHxp0G1imLXdHfzao_DSY+mkm7awYedwYafFZ+w@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 31 Oct 2013 13:33:34 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0F4261F4-4268-11E3-A084-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237176>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Oct 31, 2013 at 1:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Otherwise we would have to include commit.h.
>>
>> Was there a reason why commit.h is not included here, just like
>> revision.h would include diff.h, so that users of shortlog.h do not
>> have to worry about including commit.h themselves?
>
> Because you can't do:
>
> struct diff_options;
> struct diff_options diffopt;
>
> The storage size is not known, but you can do:
>
> struct diff_options;
> struct diff_options *diffopt;

But so can you do

	struct diff_options *diffopt;

without the declaration, no?  That is:

	$ cat >x.c <<\EOF
        struct foo {
        	struct bar *ptr;
	};

        int foo_is_null(struct foo *foo)
        {
        	return foo == 0;
	}
	EOF
        $ gcc -Wall -c x.c
