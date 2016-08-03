Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890BE1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063AbcHCSas (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:30:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35683 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbcHCSao (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:30:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so37610827wmg.2
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 11:30:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pN8Bk3FhJq+pCBnCKSMcQa9bO2NraTJcWxbI5dZ7xEY=;
        b=nUlWekTtX3N+0N27IeDCwMLV5FeSo+QMrBaaZiXjyGtR7aKn5aXruP2rpcr4LSC7B5
         cvmG0PYUSoinSZT63bVGyLi64GBiJxli+Pw5+E9zhETF3Tsk0ho0XvhHFG8DgLMI9e0V
         28bYTDMPbgvofZCDDbGxI6InP+XyDovgFsA4MIwgWMuxmRycsh6z62oCGUp9Ur37j8oK
         ZzjVexjAcqx1oBVeG7AqbsJvoZ5jj1plKbGSzwiLfnyBRlhPbGBr8q3J3ZQ+kO82SlrQ
         GTcEt0F4Nts+Vh7CVt2463Eew/PcfrqgBdXva0rM7eRL3r9uQFX4EGmI8hUPmWQNrHb+
         Gziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=pN8Bk3FhJq+pCBnCKSMcQa9bO2NraTJcWxbI5dZ7xEY=;
        b=S8rDJiOuEgxmZm2leshdQW3um1Tiqot736BoXN/q39iqbptwvqWHzZFOLffMfXsBTL
         69aD+mHoCMSD7lw7W2N7ZdXZXR+rC4BxkS/FqRPgh+DCqeLSFmdi+9UPBWseEFi1+WwZ
         RfzbQm9NkCJ2qr4S7B28keiKFMJ+dWZrfH+FMVClKdVonLdof4q4ul3BXHmazbf7Lb1T
         jNgS3Qy7i8rsQH6opVjYWeoQ+FoO1IRjCS6+QCrjGkmhFiHYxITi8a3vzPw7flPvTXO2
         k/lZoX2QB7QDGSWLqusmfLZuJyoKnD/26T9YogjiLAWALAZXcf/pfVVqIU02ASjwGZ+0
         iXgw==
X-Gm-Message-State: AEkoouuxUg0BdidO7xsheRIANBWQvdUlWSYaTckoLKge94gKh7PNvvkD47bYo28jLvLLeA==
X-Received: by 10.28.156.213 with SMTP id f204mr24647613wme.86.1470249042794;
        Wed, 03 Aug 2016 11:30:42 -0700 (PDT)
Received: from [192.168.1.26] (daq191.neoplus.adsl.tpnet.pl. [83.23.16.191])
        by smtp.googlemail.com with ESMTPSA id g184sm28384426wme.15.2016.08.03.11.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2016 11:30:41 -0700 (PDT)
Subject: Designing the filter process protocol (was: Re: [PATCH v3 10/10]
 convert: add filter.<driver>.process option)
To:	Lars Schneider <larsxschneider@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/>
 <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160729233801.82844-11-larsxschneider@gmail.com>
 <b4c9ac5d-bd6b-141b-5b85-ab4aa719ccb0@gmail.com>
 <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Martin-Louis Bright <mlbright@gmail.com>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <607c07fe-5b6f-fd67-13e1-705020c267ee@gmail.com>
Date:	Wed, 3 Aug 2016 20:30:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <ABE7D2DB-C45F-4F29-8CC2-8D873FD6C36A@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

[I'm sorry for taking so long in writing this, as I see there is v4 already]

Greetings,


I'll answer to individual emails in more detail later, but I'd like to
go back to the drawing board, and attempt to summarize the discussion and
the proposal so far.

The ultimate goal is to be able to run filter drivers faster for both `clean`
and `smudge` operations.  This is done by starting filter driver once per
git command invocation, instead of once per file being processed.  Git needs
to pass actual contents of files to filter driver, and get its output.

We want the protocol between Git and filter driver process to be extensible,
so that new features can be added without modifying protocol.


1. CONFIGURATION

As I wrote, there are different ways of configuring new-type filter driver:

 * Using a separate variable to mark filter as using new protocol
   (the original approach):

   	[filter "protocol"]
		protocolVersion = v2
		clean  = rot13-clean-filter.pl
		smudge = rot13-smudge-filter.pl

   PROS: allows to have separate clean and smudge filters
   CONS: does not allow using old-style per-file filter together with new;
         easy to make mistake and use old-style filter, leading to hang

 * Creating new variables for new filter type, separate for each phase,
   for example `cleanProcess` and `smudgeProcess` (or `processClean` and
   `processSmudge`).

   	[filter "protocol"]
   		cleanProcess  = rot13-clean-filter.pl
   		smudgeProcess = rot13-smudge-filter.pl

   PROS: allows to have separate clean and smudge filters;
         makes possible to use per-file and per-command filters together
   CONS: proliferation of additional variables, (esp. when extending it);
   NOTE: need to decide precedence between `clean` and `cleanProcess`, etc.

 # Using a single variable for new filter type, and decide on which phase
   (which operation) is supported by filter driver during the handshake
   *(current approach)*

   	[filter "protocol"]
   		process = rot13-filtes.pl

   PROS: per-file and per-command filters possible with precedence rule;
         extensible to other types of drivers: textconv, diff, etc.
         only one invocation for commands which use both clean and smudge
   CONS: need single driver to be responsible for both clean and smudge;
         need to run driver to know that it does not support given
           operation (workaround exists)


2. HANDSHAKE (INITIALIZATION)

Next, there is deciding on and designing the handshake between Git (between
Git command) and the filter driver process.  With the `filter.<driver>.process`
solution the driver needs to tell which operations among (for now) "clean"
and "smudge" it does support.  Plus it provides a way to extend protocol,
adding new features, like support for streaming, cleaning from file or
smudging to file, providing size upfront, perhaps even progress report.

Current handshake consist of filter driver printing a signature, version
number and capabilities, in that order.  Git checks that it is well formed
and matches expectations, and notes which of "clean" and "smudge" operations
are supported by the filter.

There is no interaction from the Git side in the handshake, for example to
set options and expectations common to all files being filtered.  Take
one possible extension of protocol: supporting streaming.  The filter
driver needs to know whether it needs to read all the input, or whether
it can start printing output while input is incoming (e.g. to reduce
memory consumption)... though we may simply decide it to be next version
of the protocol.

On the other hand if the handshake began with Git sending some initializer
info to the filter driver, we probably could detect one-shot filter
misconfigured as process-filter.

Note that we need some way of deciding where handshake ends, either by
specifying number of entries (currently: three lines / pkt-line packets),
or providing some terminator ("smart" transport protocol uses flush packet
for this).

Current handshake (in symbolic form):

    git< [signature]    git-filter-protocol
    git< [version]      version 2
    git< [capabilites]  clean smudge

It is expected that the handshake is limited to this information, and
that they are in this order; so naming them doesn't buy us much

    git< [capabilites]  capabilities clean smudge

or

    git< [capabilites]  capabilities=clean smudge

or

    git< [capabilites]  capabilities: clean smudge

If capabilities are to be third item, adding "capabilities", as if Git would
look at the name and select what to do based on this name, doesn't buy us
anything.  Well, beside self-documenting of the protocol.  The "smart" protocol
do not use "capabilities" as prefix/name either.

We would probably do not want to move from strict-order of information, that
is "positional parameters".  It would require to implement a parser, both for
the Git side and for the filter driver process side.

On the other hand requiring flush packet to end the handshake doesn't bring
much overhead (it is 4 bytes, it is not over the network), and improves
extendability.  Well, so does using names, be it "<var> <value>", 
"<var>=<value>", "<var>: <value>...", "<var>=[<value>, <value>...]", etc.


Let's take a look how other parts of Git communicate with external process
(a "helper").

The git-credential(1) protocol uses <variable>=<value> syntax.  But capabilities
form a list; "<var>=<val1> <val2>" doesn't look that well.  Credential helper
only uses scalar (single) values.

The gitremote-helpers(1) protocol is command / response; for example helper
responds to "capabilities" command with the list of capabilities.  Here commands
and parameters are space separated, e.g. "option <name> <value>".

The "smart" transport protocol (send-pack and receive-pack) had to (ab)use
a quirk of implementation to extend protocol with capabilities negotiation.
Here the capabilities list is sent without any prefix; some capabilities
are parametrized, and use <capability>=<value> syntax (for example
"symref=HEAD:refs/heads/master").  The handshake is closed with flush
packet, but as it consist of variable-length ref advertisement, it needs
to have explicit terminator of the each part of the "handshake".


3. SENDING CONTENTS (FILE TO BE FILTERED AND FILTER OUTPUT)

Next thing to design is decision how to send contents to be filtered
to the filter driver process, and how to get filtered output from the
filter driver process.

One thing I think we can agree on early, is sending data to filter
process on its standard input, and receiving filtered result from its
standard output.

Because Git is sending (and receiving) multiple files, it needs some
way to distinguish where one file ends and the next begins, in both
directions, to and from filter.  Also, the `clean` and `smudge`
filters support expansion of the '%f' placeholder, so at least 
some filter drivers need name of the file being filtered.  So the
protocol must send it somehow to the filter driver.

There are different approaches possible; here are ones that were used,
and ones I thought about.

 * Send whole data to filter at once, and receiver all data at once,
   for example using something akin to the 'tar' archive, or 
   uncompressed 'zip' archive (both are implemented in Git for the
   `git archive` command).  Or just list of sizes and pathnames,
   empty entry as terminator, and then contents of all files
   concatenated.

   PROS:
   - can use the one-shot infrastructure implemented already
   CONS:
   - complicates Git code and filter driver code unnecessarily
   - difficult to implement error handling, esp. soft errors
     on filter driver side (error for single file, perhaps during
     output)
   - in synchronous version (non-streaming) requires absurd amout
     of memory / storage for the filter driver process

 * Send/receive data file by file, using <size> + <content>,
   that is, send size (plus other data like the filename), then
   file contents.

   This was the protocol used in the first iteration of series.

   PROS:
   - simple to implement on Git and on filter driver side
   NOTE:
   - you need to loop over read / user read_in_full anyway
   CONS:
   - no way to signal an error encountered during output, e.g. LFS
     network/server failure for after some contents were actually
     sent
   - impossible to implement streaming for filters that do not
     know size of output without examining full input

 # Send/receive data file by file, using some kind of chunking,
   with a end-of-file marker.  The solution used by Git is
   pkt-line, with flush packet used to signal end of file.

   This is protocol used by the current implementation.

   PROS:
   - no need to know size upfront, so easier streaming support
   - you can signal error that happened during output, after
     some data were sent, as well as error known upfront
   - tracing support for free (GIT_TRACE_PACKET)
   CONS:
   - filter driver program slightly more difficult to implement
   - some negligible amount of overhead

If we want in the end to implement streaming, then the last solution
is the way to go.


4. PER-FILE HANDSHAKE - SENDING FILE TO FILTER

Let's assume that for simplicity we want to implement (for now) only
the synchronous (non-streaming) case, where we send whole contents
of a file to filter driver process, and *then* read filter driver
output.  This is enough for git-LFS solutions, which were the reason
for this patch series.  But we want to keep the protocol flexible
enough so that streaming and other features could be added easily.

First, if we choose the solution where one process is responsible
for both "clean" and "smudge" operations (and in the future possibly
also "cleanFromFile" and "smudgeToFile"), Git needs to tell the
driver which operation to perform.

Together with operation Git can send additional information
(sub-capabilities)... or we can use a separate line / packet to
send it.

If we are using pkt-line, then the convention is that text lines
are terminated using LF ("\n") character.  This needs to be stated
explicitly in the documentation for filter.<driver>.process writers.

    git> packet:  [operation] clean size=67\n

We could denote that it is operation name, but it is obvious from
position in the stream, thus not really needed.

Then we need to provide the filename; some filters supposedly need
this ('%f' in per-file `clean` / `smudge`).  Note that filename can
contain internal space characters, and could contain newlines, equal
signs; anything that is not NUL ("\0") character.

    git> packet:  [pathname] subdir/sample-file.r\n

In most cases filename would be text, so perhaps we should use "\n"
terminator (which filter driver would have to strip).  We could use
"filename=" prefix, but it is not necessary.  We know where / when
to expect the pathname (relative to project root).

If we would want to be able to add variable number of packets to
the handshake, then Git should send flush packet to signal the
end of the handshake.  But IMVHO it is unnecessary complication
of the protocol; there is enough flexibility in it.  We know
that handshake consists of two packets.

The Git would sent contents of the file to be filtered, using
as many pack lines as needed (note: large file support needs
to be tested, at least as expensive test).  Flush packet is
used to signal the end of the file.

    git> packets:  <file contents>
    git> flush packet


5. FILTER DRIVER PROCESS RESPONSE

First filter should, in my opinion, reply that it received the
request (or the command, in the case of streaming supported).
Also, in this response it can provide further information to
Git process.

    git< packet: [received]  ok size=67\n

This response could be used to refuse to filter specific file
upfront (for example if the file is not present in the artifactory
for git-LFS solutions).

   git< packet: [rejected]  reject\n

We can even provide the reasoning to Git (maybe in the future
extension)... or filter driver can print the explanation to the
standard error (but then, no --quiet / --verbose support).

   git< packet: [rejected]  reject with-message\n
   git< packet: [message]   File not found on server\n
   git< flush packet

Another response, which I think should be standarized, or at
least described in the documentation, is filter driver refusing
to filter further (e.g. git-LFS and network is down), to be not
restarted by Git.

   git< packet: [quit]      quit msg=Server error\n

or

   git< packet: [quit]      quit Server error\n

or

   git< packet: [quit]      quit with-message\n
   git< packet: [message]   Server error\n
   git< flush packet

Maybe this is over-engineering, but I don't think so.

Next comes the output from the filter driver (filtered contents),
using possibly multiple pkt-lines, ending with a flush packet:

    git< packets:  <filtered contents>
    git< flush packet

Note that empty file would consist of zero pack lines of contents,
and one flush packet.

Finally, to allow handling of [resumable] errors that occurred
during sending file contents, especially for the future streaming
filters case, we want to confirm that we send whole file
successfully.

    git< packet: [status]   success\n

If there was an error during process, making data receives so far
invalid, filter driver should tell about it

    git< packet: [status]   fail\n

or

    git< packet: [status]   reject\n

This may happen for example for UCS-2 <-> UTF-8 filter when invalid
byte sequence is encountered.  This may happen for git-LFS if the
server fails during fetch, and spare / slave server doesn't have
a file.

We may want to quit filtering at this point, and not to send another
file.

   git< packet: [status]    quit\n

There is place for extra information after the status, and in the
future we can allow variable length information too.


Best,
-- 
Jakub Narębski
