From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bundle(1): add no references required simplest case
Date: Mon, 26 Jan 2009 11:53:21 -0800
Message-ID: <7vljsx6dzi.fsf@gitster.siamese.dyndns.org>
References: <87zlirc49l.fsf@jidanni.org> <87d4e97uxb.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mdl123@verizon.net, gitster@pobox.com, spearce@spearce.org,
	git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Mon Jan 26 20:55:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXXr-0003kd-Ar
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 20:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZAZTxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 14:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbZAZTxa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 14:53:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZAZTxa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 14:53:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EFBAE1D59B;
	Mon, 26 Jan 2009 14:53:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A28C21D59A; Mon,
 26 Jan 2009 14:53:22 -0500 (EST)
In-Reply-To: <87d4e97uxb.fsf_-_@jidanni.org> (jidanni@jidanni.org's message
 of "Tue, 27 Jan 2009 03:02:08 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 008348DA-EBE3-11DD-8A30-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107260>

jidanni@jidanni.org writes:

> Signed-off-by: jidanni <jidanni@jidanni.org>
> ---
> See http://article.gmane.org/gmane.comp.version-control.git/103576
>  Documentation/git-bundle.txt |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 1b66ab7..7c1e990 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -164,6 +164,13 @@ $ git pull bundle
>  would treat it as if it is talking with a remote side over the
>  network.
>  
> +If a bundle requires no references, one may simply use:

Two nits.

 1. Bundle does not require reference;it requires commits.

 2. "One may simply use:" with a recipe without saying what the recipe is
    useful for is not very helpful.

The second point needs to be stressed.  For example, you could say
something like this:

        With any bundle, you may simply say:

                $ git ls-remote bundle.bdl

and it is a correct description if it is to see the refs in the bundle is
what you want to do, but it does not help when cloning from it is what you
want.

It would be a good practice to make the new part go with the flow of the
existing examples.  Adding the following at the end might be a better way
to do this than your "init then pull" example:

	A complete bundle is one that does not require you to have any
	prerequiste object for you to extract its contents.  Not only you
	can fetch/pull from a bundle, you can clone from a complete bundle
	as if it is a remote repository, like this:

	----------------
        $ git clone /home/me/tmp/file.bdl mine.git
        ----------------

	This will define a remote called "origin" in the resulting
	repository that lets you fetch and pull from the bundle, just
	like the previous example lets you do with the remote called
	"bundle", and from then on you can fetch/pull to update the
	resulting mine.git repository after replacing the bundle you store
	at /home/me/tmp/file.bdl with incremental updates.
