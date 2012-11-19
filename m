From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Failure to extra stable@vger.kernel.org addresses
Date: Mon, 19 Nov 2012 15:57:36 -0800
Message-ID: <7vlidxuowf.fsf@alter.siamese.dyndns.org>
References: <20121119095747.GA13552@arwen.pp.htv.fi>
 <20121119151845.GA29678@shrek.podlesie.net>
 <7vk3thxuj2.fsf@alter.siamese.dyndns.org>
 <20121119225838.GA23412@shrek.podlesie.net>
 <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Balbi <balbi@ti.com>, git@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TabDt-00020U-T9
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 00:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab2KSX5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 18:57:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2KSX5j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 18:57:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F696C74;
	Mon, 19 Nov 2012 18:57:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lCTAHldh/jmTQFAn+Fvw7zOEmMc=; b=H5gfob
	XmDPCR34AoA+XbLUiliaHL2SQ+T6TiTH5ev0+7f+Bkvc7BefZ9f3UoDYgDkuvtwF
	3rFi00xHx2uTvsOvEE6oS/rECA7K6h7dHP7BGZTWU6B266vKMe+YEMgr4xIXJ+Tu
	3A8zWoAdQul41al8osvIGwn0lPVTqug+/9dT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rEQKxrQkVCJse0q3UzMkI5lGZ3yKMabP
	nyi9BksPdf0MbRU0mWk6VoZeJS2aLMXr5JsD9tlSRVPlq1BJnKLBfV+8GVnKMiyI
	qnvAPfsJurihnfedMUjr9D/aq7aAQ/pvQbIH3IZo5xJwBT+UoQaL7MJfqH7YdULW
	RaSyDcAri40=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E161A6C72;
	Mon, 19 Nov 2012 18:57:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EF5D6C70; Mon, 19 Nov 2012
 18:57:38 -0500 (EST)
In-Reply-To: <CAMP44s0f0zYa1FVf9RhNuwYJbkQ7zPwgJ6=ty3c5knjo5a2TNw@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 20 Nov 2012 00:12:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E59AA39E-32A4-11E2-AA1F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210066>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Nov 19, 2012 at 11:58 PM, Krzysztof Mazur <krzysiek@podlesie.net> wrote:
>
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -924,6 +924,10 @@ sub quote_subject {
>>  # use the simplest quoting being able to handle the recipient
>>  sub sanitize_address {
>>         my ($recipient) = @_;
>> +
>> +       # remove garbage after email address
>> +       $recipient =~ s/(.*>).*$/$1/;
>> +
>
> Looks fine, but I would do s/(.*?>)(.*)$/$1/, so that 'test
> <foo@bar.com> <#comment>' gets the second comment removed.

Yeah, but do you need to capture the second group?  IOW, like
"s/(.*?>).*$/$1/" perhaps?
