From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 3/5] t4205, t6006, t7102: make functions better readable
Date: Fri, 05 Jul 2013 11:45:52 -0700
Message-ID: <7v61wo7sm7.fsf@alter.siamese.dyndns.org>
References: <cover.1373024281.git.Alex.Crezoff@gmail.com>
	<77116508da1bf88e6035cbd657c401cf96b08cbb.1373024281.git.Alex.Crezoff@gmail.com>
	<7va9m07syh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 20:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvB15-0001iF-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 20:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933777Ab3GESp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 14:45:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44648 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3GESpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 14:45:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5EFA2B89C;
	Fri,  5 Jul 2013 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FuhqQdtbog3jlbo1t1t8FcfzALk=; b=kHgdin
	woss9AhEysgAmDmtfBMDOVh9QSHf0+GwQX6FoXPbqFAJDE5mGDKhu+zhUK03hn2r
	XLVkRMOSUjiwoBAmpXlETseIMvPDPQ/H3dCKumBt5LgKXlsfOPbR8+0cToRqXR7f
	FlVfXuE0Tj0vyjsGUNYXzVMDd49rcDhdAwOvo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BOvTdRQp07KN9wKQQ07fe3aISe6mzDn8
	BTKqtdPMx5XX2AhKhVA3mYYFLJLoMl2D7XsdwyBD/gzdZ/WLUKUSglSsTirQaXMS
	r0FM/0iz5fout5hWia+38KzyYaU3t2qEB5QPuHrQaS1g0kGdyG78xdq6/e3PZyVi
	FRDI4y7UXZM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB66F2B89B;
	Fri,  5 Jul 2013 18:45:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E26A2B89A;
	Fri,  5 Jul 2013 18:45:54 +0000 (UTC)
In-Reply-To: <7va9m07syh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 05 Jul 2013 11:38:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F5F404C-E5A3-11E2-88AD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229678>

Junio C Hamano <gitster@pobox.com> writes:

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>
>> -	msg=$(printf "modify 2nd file (ge\303\244ndert)")
>> +	msg="modify 2nd file (ge\303\244ndert)"
>>  	if test -n "$1"
>>  	then
>> -		msg=$(echo $msg | iconv -f utf-8 -t $1)
>> +		print "$msg" | iconv -f utf-8 -t "$1"
>> +	else
>> +		print "$msg"
>>  	fi
>> -	echo $msg
>>  }
>
> I think I'll do s/print/&f/ before queuing this.

Also, I'll change the $msg constant to have \n at the end, as we are
losing it by bypassing "echo".
