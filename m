From: Mark Dominus <mjd@icgroup.com>
Subject: Re: [PATCH] document 'T' status from git-status
Date: Sun, 30 Oct 2011 16:34:35 -0400
Message-ID: <4EADB4DB.5020004@icgroup.com>
References: <1319933204-21587-1-git-send-email-mjd@plover.com>
 <7vmxcjro5t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Dominus <mjd@plover.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 21:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKc5q-0004uu-TA
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 21:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab1J3Ueq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 16:34:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033Ab1J3Uep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 16:34:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E49D5189;
	Sun, 30 Oct 2011 16:34:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=hq6VT353kgWa
	HgZJF++1Uj9Eipc=; b=hy/nnOpqxqNvdrBeN3NF25sFbxQAo5evslazD/4Q6/Zo
	usWMMJ93GZNDPRSSfn9QieV7+e/CGWJcRFdQyaFOz3qcT/FiaoBnA0pCceFcwuS0
	y0BMKC8Aj//Vr2dvT67vWYja0EJH6GkH99tQKux8cRWcw9WgZRHXoL7iksgfn/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6656F5188;
	Sun, 30 Oct 2011 16:34:44 -0400 (EDT)
Received: from [10.80.10.81] (unknown [66.92.52.243]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPA id 2ADE65186; Sun, 30 Oct 2011
 16:34:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23)
 Gecko/20110921 Thunderbird/3.1.15
In-Reply-To: <7vmxcjro5t.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: 99D7CDFE-0336-11E1-B352-9DB42E706CDE-09857176!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184477>

On 10/30/2011 02:25 AM, Junio C Hamano wrote:
> Mark Dominus<mjd@plover.com>  writes:
>
>
>> +* 'T' = file type changed
>> +  (typically from plain file to symlink, or vice versa)
>>
>>   Ignored files are not listed, unless `--ignored` option is in effect,
>>   in which case `XY` are `!!`.
>> @@ -134,9 +136,11 @@ in which case `XY` are `!!`.
>>       D         [ M]   deleted from index
>>       R        [ MD]   renamed in index
>>       C        [ MD]   copied in index
>> +    T        [ MD]   file type changed in index
>>       [MARC]           index and work tree matches
>>       [ MARC]     M    work tree changed since index
>>       [ MARC]     D    deleted in work tree
>> +    [ MARC]     T    file type changed in work tree
> The current organization of this table may need to be rethought, but if we
> were to keep it, then this change is far from sufficient. For example, you
> do not explain what XY = TT means.
Thanks for your response.

I did not try to document that because in my experimenting I was not 
able to produce that situation.  T occurs when the filetype (as reported 
by the IS_FMT macro) is different between the two files.  On systems I 
have available, there are essentially five filetypes:  plain file, 
symlink, directory, block and character devices.  Directories are 
handled separately and are not reported by git-status.  Device files 
cannot be added to the index at all.  That leaves only two possible 
filetypes, so of the three files (the committed version, the cached 
version, and the working tree version) two must be the same.

I am aware that on some systems other filetypes may exist.  For example, 
HPUX has an 'H' filetype that is a variant of a directory.  But git 
would treat this as a directory.  Since I was not aware of any situation 
in which TT could arise, I did not try to document it.

Will you be applying the alternative patch you suggested, or would you 
prefer that I try to produce one along those lines?
