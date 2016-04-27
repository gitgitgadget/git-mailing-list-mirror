From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2016, #07; Mon, 25)
Date: Wed, 27 Apr 2016 09:29:59 -0700
Message-ID: <xmqqmvof9fqw.fsf@gitster.mtv.corp.google.com>
References: <xmqqoa8xia1j.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1604271454250.2896@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:30:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSLv-00022I-0o
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbcD0QaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:30:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753416AbcD0QaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:30:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 656CA15A64;
	Wed, 27 Apr 2016 12:30:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ddq43DpPXm89YeyPo603+SgU+lQ=; b=hZ/nkH
	inH5fTewj/8DJxrvNypvS8XEdLQjFtV29liGtItH84PXYQ+eNjEP1yHt25z168Ni
	lvzFjHRjIOHLrdFp1L4lUJERO9o33Hd7mWbR6RDhh4HWqq1rZ7uqgRedygOWb2Cv
	GKpNUshTMOal3Yz8ZEZ2+XKbQSmq5P6azWe7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YgMF/h58i236JErwP/HzZ6+X7tVbuLM/
	fhXo92QgeFUQQabPUxqVN+bmWeVtuSJtd83AlEiTTzyMej53G+na93XC3T+CH6m+
	V3KhiFi7Zu/0Wg0O11ANQraqF31liSR/4pxOL7Kw7ROcfzWBpR2elmdjpX4HD+tm
	O8YwyMxGfy8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8CC115A60;
	Wed, 27 Apr 2016 12:30:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C00B115A5B;
	Wed, 27 Apr 2016 12:30:01 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1604271454250.2896@virtualbox> (Johannes
	Schindelin's message of "Wed, 27 Apr 2016 14:56:27 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4A5373EC-0C95-11E6-9F1C-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292742>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 25 Apr 2016, Junio C Hamano wrote:
>
>> * js/win32-mmap (2016-04-22) 3 commits
>>   (merged to 'next' on 2016-04-22 at cd39c60)
>>  + mmap(win32): avoid expensive fstat() call
>>  + mmap(win32): avoid copy-on-write when it is unnecessary
>>  + win32mmap: set errno appropriately
>> 
>>  mmap emulation on Windows has been optimized.
>
> Please note that it is not purely an optimization. It is also a bug fix in
> case of a pretty full disk: on Windows, mmap() is backed by the page file
> if it is in copy-on-write mode, and that can fail when the free space on
> the drive that has the page file drops below a certain threshold.

Thanks.  How does this look then?

    * js/win32-mmap (2016-04-22) 3 commits
      (merged to 'next' on 2016-04-22 at cd39c60)
     + mmap(win32): avoid expensive fstat() call
     + mmap(win32): avoid copy-on-write when it is unnecessary
     + win32mmap: set errno appropriately

     mmap emulation on Windows has been optimized and work better without
     consuming paging store when not needed.

     Will merge to 'master'.

Reducing paging file consumption still falls into optimization in my
dictionary, though ;-)
