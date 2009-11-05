From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Wed, 04 Nov 2009 21:24:30 -0800
Message-ID: <7v8welbl2p.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 06:24:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5uq0-0005LA-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 06:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbZKEFYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 00:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbZKEFYh
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 00:24:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52433 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZKEFYg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 00:24:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 97C32932EA;
	Thu,  5 Nov 2009 00:24:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sKhmnKvtpNRvpYbB3qT15A6YWmU=; b=o8ashh
	VkljHgfdNgwMeaFaCwPnvVmjxkXNy1gvJ79hPtmv/Xvsje9DweDb4ZMspX5noFLP
	h4Ozcx+sMrh0KCjqW6W4Pjvm10ii52J19Qp5e6jMjLHcciq0X3QLKn48YLTJ2Yjw
	rnUI6/KqoZxU5TCDDlkhBT0wgs1M70DZNwUSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spWZInXvJQAv5jm4QL5V1kyLZ69szric
	XdRRAOJODI1BXPWYkHQgv5Y+KhCWinN3C4do6EvK12FHBOyMrxbtI2Zephkbrd23
	sRyNejP6DA8lsN5I9DTdi+GxGxbknZoVLv3dXWiVt0bTLAE4Rw32dCa3/kIjOc9k
	qwqaAR7+tUY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6B4F8932E9;
	Thu,  5 Nov 2009 00:24:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 532D6932E5; Thu,  5 Nov 2009
 00:24:32 -0500 (EST)
In-Reply-To: <d411cc4a0911032158j2a4664e5w2601c4af59ba0837@mail.gmail.com>
 (Scott Chacon's message of "Tue\, 3 Nov 2009 21\:58\:23 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 832CA8BE-C9CB-11DE-88FD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132197>

Scott Chacon <schacon@gmail.com> writes:

> The technical documentation for the packfile protocol is both sparse and
> incorrect.  This documents the fetch-pack/upload-pack and send-pack/
> receive-pack protocols much more fully.

Thanks.

In this round, my comments ended up being mostly "nit-picky", although I
spotted a few logic errors.

> +Git Transport
> +-------------
> +
> +The Git protocol starts off by sending the command and repository

"transport"

> +on the wire using the pkt-line format, followed by a null byte and a
> +hostname paramater, terminated by a null byte.

The name of the byte whose value is 0 is "NUL", not "NULL" (as you
correctly did in the "Reference Discovery" section).

> +Basically what the Git client is doing to connect to an 'upload-pack'
> ...
> +SSH Transport
> ...
> +It is basically equivalent to running this:

> +Reference Discovery
> +-------------------
> +
> +When the client initially connects the server will immediately respond
> +with a listing of each reference it has (all branches and tags) along
> +with the object name that each reference currently points to.
> +
> +   $ echo -e -n "0039git-upload-pack
> /schacon/gitbook.git\0host=example.com\0" |

Oops...

> +      nc -v example.com 9418
> +   00887217a7c7e582c46cec22a130adf4b9d7d950fba0 HEAD\0multi_ack
> thin-pack side-band side-band-64k ofs-delta shallow no-progress
> include-tag

Oops...

It is perfectly fine to fold a long line in the document.  What I
earlier suggested was to state the fact that the document _did_ fold
a long line for typographical reasons and in the actual protocol it
is a single long line to the reader.

> +The returned response is a pkt-line stream describing each ref and
> +its known value.  The stream MUST be sorted by name according to
> +the C locale ordering.

Do we need to say "known"?

> ...
> +  advertised-refs  =  (no-refs / list-of-refs)
> +                      flush-pkt
> +
> +  no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
> +                      NUL capability-list LF)
> +
> +  list-of-refs     =  first-ref *other-ref
> +  first-ref        =  PKT-LINE(obj-id SP refname
> +                      NUL capability-list LF)
> +
> +  other-ref        =  PKT-LINE(other-tip / other-peeled)
> +  other-tip        =  obj-id SP refname LF
> +  other-peeled     =  obj-id SP refname "^{}" LF
> +
> +  capability-list  =  capability *(SP capability)
> +  capability       =  1*(LC_ALPHA / DIGIT / "-" / "_")
> +  LC_ALPHA         =  %x61-7A
> +----
> +
> +Server and client SHOULD use lowercase for SHA1, both MUST treat SHA1
> +as case-insensitive.

I hate to sound like a broken parrot, but ...

 - You do not have SHA1 in the above list; say "obj-id".

 - Why is this SHOULD and not MUST?  It's not like you or somebody else
   have already written such a broken server or client and you have to
   grandfather it by defining what goes over the wire looser than the
   current practice.  I think this is taking the "be liberal in what you
   accept" mantra too literally without real reason for doing so.

> +Packfile Negotiation
> +--------------------
> +After reference and capabilities discovery, the client can decide
> +to terminate the connection by sending a flush-pkt, telling the
> +server it can now gracefully terminate (as happens with the ls-remote
> +command) or it can enter the negotiation phase, where the client and
> +server determine what the minimal packfile necessary for transport is.
> +
> +Once the client has the initial list of references that the server
> +has, as well as the list of capabilities, it will begin telling the
> +server what objects it wants and what objects it has, so the server
> +can make a packfile that only has the objects that the client needs.

"only has" -> "only contains", perhaps, as the above has too many has
already?

> +The client will also send a list of the capabilities it supports out
> +of what the server said it could do with the first 'want' line.

It is not _wrong_ per-se, but it is not about client "supporting".  It is
asking these particular protocol extensions enabled.  How about...

	.. will also send a list of the capabilities it wants to be in
        effect, out of ...

> +If the server reads 'have' lines, it then will respond by ACKing any
> +of the obj-ids the client said it had that the server also has. The
> +server will ACK obj-ids differently depending on which ack mode is
> +signaled by the client.

Perhaps "signaled" -> "chosen"?

> +In multi_ack mode:
> ...
> +In multi_ack_detailed mode:
> ...
> +Without multi_ack:
> ...

The last one is "without multi_ack or multi_ack_detailed", isn't it?
I think the order you described these three is sensible (from the most
commonly deployed to merely describing a historical practice).

> +Packfile Data
> +-------------
> +
> +Now that the client and server have done some negotiation about what
> +the minimal amount of data that can be sent to the client is, the server
> +will construct and send the required data in packfile format.

Perhaps "done some" -> "finished"?

Is it "can be sent" or "needs to be sent"?

> +Pushing Data To a Server
> ...
> +references to be complete.  Once all the data is received and validated,
> +the server will then update it's references to what the client specified.

"it's" -> "its".

> +Reference Discovery
> +-------------------
> +
> +The reference discovery phase is done nearly the same way as it is in the
> +fetching protocol. Each reference obj-id and name on the server is sent
> +in packet-line format to the client, followed by a flush packet.  The only

I slightly prefer "a flush packet" spelled out like this, but please be
consistent either way.  You have only two instances of spelled-out "flush
packet" around this section, and everywhere else in this patch you used
"flush-pkt" (I am talking about explanation prose, not ABNF, in which you
consistently used "flush-pkt" everywhere), so changing these "flush
packet" to "flush-pkt" may be easier to change and less error prone.

> +A pack-file MUST be sent if either create or update command is used,
> +even if the server already has all the necessary objects.  In this
> +case the client MUST send an empty pack-file.   The only time this
> +is likely to happen is if the client is doing something like creating
> +a new branch that points to an existing obj-id.

"doing something like" is redundant.

> +The server will receive the packfile, unpack it, then validate each
> +reference that is being updated that it hasn't changed while the request
> +was being processed (the obj-id is still the same as the old-id), and
> +it will run any update hooks to make sure that the update is acceptable.
> +If all of that is fine, the server will then update the references.

Strictly speaking, "unpack it" is a wrong thing to say in a protocol
specification document.  The only requirement is for the server to make
objects in it accessible before the ref update takes place.  The objects
need to be accessible when hooks run.

I was about to suggest "store objects in it in the repository" instead,
but in the status report we do use a successful "unpack" to mean "made
objects accessible successfully", so it probably is Ok as-is.  At least I
cannot think of a better way to rephrase this part.

> +Report Status
> +-------------
> +
> +After receiving the pack data from the sender, the client sends a

"the client sends" -> "the server sends".

Even though it makes me a bit uneasy to describe these entities "server vs
client" (I'd prefer "sender" vs "receiver"), the entire document is
written based on the assumption that "clients" fetch from or push to "the
server", so let's be consistent.

> +report if 'report-status' capability was sent to the server.
> +It is a short listing of what happened in that update.  It will first
> +list the status of the packfile unpacking as either 'unpack ok' or
> +'unpack [error]'.  Then it will list the status for each of the references
> +that it tried to update.  Each line be either 'ok [refname]' if the

Sorry for asking a language question but "be"?

> +An example client/server communication might look like this:
> +
> +----
> +   S: 007c74730d410fcb6603ace96f1dc55ea6196122532d
> refs/heads/local\0report-status delete-refs ofs-delta\n
> +   S: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\n
> +   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\n
> +   S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
> +   S: 0000
> +
> +   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe
> 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
> +   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d
> 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n

Oops.

> diff --git a/Documentation/technical/protocol-capabilities.txt
> b/Documentation/technical/protocol-capabilities.txt
> new file mode 100644
> index 0000000..f4bf986
> --- /dev/null
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -0,0 +1,186 @@
> +Git Protocol Capabilities
> +=========================
> +
> +Servers SHOULD support all capabilities defined in this document.
> +
> +On the very first line of the initial server response of either
> +receive-pack and upload-pack the first reference is followed by
> +a null byte and then a list of space delimited server capabilities.

"null" -> "NUL"

> +Client will then send a space separated list of capabilities it
> +can support. The client SHOULD NOT ask for capabilities the server
> +did not say it supports.
> +
> +Server MUST ignore capabilities it does not understand.  Server MUST
> +NOT ignore capabilities that client requested and server advertised.
> +

I hate to sound like a broken parrot, but ...

 - It is more like "Client will ... it wants enabled", not "it can
   support".

 - Is this really "SHOULD NOT", as opposed to "MUST NOT"?  What are
   examples of plausible justifications for client implementations to
   violate this requirement and ask for a capability that it knows the
   server does not support?

 - Shouldn't server "MUST diagnose and abort" connection when client
   requests a protocol feature (i.e. capability) that it does not
   understand?

When the server advertises a capability it itself does not understand
and the client asked for it, then the client can legitimately ask for
it, and the server is not allowed to ignore it, but it must ignore it, so
it cannot satisfy this requirement.  We should spell out that the server
MUST NOT advertise capabilities it does not understand.

> +thin-pack
> +---------
> +
> +This capability implies that the server can send 'thin' packs, packs

Does it imply or explicitly state?  I think it is the latter.

> +which do not contain base objects; if those base objects are available
> +on client side. Client requests 'thin-pack' capability when it
> +understands how to "thicken" them adding required delta bases making
> +them self contained.

A single pack is sent over the wire and thicking it will create a single
pack self contained, hence "making it self contained".

> +Client MUST NOT request 'thin-pack' capability if it cannot turn thin
> +packs into proper independent packs.

"a think pack into a self contained pack"

> +side-band, side-band-64k
> +------------------------
> +
> +This means that server can send, and client understand multiplexed
> +progress reports and error info interleaved with the packfile itself.

Either "This" -> "This capability", or just begin the sentence with
"Server can send..." like your description of "ofs-delta".

> +delete-refs
> +-----------
> +
> +If the server sends back the 'delete-refs' capability, it means that
> +it is capable of accepting an all-zeroed SHA-1 value as the target
> +value of a reference update.  It is not sent back by the client, it
> +simply informs the client that it can be sent zeroed SHA-1 values
> +to delete references.

You earlier called these "all-zeroed SHA-1 value"s "zero-id"s.  Be
consistent.

> diff --git a/Documentation/technical/protocol-common.txt
> b/Documentation/technical/protocol-common.txt
> new file mode 100644
> index 0000000..2dca642
> --- /dev/null
> +++ b/Documentation/technical/protocol-common.txt
> @@ -0,0 +1,96 @@
> ...
> +A refname is a hierarichal octet string beginning with "refs/" and

"hierarchical"
