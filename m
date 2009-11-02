From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Sun, 01 Nov 2009 21:17:16 -0800
Message-ID: <7vzl75v737.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 02 06:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4pIS-00016a-Dn
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 06:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbZKBFRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 00:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbZKBFRX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 00:17:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZKBFRW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 00:17:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 196578EDB9;
	Mon,  2 Nov 2009 00:17:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ibk9Hkg1hI4gwCS2YkmC/eWa/g=; b=IgZEI6
	DrTU7OTKX5SB8VwKFapc0vKD8ofbyNxL17bR6G0eq37J7NxPY/mK0OgAilm/EZ3S
	yjCRW0Oh3JSI5yx93z6nr7dF2pHKGIP47lOH3KMRLw3S1htHXcb5KklZDZbKhPiT
	yR3b+7MkRYhLE7+PgPnrBKRE7zwF+CTZM7THU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CSDsNV/XAn2HS8rRNO1CY2h8/F/n2CXT
	l/N4LaFLgOTDdUhCkjCDbCEAOOSk1iL+BLTV+B4cTXj7/7A0yeeK85NUi+9FAKm4
	HpxFJZu+nHMfKzUGLCOGc4vB+bTvJ7c9IWvzObvxSLIg4+SraszstQVP3n9YfIa3
	vjE6CPfnnmc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E48B98EDB8;
	Mon,  2 Nov 2009 00:17:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E56568EDB0; Mon,  2 Nov 2009
 00:17:17 -0500 (EST)
In-Reply-To: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com>
 (Scott Chacon's message of "Sun\, 1 Nov 2009 15\:18\:02 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 00F36A94-C76F-11DE-8208-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131896>

Scott Chacon <schacon@gmail.com> writes:

> The technical documentation for the packfile protocol is both sparse and
> incorrect.  This documents the fetch-pack/upload-pack and send-pack/
> receive-pack protocols much more fully.
>
> Add documentation from Shawn's upcoming http-protocol docs that is shared
> by the packfile protocol. protocol-common.txt describes ABNF notation
> amendments, refname rules and the packet line format.
>
> Add documentation on the various capabilities supported by the
> upload-pack and receive-pack protocols. protocol-capabilities.txt describes
> multi-ack, thin-pack, side-band[-64k], shallow, no-progress, include-tag,
> ofs-delta, delete-refs and report-status.
>
> Signed-Off-By: Scott Chacon <schacon@gmail.com>
> ---

This is just for future reference, but please downcase O and B above.

> diff --git a/Documentation/technical/pack-protocol.txt
> b/Documentation/technical/pack-protocol.txt
> index 9cd48b4..1cc61d8 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> +Packfile transfer protocols
> +===========================
> +
> +Git supports transferring data in packfiles over the ssh://, git:// and
> +file:// transports.  There exist two sets of protocols, one for pushing
> +data from a client to a server and another for fetching data from a
> +server to a client.  All three transports (ssh, git, file) use the same
> +protocol to transfer data.
> +
> +The processes invoked in the canonical Git implementation are 'upload-pack'
> +on the server side and 'fetch-pack' on the client side for fetching data;
> +then 'receive-pack' on the server and 'send-pack' on the client for pushing
> +data.  The protocol functions to have a server tell a client what is
> +currently on the server, then for the two to negotiate the smallest amount
> +of data to send in order to fully update one or the other.
> +
> +Transports
> +----------
> +There are three transports over which the packfile protocol is
> +initiated.  The Git transport is a simple, unauthenticated server that
> +simply takes the command (almost always 'upload-pack', though Git
> +servers can be configured to be globally writable, in which 'receive-
> +pack' initiation is also allowed) with which the client wishes to
> +communicate and executes it and connects it to the requesting
> +process.
> +
> +In the SSH transport, the client basically just runs the 'upload-pack'
> +or 'receive-pack' process on the server over the SSH protocol and then
> +communicates with that invoked process over the SSH connection.
> +
> +The file:// transport simply runs the 'upload-pack' or 'receive-pack'
> +process locally and communicates with it over a pipe.

Very nicely and concisely written.  Noise words like "simply" and
"basically" might be better omitted, though (not just this part but in the
rest of the document as well).

Yes, I admit I have the tendency to excessively use them, too.

> +Git Protocol
> +------------
> +
> +The Git protocol starts off by sending "git-receive-pack 'repo.git'"
> +on the wire using the pkt-line format, followed by a null byte and a
> +hostname paramater, terminated by a null byte.
> +
> +   0032git-upload-pack /project.git\0host=myserver.com\0

Two-and-a-half issues.

 - You are calling distinction between ssh/git/file "transport", and the
   actual data exchange for pushing/fetching "protocol" in the first part
   of the document, and I agree with the choice of words.  The header for
   this section should read "Git Transport", as that is what you are
   describing.

 - The example and the first line of the description contradict with each
   other.

 - As you already said that receive-pack could be requested over git
   transport in the earlier part, I would fix the description on the first
   line to say "... by sending 'command' and 'repository' on the wire ..."
   to make it explain the _concept_.

> +--
> +   git-proto-request = request-command SP pathname NUL [ host-parameter NUL ]
> +   request-command   = "git-upload-pack" / "git-receive-pack" /
> +                       "git-upload-archive"   ; case sensitive
> +   pathname          = *( %x01-ff ) ; exclude NUL
> +   host-parameter    = "host=" hostname [ ":" port ]
> +--
> +Only host-parameter is allowed in the git-proto-request. Clients
> +MUST NOT attempt to send additional parameters. It is used for the
> +git-daemon name based virtual hosting.  See --interpolated-path
> +option to git daemon, with the %H/%CH format characters.
> +Basically what the Git client is doing to connect to an 'upload-pack'
> +process on the server side over the Git protocol is this:
> +
> +   $ echo -e -n \
> +     "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
> +     nc -v example.com 9418
> +
> +
> +SSH Protocol
> +------------

This is "SSH Transport", I think.

> +Initiating the upload-pack or receive-pack processes over SSH is
> +simply executing the binary on the server via SSH remote execution.
> +It is basically equivalent to running this:
> +
> +   $ ssh git.example.com "git-upload-pack '/project.git'"
> +
> +For a server to support Git pushing and pulling for a given user over
> +SSH, that user needs to be able to execute one or both of those
> +commands via the SSH shell that they are provided on login.  On some
> +systems, that shell access is limited to only being able to run those
> +two commands, or even just one of them.
> +
> +In an ssh:// format URI, it's absolute in the URI, so the '/' after
> +the host name (or port number) is sent as an argument, which is then
> +read by the remote git-upload-pack exactly as is, so it's effectively
> +an absolute path in the remote filesystem.
> +
> +       git clone ssh://user@example.com/project.git
> +                    |
> +                    v
> +    ssh user@example.com "git-upload-pack '/project.git'"
> +
> +In a "user@host:path" format URI, its relative to the user's home
> +directory, because the Git client will run:
> +
> +     git clone user@example.com:project.git
> +                    |
> +                    v
> +  ssh user@example.com "git-upload-pack 'project.git'"
> +
> +The exception is if a '~' is used, in which case
> +we execute it without the leading '/'.
> +
> +      ssh://user@example.com/~alice/project.git,
> +                     |
> +                     v
> +   ssh user@example.com "git-upload-pack '~alice/project.git'"

This depends on the intended audience of this document, but if we are
writing for people who want to implement their own gitosis and gitolite to
replace the login shell spawned by ssh daemon, you may want to explain the
"command line" given to it a bit more precisely.  Specifically:

 - The "command name" is spelled with dash (e.g. git-upload-pack), but
   this can be overridden by the client;

 - The repository path is always quoted with sq (i.e. by sq_quote_buf()).

> +Fetching Data From a Server
> +===========================
> +
> +When one Git repository wants to get all the data that a second
> +repository has, the first can 'fetch' from the second.  This
> +operation determines what data the server has that the client does
> +not then streams that data down to the client in packfile format.

I've been disturbed by this "all" since your first draft, as fetching data
reachable from only a few refs but not all is perfectly a valid thing to
do, but I am not sure if it is worth complicating this document to clarify
this point.  Probably not---but then the above would read perfectly well
without "all".

> +The server side binaries need to be executable as 'git-upload-pack'
> +for fetching and 'git-receive-pack' for pushing over SSH, since the
> +Git clients will connect to the server and attempt to run that command
> +directly.  Over the Git protocol, one could write their own daemon
> +that sees that the client is trying to invoke those commands and
> +simply handle the requests.

I am not sure what audience this paragraph is trying to help by making it
sound as if git transport allows customized daemon but ssh transport
doesn't.  gitosis and gitolite are examples of "own daemon that sees that
the client is trying to invoke those commands and simply handle the
requests" over SSH, aren't they?  So if the purpose is to help server
authors, this paragraph does more harm than being useful.  If the purpose
is to satisfy curiosity, I doubt this level of detail is necessary.

Also there is a terminology mix-up; the last sentence should begin with
"Over the Git transport".

> +Reference Discovery
> +-------------------
> +
> +When the client initially connects the server will immediately respond
> +with a listing of each reference it has (all branches and tags) along
> +with the commit SHA that each reference currently points to.

Not "the commit SHA", but "object name". a ref can point at a non-commit
object, such as a tag.

> +   $ echo -e -n \
> +     "0039git-upload-pack /schacon/gitbook.git\0host=example.com\0" |
> +      nc -v example.com 9418
> +   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack \
> +     thin-pack side-band side-band-64k ofs-delta shallow no-progress \
> +     include-tag

We should explain this is actually a long single line, and line folding
with backslashes is solely for the readers of this document, after this
sample response.

> +   00441d3fcd5ced445d1abc402225c0b8a1299641f497 refs/heads/integration
> +   003f7217a7c7e582c46cec22a130adf4b9d7d950fba0 refs/heads/master
> +   003cb88d2441cac0977faf98efc80305012112238d9d refs/tags/v0.9
> +   003c525128480b96c89e6418b1e40909bf6c5b2d580f refs/tags/v1.0
> +   003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
> +   0000
> +Server SHOULD terminate each non-flush line
> +using LF ("\n") terminator; client MUST NOT complain if there is no
> +terminator.

Hmm, LF ("\n") makes me wonder how precise we would want to be.  We
probably should also say we use ASCII (meaning "not EBCDIC") somewhere but
that level of details can wait until a more later draft..

> +The returned response is a pkt-line stream describing each ref and
> +its known value.  The stream SHOULD be sorted by name according to
> +the C locale ordering.  The stream SHOULD include the default ref
> +named 'HEAD' as the first ref.  The stream MUST include capability
> +declarations behind a NUL on the first ref.

I have a vague recollection that in a recent discussion (not discussion on
this documentation patch, but on a "builtin-fetch.c" patch around mid
September), we decided that the above two SHOULD should be MUST.  Another
MUST that is missing from here is that a line that describes a peeled tag
MUST immediately follow the tag itself.

Shawn?

> +----
> +	advertised-refs  =  (no-refs / list-of-refs)
> +			    flush-pkt
> +
> +	no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
> +				     NUL capability-list LF)
> +
> +	list-of-refs     =  first-ref *other-ref
> +	first-ref        =  PKT-LINE(obj-id SP refname
> +				     NUL capability-list LF)
> +
> +	other-ref        =  PKT-LINE(other-tip / other-peeled)
> +	other-tip        =  obj-id SP refname LF
> +	other-peeled     =  obj-id SP refname "^{}" LF
> +
> +	capability-list  =  capability *(SP capability)
> +    capability       =  1*(ALPHA / DIGIT / "-" / "_")
> +----
> +
> +Server and client SHOULD use lowercase for SHA1, both MUST treat SHA1
> +as case-insensitive.

Why do we need to retroactively loosen these to allow uppercases?  Are
there implementations that want this loosening?

> +Packfile Negotiation
> +--------------------

I'll look at the rest another day.

Thanks.
