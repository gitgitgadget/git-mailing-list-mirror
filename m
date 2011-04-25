From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] diff.c: return filepair from diff_unmerge()
Date: Sun, 24 Apr 2011 18:18:41 -0700
Message-ID: <7vtydnku1a.fsf@alter.siamese.dyndns.org>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
 <1303678289-27627-3-git-send-email-gitster@pobox.com>
 <BANLkTi=fnzRVc8Lx_Wba4yqa7u8t3xGAtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 03:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEASE-0007X8-4G
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 03:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756338Ab1DYBSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 21:18:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab1DYBSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 21:18:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A24DC5B2D;
	Sun, 24 Apr 2011 21:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3bP9ZrVQAF5uftdwYd4f7/eaRZs=; b=ntPD46
	uX26UNB4i9RzUsz+g9eNqhArwjqsIPf3zTwzNb+Cp0657dEkWW72Rb9KkdqkSdEA
	rFA+vgUsyxOwrxdPs4c96Hd0kV1MssQSamVsKVzpqGlkAHLvCyYJWFfruC4tmT8s
	/hoxFgCLpaYp+LR2HlY5rVRLr5tsdCDnbBxGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXbCgA8PstbB/J/oYLCVOUctkoIrq25x
	L5B8TbR6hbS07RRTp1ipHDuLKelKYAkkiXbyOwUHlqmIo0DkKe3QOQGkXnwsikFN
	tSzGq53ZC2L9o2/o3YrQfpVv0jgZoqV1coz2pIdsH5W8jzUz8ndi6qUtA6sT03TG
	BjK21AUfPbE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80A2B5B2A;
	Sun, 24 Apr 2011 21:20:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98DA45B28; Sun, 24 Apr 2011
 21:20:45 -0400 (EDT)
In-Reply-To: <BANLkTi=fnzRVc8Lx_Wba4yqa7u8t3xGAtQ@mail.gmail.com> (Thiago
 Farina's message of "Sun, 24 Apr 2011 19:18:35 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40749E40-6EDA-11E0-AA89-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172011>

Thiago Farina <tfransosi@gmail.com> writes:

> Some unrelated style comments below.
> ...
>> -void diff_unmerge(struct diff_options *options,
>> -                 const char *path,
>> -                 unsigned mode, const unsigned char *sha1)
>> +struct diff_filepair *diff_unmerge(struct diff_options *options,
>> +                                  const char *path,
>> +                                  unsigned mode, const unsigned char *sha1)
>>  {
>
> While you are here, why not write one arg per line?

No, actually I reindented the two lines by accident; I didn't mean to.

>> diff --git a/diff.h b/diff.h
>> index bf2f44d..f51a8ee 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -209,7 +209,7 @@ extern void diff_change(struct diff_options *,
>>                        const char *fullpath,
>>                        unsigned dirty_submodule1, unsigned dirty_submodule2);
>>
>> -extern void diff_unmerge(struct diff_options *,
>> +extern struct diff_filepair *diff_unmerge(struct diff_options *,
>
> While you are here, why not add the argument name |options| here too?
>
>>                         const char *path,
>>                         unsigned mode,
>>                         const unsigned char *sha1);

The patch was meant to be minimum to begin with.  Besides, there is no
risk of confusion from not naming the option in this case, so even if we
were shooting for clean-up, we wouldn't be adding such noise here.  The
other parameters do benefit from descriptive names, so there is no need to
remove the names either.

In other case, your "why not" is totally unwarranted for this hunk.
