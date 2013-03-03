From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/5] Show 'git help <guide>' usage, with examples
Date: Sun, 03 Mar 2013 15:38:11 -0800
Message-ID: <7v4ngs12cc.fsf@alter.siamese.dyndns.org>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org>
 <1362342072-1412-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Mar 04 00:38:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIUL-0000WO-54
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab3CCXiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:38:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753643Ab3CCXiO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:38:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 397FEB60E;
	Sun,  3 Mar 2013 18:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=DFJREbF3OwWx3yRZ5zO5Qip0dtM=; b=OekpRwZyBwVzuqb/hIHG
	EpTG6vez+ptdOrjll/E45rIcBJsMR4nG1wgrh1XEwHfd4u3xBfxzXplZZKm15t+C
	s6uR8jM4GDPlx8xw+JVxf65u+jNHiDg4vCpiipEteVmUVs6Kf/sGXI+2dIfBGVrC
	u8L36sk4QMJdD3L8je9vGGI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gPQegbf7z0hx72uOu0gOmGjaaHkHhSVTZ95x1p1SpQhoT9
	QWgIva3PjQalZAa0sy/rylPnbWwAweAPG2wUp3Aw4Y7lJzi1A2ANiIzr+EJ9Zd2Y
	zvVzCr+QUyoLTER2J6ZbCwGBt1qeOsW13ZYt4CxE4MI6Yhv/ozzqE/nU84ufI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9E5B60D;
	Sun,  3 Mar 2013 18:38:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0067B609; Sun,  3 Mar 2013
 18:38:12 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69D949E6-845B-11E2-AE58-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217368>

Philip Oakley <philipoakley@iee.org> writes:

> The git(1) man page must be accessed via 'git help git' on Git for Windows
> as it has no 'man' command. And it prompts users to read the git(1) page,
> rather than hoping they follow a subsidiary link within another
> documentation page. The 'tutorial' is an obvious guide to suggest.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  git.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/git.c b/git.c
> index b10c18b..d9b71c1 100644
> --- a/git.c
> +++ b/git.c
> @@ -13,7 +13,9 @@ const char git_usage_string[] =
>  	"           <command> [<args>]";
>  
>  const char git_more_info_string[] =
> -	N_("See 'git help <command>' for more information on a specific command.");
> +	N_("See 'git help <command>' for more information on a specific command.\n"
> +	   "While 'git help <guide>', will show the selected Git concept guide.\n"
> +	   "Examples: 'git help git', 'git help branch', 'git help tutorial'...");

While I think it is a good idea to mention that the argument to
"help" does not have to be the name of a subcommand, I have two
issues with this patch.

 * A free-standing "While" looks strange.  I would expect a sentence
   that begins with "While 'git help <guide>' shows X" to end with
   something negative like "it is not recommended". Perhaps it is
   just me.

 * It took me two readings to realize that "selected" in "selected
   Git concept guide" refers to "what the user chose to see by
   naming the <guide>".  It looked as if the command will give users
   only a selected few among 47 available ones, chosen by the
   implementors.

How about doing it this way if you are adding two lines anyway?

	'git help -a' and 'git help -g' lists available subcommands
	and concept guides. See 'git help <command>' or 'git help
	<concept>' to read about a specific subcommand or concept.

Replacing "Examples:" that has to stay incomplete for brevity with
the way to get the list of subcommands and concepts would a better
approach, I think.  Teach them how to fish, instead of giving them
fish.
