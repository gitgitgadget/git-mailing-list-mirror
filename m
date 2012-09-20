From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] new git check-ignore sub-command
Date: Thu, 20 Sep 2012 14:43:53 -0700
Message-ID: <7vsjac8j52.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <7v4nms9yja.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:44:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEoXV-0004zp-Hc
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 23:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab2ITVn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 17:43:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52247 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755882Ab2ITVn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 17:43:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62B168E8F;
	Thu, 20 Sep 2012 17:43:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EH6p+B15bfhKBaKvyslAWb/selE=; b=X7pC58
	XjvDA+YsXgdUPRErY5xNipAlbodvx7C54zfIiAvZj6mcb9GsG+mi5d1pIOfVtyUI
	ZtFuGgI8Jadw+aicDKubcgGj2UsQCmWzmZOCyOnUjfhkhsSdoUMgG6m/6fzye4CC
	Zy+7Aq/J8ab2WZKjjUIRUtRweyXSdi1/f6/xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OAyqZxdy24Idtb/wJ2nybsuN/4OlXXFi
	kAxlKxKGKxqFFFBPQ2cQSKWpd6+WIiyDYBlMbW//i5CNgELay6iX9eHH6BsUN24S
	q8a4ROMj2qy8mbHOX578tNZHbtCL4YD+6LS7hcotFoeWzCf69gW6+J+WscHUqDcx
	HTeZzZzH4Sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5083E8E8E;
	Thu, 20 Sep 2012 17:43:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD16E8E82; Thu, 20 Sep 2012
 17:43:54 -0400 (EDT)
In-Reply-To: <7v4nms9yja.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Sep 2012 14:26:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46690796-036C-11E2-9BFA-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206098>

Junio C Hamano <gitster@pobox.com> writes:

> Adam Spiers <git@adamspiers.org> writes:
>
>> Adam Spiers (14):
>>   Update directory listing API doc to match code
>>   Improve documentation and comments regarding directory traversal API
>>   Rename cryptic 'which' variable to more consistent name
>>   Rename path_excluded() to is_path_excluded()
>>   Rename excluded_from_list() to is_excluded_from_list()
>>   Rename excluded() to is_excluded()
>>   Refactor is_excluded_from_list()
>>   Refactor is_excluded()
>>   Refactor is_path_excluded()
>>   For each exclude pattern, store information about where it came from
>>   Refactor treat_gitlinks()
>>   Extract some useful pathspec handling code from builtin/add.c into a
>>     library
>>   Provide free_directory() for reclaiming dir_struct memory
>>   Add git-check-ignore sub-command
>
> Please retitle these to have a short "prefix: " that names a
> specific area the series intends to touch.  I retitled your other
> series to share "test :" as their common prefix.

Just to clarify, I think most of them can say "dir.c: ".

I saw quite a few decl-after-statement in new code.  Please fix
them.

As to the "who owns x->src and when is it freed" question, it may
make sense to give el a "filename" field (command line and other
special cases would get whatever value you deem appropriate, like
NULL or "<command line>"), have x->src point at that field when you
queue many x's to the el in add_exc_from_file_to_list().  Then when
you pop an element in the exclude_stack, you can free el->filename
to plug a potential leak.

Also I do not see why you need to have the strdup() in the caller of
add_excludes_from_file_to_list().  If you need to keep it stable
because you are copying it away in exclude or excludde_list,
wouldn't it make more sense to do that at the beginning of the
callee, i.e. add_excludes_from_file_to_list() function?
