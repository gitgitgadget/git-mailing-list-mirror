From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] add 'git credential' plumbing command
Date: Fri, 22 Jun 2012 13:24:17 -0700
Message-ID: <7vzk7vnlhq.fsf@alter.siamese.dyndns.org>
References: <1340381231-9522-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340381231-9522-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Javier.Roucher-Iglesias@ensimag.imag.fr,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 22:24:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiAP3-0004ut-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 22:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab2FVUYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 16:24:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754608Ab2FVUYU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 16:24:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CCF57BC5;
	Fri, 22 Jun 2012 16:24:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CeigvD0FZV/VHysxQGc6JeX8iSE=; b=HNg9xJ
	HF8x3b3egscUUmcuttTf1YpQwUD25Gwv/fNvvE0DiTQRmNbGb1/yO8N6iviRzj6i
	YjvagKQOs04d0HSXHbox75QXaoyEd5UXLF7tyEdjXZ481M3i6i8sGZUp9ddRG9rE
	nPX2kgsXw1T9pxXG3EFqxSURwxmnY2ek+qKb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OiqS26XIKA6pVzl2X00RvlQXOBH0C0ba
	Mx1VRNDpOSGDMR+fORIc1WU/mT4zDVvLBj70KsJTvgc4tqktkI4S/zqIr12/VSor
	5O93hawrhF7qcAaf9o5eB6h9+V/GTSuKRFo8c+Su9V1/8j5D9Ya+TkwxIjztvDKa
	9lRJA91ffBM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 631117BC4;
	Fri, 22 Jun 2012 16:24:19 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95D527BB9; Fri, 22 Jun 2012
 16:24:18 -0400 (EDT)
In-Reply-To: <1340381231-9522-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 22 Jun 2012 18:07:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E75BA94-BCA8-11E1-A050-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200467>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> From: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
>
> The credential API is in C, and not available to scripting languages.
> Expose the functionalities of the API by wrapping them into a new
> plumbing command "git credentials".
>
> In other words, replace the internal "test-credential" by an official Git
> command.
>
> Most documentation writen by: Jeff King <peff@peff.net>
> Signed-off-by: Pavel Volek <Pavel.Volek@ensimag.imag.fr>
> Signed-off-by: Kim Thuat Nguyen <Kim-Thuat.Nguyen@ensimag.imag.fr>
> Signed-off-by: Javier Roucher Iglesias <Javier.Roucher-Iglesias@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  .gitignore                                  |   2 +-
>  Documentation/git-credential.txt            | 126 ++++++++++++++++++++++++++++
>  Documentation/technical/api-credentials.txt |  39 +--------
>  Makefile                                    |   2 +-
>  builtin.h                                   |   1 +
>  test-credential.c => builtin/credential.c   |  20 ++---

Nice ;-)

> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> new file mode 100644
> index 0000000..b64ac30
> --- /dev/null
> +++ b/Documentation/git-credential.txt
> @@ -0,0 +1,126 @@
> ...
> +DESCRIPTION
> +-----------
> +...

Very clearly written.

> +TYPICAL WORKFLOW
> +----------------
> +
> +An application using git-credential will typically follow this
> +workflow:

Again, who does what in what order is very clearly described below.

One minor question I had was "is this _workflow_?".  "An application
using ... typically follow this workflow:" might want to be reworded
to "An application uses `git credential` like this:" or something like
that.

I am not sure about the section title, though.

> +  1. Generate a credential description based on the context.
> ++
> +For example, if we want a password for
> +`https://example.com/foo.git`, we might generate the following
> +credential description (don't forget the blank line at the end):

Add "; it tells `git credential` that the application finished feeding
all the infomation it has" or something after "blank line at the
end" to justify why the user must not forget it.

> +
> +         protocol=https
> +         host=example.com
> +         path=foo.git

I also thought that we discussed optionally removing the burden of
parsing the incoming URL (e.g. https://exmaple.com/foo.git) into its
components by giving them a way to feed a single line

	url=https://example.com/foo.git

in place of the above three?  Perhaps it will come as an enhancement
in a later patch in the series?

> +  2. Ask git-credential to give us a username and password for this
> +     description. This is done by running `git credential fill`,
> +     feeding the description from step (1) to its stdin. The username
> +     and password will be produced on stdout, like:
> +
> +	username=bob
> +	password=secr3t

I may be ahead of myself, but the following untold paragraph came to
my mind while I was reading this:

    If the "git credential" knew about the password, this step may
    not have involved the user actually typing this password (the
    user may have typed a password to unlock the keychain instead,
    or no user interaction was done if the keychain was already
    unlocked) before it returned "password=secr3t".

> +  3. Try to use the credential (e.g., by accessing the URL with the
> +     username and password from step (2)).

OK.  Drop "Try to use" and just say "Use"; it's clearer.  Similarly,
s/by accessing/access/.

> +  4. Report on the success or failure of the password. If the
> +     credential allowed the operation to complete successfully, then
> +     it can be marked with an "approve" action. If the credential was
> +     rejected during the operation, use the "reject" action. In either
> +     case, `git credential` should be fed with the credential
> +     description obtained from step (2) together with the ones already
> +     provided in step (1).

A question that came to my mind after the first sentence was "Why
should I report it?  What benefit am I getting, if I successfully
accessed the resource I wanted to in the previous step already?"

    4. Tell the git credential if the credential was good, so that
       git credential can ask the user the correct password upon the
       next invocation, if the one returned in step 2. did not work
       (e.g. a bad password came from a keychain), by using "approve"
       to tell it that it was good, or "reject" to tell it that it
       was bad.  In either case, ...

The term "credential" is used here without definition (I think you
meant a <username, password> pair with the word).  I think it makes
the description shorter to say "credential" instead of "username and
password", but then we would want to define the term upfront and use
it throughout the document.  E.g. the end of step 2. would read like
this if we did so:

	... to its standard input.  The credential will be produced
	on the standard output, like so:

		username=bob
                password=secr3t

Oh, another thing.  Please avoid using "stdin", etc., when you are
not discussing variables in the program text but you are referring
to them as mechanism names, and instead spell it out.

> +[[IOFMT]]
> +INPUT/OUTPUT FORMAT
> +-------------------
> +
> +`git credential` reads and/or writes (depending on the action used)
> +credential information in its standard input/output. These information
> +can correspond either to keys from which `git credential` will obtain
> +the login/password information (e.g. host, protocol, path), or to the
> +actual credential data to be obtained (login/password).

Shouldn't "keys from which ..." be "keys for which ..."?  You ask
for a data item from somebody who has the data _for_ a key, or you
query a data item from a database _with_ a key.  The data source
could be human in this context, so I'd prefer not get my brain
queried with a key (asking me politely for data for a key is OK ;-).

> +The credential is split into a set of named attributes.
> +Attributes are provided to the helper, one per line. Each attribute is
> ...

I didn't have any issue with the remainder of the paragraph.

> diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
> index adb6f0c..5977b58 100644
> --- a/Documentation/technical/api-credentials.txt
> +++ b/Documentation/technical/api-credentials.txt
> @@ -241,42 +241,9 @@ appended to its command line, which is one of:
>  	Remove a matching credential, if any, from the helper's storage.
>  
>  The details of the credential will be provided on the helper's stdin
> +stream. The exact format is the same as the input/output format of the
> +`git credential` plumbing command (see the section `INPUT/OUTPUT
> +FORMAT` in linkgit:git-credential[7] for a detailed specification).

OK.

> diff --git a/test-credential.c b/builtin/credential.c
> similarity index 63%
> rename from test-credential.c
> rename to builtin/credential.c
> index dee200e..4147314 100644
> --- a/test-credential.c
> +++ b/builtin/credential.c
> @@ -1,21 +1,18 @@
> -#include "cache.h"
> +#include <stdio.h>
>  #include "credential.h"
> -#include "string-list.h"
> +#include "builtin.h"

I understand that you do not want the entire cache.h, but could you
include "git-compat-util.h" instead?  We try to absorb platform
dependencies in that header file and avoid including system headers
directly to C sources.

>  static const char usage_msg[] =
> -"test-credential <fill|approve|reject> [helper...]";
> +	"credential <fill|approve|reject>";
>  
> -int main(int argc, const char **argv)
> +int cmd_credential (int argc, const char **argv, const char *prefix)

Style.

> diff --git a/git.c b/git.c
> index d232de9..660c926 100644
> --- a/git.c
> +++ b/git.c
> @@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
>  		{ "config", cmd_config, RUN_SETUP_GENTLY },
>  		{ "count-objects", cmd_count_objects, RUN_SETUP },
> +		{ "credential", cmd_credential, RUN_SETUP_GENTLY },

Good.

> diff --git a/t/lib-credential.sh b/t/lib-credential.sh
> index 4a37cd7..7c4826e 100755
> --- a/t/lib-credential.sh
> +++ b/t/lib-credential.sh
> @@ -4,10 +4,20 @@
>  # stdout and stderr should be provided on stdin,
>  # separated by "--".
>  check() {
> +	credential_opts=
> +	credential_cmd=$1
> +	shift
> +	for arg in "$@"; do
> +		credential_opts="$credential_opts -c credential.helper='$arg'"
> +	done
>  	read_chunk >stdin &&
>  	read_chunk >expect-stdout &&
>  	read_chunk >expect-stderr &&
> -	test-credential "$@" <stdin >stdout 2>stderr &&
> +	if ! eval "git $credential_opts credential $credential_cmd <stdin >stdout 2>stderr"; then
> +		echo "git credential failed with code $?" &&
> +		cat stderr &&
> +		false
> +	fi &&
>  	test_cmp expect-stdout stdout &&
>  	test_cmp expect-stderr stderr
>  }
> @@ -41,7 +51,7 @@ reject() {
>  		echo protocol=$2
>  		echo host=$3
>  		echo username=$4
> -	) | test-credential reject $1
> +	) | git -c credential.helper=$1 credential reject
>  }
>  
>  helper_test() {

Nice.

Thanks.
