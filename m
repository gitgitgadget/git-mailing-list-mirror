From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Confusing error message
Date: Thu, 14 Jun 2012 16:18:04 -0700
Message-ID: <7vy5npcwk3.fsf@alter.siamese.dyndns.org>
References: <CABURp0qE+qJjyrhRFb8-gWucM0=3TpYwDBsnbCPrZNVe3QGQBQ@mail.gmail.com>
 <7v395xebal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 01:18:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfJIq-0004Ik-VS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604Ab2FNXSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 19:18:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106Ab2FNXSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 19:18:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6AAB942F;
	Thu, 14 Jun 2012 19:18:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hENx8y8QJocY7nay/o35aNnz4Do=; b=wVfAeh
	RPfWJ8TVuhW//y4ZmvAxqNniRCeivyDipQmJlakYS81VR8ck3IhejTU8zp5rcclZ
	LRlxXXVpE8Xpv92gRajmWSiCQdf9zP+8mMaJDTXAp+vTg6MhyyrkrDM0IljIr6oF
	Ng8GYcIPr6SMLyw9H1FWs84YKr8am/+A+Uhu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gno4YBKJkOSR8sR5QdSh6KsIGY8huXoa
	aj6pXNMUjUvMyQIMySnTKeCfTc20t0Ez9+3DBcMsqXPdp8tw/MCZptVFKjsCfLyJ
	W6v+4gPP9J0Uc1suglsGGLzWYwcWxaLtUu8iq3Scm3RoL2RG2sVxuFs3Rx2aNyVQ
	CVhdNiTty4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDDB6942E;
	Thu, 14 Jun 2012 19:18:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54780942D; Thu, 14 Jun 2012
 19:18:06 -0400 (EDT)
In-Reply-To: <7v395xebal.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 14 Jun 2012 16:14:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32912C2C-B677-11E1-86B1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200035>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <phil.hord@gmail.com> writes:
>
>> I messed something up during a rebase in a moved file (probably
>> because I had rename detection turned off).  So now I want to fix it.
>>
>> I think I have the commit amended right, but to be sure I want to diff
>> the old file and the new file.
>>
>>   $ git diff newfile HEAD^:oldfile
>>   fatal: Path 'oldfile' exists, but not 'oldfile'.
>>   Did you mean 'HEAD^:oldfile' aka 'HEAD^:./oldfile'?
>
> You can feed two blob object names to "git diff", but I do not think
> there is any provision to compare a blob object and a file in the
> working tree.

Ah, actually we do have a bolted-on hack to allow you feeding a blob
and a file, but I think you still need to follow the command line
convention of subcommand name (=diff), any dashed options
(e.g. "-R"), any object names (=HEAD^:oldfile) and then finally
pathnames (e.g. "newfile").

Does "git diff -R HEAD^:oldfile newfile" work?
