From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 4/6] send-email: --compose takes optional argument to
 existing file
Date: Sat, 11 Apr 2009 12:22:39 -0700
Message-ID: <7vk55rf11c.fsf@gitster.siamese.dyndns.org>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-2-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-3-git-send-email-mfwitten@gmail.com>
 <1239139522-24118-4-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipD-0004sO-2z
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863AbZDKTWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758655AbZDKTWq
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:22:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758524AbZDKTWp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:22:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A23F4A9E5C;
	Sat, 11 Apr 2009 15:22:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8ACDEA9E5B; Sat,
 11 Apr 2009 15:22:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22307702-26CE-11DE-9524-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116327>

Michael Witten <mfwitten@gmail.com> writes:

> Now, a user may specify an existing (in-progress) file to use as
> the introductory/summary email.
>
> The file is opened for any additional editing as usual.
>
> Signed-off-by: Michael Witten <mfwitten@gmail.com>
> ---
>  Documentation/git-send-email.txt |    7 ++-
>  git-send-email.perl              |  112 ++++++++++++++++++++++----------------
>  2 files changed, 71 insertions(+), 48 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 4b656ca..bc9ff13 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -57,8 +57,11 @@ The --cc option must be repeated for each user you want on the cc list.
>  	or one for all of them at once.
>  
>  --compose::
> -	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
> -	introductory message for the patch series.
> +	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR, or vi to edit an

I think addition of ", or vi" makes sense but the ", or $EDITOR" needs to
change, and also the language needs to be clarified to say the first one
of these is used.

The name of the new variable $compose_file that is used as a filehandle
was confusing to read (almost everybody else in the program uses $fh, and
it looked as if $compose_file is talking about the name of the file or
indirectly pointing at an existing filehandle, but it was not).
