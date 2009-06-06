From: Jakub Narebski <jnareb@gmail.com>
Subject: Comments pack protocol description in "Git Community Book" (second round)
Date: Sat, 6 Jun 2009 23:38:00 +0200
Message-ID: <200906062338.02451.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>, Tony Finch <dot@dotat.at>,
	Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:38:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD3aj-0002lu-Cu
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 23:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZFFViH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 17:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752370AbZFFViG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 17:38:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:30529 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbZFFViE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 17:38:04 -0400
Received: by fg-out-1718.google.com with SMTP id d23so502973fga.17
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=MWT1xVlGRO09m23XGbse5IiHtYvAfi8WA6ckgQWn4Fo=;
        b=AyylR1XQaeL6oev+Gh+BVWh7skhM9scTQBlVop9W6kntLnQ/0/ab/86B/Tcpbdo8Wx
         Dr1XXkqjgcpEIIh0X08prcZCQsNDWOr6vnLriEycTtTFqEQlMbEha/q3XIH3eGFava/G
         ggmwj2H1D0bXLFArW5nIRz6KU05+XTMyEvyYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=j1RwVer5Yvubuc90l+xasL+xqA2nWPaUa0wrykRu2BZAfz6Tz7eG4GIFf2vUvStpbB
         veWZoMfvBMt+BvYL+aXVMAbOba9zo5jRLLfkwi2iRjfFVqJk0F9aEFLZaIFxhCBgoxRz
         asIWOqL7A0yZRWT+Ad93P7iutQccj1aHd/Or4=
Received: by 10.86.51.2 with SMTP id y2mr5438488fgy.3.1244324285419;
        Sat, 06 Jun 2009 14:38:05 -0700 (PDT)
Received: from ?192.168.1.13? (abwg130.neoplus.adsl.tpnet.pl [83.8.230.130])
        by mx.google.com with ESMTPS id d4sm3265822fga.24.2009.06.06.14.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 14:38:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906022339.08639.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120940>

There are beginnings of description of git pack protocol in section
"Transfer Protocols"[1][2] of chapter "7. Internals and Plumbing"
of "Git Community Book" (http://book.git-scm.com).

 [1] http://book.git-scm.com/7_transfer_protocols.html
 [2] http://github.com/schacon/gitbook/blob/master/text/54_Transfer_Protocols/0_Transfer_Protocols.markdown

This is second round of my comments about this item. I'd like to have
some more comments about git pack protocol before trying to come up
with formulation which is good enough to send as patch against source
of mentioned section.

The relevant parts of above source are quoted as if they were email
I am replying too.

I have CC-ed everybody who participated in this subthread (originally
named "Re: Request for detailed documentation of git pack protocol").

....
> ### Fetching Data with Upload Pack ###
> 
> For the smarter protocols, fetching objects is much more efficient.  A
> socket is opened, either over ssh or over port 9418 (in the case of
> the git:// protocol), and the git-fetch-pack(1) command on the client
> begins communicating with a forked git-upload-pack(1) process on the
> server.
> 
> Then the server will tell the client which SHAs it has for each ref,
> and the client figures out what it needs and responds with a list of
> SHAs it wants and already has.

It would be probably more clear here to state explicitely that there
are two lists, i.e. "a list of SHAs it wants and a list of SHAs it
already has".

> 
> At this point, the server will generate a packfile with all the
> objects that the client needs and begin streaming it down to the
> client.

This is a bit of oversimplification.  In most simple case like client
using git-clone to get all objects it is true that server can generate
packfile and stream it to client after client tells a list of wanted
SHAs.  In more complicated case however there can be series of
exchanges between client and server, with client sending sets of
commits it have, and server responding whether it is enough (or
perhaps this line of commits is uninteresting)... and only then
arriving at list of objects to send in a packfile.

> 
> Let's look at an example.

I think that before example we should have short description (sketch)
of the whole exchange; for example the one taken from
'Documentation/technical/pack-protocol.txt':

upload-pack (S) | fetch/clone-pack (C) protocol:

  # Tell the puller what commits we have and what their names are
  S: SHA1 name
  S: ...
  S: SHA1 name
  S: # flush -- it's your turn
  # Tell the pusher what commits we want, and what we have
  C: want name
  C: ..
  C: want name
  C: have SHA1
  C: have SHA1
  C: ...
  C: # flush -- occasionally ask "had enough?"
  S: NAK
  C: have SHA1
  C: ...
  C: have SHA1
  S: ACK
  C: done
  S: XXXXXXX -- packfile contents.


> 
> The client connects and sends the request header. The clone command
> 
> 	$ git clone git://myserver.com/project.git
> 
> produces the following request:
> 
> 	0032git-upload-pack /project.git\\000host=myserver.com\\000

Although fetching via SSH protocol is, I guess, much more rare than
fetching via anonymous unauthenticated git:// protocol, it _might_ be
good idea to tell there that fetching via SSH differs from above
sequence that instead of opening TCP connection to port 9418 and
sending above packet, and later reading from and writing to socket,
"git clone ssh://myserver.com/srv/git/project.git" calls

	ssh myserver.com git-upload-pack /srv/git/project.git

and later reads from standard output of the above command, and writes
to standard input of above command.

The rest of exchange is _identical_ for git:// and for ssh:// (and
I guess also for file:// pseudoprotocol).

> 
> The first four bytes contain the hex length of the line (including 4
> byte line length and trailing newline if present). Following are the
> command and arguments. This is followed by a null byte and then the
> host information. The request is terminated by a null byte.

I think it would be better to describe packet (chunk) format, called
pkt-line in git, separately from describing the contents of above
packet; either first pkt-line then command, or first command then
pkt-line.  Otherwise we would be left with describing pkt-line format
many times, as it is done in current version of this chapter.


In git clients communicates with server using a packetized stream,
where each line (packet, chunk) is preceded by its length (including
the header) as a 4-byte hex number.  A length of 'zero', i.e. packet
"0000" has a special meaning: it means end of stream / flush
connection.  The "# flush ..." in description of client--server
exchange above is done using exactly "0000" packet. 

Footnote: this format somewhat reminds / resembles 'chunked' transfer
encoding used in HTTP[1], although there are differences.
  http://en.wikipedia.org/wiki/Chunked_transfer_encoding

> 
> The request is processed and turned into a call to git-upload-pack:
> 
>  	$ git-upload-pack /path/to/repos/project.git

This is alternate place where we could tell about fetching via ssh://

We probably should tell where /path/to/repos that /project.git is
prefixed with comes from; it is from --base-path=/path/to/repos
argument to git-daemon (a sort of "GIT root").

BTW. (this is just a very minor nit) shouldn't we use FHS compliant
path, i.e. "/srv/git" instead of "/path/to/repos" (and follow RFC in
using "example.com" in place of "myserver.com")?

> 
> This immediately returns information of the repo:
> 
> 	007c74730d410fcb6603ace96f1dc55ea6196122532d HEAD\\000multi_ack thin-pack side-band side-band-64k ofs-delta shallow no-progress include-tag\\n
> 	003e7d1665144a3a975c05f1f43902ddaf084e784dbe refs/heads/debug\\n
> 	003d5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/dist\\n
> 	003e7e47fe2bd8d01d481f44d7af0531bd93d3b21c01 refs/heads/local\\n
> 	003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/master\\n
> 	0000

I have added explicit LF terminators in the form of "\\n" (which would
render as "\n"), mainly because "0000" flush packed _doesn't_ have it.
Also I have added "include-tag", as modern git installations provide
this capability.

Here is a dilemma: currently example output is provided almost exactly
as-is, only indented and with some quoting/escaping (\\000 or \\0 for
NUL character, \\n for LF, later \\001 and \\002 for 0x01 and 0x02
bytes).  To know if given example output is what client sends or what
server outputs, you have to read the narrative.  Alternate solution
would be to use "C: " and "S: " prefixing (perhaps with some extra
format to make it more clear that it is not part of data), used in
pack-protocol.txt technical documentation, and proposed for describing
network protocols by some RFC (I don't remember which, unfortunately).
Which one to choose?


We would want, at some point, describe that first line of first
response from server contains 'stuffed' behind "\0" (NUL) space
separated list of capabilities our server supports.  Those
capabilities would have to be described somewhere: as a sidebar, 
or in a separate subsection, or in an appendix.

Below there is (for completeness) list of git-upload-pack
capabilities, with short description of each:

 * multi_ack (for historical reasons not multi-ack)

   It allows the server to return "ACK $SHA1 continue" as soon as it
   finds a commit that it can use as a common base, between the
   client's wants and the client's have set.

   By sending this early, the server can potentially head off the
   client from walking any further down that particular branch of the
   client's repository history.
 
   See the thread for more details (posts by Shawn O. Pearce and by
   Junio C Hamano).

 * thin-pack

   Server can send thin packs, i.e. packs which do not contain base
   elements for some delta chains, if those base elements are
   available on client side.  Client has thin-pack capability when it
   understand how to "thicken" them adding required delta bases,
   making those packfiles independent.

   Of course it doesn't make sense for client to use (request) this
   capability for git-clone... But if the client does request it (and
   I think modern clients actually do request it, even on initial
   clone case) the server won't produce a thin pack. Why?  There is no
   common base, so there is no uninteresting set to omit from the
   pack.  :-)
  
 * side-band 
 * side-band-64k 

   This means that server can send, and client understand multiplexed
   (muxed) progress reports and error info interleaved with the
   packfile itself.

   These two options are mutually exclusive. A client should ask for
   only one of them, and a modern client always favors side-band-64k.
   If client ask for both, server uses side-band-64k.

   Older side-band allows only up to 1000 bytes per packet.

 * ofs-delta 

   Server can send, and client understand PACKv2 with delta refering
   to its base by position in pack rather than by SHA-1.  Both can
   send/read OBJ_OFS_DELTA, aka type 6 in a pack file.

 * shallow 

   Server can send shallow clone (git clone --depth ...).

 * no-progress

   Client should use it if it was started with "git clone -q" or
   something, and doesn't want that side brand 2.  We still want
   sideband 1 with actual data (packfile), and sideband 3 with error
   messages.

 * include-tag

   If we pack an object to the client, and a tag points exactly at
   that object, we pack the tag too.  In general this allows a client
   to get all new tags when it fetches a branch, in a single network
   connection, instead of two (separate connection for tags).

   This capability is not to be used when client was called with
   '--no-tags'.

> 
> Each line starts with a four byte line length declaration in hex. The
> section is terminated by a line length declaration of 0000.

This repetition would not be necessary if pkt-line format had its own
description somewhere before.  We would probably still want to remind
the reader that "0000" line length declaration means 'flush'.

> 
> This is sent back to the client verbatim. 

Hmmm... "sent back ... verbatim"? I wonder what did you want to say
here...

> The client responds with another request:
> 
> 	0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack side-band-64k ofs-delta\\n
> 	0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\\n
> 	0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\\n
> 	0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\\n
> 	0032want 74730d410fcb6603ace96f1dc55ea6196122532d\\n
> 	0000
>       0009done\\n

Here again I added explicit LF terminator, and split off "0000" flush
packet in separate line, to make this request (well, two requests)
more clear.

The first line of this request contains capabilities client wants to
use.  It should be some subset of capabilities server supports.

> 
> The is sent to the open git-upload-pack process which then streams out
> the final response:

"_The_ is send"?

I would remove quotes around lines of server response below, but would
leave explicit \n for LF, and \\001 and \\002 for bytes 0x01 and 0x02
denoting channel.

> 
> 	"0008NAK\n"

This NAK means that server did not found [closed] set of common
ancestors. It is response to "0000" flush line ("had enough?" line)
from client. As the example is about git-clone, and client doesn't
_have_ any commits to show server as candidates for common ancestors
(calculation), it replies with "done" to get pack.

> 	"0023\\002Counting objects: 2797, done.\n"

This is a bit untypical example, as for larger repositories like Linux
kernel or even git repository, usually you would have much more
objects, and actually object enumeration would take more time.  You
would see many

	"0020\\002Counting objects: 10662   \r"
	"0020\\002Counting objects: 22318   \r"
	"0020\\002Counting objects: 29506   \r"

packets before

 	"0023\\002Counting objects: 65058, done.\n"

> 	"002b\\002Compressing objects:   0% (1/1177)   \r"
> 	"002c\\002Compressing objects:   1% (12/1177)   \r"
> 	"002c\\002Compressing objects:   2% (24/1177)   \r"
> 	"002c\\002Compressing objects:   3% (36/1177)   \r"
> 	"002c\\002Compressing objects:   4% (48/1177)   \r"
> 	"002c\\002Compressing objects:   5% (59/1177)   \r"
> 	"002c\\002Compressing objects:   6% (71/1177)   \r"
> 	"0053\\002Compressing objects:   7% (83/1177)   \rCompressing objects:   8% (95/1177)   \r"
> 	...
> 	"005b\\002Compressing objects: 100% (1177/1177)   \rCompressing objects: 100% (1177/1177), done.\n"

Sidenote: the reason why there is sometimes more than one line send in
a single packet / single pkt-line is buffering between git-pack-objects
which produces those messages to pipe, and git-upload-pack which reads
them and sends them to client.  If pack-objects can write two messages
into the pipe buffer before upload-pack is woken to read them out,
upload-pack might find two (or more) messages ready to read without
blocking.  These get bundled into a single packet, because, why not,
its easier to code it that way.

Here or a little later we probably should explain (even though it is
fairly obvious), that final response from server is (here) in pkt-line
with sideband format, where first byte of data denotes channel
(stream) number: 1 for data, 2 for progress info, 3 for fatal errors.

> 	"2004\\001PACK\\000\\000\\000\\002\\000\\000\n\\355\\225\\017x\\234\\235\\216K\n\\302"...
> 	"2005\\001\\360\\204{\\225\\376\\330\\345]z\226\273"...

Here I think it would be enough to show only the fragment which is
packfile signature...

> 	...
> 	"0037\\002Total 2797 (delta 1799), reused 2360 (delta 1529)\n"
> 	...
> 	"<\\276\\255L\\273s\\005\\001w0006\\001[0000"

This line is I think is broken in wrong place.  It is the tail
end of some packet (each packed begins with 4 characters wide 0-padded
length of chunk as hex number; "<\\276\\255L" does not match 4HEXDIG),
followed by "0000" 'flush' packet (here it signals end of stream).

> 	
> See the Packfile chapter previously for the actual format of the
> packfile data in the response.
> 
> 
....
-- 
Jakub Narebski
Poland
