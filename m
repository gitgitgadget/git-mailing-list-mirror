From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Aborting "git commit --interactive" discards updates to index
Date: Sun, 08 Jan 2012 16:41:39 -0800
Message-ID: <7v62glg118.fsf@alter.siamese.dyndns.org>
References: <CANgJU+X+qLe3Aqy_ZpoSDKMuf=8=OxVvpkt0tGmSi=KVgti3HQ@mail.gmail.com>
 <7vvcoogkw8.fsf@alter.siamese.dyndns.org>
 <CANgJU+WGEBMMQzsGyQSnMBK3Q8Z2XZdbDx4nr-tB-s0uYEU9CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 01:41:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rk3J7-00008y-5u
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 01:41:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2AIAln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 19:41:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891Ab2AIAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 19:41:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4C4175B1;
	Sun,  8 Jan 2012 19:41:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zdaVd97b09GayDFkxto1vbhlZto=; b=vvoDZ2
	/c7qwh36x/nzUd5iGx+bDQ5c6Ew2acKwoz7Uq+2Yl/0FMylPuDnwgXTyBN1WI7V0
	2MVTt+221HlNpJCbckIHsZTd8k/2A8413/ECXvDUrvzbHy0ifartF7yXhhJ0hxQV
	p8lz7jFc0bQ4T7LBesz4JQsGUiIiYooGhiWxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JWn7P8lVLwphYjhbDoSWZHEcOnCHNtz/
	9D6kgpJrkd+gYRrhzbhwVQth+gbA1IlGL/lm0h+jkfe6BJCV9mwgWSpux1+0EshR
	ZJwZjo8gFFdxOaFbud/v9zkt6mHaoG9nEtGJzbL/TN8A4xDyGjaZf682+kY2p82z
	9LCZXzlhKWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCBCB75B0;
	Sun,  8 Jan 2012 19:41:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5343F75AF; Sun,  8 Jan 2012
 19:41:41 -0500 (EST)
In-Reply-To: <CANgJU+WGEBMMQzsGyQSnMBK3Q8Z2XZdbDx4nr-tB-s0uYEU9CQ@mail.gmail.com>
 (demerphq@gmail.com's message of "Sat, 7 Jan 2012 15:16:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2784A22-3A5A-11E1-9CF6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188152>

demerphq <demerphq@gmail.com> writes:

> On 7 January 2012 06:08, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> You are welcome to rehash the age old discussion, though. Personally I do
>> not care very deeply either way. I would never use "commit --interactive"
>> myself, and I would not encourage others to use it, either, even if we do
>> not worry about the behaviour when a commit is aborted.
>
> If I were to provide a patch to make this behavior configurable would
> you have any objections?

You are welcome to rehash the discussion.

I am not a dictator and will listen to other people on the list for their
opinions, and I cannot say if such a patch will be accepted or not without
seeing how well it is done.

>> ... off to run "git add -i" to prepare the index, "git stash save -k" to check
>> out what is to be committed (and stash away what are to be left out) so
>> that you can make sure what you are committing is what you thought are
>> committing (by asking "git diff" and "make test" for example), and after
>
> Isnt this what the diff option in commit interactive is for?

Not at all.

That is to help the user incrementally in the process and not a
replacement for the final eyeballing of the result.

Neither the patch shown in "commit -v", whose primary purpose is to aid
the user to write a better log message.
