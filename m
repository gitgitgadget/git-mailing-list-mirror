From: Tay Ray Chuan <rctay89@gmail.com>
Subject: (resend v2) Re: [RFC PATCH 1/4] Document the HTTP transport
 protocol
Date: Thu, 8 Apr 2010 03:11:59 +0800
Message-ID: <20100408031159.00006ec7@unknown>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <7vskdss3ei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 21:12:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzafp-0005ve-Hu
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 21:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169Ab0DGTMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 15:12:20 -0400
Received: from mail-bw0-f161.google.com ([209.85.218.161]:63032 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756245Ab0DGTMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 15:12:19 -0400
Received: by bwz1 with SMTP id 1so127436bwz.1
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 12:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=h2RaOR5K/E6FRgNc+88bpQ4qb95tLa8q6b0kTI+AG3Y=;
        b=PDXm/xC05ZUTwTBuRTh1V+eKpbKvMgqF5tKeYhDwM4rtV+P06Ac1QgMB4q0I7+WdRn
         UiQZbtxdeJu6BxrjYUfiuKQ6vJZcjpO0XXbfsSz3+KlsoLONarr24WylOqRtIFe5gd2e
         S+44EIDV02wpd3ljY3OcVCeRk4axFh6qhi30I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=k0ABlg2DEPD1xNuwYQF1XUBoZ04UxTzPVh1v4g8IvJDZi1qVBx/oWVD4MhzWZ1NZZX
         IJumRAdRVScDArDcnPHB6BDifW+0frCRlrdzqfvwTD41XKpx6thdptfAVwgXbeRDkHLy
         Oxw2JT3oO27+Z5pdTdpIaM+6+s8JgPrrpLpMM=
Received: by 10.204.22.75 with SMTP id m11mr3421961bkb.51.1270667536220;
        Wed, 07 Apr 2010 12:12:16 -0700 (PDT)
Received: from unknown (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id 13sm7077098bwz.3.2010.04.07.12.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 12:12:15 -0700 (PDT)
In-Reply-To: <7vskdss3ei.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.4cvs1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144272>

(sorry for the multiple copies - something wrong with my MUA. Had to
give it a kiss in the a** to get it working.)

(v2 - added back headers. My apologies again.)

Hi,

(I'm reviving this thread to complete the document. What I have right
now is available at my github repo; you can see it at

  http://github.com/rctay/git/compare/git/next...feature/http-doc#files_bucket

.

An inlined patch should be sent in soon.)

On Fri, 09 Oct 2009 13:44:53 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
> > new file mode 100644
> > index 0000000..316d9b6
> > --- /dev/null
> > +++ b/Documentation/technical/http-protocol.txt
> > @@ -0,0 +1,542 @@
> > +HTTP transfer protocols
> > +=======================
> > ...
> > +As a design feature smart clients can automatically upgrade "dumb"
> > +protocol URLs to smart URLs.  This permits all users to have the
> > +same published URL, and the peers automatically select the most
> > +efficient transport available to them.
>
> The first sentence feels backwards although the conclusion in the second
> sentence is true.  It is more like smart ones trying smart protocol first,
> and downgrading to "dumb" after noticing that the server is not smart.

I think Shawn is trying to describe this from the persepective of the
client implementation - a "dumb" url is first constructed, then
"upgraded" to a "smart" one.

> > +Authentication
> > +--------------
> > ...
> > +Clients SHOULD support Basic authentication as described by RFC 2616.
> > +Servers SHOULD support Basic authentication by relying upon the
> > +HTTP server placed in front of the Git server software.
>
> It is perfectly fine to make it a requirement for a server to support the
> Basic authentication, but should you make it a requirement that the
> support is done by a specific implementation, i.e. "by relying upon..."?

I think the term "Server" in this document is implied as an amalgam of
the HTTP server, and a CGI script/program ("Git server software"). I
think what Shawn meant was for Basic authentication to be implemented
at the server layer, not in the CGI scripts/program.

> > +Session State
> > +-------------
> > ...
> > +retained and managed by the client process.  This permits simple
> > +round-robin load-balancing on the server side, without needing to
> > +worry about state mangement.
>
> s/mangement/management/;

Done.

> > +pkt-line Format
> > +---------------
> > ...
> > +Examples (as C-style strings):
> > +
> > +  pkt-line          actual value
> > +  ---------------------------------
> > +  "0006a\n"         "a\n"
> > +  "0005a"           "a"
> > +  "000bfoobar\n"    "foobar\n"
> > +  "0004"            ""
> > +
> > +A pkt-line with a length of 0 ("0000") is a special case and MUST
> > +be treated as a message break or terminator in the payload.
>
> Isn't this "MUST be" wrong?
>
> It is not an advice to the implementors, but the protocol specification
> itself defines what the flush packet means.  IOW, "The author of this
> specification, Shawn, MUST treat a flush packet as a message break or
> terminator in the payload, when designing this protocol."

This section has been purged; we already have this in
Documentation/technical/protocol-common.txt.

> > +General Request Processing
> > +--------------------------
> > +
> > +Except where noted, all standard HTTP behavior SHOULD be assumed
> > +by both client and server.  This includes (but is not necessarily
> > +limited to):
> > +
> > +If there is no repository at $GIT_URL, the server MUST respond with
> > +the '404 Not Found' HTTP status code.
>
> We may also want to add
>
>     If there is no object at $GIT_URL/some/path, the server MUST respond
>     with the '404 Not Found' HTTP status code.
>
> to help dumb clients.

Proposed re-wording:

  If there is no repository at $GIT_URL, or the resource pointed to by a
  location containing $GIT_URL does not exist, the server MUST NOT respond
  with '200 OK' response.  A server SHOULD respond with
  '404 Not Found', '410 Gone', or any other suitable HTTP status code
  which does not imply the resource exists as requested.

(The 'valid info/refs response' part has been dropped.)

> > +Dumb Clients
> > +~~~~~~~~~~~~
> > +
> > +HTTP clients that only support the "dumb" protocol MUST discover
> > +references by making a request for the special info/refs file of
> > +the repository.
> > +
> > +Dumb HTTP clients MUST NOT include search/query parameters when
> > +fetching the info/refs file.  (That is, '?' must not appear in the
> > +requested URL.)
>
> It is unclear if '?' can be part of $GIT_URL. E.g.
>
>     $ wget http://example.xz/serve.cgi?path=git.git/info/refs
>     $ git clone http://example.xz/serve.cgi?path=git.git
>
> It might be clearer to just say
>
>     Dumb HTTP clients MUST make a GET request against $GIT_URL/info/refs,
>     without any search/query parameters.  I.e.
>
> 	C: GET $GIT_URL/info/refs HTTP/1.0
>
> to also exclude methods other than GET.

Done.

> > +	C: GET $GIT_URL/info/refs HTTP/1.0
> > +
> > +	S: 200 OK
> > ...
> > +When examining the response clients SHOULD only examine the HTTP
> > +status code.  Valid responses are '200 OK', or '304 Not Modified'.
>
> Isn't 401 ("Ah, I was given a wrong URL") and 403 ("Ok, I do not have an
> access to this repository") also valid?

I think "valid" for the client means "ok, continue processing
normally".

> > +The returned content is a UNIX formatted text file describing
> > +each ref and its known value.  The file SHOULD be sorted by name
> > +according to the C locale ordering.  The file SHOULD NOT include
> > +the default ref named 'HEAD'.
>
> I know you said "known" to imply "concurrent operations may change it
> while the server is serving this client", but it feels rather awkward.

TODO

> > +Smart Server Response
> > +^^^^^^^^^^^^^^^^^^^^^
> > +
> > +Smart servers MUST respond with the smart server reply format.
> > +If the server does not recognize the requested service name, or the
> > +requested service name has been disabled by the server administrator,
> > +the server MUST respond with the '403 Forbidden' HTTP status code.
>
> This is a bit confusing.
>
> If you as a server administrator want to disable the smart upload-pack for
> one repository (but not for other repositories), you would not be able to
> force smart clients to fall back to the dumb protocol by giving "403" for
> that repository.
>
> Maybe in 2 years somebody smarter than us will have invented a more
> efficient git-upload-pack-2 service, which is the only fetch protocol his
> server supports other than dumb.  If your v1 smart client asks for the
> original git-upload-pack service and gets a "403", you won't be able to
> fall back to "dumb".
>
> The solution for such cases likely is to pretend as if you are a dumb
> server for the smart request.  That unfortunately means that the first
> sentence is misleading, and the second sentence is also an inappropriate
> advice.

Proposed rewording:

  If the server does not recognize the requested service name, or the
  requested service name has been disabled by the server administrator,
  the server MUST respond with the '403 Forbidden' HTTP status code.

  Otherwise, smart servers MUST respond with the smart server reply
  format for the requested service name.

> > +The Content-Type MUST be 'application/x-$servicename-advertisement'.
> > +Clients SHOULD fall back to the dumb protocol if another content
> > +type is returned.  When falling back to the dumb protocol clients
> > +SHOULD NOT make an additional request to $GIT_URL/info/refs, but
> > +instead SHOULD use the response already in hand.  Clients MUST NOT
> > +continue if they do not support the dumb protocol.
>
> The part I commented on (the beginning of Smart Server Response) was
> written as a generic description, not specific to git-upload-pack service,
> and the beginning of this paragraph also pretends to be a generic
> description, but it is misleading.  This is a specific instruction to the
> clients that asked for git-upload-pack service and got a dumb server
> response (if the above were talking about something other than upload-pack
> service, there is no guarantee that "response already in hand" is useful
> to talk to dumb servers).

Previous hunk should fix this.

> > +	ref_list       = empty_list | populated_list
> > +
> > +	empty_list     = PKT-LINE(id SP "capabilities^{}" NUL cap_list LF)
> > +
> > +	non_empty_list = PKT-LINE(id SP name NUL cap_list LF)
> > +	                 *ref_record
>
> [snip]
>
> Did you define what "populated_list" is?

I think "non_empty_list" was meant.

Ideally, ref advertisements should be in protocol-common.txt.

> > +Smart Service git-upload-pack
> > +------------------------------
> > +This service reads from the remote repository.
>
> The wording "remote repository" felt confusing.  I know it is "from the
> repository served by the server", but if it were named without
> "upload-pack", I might have mistaken that you are allowing to proxy a
> request to access a third-party repository by this server.  The same
> comment applies to the git-receive-pack service.

Would

  This service reads from the repository pointed to by $GIT_URL.

be an improvement?

> > +Capability include-tag
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +When packing an object that an annotated tag points at, include the
> > +tag object too.  Clients can request this if they want to fetch
> > +tags, but don't know which tags they will need until after they
> > +receive the branch data.  By enabling include-tag an entire call
> > +to upload-pack can be avoided.
> > +
>
> I think you are avoiding an "extra" call; you would need one entire call
> to upload-pack anyway for the primary transfer.

Done.

--
Cheers,
Ray Chuan
