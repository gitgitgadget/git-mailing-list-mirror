From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 15:15:23 +0200
Message-ID: <20080901131523.GA6739@neumann>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	<1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	szeder@ira.uka.de, "Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 15:16:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka9Gj-0002eK-Vm
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 15:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYIANP0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 09:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbYIANP0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 09:15:26 -0400
Received: from francis.fzi.de ([141.21.7.5]:11102 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751274AbYIANP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 09:15:26 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 15:15:22 +0200
Content-Disposition: inline
In-Reply-To: <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 01 Sep 2008 13:15:22.0918 (UTC) FILETIME=[CA552460:01C90C34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94584>

Hi,

On Sun, Aug 31, 2008 at 02:41:07PM +0200, Bert Wesarg wrote:
> This strips from the refname the common directory prefix with the
> matched pattern.
>=20
> This is particular usefull for bash completion, to get refs without
> `refs/heads` or `refs/tags`.

>  refname::
>  	The name of the ref (the part after $GIT_DIR/).
> +	For a short name of the ref append `:short`. This will strip
> +	the common directory prefix with the pattern which matches this ref=
=2E
> +	I.e. for a the pattern `refs/heads` you get `master`, or for
> +	`refs/tags/v1.5.[01].*` you get `v1.5.[01].*`.
> +	This is particular usefull for bash completion.
Should this last sentence really belong to the documentation?

=46urthermore, I think ':strip' better describes what this format
actually does.  Even you have used the word 'strip' in the commit
message and in the documentation as well.


As far as bash completion is concerned, I'm for it, as it does exactly
what the completion script needs to perform better, it doesn't have
those conceptual issues 'refbasename' has, and it's only a tad slower
than 'refbasename'.

However, if we consider possible use cases other than bash completion,
I don't know which one is more useful.  For example, if you have two
branches 'foo/bar' and 'foo/baz', then 'git merge $(git for-each-ref
--format=3D%(refbasename) refs/heads/foo)' will work as expected, but
'refname:short' not, as it will output only 'bar' and 'baz' which 'git
merge' can not find.


Best,
G=E1bor
