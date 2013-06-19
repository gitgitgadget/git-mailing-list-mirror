From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 15:36:28 -0700
Message-ID: <7vwqppwwwj.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-3-git-send-email-rhansen@bbn.com>
	<7vhagu10ql.fsf@alter.siamese.dyndns.org> <51C203A1.4000404@bbn.com>
	<7vtxktyfo1.fsf@alter.siamese.dyndns.org> <51C22F77.8050004@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 00:36:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpQzU-0007p8-Bn
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 00:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935284Ab3FSWgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 18:36:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935252Ab3FSWgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 18:36:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F238E1B39E;
	Wed, 19 Jun 2013 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=L1buVJ98bWRpk0U9Q0bPhPdmciM=; b=SJBSWP
	QWnb3U3C6iOyfVXmk9rT+M6dTPohnvbwa5WiMIaTvvuu/8Qwx9LKzv/p8sXnHo4c
	87ORm2PdfZ/2xi+aoA1BAqe+6Ah/FBxnFRaH0DBfBur4veHFMwy51on0jZbe/R1p
	y534i4Le1KHqucBrV4syWuxHFw7sUuBa6ei+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CkPIPqumWxS5R4hmhEiM708zVWK9CUiY
	JGCghkGQnrTmL47jaJVtQNCU7lmrPnYPF/YPTjcdA8KHoZWB6R9x2Omf6iU8JT34
	LuJN75KezdoIeurkb8MEUrQW8+jvZ+K0KtqZX3SVLmHyNYRzzHP/bJGbispL5Pkw
	TvXbxt9B3Gc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E72801B39D;
	Wed, 19 Jun 2013 22:36:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 489AA1B39B;
	Wed, 19 Jun 2013 22:36:30 +0000 (UTC)
In-Reply-To: <51C22F77.8050004@bbn.com> (Richard Hansen's message of "Wed, 19
	Jun 2013 18:23:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFA5A030-D930-11E2-A4B2-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228431>

Richard Hansen <rhansen@bbn.com> writes:

> Here's what I'm trying to say:
>
>   * Given the current definition of "ref" in gitglossary(7), claiming
>     that a foo-ish is a ref is not entirely incorrect.

Ahh.  If you had quoted this a few exchanges ago:

    [[def_ref]]ref::
            A 40-byte hex representation of a <<def_SHA1,SHA-1>> or a name that
            denotes a particular <<def_object,object>>. They may be stored in
            a file under `$GIT_DIR/refs/` directory, or
            in the `$GIT_DIR/packed-refs` file.

I would have immediately understood what you were trying to say.
Sorry about a wasted back-and-forth.

The above is an utterly confused explanation.  It explains object
names and mentions as a sidenote that object names _can_ be held in
refs.

It does not say what a ref is, in other words.

Before 'packed-refs' was introduced, the right definition would have
been

	A file under `$GIT_DIR/refs/` directory that holds an object
	name.

And packed-refs is a way to coalesce such files into a single file
to make it easier/faster to access.

In today's world (after packed-refs was introduced), probably

	A name that begins with refs/ (e.g. refs/heads/master) that
	can point at an object name.

        The namespace of refs is hierarchical and different
        subhierarchy is used for different purposes (e.g. the
        refs/heads/ hierarchy is used to represent local branches).

is an appropriate rewrite of the above.

If we also want to explain the implementation details of refs, then
additionally at the end of the first paragraph, add:

	... at an object name, by storing its 40-byte hex
	representation.  They are implemented as either a file in
	$GIT_DIR/refs/ directory (called "loose refs") or an entry
	in $GIT_DIR/packed-refs file (called "packed refs"); when a
	loose ref exists, a packed ref of the same name is ignored.
