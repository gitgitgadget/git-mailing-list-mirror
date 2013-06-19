From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 18:23:51 -0400
Message-ID: <51C22F77.8050004@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <7vhagu10ql.fsf@alter.siamese.dyndns.org> <51C203A1.4000404@bbn.com> <7vtxktyfo1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 00:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQnQ-0008Nb-Fq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 00:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934Ab3FSWXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 18:23:55 -0400
Received: from smtp.bbn.com ([128.33.0.80]:61522 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934961Ab3FSWXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 18:23:54 -0400
Received: from socket.bbn.com ([192.1.120.102]:40604)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpQnA-000Flr-B3; Wed, 19 Jun 2013 18:23:52 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 1644640665
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vtxktyfo1.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228430>

On 2013-06-19 17:05, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
>> On 2013-06-19 13:14, Junio C Hamano wrote:
>>> <object-type>-ish does not have anything to do with a ref.  Even
>>> when an object is dangling in your object store without being
>>> reachable from any of your refs, it keeps its own "ish"-ness.
>>
>> Ah, so your personal definition of "ref" matches my personal definition
>> of "ref", and this definition doesn't match gitglossary(7).  :)
> 
> Huh?  The only thing I I said was that "*-ish" does not have
> anything to do with a ref.  I didn't say anything about definition
> of "ref".

The phrase

    when an object is dangling in your object store without being
    reachable from any of your refs

implies something about your definition of a ref that is inconsistent
with gitglossary(7).  See below.

> 
> You are the one who brought "ref" into description of *-ish, with
> this:
> 
>> +[[def_committish]]committish (also commit-ish)::
>> +	A <<def_ref,ref>> pointing to an <<def_object,object>> that
>> +	can be recursively dereferenced to a

And I did that to be consistent with the definition of tree-ish, which
currently says:

    tree-ish
        A ref pointing to either a commit object, a tree object, or a
        tag object pointing to a tag or commit or tree object.

Notice the term "ref" in the above definition.  This definition says
that a tree-ish is a particular kind of ref -- NOT a property of an
object as you claim.  I'm not saying you're wrong -- I actually agree
with you completely -- I'm just saying that your definition of ref
doesn't match the definition of ref in gitglossary(7).

The current definition of ref says:

    ref
        A 40-byte hex representation of a SHA-1 or a name that denotes
        a particular object.  They may be stored in a file under
        $GIT_DIR/refs/ directory, or in the $GIT_DIR/packed-refs file.

Depending on how one interprets "name" (which is not defined in
gitglossary(7)) in the above definition of ref, claiming that
"master:README" is a ref is consistent with gitglossary(7).  It is NOT,
however, consistent with what you -- or anyone else I know -- think of
as a ref.

> 
> All I am saying is that an object does not have to be pointed by any
> ref to be any-ish.  ish-ness is an attribute of an object, not an
> ref.  You do not say refs/heads/master (which is a ref) is a
> commit-ish or a tree-ish.  The object pointed at by that ref is
> always a commit and is a commit-ish and a tree-ish.

I understand and agree completely and always have.

Here's what I'm trying to say:

  * Given the current definition of "ref" in gitglossary(7), claiming
    that a foo-ish is a ref is not entirely incorrect.
  * If the definition of "ref" is altered to match the general
    understanding of a "ref", then claiming that a foo-ish is a ref is
    wrong.  Very wrong.

I was trying to be minimal and consistent with my changes, but
unfortunately it seems like more changes are necessary.  When I next
have time, I'll send some revised patches to include the following changes:

  * replace the current definition of "ref" with something that matches
    general understanding
  * eliminate the use of "ref" in the definitions of tag object, tree
    object, and tree-ish
  * create a term that means "a thing understood by rev-parse that
    uniquely identifies an object" (perhaps "object specifier"?) that
    can be used in gitglossary(7) and elsewhere

-Richard
