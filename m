From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Mon, 28 Oct 2013 08:48:44 -0700
Message-ID: <xmqq61shgzvn.fsf@gitster.dls.corp.google.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 16:48:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vap3k-0007TF-OY
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 16:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908Ab3J1Pst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 11:48:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004Ab3J1Psr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 11:48:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6C024E082;
	Mon, 28 Oct 2013 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//j30bb9+MTNwYngmzpXv0yEsFM=; b=W1aRHB
	9Dq4MXVgT3roeur1RkyTVXpcKEaahM1tav1kJQ0FeMnrJdebCYXUYLw+JfspHdjq
	7dOJ8uDHcREQhJV018GXg07T6RG6R9OC4imUV2bPsbHxFrV2+oYgbnbkrdsGT4r7
	sZ4Wfd/EsU/0T6JW+GnCjY79zAGW6pJuzaKxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZ9WU/Fzv13YzzuTMPaz7G1Zod0bJNne
	YB9o+TfkVar9n/9pSDaG5xKjH6zByg22CXrmzHmsVN7WYxMXX3F6Dzs7xr8vNpq4
	sjfaiPIRwJ3UMsMDVD++mRDnE47N1scs0v7aEvpWLtqOWis992MBffio30cj5gn2
	y09ZO1fvgg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 980704E081;
	Mon, 28 Oct 2013 15:48:46 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F233D4E07B;
	Mon, 28 Oct 2013 15:48:45 +0000 (UTC)
In-Reply-To: <CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 26 Oct 2013 17:30:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DE68BC2-3FE8-11E3-BD76-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236836>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Oct 26, 2013 at 6:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * kb/fast-hashmap (2013-10-22) 12 commits
>>  - remove old hash.[ch] implementation
>>  - read-cache.c: fix memory leaks caused by removed cache entries
>>  - name-hash.c: remove cache entries instead of marking them CE_UNHASHED
>>  - name-hash.c: use new hash map implementation for cache entries
>>  - name-hash.c: remove unreferenced directory entries
>>  - name-hash.c: use new hash map implementation for directories
>>  - diffcore-rename.c: use new hash map implementation
>>  - diffcore-rename.c: simplify finding exact renames
>>  - diffcore-rename.c: move code around to prepare for the next patch
>>  - buitin/describe.c: use new hash map implementation
>>  - add a hashtable implementation that supports O(1) removal
>>  - submodule: don't access the .gitmodules cache entry after removing it
>>
>>  Improvements to our hash table to get it to meet the needs of the
>>  msysgit fscache project, with some nice performance improvements.
>>
>>  The preparatory clean-up to submodule from Jens is at the bottom. I
>>  also squashed in a fix-up by Karsten found at $gmane/236468 (please
>>  double-check the result).
>
> jk/pack-bitmap adds khash.h, which from a first glance looks like yet
> another hash table implementation. I was just wondering if kb's new
> hash tables can cover the need of pack-bitmap.c too so we can remove
> khash.h later..

Good thinking ;-).
