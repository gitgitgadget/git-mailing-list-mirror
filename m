From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Fri, 03 Feb 2012 10:27:56 -0800
Message-ID: <7vty37rcur.fsf@alter.siamese.dyndns.org>
References: <CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com>
 <21056.1328185509@redhat.com>
 <9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
 <15281.1328207789@redhat.com> <4681.1328276820@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Valerie Aurora <valerie.aurora@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 19:28:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtNri-0004j0-74
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 19:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683Ab2BCS2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 13:28:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2BCS17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 13:27:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9B0740E1;
	Fri,  3 Feb 2012 13:27:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dJBG8rX+d7s/FUDPQWBk8noGxxA=; b=FBvevA
	rmesqL/rt0Hp2s+mxvghk3NpO15G6hZRqqVhMyJz8dc5NwvSLQq2e7nANpZNquM5
	75De5rw4tT10x/x+q45u3kXQIlHqfwre8s6KLZ5EHXzZNBCVQ03TDzKkdW/ONi8w
	T3TGUleWVxKx8IgMBFW/YZYMPbFZT9IdmWSW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nZE1d/F4RGvhsJ5LdqW1GGwvCoTqDZi3
	+VeKMU1bUmT20wBIkC3EM7t5NbrqAQbTYa+I9aW+6X/JOEKP18WoZim0a2fcM0u8
	jRonWdu7EEVe0+oDwXexNQiqG9BG0bl9gNuDt7AGcM0dKWkTkkzPtChonOVuhN29
	yzQuYYpODrs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E07F140E0;
	Fri,  3 Feb 2012 13:27:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5762A40D4; Fri,  3 Feb 2012
 13:27:58 -0500 (EST)
In-Reply-To: <4681.1328276820@redhat.com> (David Howells's message of "Fri,
 03 Feb 2012 13:47:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC1234C2-4E94-11E1-B8AB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189790>

David Howells <dhowells@redhat.com> writes:

> Valerie Aurora <valerie.aurora@gmail.com> wrote:
>
>> And for a complete (meaningful) rewrite such as David has done, he
>> changes the commit authorship and adds a Signed-off-by for the
>> original author.
>
> Val[*] hasn't signed off all her patches, and indeed I've merged together some
> patches that she has signed off and some she hasn't.  I can't simply add
> Signed-off-by her without her permission.  However, if she's willing for me to
> add such lines, then I can do so.
>
>> Signed-off-by: Some Upstream Author
>> Signed-off-by: Maintainer or Merger (rewrote error handling)
>
> And if the changes are more than can be put in what's left of the line?  I
> would've thought it would make more sense to do something like:
>
>   Signed-off-by: Valerie Aurora <valerie.aurora@gmail.com> (Original author)
>   Signed-off-by: David Howells <dhowells@redhat.com> (Further development)
>
> David

That all sounds sensible.

I personally think the "recognition" factor Valerie alluded to in one of
her earlier message is a real and important issue, but I do not think
adding arbitrary number of "author" headers to the commit object would
help very much to solve it, for various reasons:

 * While we made it easy to run "git shortlog -s -n --since=3.months" and
   congratulate himself with "I now am the third most active person!" for
   anybody, Git itself does not ship an equally easy way to analyze other
   kinds of contributions to your project.  I am merely a bystander, but
   if I recall correctly, there were discussions on how to recognize
   contributions by bug-reporters and testers using the history stored in
   Git on the kernel list.  The types of contribution you would want to
   recognize however would be different from project to project.  For that
   kind of analysis, you would be better off doing something like what
   lwn.net does, mining the text from the message part of the log.

 * Even if we limit the issue to "who wrote X" (replace X with the name of
   any piece of software), taking "author" field as anything more than an
   approximation would be asking for a trouble.  Not all patches are of
   equal impact and importance.

 * You would also have to think about how you would present "git shortlog"
   output if you updated Git to record more than one "author" field in the
   commit header.  If Valerie wrote 27 patches by herself, 33 patches
   together with you sitting next to each other, 17 patches with somebody
   else, how would the entries for her, you and the third person look
   like?  Or would combinations of "Valerie & David", "Valerie & the
   third person", etc. have separate entries in the output?

In short, I would say that you should take the name recorded in the
"author" field nothing more than the primary contact for a particular
commit to be used in case others have question on it later.
