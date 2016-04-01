From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: clarify that notes can be attached to any type of stored object
Date: Fri, 01 Apr 2016 08:31:38 -0700
Message-ID: <xmqqy48xjqg5.fsf@gitster.mtv.corp.google.com>
References: <56FE48C6.9050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 17:31:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am135-0005SV-Re
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 17:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbcDAPbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 11:31:42 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbcDAPbl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 11:31:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 313A04FAFD;
	Fri,  1 Apr 2016 11:31:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7V+qMItpX0jzc/pIANtLNfWhn40=; b=DHQbvy
	hGV1aE+FK6OgXBCDP77/Drwt5icVMoaYe3Ep4B0nzafFATQxEAbA4SqS1FKeyRnj
	/lWqWD3jLdkeNbfPuxYOvOT/981ZpbmI9VebMNNGxF1sB8mAFM4V9xAs9Zhvzk+j
	LDlcK110DO7hGKvbH+VcUdKIuq38iJsbwBXdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xi382ShqWlxxW1zvtEf7VE9fJtWZ8wur
	JCKWVKb4Bv+aekB/lUhyPlDE/l/2Hll4D1AjfE5cfjhaG/h7DifMnDCQAO4pcp2F
	weVldDcH+KI+98UzWP8kCFSQp4TKU7PpmncFnsg6LNz6Ft+31QjLqS9F6GG6SR1P
	1WlFLI27NO0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1B03D4FAFB;
	Fri,  1 Apr 2016 11:31:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 667494FAFA;
	Fri,  1 Apr 2016 11:31:39 -0400 (EDT)
In-Reply-To: <56FE48C6.9050306@gmail.com> (Sebastian Schuberth's message of
	"Fri, 1 Apr 2016 12:09:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4032758-F81E-11E5-ADE4-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290545>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-notes.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 8de3499..5375d98 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -234,8 +234,9 @@ which operation triggered the update, and the commit authorship is
>  determined according to the usual rules (see linkgit:git-commit[1]).
>  These details may change in the future.
>  
> -It is also permitted for a notes ref to point directly to a tree
> -object, in which case the history of the notes can be read with
> +It is also permitted for a notes ref to point to any other object in
> +the object store besides commit objects, that is annotated tags, blobs
> +or trees. For the latter, the history of the notes can be read with
>  `git log -p -g <refname>`.

I do not think this is correct place to patch.  The original is not
talking about what objects can have notes attached at all.  What it
explains is this.

    <refname> aka refs/notes/<name> (where <name> typically is
    "commit") is usually a commit, whose tree is a notes-shaped
    tree.  The (normal) history you get by following the parent link
    of the commit represents how the entire set of notes evolved.
    However, it is OK for the <refname> to point directly to a tree,
    which is a notes-shaped one, without an enclosing commit.  You
    would lose the normal way to learn how the entire set of notes
    evolved, but you could do "git log -p -g <refname>", i.e. by
    following its reflog, to pretend as if the history is recorded.

There is no way a blob can be pointed by <refname> there and expect
it to work sensibly at all.
