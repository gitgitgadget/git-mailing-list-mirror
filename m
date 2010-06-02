From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation: git-mergetool updated to warn against
 builtin tools invocations
Date: Wed, 02 Jun 2010 16:38:32 -0700
Message-ID: <7vbpbt9f9j.fsf@alter.siamese.dyndns.org>
References: <1275501453-13081-1-git-send-email-srabot@steek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sylvain@abstraction.fr,
	David Aguilar <davvid@gmail.com>
To: Sylvain Rabot <srabot@steek.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 01:38:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJxWR-0001Hh-TY
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 01:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933313Ab0FBXip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 19:38:45 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667Ab0FBXin (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 19:38:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C8BB734C;
	Wed,  2 Jun 2010 19:38:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JUwJXdmIwKtuDsnBX1BM759O51Q=; b=Yzb0YZAdnYZVDImO2UEW6aw
	jW7Jld9TWbJSFwyDFp4gZlWenbQBUayLGu4Xq2fa2y+LAFhXDs/TViTHYz7xP2+L
	UsWVtvdtx3oFkmf/us0S2qUvMraI3/tk93WL0M8CBH2Vl2ZTzXKU43FLVIo1D6ZF
	bsgVSN2XJX26MKu4TkqY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lbEw2RlQ6MXQFkAel8Y7R99ejcjlctU0W3qBL5dhqGj90jzWw
	/qFSQautgxZ5CNN1X2ivNwWHdb0dmPwxPcf6H47zdWERQd9s+wjCCUTMTC3XQqRN
	tBQsBG5t9sjy9a2Vjl/lx6VLMi+sJjqoPOTxoyDLjb+0l6BWCzQTBOrxbY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B18AB734B;
	Wed,  2 Jun 2010 19:38:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5EBE5B734A; Wed,  2 Jun
 2010 19:38:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F8855362-6E9F-11DF-B350-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148284>

Sylvain Rabot <srabot@steek.com> writes:

> +Be aware that 'git mergetool' has some predefined invocation commands builtin
> +for known diff tools like meld, diffuse, p4merge ... etc. It means that if
> +you set the merge.tool configuration to one of these tools, the
> +mergetool.<tool>.* configurations will not be taken care of. If you
> +really want to customize the invocation of one of these tools,
> +set `merge.tool` to "custom" or whatever you want and `mergetool.custom.cmd`
> +to "/usr/bin/<tool> $LOCAL $MERGED $REMOTE"

Two half-points and three points (that makes them four in total ;-):

 o If I read the above without "It means that", it still makes sense;

 o "If you really" can go without "really";

 * I had to read "will not be taken care of" twice; "are ignored" is
   probably easier to understand;

 * The description and the example makes it sound as if the command line
   has to have these three tokens in the given order, but the whole point
   of this mechanism is that you can launch whatever external command with
   a custom command line, so "and `mergetool.custom.cmd` to a command line
   to invoke the command.  $LOCAL $MERGED and $REMOTE on this command line
   are substituted by ...." may be more reader-friendly.

 * As a documentation update it is perfectly fine to describe this glitch,
   but I wonder if we might want to lift this restriction (read: consider
   this as a bug and fix it).

> ++
> +-------------
> +[merge]
> +    tool = diffuse-custom
> +[mergetool "diffuse-custom"]
> +    cmd = diffuse $LOCAL $MERGED $REMOTE
> +-------------
> ++

Thanks.
