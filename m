From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] credentials helpers+remote helpers
Date: Thu, 07 Jun 2012 12:22:30 -0700
Message-ID: <7vr4trexl5.fsf@alter.siamese.dyndns.org>
References: <1339079743-31068-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Thu Jun 07 21:22:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SciI3-0005Hh-OR
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 21:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761373Ab2FGTWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 15:22:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35922 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754762Ab2FGTWd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 15:22:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C97248740;
	Thu,  7 Jun 2012 15:22:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8VA6xJY79TSs5Xfbtied5zPbROw=; b=W1H4ue
	anID0id7tidRuCKmAIz2lghBRSYVxy/U4FrniTLRPEwTpHyHWFZtR3p7rl4wcnzU
	6/5Ap8RzhcwpQnpD8RmUXjmS/y8n2vBzB76dpfdrz8PlItK6ApTeXVipRUqxnGvV
	SQBaSPmO60/UoippdjJXbhFii34g9q0TFBeZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bLhOvHxC+hWeLtEVeLdYNEYor1gnQ5iu
	8CBh+xy8oIGVB6mrjsaETvsL0g9H+MDVMJ4y9nURxhHBHm00/s3yqHFj0MZr/c7v
	3q2+thrTcMD9gwOGn/pTYBpO/Gl4pHcqeWoTaSZULldKhSd3lQtIX/HvBTQ+eMC7
	ZgfQv/PvXNk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C01E6873F;
	Thu,  7 Jun 2012 15:22:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2ADFD8738; Thu,  7 Jun 2012
 15:22:32 -0400 (EDT)
In-Reply-To: <1339079743-31068-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 (Javier Roucher-Iglesias's message of "Thu, 7 Jun 2012 16:35:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 211469BA-B0D6-11E1-8D00-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199441>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> From: Javier Roucher <jroucher@gmail.com>
>
>
> Add "git credential" plumbing command
>
> The credential API is in C, and not available to scripting languages.
> Expose the functionalities of the API by wrapping them into a new
> plumbing command "git credentials".
>
> Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
> Signed-off-by: NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>
> Signed-off-by: ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

In addition to all good comments already given by Matthieu,...

> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> new file mode 100644
> index 0000000..a6e1d0a
> --- /dev/null
> +++ b/Documentation/git-credential.txt
> @@ -0,0 +1,70 @@
> +git-credential(7)
> +=================
> +
> +NAME
> +----
> +git-credential - Providing and storing user credentials to git

This sounds as if we are storing passwords "in git", which is not
exactly the point of the credential API, no?

> +SYNOPSIS
> +--------
> +------------------
> +git credential [fill|approve|reject]
> +
> +------------------
> +
> +DESCRIPTION
> +-----------
> +
> +Git-credential permits to save username, password, host, path and protocol.
> +When you invoke git-credential, you can ask for a password, using the command
> +'git credential fill'.
> +Providing them by STDIN: 
> +
> +		username=admin\n 
> +		protocol=[http|https]\n
> +		host=localhost\n
> +		path=/dir\n\n

It's a bit strange way to convey that the user feeds record
separated by a blank line, and each column in a record is terminated
with a newline.

How about saying that more explicitly?  E.g. "when taking data from
the standard input, the program treats each line as a separate data
item, and the end of series of data item is signalled by a blank
line" or something?

> +-If git-credential system, have the password already stored
> +git-credential will answer by STDOUT:
> +	
> +		username=admin\n
> +		password=*****\n

Does the reading side get any clue that there is no more output,
like you gave yourself on the input side (i.e. it can and should
read until it sees a blank line)?

Shouldn't it?

> +-If it is not stored, git-credential will ask you to enter 
> +the password:
> +		
> +		> Password for '[http|https]admin@localhost':
> +
> +Then if password is correct, you can store using command
> +'git crendential approve' providing the structure, by STDIN.
> +
> +		username=admin\n 
> +		password=*****\n
> +		protocol=[http|https]\n
> +		host=localhost\n
> +		path=/dir\n\n
> +
> +If the password is refused, you can delete using command
> +'git credential reject' providing the same structure.

It is unclear who decides "correct" vs "refused" here.

Perhaps it would help to describe the purpose of the script that
uses this command first.  My understanding is that there are three
actors: the end user, the script that uses "git credential" and an
external system that wants to authenticate the user.

    _
   / \        +------------------+      +-----------------+
  | U |       |                  |      |                 |
   \ /        | Script that uses |      | External system |
  --+--  <==> | "git credential" | <==> |                 | 
    ^         +------------------+      +-----------------+
   / \                 ^
                       |
                       v
                credential API

And the "Script" is trying to respond to the external system with
credential material on behalf of the user.  For that, if the script
knows the username, it can give the <user,proto,host,path> tuple to
"git credential", and if "git credential" knows the password, it
will be given to the script. If it does not, it may ask the user and
obtain it before giving it back to the script.

Is that what is going on?

Assuming it is, after that happens, the script gives the credential
information to the external system. The external system may or may
not accept that credential, and that is what decides "correct" vs
"refused".

After that, the script tells the "git credential" the result; giving
"reject" to it to purge the credential information that it already
knows the external system will reject, for example.
