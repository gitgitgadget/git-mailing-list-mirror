From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: add vimdiff3 mode
Date: Tue, 22 Apr 2014 10:30:28 -0700
Message-ID: <xmqq7g6h6zm3.fsf@gitster.dls.corp.google.com>
References: <1398039860-31420-1-git-send-email-felipe.contreras@gmail.com>
	<20140422050142.GB60610@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 19:30:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WceWw-0008Qd-4n
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 19:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933571AbaDVRai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 13:30:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50259 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273AbaDVRac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 13:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8CF37F30E;
	Tue, 22 Apr 2014 13:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F0ghKSLVTyxMj/c3GmkfmnJki1E=; b=adA8ak
	aweNYnLI3rfRKLy4W+txGUDL3XRAWH47fAWNRHiK0S1MwahYK1Jz9TV8RB26yKbk
	1/B04VQfNXFuC1Z4Xv8RPOYvO4uYtl13x7z4GZ1RrGfwEChkO/hbelESykMMCLHh
	3jG+q7FcPpl59r/yITH5VyNQjDQkY2GLkwnXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O4lARzy68sBJEoEzUuq3vzCasg9mgaIb
	nXYfu+7Eo6limuH987eVTtCKQDyUsaXD9e0fuKKeE3FFDFtydRBQf3wfNyvK1Idc
	1MKK2nd7Bb9u8AqFODDd0ohZ+gsDy2bn5M7MyYhm814/D2aNwn6QXT6OthCHdbw1
	xiWEiQvjgV4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D47527F30D;
	Tue, 22 Apr 2014 13:30:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F03CA7F30C;
	Tue, 22 Apr 2014 13:30:29 -0400 (EDT)
In-Reply-To: <20140422050142.GB60610@gmail.com> (David Aguilar's message of
	"Mon, 21 Apr 2014 22:01:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CCE421D0-CA43-11E3-9709-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246755>

David Aguilar <davvid@gmail.com> writes:

> On Sun, Apr 20, 2014 at 07:24:20PM -0500, Felipe Contreras wrote:
>> It's similar to the default, except that the other windows are hidden.
>> This ensures that removed/added colors are still visible on the main
>> merge window, but the other windows not visible.
>> 
>> Specially useful with merge.conflictstyle=diff3.
>
> This is a nice addition, thanks.
>
> FWIW,
> Acked-by: David Aguilar <davvid@gmail.com>

Thanks for an explicit Ack.

I personally think a new backend vimdiff3 can go in 2.0 (though we
are -rc0), as we can read from the patch below, it is very unlikely
to break anything else (I am not sure what these 'hid' are in the
implementation, but even if we had any breakage there, it would not
affect anybody other than vimdiff3 backend).

>> 
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> 
>> How a conflict looks:
>> http://felipec.org/vimdiff3-conflict.png
>> 
>> How it looks resolved:
>> http://felipec.org/vimdiff3-resolved.png
>> 
>>  mergetools/gvimdiff3 |  1 +
>>  mergetools/vimdiff   | 14 ++++++++++++--
>>  mergetools/vimdiff3  |  1 +
>>  3 files changed, 14 insertions(+), 2 deletions(-)
>>  create mode 100644 mergetools/gvimdiff3
>>  create mode 100644 mergetools/vimdiff3
>> 
>> diff --git a/mergetools/gvimdiff3 b/mergetools/gvimdiff3
>> new file mode 100644
>> index 0000000..04a5bb0
>> --- /dev/null
>> +++ b/mergetools/gvimdiff3
>> @@ -0,0 +1 @@
>> +. "$MERGE_TOOLS_DIR/vimdiff"
>> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
>> index 39d0327..1ddfbfc 100644
>> --- a/mergetools/vimdiff
>> +++ b/mergetools/vimdiff
>> @@ -20,16 +20,26 @@ merge_cmd () {
>>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>>  			"$LOCAL" "$MERGED" "$REMOTE"
>>  		;;
>> +	gvimdiff3|vimdiff3)
>> +		if $base_present
>> +		then
>> +			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
>> +				"$LOCAL" "$REMOTE" "$BASE" "$MERGED"
>> +		else
>> +			"$merge_tool_path" -f -d -c 'hid | hid' \
>> +				"$LOCAL" "$REMOTE" "$MERGED"
>> +		fi
>> +		;;
>>  	esac
>>  	check_unchanged
>>  }
>>  
>>  translate_merge_tool_path() {
>>  	case "$1" in
>> -	gvimdiff|gvimdiff2)
>> +	gvimdiff|gvimdiff2|gvimdiff3)
>>  		echo gvim
>>  		;;
>> -	vimdiff|vimdiff2)
>> +	vimdiff|vimdiff2|vimdiff3)
>>  		echo vim
>>  		;;
>>  	esac
>> diff --git a/mergetools/vimdiff3 b/mergetools/vimdiff3
>> new file mode 100644
>> index 0000000..04a5bb0
>> --- /dev/null
>> +++ b/mergetools/vimdiff3
>> @@ -0,0 +1 @@
>> +. "$MERGE_TOOLS_DIR/vimdiff"
>> -- 
>> 1.9.2+fc1.1.g5c924db
