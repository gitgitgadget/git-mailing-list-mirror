From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] send-email: make annotate configurable
Date: Sun, 07 Apr 2013 00:42:12 -0700
Message-ID: <7vfvz2948b.fsf@alter.siamese.dyndns.org>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
 <1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 09:42:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOkFB-0005hS-N3
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:42:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924Ab3DGHmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:42:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51274 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760311Ab3DGHmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:42:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D461FD05;
	Sun,  7 Apr 2013 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fRYS/Mb/2+mMzKFrZpDN3M0nAS8=; b=w1mXXG
	+UUv6FJWklO5iC85u90HSL4Rqx4fzSkXv1pV+V7lotFZthzadgIHhPKZLjLufby9
	6kdDFdPRk/4WjpE8nbUZGLUKER5KlpT3WLeOmf1bsOBSG1UOOQkXzf7FPAN4t8XO
	X9ng3486XAwoqa6c/DF95Ua9q1k5EbJ0B64go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sgxk22WNK+GieLY1aSHXuIm+MC9emw/t
	KFQDSM0rbz1haSKsQ3WT25MH6Wc53fvGgjHAxgWI1HuUEMDIKJXMLalEeSN2xtYh
	urGfjzpmRnlxuN3Joj97qII/O2K1SinXp/XPJuoTUh65TkMbbNxvgtXf3ZPB9nC6
	sz4L8tGbdmQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E50FD04;
	Sun,  7 Apr 2013 07:42:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB572FD02; Sun,  7 Apr 2013
 07:42:13 +0000 (UTC)
In-Reply-To: <1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 7 Apr 2013 01:10:27 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A9D52B1C-9F56-11E2-BBF4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220289>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Some people always do --annotate, lets not force them to always type
> that.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

Sounds sensible; any tests to protect this from later breakages?

>  Documentation/config.txt         | 1 +
>  Documentation/git-send-email.txt | 5 +++--
>  git-send-email.perl              | 7 ++++---
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bbba728..c8e2178 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1994,6 +1994,7 @@ sendemail.<identity>.*::
>  
>  sendemail.aliasesfile::
>  sendemail.aliasfiletype::
> +sendemail.annotate::
>  sendemail.bcc::
>  sendemail.cc::
>  sendemail.cccmd::
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 44a1f7c..2facc18 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -45,8 +45,9 @@ Composing
>  ~~~~~~~~~
>  
>  --annotate::
> -	Review and edit each patch you're about to send. See the
> -	CONFIGURATION section for 'sendemail.multiedit'.
> +	Review and edit each patch you're about to send. Default is the value
> +	of 'sendemail.annotate'. See the CONFIGURATION section for
> +	'sendemail.multiedit'.
>  
>  --bcc=<address>::
>  	Specify a "Bcc:" value for each email. Default is the value of
> diff --git a/git-send-email.perl b/git-send-email.perl
> index be809e5..e187b12 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -54,7 +54,7 @@ git send-email [options] <file | directory | rev-list options >
>      --[no-]bcc              <str>  * Email Bcc:
>      --subject               <str>  * Email "Subject:"
>      --in-reply-to           <str>  * Email "In-Reply-To:"
> -    --annotate                     * Review each patch that will be sent in an editor.
> +    --[no-]annotate                * Review each patch that will be sent in an editor.
>      --compose                      * Open an editor for introduction.
>      --compose-encoding      <str>  * Encoding to assume for introduction.
>      --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
> @@ -212,7 +212,8 @@ my %config_bool_settings = (
>      "signedoffbycc" => [\$signed_off_by_cc, undef],
>      "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
>      "validate" => [\$validate, 1],
> -    "multiedit" => [\$multiedit, undef]
> +    "multiedit" => [\$multiedit, undef],
> +    "annotate" => [\$annotate, undef]
>  );
>  
>  my %config_settings = (
> @@ -304,7 +305,7 @@ my $rc = GetOptions("h" => \$help,
>  		    "smtp-debug:i" => \$debug_net_smtp,
>  		    "smtp-domain:s" => \$smtp_domain,
>  		    "identity=s" => \$identity,
> -		    "annotate" => \$annotate,
> +		    "annotate!" => \$annotate,
>  		    "compose" => \$compose,
>  		    "quiet" => \$quiet,
>  		    "cc-cmd=s" => \$cc_cmd,
