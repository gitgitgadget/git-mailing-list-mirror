From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 10:14:42 -0700
Message-ID: <7vhagu10ql.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-3-git-send-email-rhansen@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 19:15:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpLyM-0005sU-Jc
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 19:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934970Ab3FSRPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 13:15:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934968Ab3FSROo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 13:14:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37553293AF;
	Wed, 19 Jun 2013 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Z3i6H/xyk9pKKWx4Q6kt8p/A9w=; b=hgM6LR
	VP/6/mvvpVSbVpvRnb4IrMx81tDn5ZOUXF1vuZDE24krOgPVd4wCdQAEV1ArqFhI
	sBwfZunylrwQqn9HU64w6FUknCBRvSBRxPqyWG0NpcZ1Rp1q/PiA8EOQORzzYRZ5
	E6u1oO2wOxxyr3veonKDZMqrEkYegDfzZsMKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ID/jjY+6jNEoN7rLMqgeXcVY+L0JUikL
	J8KxeDWzNDVvLFZ6FF9hrCTviu1+c+UBZT5MH16+VOT91puJcPEoF6adlkrpLepC
	b/4EJntOr77PDkbRFVKcS9Q2Jvol9WU4mmTVom+wsI6eIkC1X+nYBLFi0xp+gHx4
	vM6iNrqmbDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29E85293AB;
	Wed, 19 Jun 2013 17:14:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AF22293A6;
	Wed, 19 Jun 2013 17:14:43 +0000 (UTC)
In-Reply-To: <1371607780-2966-3-git-send-email-rhansen@bbn.com> (Richard
	Hansen's message of "Tue, 18 Jun 2013 22:09:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBF093AE-D903-11E2-AEA5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228403>

Richard Hansen <rhansen@bbn.com> writes:

> Signed-off-by: Richard Hansen <rhansen@bbn.com>
> ---
>  Documentation/glossary-content.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 01365d9..a3cc003 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -82,6 +82,17 @@ to point at the new commit.
>  	to the top <<def_directory,directory>> of the stored
>  	revision.
>  
> +[[def_committish]]committish (also commit-ish)::
> +	A <<def_ref,ref>> pointing to an <<def_object,object>> that
> +	can be recursively dereferenced to a
> +	<<def_commit_object,commit object>>.
> +	The following are all committishes:
> +	a ref pointing to a commit object,
> +	a ref pointing to a <<def_tag_object,tag object>> that points
> +	to a commit object,
> +	a ref pointing to a tag object that points to a tag object
> +	that points to a commit object, etc.
> +

<object-type>-ish does not have anything to do with a ref.  Even
when an object is dangling in your object store without being
reachable from any of your refs, it keeps its own "ish"-ness.

"ish"-ness is a property of the object itself.

 * A commit object has a single top-level tree, and when a command
   wants a tree object, you can often pass it a commit (historically
   some commands were more strict and refused to work on a commit
   when they wanted a tree).  In other words, a commit can be used
   in place for a tree.  A commit object is a tree-ish.

 * A tag object, when it points (recursively) at a commit object,
   can often be used in place for a commit object.  Such a tag
   object is a commit-ish.

 * A tag object, when it points (recursively) at a tree object, can
   often be used in place for a tree object.  Such a tag object is a
   tree-ish.  Note that such a tag object cannot be a commit-ish.
