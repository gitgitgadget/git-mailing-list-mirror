From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t/diff-lib: check exact object names in compare_diff_raw
Date: Mon, 23 Feb 2015 11:45:30 -0800
Message-ID: <xmqq385wtns5.fsf@gitster.dls.corp.google.com>
References: <1424043824-25242-1-git-send-email-gitster@pobox.com>
	<1424043824-25242-6-git-send-email-gitster@pobox.com>
	<54EB6E17.5040102@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:45:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPywl-00050m-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbbBWTpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:45:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752158AbbBWTpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:45:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1248439CEE;
	Mon, 23 Feb 2015 14:45:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CszKQA34/eCfMK2vIWqhJFNl/7U=; b=lO+c+t
	9xzFCAHqltPAHacBqiylZa1DM4ihl5JkfLz1CI95i1xxXzsq+T8vZpJKz2unOH+O
	0PN4ebDdonEBIbYFMu2e6XC8IePCFRUnaKeczqEqiAn5ghJZzLceX3tjDbNcJVO2
	5+kG3NR37sgAsLK1WzMQsjpRCrFSOTJze3Tcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ITQmkEEOJXOPY3xO1D807kNMi5NMGnVn
	VR2R3GdX0VnGPSmnpw0CZCsdzCZFdV2k2gWIchJi/2zYgWQBH1wyH0wcwYIWgjbM
	w5+MjY5+Py8mphm4ZRUKYf9XKt5CDhcs99SFns8c2G8CEMwgjChjcHGhtSfGIh9w
	UiVGPx3qZoI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D5D39CED;
	Mon, 23 Feb 2015 14:45:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 44B4B39CD9;
	Mon, 23 Feb 2015 14:45:32 -0500 (EST)
In-Reply-To: <54EB6E17.5040102@kdbg.org> (Johannes Sixt's message of "Mon, 23
	Feb 2015 19:14:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 870754AA-BB94-11E4-A2DA-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264291>

Johannes Sixt <j6t@kdbg.org> writes:

>> diff --git a/t/diff-lib.sh b/t/diff-lib.sh
>> index 75a35fc..c211dc4 100644
>> --- a/t/diff-lib.sh
>> +++ b/t/diff-lib.sh
>> @@ -1,6 +1,6 @@
>>   :
>>   
>> -sanitize_diff_raw='/^:/s/ '"$_x40"' '"$_x40"' \([A-Z]\)[0-9]*	/ X X \1#	/'
>> +sanitize_diff_raw='/^:/s/ '"\($_x40\)"' '"\($_x40\)"' \([A-Z]\)[0-9]*	/ \1 \2 \3#	/'
>>   compare_diff_raw () {
>>       # When heuristics are improved, the score numbers would change.
>>       # Ignore them while comparing.
>> 
>
> This reveals a minor bug in test_ln_s_add:

Thanks for catching it before it hits 'master'.
