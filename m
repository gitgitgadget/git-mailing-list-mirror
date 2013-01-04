From: Junio C Hamano <gitster@pobox.com>
Subject: Re: as/check-ignore (was Re: What's cooking in git.git (Jan 2013,
 #02; Thu, 3))
Date: Fri, 04 Jan 2013 13:13:12 -0800
Message-ID: <7vobh4tzx3.fsf@alter.siamese.dyndns.org>
References: <7vmwwqvzy4.fsf@alter.siamese.dyndns.org>
 <CAOkDyE-f-8XZAzWrQgh_DG=fZctqBFXqpog-FSDU_yeXfwWTwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:19:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrEa7-0000qx-5a
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab3ADVNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:13:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934Ab3ADVNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:13:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280A3AECE;
	Fri,  4 Jan 2013 16:13:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=/73S9yhyDwU3ucFsZT8XiBrhde4=; b=wUq5L8BfiSDhzo7di6rk
	BX9sHWI0NI8nzC7EVfQcIRmQbOjvhfXw0kjLbSW93UgMhCFYOVQ0ElIeLsZrSwXi
	S7cnwIBX0NvrL7qSmWHCehmIRzXNilKBgm4xJXwaWtGlkIybPaaeECzW9O/zGbZp
	PrhbfLDEpwPv95gJsODkeYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=poVn7qiPU3sgbIFaPzV/aWcc7WxaGhf6tg5P+Mbqrdfxzb
	2/P5TjXCiYFCLuX9mgbCdh0hwB1jJ2xf1PPMZ5/l3L6R4bVp01CwMs72rofsZoJH
	c9SJ2EXIJmDtBjlKZ8PagAmkzLpZmlnOYB9Fo+Ema8uehV+ntkbaKVvIgvCNM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1779FAECD;
	Fri,  4 Jan 2013 16:13:15 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63CC7AECC; Fri,  4 Jan 2013
 16:13:14 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D4ADAF0-56B3-11E2-8DA1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212641>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Jan 3, 2013 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * as/check-ignore (2012-12-28) 19 commits
>>  - Add git-check-ignore sub-command
>>  - setup.c: document get_pathspec()
>>  - pathspec.c: extract new validate_path() for reuse
>>  - pathspec.c: move reusable code from builtin/add.c
>>  - add.c: remove unused argument from validate_pathspec()
>>  - add.c: refactor treat_gitlinks()
>>  - dir.c: provide clear_directory() for reclaiming dir_struct memory
>>  - dir.c: keep track of where patterns came from
>>  - dir.c: use a single struct exclude_list per source of excludes
>>  - dir.c: rename free_excludes() to clear_exclude_list()
>>  - dir.c: refactor is_path_excluded()
>>  - dir.c: refactor is_excluded()
>>  - dir.c: refactor is_excluded_from_list()
>>  - dir.c: rename excluded() to is_excluded()
>>  - dir.c: rename excluded_from_list() to is_excluded_from_list()
>>  - dir.c: rename path_excluded() to is_path_excluded()
>>  - dir.c: rename cryptic 'which' variable to more consistent name
>>  - Improve documentation and comments regarding directory traversal API
>>  - api-directory-listing.txt: update to match code
>>
>>  Rerolled.  The early parts looked mostly fine; we may want to split
>>  this into two topics and have the early half graduate sooner.
>
> Sounds good to me.  As already mentioned, I have the v4 series ready
> and it addresses all issues already voiced in v3, but I have postponed
> submitting it as per your request.  Please let me know when and how to
> proceed, thanks!

I was planning to add a new "as/dir-c-cleanup" topic that leads to
f619881 (dir.c: rename free_excludes() to clear_exclude_list(),
2012-12-27), and leave the remainder in this series.  I think the
earlier parts of this series up to that point should go 'next' now.
