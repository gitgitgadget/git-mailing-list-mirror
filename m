From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] adds --date=raw support to git blame and related
 documentation
Date: Mon, 23 Feb 2009 17:35:20 -0800
Message-ID: <7v3ae4pqg7.fsf@gitster.siamese.dyndns.org>
References: <1235379429-20934-1-git-send-email-eletuchy@gmail.com>
 <7vprh9t6xt.fsf@gitster.siamese.dyndns.org> <49A2E170.9030807@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "eletuchy@gmail.com" <eletuchy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: eugene@facebook.com
X-From: git-owner@vger.kernel.org Tue Feb 24 02:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbmEC-0001q5-Dr
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 02:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbZBXBf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 20:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753843AbZBXBf2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 20:35:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbZBXBf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 20:35:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A569D2BCAE;
	Mon, 23 Feb 2009 20:35:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAD492BCAB; Mon,
 23 Feb 2009 20:35:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 68FB3076-0213-11DE-B2A0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111193>

Eugene Letuchy <eletuchy@facebook.com> writes:

> On 2/23/09 9:10 AM, Junio C Hamano wrote:
>> eletuchy@gmail.com writes:
>>
>>> From: Eugene Letuchy<eugene@facebook.com>
>>>
>>> In the wake of Linus' 7dff9b3, git blame --date support needs to
>>> incorporate --date=raw in addition to the previously supported
>>> date formats.
>>
>> Thanks, but I do not understand what you meant by the following two lines:
>>
>>> Test:>  git grep relative | grep iso | grep -v raw
>>>        >  git blame --date=raw builtin-blame.c
>>
>> With the patch to add --date=raw format already on 'master', I'd prefer a
>> reroll of the original patch (it needs a fix for the config "don't ignore
>> a misconfiguration" bug Peff pointed out anyway) with this documentation
>> update patch squashed in.
>>
>
> Yeah I can do that.

Thanks.

>>> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
>>> index e6717af..1316d4e 100644
>>> --- a/Documentation/blame-options.txt
>>> +++ b/Documentation/blame-options.txt
>>> @@ -36,7 +36,7 @@ of lines before or after the line given by<start>.
>>>   	Show long rev (Default: off).
>>>
>>>   -t::
>>> -	Show raw timestamp (Default: off).
>>> +	Synomym for --date=raw (Default: off).
>>
>> This is interesting.  It suggests that we should internally get rid of
>> show_raw_time variable (and need to error out when --date= and -t options
>> are given at the same time, as they are mutually incompatible).
>>
>> But do -t and --date=raw really behave identically?  I think they should
>> but I didn't check.
>>
>
> The output of -t and --date=raw are exactly identical (well, after
> this patch they are); for that reason, I think providing both is
> redundant but not an error. However, I wanted to retain -t for "git
> annotate" compatibility, which has -t as the sole date option. In
> git-annotate mode, no other --date mode options can apply.

Oh, I didn't mean combination of -t and --date=raw.  Consider a
combination such as -t and --date=iso given together.

The removal of show_raw_time would be a good idea if -t and --date=raw
are meant to be identical, right?
