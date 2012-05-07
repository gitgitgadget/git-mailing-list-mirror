From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git fetch/pull stopped working
Date: Mon, 07 May 2012 16:44:23 -0700
Message-ID: <7vehqv36aw.fsf@alter.siamese.dyndns.org>
References: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Egor Ryabkov <egor.ryabkov@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 01:44:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRXbT-0000dl-HX
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 01:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab2EGXo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 19:44:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889Ab2EGXo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 19:44:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A4057F27;
	Mon,  7 May 2012 19:44:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9KV+r3QVVscj/okDjE1cSI4+vEE=; b=f/ni5B
	H2x3oOya8fO8sfOjLtvOcwAXx2md0spt8CN1k9EY5MmSGMEl8I1RunXNulAJyi54
	yj26KdG2PjgMdHSfSrdvn5XiOytd/ZXYLpDGxZSyYIWs03sl77OgBGk/nB0WPQhC
	9Kr5FQne9ZDnjzMDK+uSJoF+nYlX3wK+m+Ne4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i+FLmx0MC6+udNVsoVXPO6/nI8Ghajxk
	BQ7cnXgcumjfqKsilG0QTsUxT54YFhCbEexddD2fU+E7FXHnkTSZdwZw6rdDsPj3
	dhZTkpmLZ+EEzVrLV6aA2lVwOzNRybO3qyPwVaUeGiKIlzPp72BLtC+oKQCgmuKl
	ZOsXTXUdPqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60F547F26;
	Mon,  7 May 2012 19:44:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E88EB7F22; Mon,  7 May 2012
 19:44:24 -0400 (EDT)
In-Reply-To: <CADB4Qb1BhWpm1mAwiHy+edySvo7P+YcvrSiTSc8dVzKQsnNCfQ@mail.gmail.com> (Egor
 Ryabkov's message of "Tue, 8 May 2012 02:45:08 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93CAF76C-989E-11E1-83C0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197327>

Egor Ryabkov <egor.ryabkov@gmail.com> writes:

> git fetch and pull stopped working a few days ago on my server with
> the following message:
>
> $ git fetch
> ERROR: Repository not found.
> fatal: The remote end hung up unexpectedly

Are you sure it is an error on the remote side (presumably on GitHub)?

More interestingly, neither "Repository not found" nor "ERROR:" hits
anything relevant to "git fetch" codepath.  The closest I can find is in
http-backend.c that says "Repository not exported", which is on the server
side, but you were talking about ssh connection, so it probably is not
what you are seeing.

Oh, wait.

> "$ GIT_TRACE=1 git fetch" gives somewhat different output on local PC
> and server:
> http://pastecode.com/bd3fc1a79f8e9d1eaf30911d9895938051c472f4

So you are going over http:// after all.  But it does not look like github
to me, so you may be comparing apples and oranges, which would not help in
diagnosing the issue very much.

Puzzled...
