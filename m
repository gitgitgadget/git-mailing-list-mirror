From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: explain "git branch --with"
Date: Thu, 09 Sep 2010 15:45:13 -0700
Message-ID: <7vhbhyleo6.fsf@alter.siamese.dyndns.org>
References: <4C83FEC3.3040101@gmail.com>
 <7viq2jv05c.fsf@alter.siamese.dyndns.org>
 <AANLkTinDfCkkY_D6F7VepvuNAN1g1hC9UgnqRUjZn88y@mail.gmail.com>
 <AANLkTim4kxpQj_UFOBcwCaVmBFCHun4T9t3O9Zvq3w49@mail.gmail.com>
 <AANLkTinPDUeL2jaY3P17TiA959WH8eOQZ4=CeaHOYuq2@mail.gmail.com>
 <7v39tmtpci.fsf@alter.siamese.dyndns.org> <20100907055209.GT1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 00:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otpwf-0003G7-8A
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 00:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757257Ab0IIWsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 18:48:40 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933259Ab0IIWp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 18:45:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E054D4985;
	Thu,  9 Sep 2010 18:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t08DHSYgkwgWqMDDn5qsGjPq1WA=; b=EQhuoB
	pXMtRSD2QsO7dBIsygaKED5a+BOdUuYWLtuurkCFZDd8rSZhGItFXmUAvjgrqMa1
	0VDq/CbIGscTdGdCaoB3DQW153tNZoVQA7YDVkmGXf0WqakdtEN0MLhtoSlqs04o
	SGgR/GbLdC3Ownk8O0H8UnnJcq0JIc9PuQfOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qC20iPOS0zXkVA+dciQgtJppfNFb8ff9
	C1zU1rZ+IvVNEkvLxp28KvDhFa3iG2/GU86qdzpG3/T9w1Z6mqjlOBu2K8yubGYM
	XvQO9qIWmdJF4XoQ7/SiNCcWZXLcp18+OcxZgiYTOWv1xYSUorxFA5PRkQmvGlVz
	hLtlGHu4dUc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C0173D4984;
	Thu,  9 Sep 2010 18:45:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1404D497B; Thu,  9 Sep
 2010 18:45:15 -0400 (EDT)
In-Reply-To: <20100907055209.GT1182@burratino> (Jonathan Nieder's message of
 "Tue\, 7 Sep 2010 00\:52\:09 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED8C89F0-BC63-11DF-9E61-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155909>

Jonathan Nieder <jrnieder@gmail.com> writes:

> More precisely, it is advertised by "git branch --help-all" but not
> the manual or "git branch -h".

Sorry, but I don't understand what you are trying to say here.  Isn't it
the whole point of distinction between --help-all vs -h (aka
PARSE_OPT_HIDDEN)?

Some interesting findings after a quick "grep" to see which ones are
hidden (potential bugs below might be good for janitors).

* apply --allow-binary-replacement, --binary

  These are always on, and are no-op (even --no-binary is a no-op);
  documented.

* archive -[2-8]

  git-archive manual page mentions -0 thru -9 can be used as "zip backend
  option", while explicitly describing -0 and -9.  "git archive -h" gives
  special description for -1 as well.  Perhaps we should be consistent and
  document -1 in the manual page.
  
* checkout --[no-]guess

  Controls the "dwim 'git checkout x' to 'git checkout -b x remote/x' when
  'x' cannot possibly name anything other than a branch that we copied
  from a remote repository uniquely"; since the dwimming is on by default,
  the only use case is to say --no-guess; not documented.

* clone --naked

  An old name used during the development for the current --bare option;
  not documented.

* commit --allow-empty --allow-empty-message

  Documented; hidden primarily to discourage their uses and also to keep
  output from 'commit -h' short.

* fmt-merge-msg --summary

  An old name used during the development for the current --log option;
  documented.

* grep --help-all, show-ref --help-all

  I do not know why an entry for this needs to be in the struct option []
  for the command.  It is not (and should not be) documented in the manual
  page of the individual commands.

* show-ref -h

  "-h" was meant to be a historical synonym for "--head" (i.e. tells the
  command include HEAD in the output not just under refs/ hierarchy), but
  it seems that we broke it somewhere between v1.6.5 and v1.7.0; it now
  shows the help text.

* write-tree --ignore-cache-tree

  A debugging aid; not documented.


It seems that our use of OPT_HIDDEN or if a hidden option is documented
are not entirely consistent. The "--with" under discussion is similar to
"clone --naked" and "fmt-merge-msg --summary".

I am Ok with a policy to document historical synonyms that are hidden, but
if we were to document them, I suspect that we would need to explicitly
state they are synonyms.  Otherwise, somebody who saw this...

>  --contains <commit>::
> +--with <commit>::
>  	Only list branches which contain the specified commit.

... for the first time is bound to ask what the differences are between
the two.
