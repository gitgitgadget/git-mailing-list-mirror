From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 13:09:09 -0700
Message-ID: <7vocf0chwa.fsf@alter.siamese.dyndns.org>
References: <2251bbc1e40505dcb80103bf5daebea07dc0e9f7.1277374210.git.git@drmicha.warpmail.net> <vpqmxukir3e.fsf@bauges.imag.fr> <4C2355EF.7030604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsjv-0002nJ-SF
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249Ab0FXUJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:09:27 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48205 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0FXUJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:09:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF67CBE9A2;
	Thu, 24 Jun 2010 16:09:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ij6+3GplVLjtLH2NYtoCFkFZZAY=; b=VLdpaA
	C6vezGHSugQvdCC4qG058OGfJEVr2hWtwGr7FkW2a7g6xATl7dtRD6M609H2Qd6n
	yI9iwzdd6QvRMmJXK2BNbxPZSZu8JV/TTXOzOtrBN2OyHu/pFs29vlsJ2Nh8ro03
	r2U/geUIuxT1vz5C5CSXAe0qiVMHpAtabv4NU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bsZVMHYlwAPpnrgE2RAMSrpqrg+/X9a1
	JJykD/7Nm3cYhbqjSNe9cEQrkW8WxUfJiIS5yW31sJ9wh+b5OK1XNMEzHS8B3XCq
	vFqw4jnYd46CNyukLTLL1+XIs5XvYsSyXwKvw4+08vJuXKzlz/++mK4+xfIA+08e
	vpIwdS82ddU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FE69BE99A;
	Thu, 24 Jun 2010 16:09:18 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E13FCBE998; Thu, 24 Jun
 2010 16:09:10 -0400 (EDT)
In-Reply-To: <4C2355EF.7030604@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu\, 24 Jun 2010 14\:56\:15 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5EAF1A6E-7FCC-11DF-9691-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149631>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Wait a minute:
>
> git show HEAD:path >a
> git show :path >b
> diff a b
>
> Oh no! We've been having this all along. This is bad but probably
> unchangeable.

There is nothing "bad" about this, unless you forgot about the index.
The comparision target of "git diff" defaults to the index, not HEAD, if
you want other precedents.

If you kept telling others that "everything defaults to HEAD", it is
indeed bad, but that can be fixed ;-).

> I was going with the usage line, but you are right: <a>:<b> makes more
> sense semantically and is clearer.
>> 
>> What about this:
>> 
>> --textconv:: 
>> 	Show the content as transformed by a textconv filter. In this
>> 	case, <object> has be of the form <treeish>:<path>, or :<path>
>> 	to run the filter on the file <path> stored in the index.
>
> I'll be more mathematically stubborn about "file", see v2;)

If you want to be mathematically stubborn, then I think you should prefer
<path> in a context like this, since <treeish>:<path> is the notation to
reach to a <blob> inside the treeish.  <file> is merely one of the two
possible manifestations of <blob> when it is accessed through the tree
that immediately contains it (other being <symlink>).

Most importantly, "cat-file blob <blob>" codepath has nothing to do with
that "should this <blob> materialize as a <file> or a <symlink>?" logic,
so saying <file> is doubly wrong in this context.
