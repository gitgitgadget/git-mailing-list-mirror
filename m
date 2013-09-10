From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 00/14] document edits to original http protocol documentation
Date: Wed, 11 Sep 2013 01:07:44 +0800
Message-ID: <1378832878-12811-1-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, Jeff King <peff@peff.net>,
	"Shawn O . Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:08:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQU-00037D-VL
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754016Ab3IJRIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 13:08:24 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48348 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3IJRIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:19 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so8034874pab.13
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CWV02J/sxNWPUizJQNf6maLnKwBckutZsbdIlA/xHaU=;
        b=lXqiwzQzNceGYT8EIjSg3C278U0n5NVNDZjMhSNhcdUYP7PEboxyw3G4Hy9SciqkVs
         010gU6OcXrPbbasi83lQNg9yTF0Jh+lpDsVv6K6o3GxDG5JG1XznmQ63eBWbcc1KtV3d
         Hmp2esjz0qE2s4EODpgkjbKDUW05xG8eyN6CMQvZvuS+6NvW7gUGNApI1IvdfGR46qbN
         WlfRRWx6ApAowo/d+kcQDXlczkW2K6/hn8/HpC42u12qYMS5mXwM8uopOrPhfFtWMoDJ
         nXOiWkMTQlpDDJBwEKpahWECXN3XErKC0VmZW7GxD9DTm3DAHvQCef5e0SVbDdz9YD4e
         q7KQ==
X-Received: by 10.68.241.6 with SMTP id we6mr9709108pbc.174.1378832898768;
        Tue, 10 Sep 2013 10:08:18 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1255065768-10428-2-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234447>

This patch series are the changes based on the discussion on Shawn's
original text [1]. Some of them are minor, while some may potentially
change behaviour; see below for a classification of the changes.
Hopefully they can be examined by the git contributors here.

An earlier iteration of this patch series [2], including additional
changes by Nguyen [3], had been merged in 36d8020 (Merge branch
'sp/doc-smart-http', Aug 30). Since that iteration, the changes have
been corrected and consolidated. Effort has also been made to provide
the context for the changes; hopefully it helps with the review.

[1] http://mid.gmane.org/<1255065768-10428-2-git-send-email-spearce@spearce.org>
[2] https://github.com/rctay/git/blob/rc/http-doc/v1/p/Documentation/technical/http-protocol.txt
[3] http://mid.gmane.org/<1377092713-25434-1-git-send-email-pclouds@gmail.com>

(For convenience, a diff against 36d8020 is included at the end of this
message; it is in word-diff form, hopefully for better clarity of the
changes.)

Given that an earlier iteration had already been merged, perhaps that
could be replaced with merge -Xtheirs (just throwing ideas, my git-fu is
not that strong). This would make the changes on the original RFC
available eg. via git-blame, which may be helpful for implementations
made based on the original RFC, especially since these "early"
implementations may now be in violation of the recently-included copy of
the spec.

The patches have been grouped based on their "safeness" (with regard to
potentially changing the protocol spec), with a bias towards caution, as
follows:

Trivial changes (eg formatting, style):
  [PATCH 01/14] Document the HTTP transport protocol
  [PATCH 02/14] normalize indentation with protcol-common.txt
  [PATCH 03/14] capitalize key words according to RFC 2119
  [PATCH 04/14] normalize rules with RFC 5234
  [PATCH 05/14] drop rules, etc. common to the pack protocol
  [PATCH 10/14] fix example request/responses
  [PATCH 13/14] shift dumb server response details
  
Rewords based on discussions that have been settled, or seem safe:
  [PATCH 07/14] weaken specification over cookies for authentication
  [PATCH 09/14] reduce ambiguity over '?' in $GIT_URL for dumb clients
  [PATCH 11/14] be clearer in place of 'remote repository' phrase
  
Potentially behaviour-changes, may need of discussion:
  [PATCH 06/14] reword behaviour on missing repository or objects
  [PATCH 08/14] mention different variations around $GIT_URL
  [PATCH 12/14] reduce confusion over smart server response behaviour
  [PATCH 14/14] mention effect of "allow-tip-sha1-in-want" capability

Full, ordered listing:
  [PATCH 01/14] Document the HTTP transport protocol
  [PATCH 02/14] normalize indentation with protcol-common.txt
  [PATCH 03/14] capitalize key words according to RFC 2119
  [PATCH 04/14] normalize rules with RFC 5234
  [PATCH 05/14] drop rules, etc. common to the pack protocol
  [PATCH 06/14] reword behaviour on missing repository or objects
  [PATCH 07/14] weaken specification over cookies for authentication
  [PATCH 08/14] mention different variations around $GIT_URL
  [PATCH 09/14] reduce ambiguity over '?' in $GIT_URL for dumb clients
  [PATCH 10/14] fix example request/responses
  [PATCH 11/14] be clearer in place of 'remote repository' phrase
  [PATCH 12/14] reduce confusion over smart server response behaviour
  [PATCH 13/14] shift dumb server response details
  [PATCH 14/14] mention effect of "allow-tip-sha1-in-want" capability

This patch series is queued at:

  https://github.com/rctay/git/commits/rc/http-doc/v2/q

-- 
1.8.4.rc4.527.g303b16c

output of

  $ git diff -b --word-diff 36d8020 -- Documentation/technical/http-protocol.txt

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index a1173ee..acc68ac 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -11,6 +11,10 @@ protocol URLs to smart URLs.  This permits all users to have the
same published URL, and the peers automatically select the most
efficient transport available to them.

{+The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL+}
{+NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and+}
{+"OPTIONAL" in this document are to be interpreted as described in+}
{+RFC 2119.+}

URL Format
----------
@@ -33,16 +37,13 @@ An example of a dumb client requesting for a loose object:
  $GIT_URL:     http://example.com:8080/git/repo.git
  URL request:  http://example.com:8080/git/repo.git/objects/d0/49f6c27a2244e12041955e262a404c7faba355

An example of a smart request to a catch-all [-gateway:-]{+gateway (notice how the+}
{+'service' parameter is passed with '&', since a '?' was detected in+}
{+$GIT_URL):+}

  $GIT_URL:     http://example.com/daemon.cgi?svc=git&q=
  URL request:  http://example.com/daemon.cgi?svc=git&q=/info/refs&service=git-receive-pack

[-An example of a request to a submodule:-]

[-  $GIT_URL:     http://example.com/git/repo.git/path/submodule.git-]
[-  URL request:  http://example.com/git/repo.git/path/submodule.git/info/refs-]

Clients MUST strip a trailing '/', if present, from the user supplied
$GIT_URL string to prevent empty path tokens ('//') from appearing
in any URL sent to a server.  Compatible clients MUST expand
@@ -103,9 +104,10 @@ Except where noted, all standard HTTP behavior SHOULD be assumed
by both client and server.  This includes (but is not necessarily
limited to):

If there is no repository at $GIT_URL, [-or-]{+the server MUST NOT respond with+}
{+'200 OK' and a valid info/refs response.  Also, if+} the resource pointed
to by a location matching $GIT_URL does not exist, the server MUST NOT
respond with '200 [-OK' response.-]{+OK'.+}  A server SHOULD respond with
'404 Not Found', '410 Gone', or any other suitable HTTP status code
which does not imply the resource exists as requested.

@@ -114,12 +116,12 @@ permitted, the server MUST respond with the '403 Forbidden' HTTP
status code.

Servers SHOULD support both HTTP 1.0 and HTTP 1.1.
Servers SHOULD support chunked encoding for both
request and response bodies.

Clients SHOULD support both HTTP 1.0 and HTTP 1.1.
Clients SHOULD support chunked encoding for both
request and response bodies.

Servers MAY return ETag and/or Last-Modified headers.

@@ -149,40 +151,16 @@ references by making a request for the special info/refs file of
the repository.

Dumb HTTP clients MUST make a GET request to $GIT_URL/info/refs,
without any search/query parameters.  {+E.g.+}

   C: GET $GIT_URL/info/refs HTTP/1.0

   S: 200 OK
   S:
   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	[-refs/heads/maint-]{+refs/heads/maint\n+}
   S: d049f6c27a2244e12041955e262a404c7faba355	[-refs/heads/master-]{+refs/heads/master\n+}
   S: 2cb58b79488a98d2721cea644875a8dd0026b115	[-refs/tags/v1.0-]{+refs/tags/v1.0\n+}
   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	[-refs/tags/v1.0^{}-]

[-The Content-Type of the returned info/refs entity SHOULD be-]
[-"text/plain; charset=utf-8", but MAY be any content type.-]
[-Clients MUST NOT attempt to validate the returned Content-Type.-]
[-Dumb servers MUST NOT return a return type starting with-]
[-"application/x-git-".-]

[-Cache-Control headers MAY be returned to disable caching of the-]
[-returned entity.-]

[-When examining the response clients SHOULD only examine the HTTP-]
[-status code.  Valid responses are '200 OK', or '304 Not Modified'.-]

[-The returned content is a UNIX formatted text file describing-]
[-each ref and its known value.  The file SHOULD be sorted by name-]
[-according to the C locale ordering.  The file SHOULD NOT include-]
[-the default ref named 'HEAD'.-]

[-  info_refs   =  *( ref_record )-]
[-  ref_record  =  any_ref / peeled_ref-]

[-  any_ref     =  obj-id HTAB refname LF-]
[-  peeled_ref  =  obj-id HTAB refname LF-]
[-		 obj-id HTAB refname "^{}" LF-]{+refs/tags/v1.0^{}\n+}

Smart Clients
~~~~~~~~~~~~~
@@ -196,15 +174,20 @@ The request MUST contain exactly one query parameter,
name the client wishes to contact to complete the operation.
The request MUST NOT contain additional query parameters.

{+TODO: "exactly" one query parameter may be too strict; see the catch-all+}
{+gateway $GIT_URL for an example where more than one parameter is passed.+}
{+In fact, the http client implementation in Git can handle similar+}
{+$GIT_URLs, and thus may pass more than parameter to the server.+}

   C: GET $GIT_URL/info/refs?service=git-upload-pack HTTP/1.0

   dumb server reply:
   S: 200 OK
   S:
   S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	[-refs/heads/maint-]{+refs/heads/maint\n+}
   S: d049f6c27a2244e12041955e262a404c7faba355	[-refs/heads/master-]{+refs/heads/master\n+}
   S: 2cb58b79488a98d2721cea644875a8dd0026b115	[-refs/tags/v1.0-]{+refs/tags/v1.0\n+}
   S: a3c2e2402b99163d1d59756e5f207ae21cccba4c	[-refs/tags/v1.0^{}-]{+refs/tags/v1.0^{}\n+}

   smart server reply:
   S: 200 OK
@@ -216,13 +199,35 @@ The request MUST NOT contain additional query parameters.
   S: 0042d049f6c27a2244e12041955e262a404c7faba355 refs/heads/master\n
   S: 003c2cb58b79488a98d2721cea644875a8dd0026b115 refs/tags/v1.0\n
   S: 003fa3c2e2402b99163d1d59756e5f207ae21cccba4c refs/tags/v1.0^{}\n
   {+S: 0000+}

Dumb Server Response
^^^^^^^^^^^^^^^^^^^^
Dumb servers MUST respond with the dumb server reply format.

[-See-]{+The Content-Type of+} the [-prior section under dumb clients for-]{+returned info/refs entity SHOULD be+}
{+"text/plain; charset=utf-8", but MAY be any content type.+}
{+Clients MUST NOT attempt to validate the returned Content-Type.+}
{+Dumb servers MUST NOT return+} a [-more detailed-]
[-description-]{+return type starting with+}
{+"application/x-git-".+}

{+Cache-Control headers MAY be returned to disable caching+} of the
[-dumb server response.-]{+returned entity.+}

{+When examining the response clients SHOULD only examine the HTTP+}
{+status code.  Valid responses are '200 OK', or '304 Not Modified'.+}

{+The returned content is a UNIX formatted text file describing+}
{+each ref and its known value.  The file SHOULD be sorted by name+}
{+according to the C locale ordering.  The file SHOULD NOT include+}
{+the default ref named 'HEAD'.+}

{+  info_refs        =  *( ref_record )+}
{+  ref_record       =  any_ref / peeled_ref+}

{+  any_ref          =  obj-id HTAB refname LF+}
{+  peeled_ref       =  obj-id HTAB refname LF+}
{+		      obj-id HTAB refname "^{}" LF+}

Smart Server Response
^^^^^^^^^^^^^^^^^^^^^
@@ -268,23 +273,7 @@ named 'HEAD' as the first ref.  The stream MUST include capability
declarations behind a NUL on the first ref.

  smart_reply      =  PKT-LINE("# service=$servicename" LF)
		      [-ref_list-]
[-		     "0000"-]
[-  ref_list        =  empty_list / non_empty_list-]

[-  empty_list      =  PKT-LINE(zero-id SP "capabilities^{}" NUL cap-list LF)-]

[-  non_empty_list  =  PKT-LINE(obj-id SP name NUL cap_list LF)-]
[-		     *ref_record-]

[-  cap-list        =  capability *(SP capability)-]
[-  capability      =  1*(LC_ALPHA / DIGIT / "-" / "_")-]
[-  LC_ALPHA        =  %x61-7A-]

[-  ref_record      =  any_ref / peeled_ref-]
[-  any_ref         =  PKT-LINE(obj-id SP name LF)-]
[-  peeled_ref      =  PKT-LINE(obj-id SP name LF)-]
[-		     PKT-LINE(obj-id SP name "^{}" LF-]{+advertised-refs+}

Smart Service git-upload-pack
------------------------------
@@ -394,7 +383,7 @@ The computation to select the minimal pack proceeds as follows
     emptied C_PENDING it SHOULD include a "done" command to let
     the server know it won't proceed:

   C: [-0009done-]{+0009done\n+}

  (s) Parse the git-upload-pack request:

@@ -450,7 +439,7 @@ TODO: Document parsing response

Smart Service git-receive-pack
------------------------------
This service [-reads from-]{+modifies+} the repository pointed to by $GIT_URL.

Clients MUST first perform ref discovery with
'$GIT_URL/info/refs?service=git-receive-pack'.
@@ -458,7 +447,7 @@ Clients MUST first perform ref discovery with
   C: POST $GIT_URL/git-receive-pack HTTP/1.0
   C: Content-Type: application/x-git-receive-pack-request
   C:
   C: ....0a53e9ddeaddad63ad106860237bbf53411d11a7 441b40d833fdfa93eb2908e52742248faf0ee993 [-refs/heads/maint\0 report-status-]{+refs/heads/maint\0report-status+}
   C: 0000
   C: PACK....

@@ -487,9 +476,9 @@ the id obtained through ref discovery as old_id.
  cap_list         =  *(SP capability) SP

  command          =  create / delete / update
  create           =  zero-id SP new_id SP [-name-]{+refname+}
  delete           =  old_id SP zero-id SP [-name-]{+refname+}
  update           =  old_id SP new_id SP [-name-]{+refname+}

TODO: Document this further.

@@ -498,6 +487,9 @@ References
----------

link:http://www.ietf.org/rfc/rfc1738.txt[RFC 1738: Uniform Resource Locators (URL)]
{+link:http://www.ietf.org/rfc/rfc2119.txt[RFC 2119: Key words for use in RFCs to Indicate Requirement Levels]+}
link:http://www.ietf.org/rfc/rfc2616.txt[RFC 2616: Hypertext Transfer Protocol -- HTTP/1.1]
link:technical/pack-protocol.txt
{+link:technical/protocol-common.txt+}
link:technical/protocol-capabilities.txt
