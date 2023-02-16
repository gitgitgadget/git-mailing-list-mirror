Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA261C636D7
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjBPWev (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBPWes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 17:34:48 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9FD3A83
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:34:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f18-20020a7bcd12000000b003e206711347so2949740wmj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 14:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fO4NHM7wRSY+71j2XQCvMkA1qVA/4uhVs2knZWWb5k=;
        b=MXuM+boM+pX3uKnFN4L1fJ+XyF47iKnzoHDOJRHR8Xlg9rMtKOgo3MU+YUUzzwJPbu
         34PyQYF67aO0wkGoGG+qihX3e40hcsgz1wAW3Czrh60qFH9iWxMvTZqBlUCAabo8e1Nx
         QA6mwkmWHCVKo5SAKaKLuAVn0rnSOjiFGk0Vi02OMVn04rOl5ei+1rgnrCksJ2SBVIcB
         MiKTIbWBuvpzwt5P2HwSPFFVYW+yTsMFIkBj4kanJPpCLigg+IJx00dVXxgWrfqSHnW3
         lkWE1EvGfbw4urJ5nKlJScwVs4n3YyNMrXmzkoqVbYSlC4JSqNzpQM9bNdd0rhQQW6jx
         S9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fO4NHM7wRSY+71j2XQCvMkA1qVA/4uhVs2knZWWb5k=;
        b=oCVyyPZwJvPX1uxRw4VUK9q2JjngPxW8isYjcze/tpAorN9PZhf5O4OAWdWO/kFG/N
         eiNUPbnSP3kqapo0XE1BFQ55RZWcBW5EXGtaRmVLg+lsYLSDBP6Gv1Qb50dWWi8jH7ac
         BLKPrdoVlLEcMOZmD2MH7JU4nIEPsydLv5iskX4Ke/UjET4orsrJ3x3iSbGvIrrvLmpr
         e3CzF0Yqf4+eExCVWJdWFks5tiKQOFxPTEPnZ5O0qJNp7JJf9ceZsHYIlBi7eKENONwW
         4KSZ2aVl8sVWymJoyziHDdoiYfyKMbQjE1h9l8aZ8BcfGzLtG+7YCqQG5Up0LTrzVs0/
         Nw2Q==
X-Gm-Message-State: AO0yUKWkhMauIxSetP6N1L+NKV35DovPhV+PCX8mKYArRjXHCgCSpFNR
        2lvHjlM+S1dG31dkOpYyZb/gfYbamFs=
X-Google-Smtp-Source: AK7set/NE+N4oAo5zAY8UxeT3GQOrQNEJUfhCsEyaaI/Sv4E24sOMf3vUAeSzEcPaWmq7YQX8ReRfQ==
X-Received: by 2002:a05:600c:3ba8:b0:3df:db2f:66a with SMTP id n40-20020a05600c3ba800b003dfdb2f066amr5860391wms.31.1676586882939;
        Thu, 16 Feb 2023 14:34:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a056000118200b002c55de1c72bsm2496532wrx.62.2023.02.16.14.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 14:34:42 -0800 (PST)
Message-Id: <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Feb 2023 22:34:38 +0000
Subject: [PATCH v10 0/3] Enhance credential helper protocol to include auth headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Following from my original RFC submission [0], this submission is considered
ready for full review. This patch series is now based on top of current
master (9c32cfb49c60fa8173b9666db02efe3b45a8522f) that includes my now
separately submitted patches [1] to fix up the other credential helpers'
behaviour.

In this patch series I update the existing credential helper design in order
to allow for some new scenarios, and future evolution of auth methods that
Git hosts may wish to provide. I outline the background, summary of changes
and some challenges below.

Testing these new additions, I use a small CGI shell script that acts as a
frontend to git-http-backend; simple authentication is configurable by
files.


Background
==========

Git uses a variety of protocols [2]: local, Smart HTTP, Dumb HTTP, SSH, and
Git. Here I focus on the Smart HTTP protocol, and attempt to enhance the
authentication capabilities of this protocol to address limitations (see
below).

The Smart HTTP protocol in Git supports a few different types of HTTP
authentication - Basic and Digest (RFC 2617) [3], and Negotiate (RFC 2478)
[4]. Git uses a extensible model where credential helpers can provide
credentials for protocols [5]. Several helpers support alternatives such as
OAuth authentication (RFC 6749) [6], but this is typically done as an
extension. For example, a helper might use basic auth and set the password
to an OAuth Bearer access token. Git uses standard input and output to
communicate with credential helpers.

After a HTTP 401 response, Git would call a credential helper with the
following over standard input:

protocol=https
host=example.com


And then a credential helper would return over standard output:

protocol=https
host=example.com
username=bob@id.example.com
password=<BEARER-TOKEN>


Git then the following request to the remote, including the standard HTTP
Authorization header (RFC 7235 Section 4.2) [7]:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: Basic base64(bob@id.example.com:<BEARER-TOKEN>)


Credential helpers are encouraged (see gitcredentials.txt) to return the
minimum information necessary.


Limitations
===========

Because this credential model was built mostly for password based
authentication systems, it's somewhat limited. In particular:

 1. To generate valid credentials, additional information about the request
    (or indeed the requestee and their device) may be required. For example,
    OAuth is based around scopes. A scope, like "git.read", might be
    required to read data from the remote. However, the remote cannot tell
    the credential helper what scope is required for this request.

 2. This system is not fully extensible. Each time a new type of
    authentication (like OAuth Bearer) is invented, Git needs updates before
    credential helpers can take advantage of it (or leverage a new
    capability in libcurl).


Goals
=====

 * As a user with multiple federated cloud identities:
   
   * Reach out to a remote and have my credential helper automatically
     prompt me for the correct identity.
   * Allow credential helpers to differentiate between different authorities
     or authentication/authorization challenge types, even from the same DNS
     hostname (and without needing to use credential.useHttpPath).
   * Leverage existing authentication systems built-in to many operating
     systems and devices to boost security and reduce reliance on passwords.

 * As a Git host and/or cloud identity provider:
   
   * Enforce security policies (like requiring two-factor authentication)
     dynamically.
   * Allow integration with third party standard based identity providers in
     enterprises allowing customers to have a single plane of control for
     critical identities with access to source code.


Design Principles
=================

 * Use the existing infrastructure. Git credential helpers are an
   already-working model.
 * Follow widely-adopted time-proven open standards, avoid net new ideas in
   the authentication space.
 * Minimize knowledge of authentication in Git; maintain modularity and
   extensibility.


Proposed Changes
================

 1. Teach Git to read HTTP response headers, specifically the standard
    WWW-Authenticate (RFC 7235 Section 4.1) headers.

 2. Teach Git to include extra information about HTTP responses that require
    authentication when calling credential helpers. Specifically the
    WWW-Authenticate header information.
    
    Because the extra information forms an ordered list, and the existing
    credential helper I/O format only provides for simple key=value pairs,
    we introduce a new convention for transmitting an ordered list of
    values. Key names that are suffixed with a C-style array syntax should
    have values considered to form an order list, i.e. key[]=value, where
    the order of the key=value pairs in the stream specifies the order.
    
    For the WWW-Authenticate header values we opt to use the key wwwauth[].


Handling the WWW-Authenticate header in detail
==============================================

RFC 6750 [8] envisions that OAuth Bearer resource servers would give
responses that include WWW-Authenticate headers, for example:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


Specifically, a WWW-Authenticate header consists of a scheme and arbitrary
attributes, depending on the scheme. This pattern enables generic OAuth or
OpenID Connect [9] authorities. Note that it is possible to have several
WWW-Authenticate challenges in a response.

First Git attempts to make a request, unauthenticated, which fails with a
401 response and includes WWW-Authenticate header(s).

Next, Git invokes a credential helper which may prompt the user. If the user
approves, a credential helper can generate a token (or any auth challenge
response) to be used for that request.

For example: with a remote that supports bearer tokens from an OpenID
Connect [9] authority, a credential helper can use OpenID Connect's
Discovery [10] and Dynamic Client Registration [11] to register a client and
make a request with the correct permissions to access the remote. In this
manner, a user can be dynamically sent to the right federated identity
provider for a remote without any up-front configuration or manual
processes.

Following from the principle of keeping authentication knowledge in Git to a
minimum, we modify Git to add all WWW-Authenticate values to the credential
helper call.

Git sends over standard input:

protocol=https
host=example.com
wwwauth[]=Bearer realm="login.example", scope="git.readwrite"
wwwauth[]=Basic realm="login.example"


A credential helper that understands the extra wwwauth[n] property can
decide on the "best" or correct authentication scheme, generate credentials
for the request, and interact with the user.

The credential helper would then return over standard output:

protocol=https
host=example.com
path=foo.git
username=bob@identity.example
password=<BEARER-TOKEN>


Note that WWW-Authenticate supports multiple challenges, either in one
header:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"


or in multiple headers:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: Bearer realm="login.example", scope="git.readwrite"
WWW-Authenticate: Basic realm="login.example"


These have equivalent meaning (RFC 2616 Section 4.2 [12]). To simplify the
implementation, Git will not merge or split up any of these WWW-Authenticate
headers, and instead pass each header line as one credential helper
property. The credential helper is responsible for splitting, merging, and
otherwise parsing these header values.

An alternative option to sending the header fields individually would be to
merge the header values in to one key=value property, for example:

...
wwwauth=Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"



Future work
===========

In the future we can further expand the protocol to allow credential helpers
decide the best authentication scheme. Today credential helpers are still
only expected to return a username/password pair to Git, meaning the other
authentication schemes that may be offered still need challenge responses
sent via a Basic Authorization header. The changes outlined above still
permit helpers to select and configure an available authentication mode, but
require the remote for example to unpack a bearer token from a basic
challenge.

More careful consideration is required in the handling of custom
authentication schemes which may not have a username, or may require
arbitrary additional request header values be set.

For example imagine a new "FooBar" authentication scheme that is surfaced in
the following response:

HTTP/1.1 401 Unauthorized
WWW-Authenticate: FooBar realm="login.example", algs="ES256 PS256"


With support for arbitrary authentication schemes, Git would call credential
helpers with the following over standard input:

protocol=https
host=example.com
wwwauth[]=FooBar realm="login.example", algs="ES256 PS256", nonce="abc123"


And then an enlightened credential helper could return over standard output:

protocol=https
host=example.com
authtype=FooBar
username=bob@id.example.com
password=<FooBar credential>
header[]=X-FooBar: 12345
header[]=X-FooBar-Alt: ABCDEF


Git would be expected to attach this authorization header to the next
request:

GET /info/refs?service=git-upload-pack HTTP/1.1
Host: git.example
Git-Protocol: version=2
Authorization: FooBar <FooBar credential>
X-FooBar: 12345
X-FooBar-Alt: ABCDEF



Why not SSH?
============

There's nothing wrong with SSH. However, Git's Smart HTTP transport is
widely used, often with OAuth Bearer tokens. Git's Smart HTTP transport
sometimes requires less client setup than SSH transport, and works in
environments when SSH ports may be blocked. As long as Git supports HTTP
transport, it should support common and popular HTTP authentication methods.


References
==========

 * [0] [PATCH 0/8] [RFC] Enhance credential helper protocol to include auth
   headers
   https://lore.kernel.org/git/pull.1352.git.1663097156.gitgitgadget@gmail.com/

 * [1] [PATCH 0/3] Correct credential helper discrepancies handling input
   https://lore.kernel.org/git/pull.1363.git.1663865974.gitgitgadget@gmail.com/

 * [2] Git on the Server - The Protocols
   https://git-scm.com/book/en/v2/Git-on-the-Server-The-Protocols

 * [3] HTTP Authentication: Basic and Digest Access Authentication
   https://datatracker.ietf.org/doc/html/rfc2617

 * [4] The Simple and Protected GSS-API Negotiation Mechanism
   https://datatracker.ietf.org/doc/html/rfc2478

 * [5] Git Credentials - Custom Helpers
   https://git-scm.com/docs/gitcredentials#_custom_helpers

 * [6] The OAuth 2.0 Authorization Framework
   https://datatracker.ietf.org/doc/html/rfc6749

 * [7] Hypertext Transfer Protocol (HTTP/1.1): Authentication
   https://datatracker.ietf.org/doc/html/rfc7235

 * [8] The OAuth 2.0 Authorization Framework: Bearer Token Usage
   https://datatracker.ietf.org/doc/html/rfc6750

 * [9] OpenID Connect Core 1.0
   https://openid.net/specs/openid-connect-core-1_0.html

 * [10] OpenID Connect Discovery 1.0
   https://openid.net/specs/openid-connect-discovery-1_0.html

 * [11] OpenID Connect Dynamic Client Registration 1.0
   https://openid.net/specs/openid-connect-registration-1_0.html

 * [12] Hypertext Transfer Protocol (HTTP/1.1)
   https://datatracker.ietf.org/doc/html/rfc2616


Updates from RFC
================

 * Submitted first three patches as separate submission:
   https://lore.kernel.org/git/pull.1363.git.1663865974.gitgitgadget@gmail.com/

 * Various style fixes and updates to- and addition of comments.

 * Drop the explicit integer index in new 'array' style credential helper
   attrbiutes ("key[n]=value" becomes just "key[]=value").

 * Added test helper; a mini HTTP server, and several tests.


Updates in v3
=============

 * Split final patch that added the test-http-server in to several, easier
   to review patches.

 * Updated wording in git-credential.txt to clarify which side of the
   credential helper protocol is sending/receiving the new wwwauth and
   authtype attributes.


Updates in v4
=============

 * Drop authentication scheme selection authtype attribute patches to
   greatly simplify the series; auth scheme selection is punted to a future
   series. This series still allows credential helpers to generate
   credentials and intelligently select correct identities for a given auth
   challenge.


Updates in v5
=============

 * Libify parts of daemon.c and share implementation with test-http-server.

 * Clarify test-http-server Git request regex pattern and auth logic
   comments.

 * Use STD*_FILENO in place of 'magic' file descriptor numbers.

 * Use strbuf_* functions in continuation header parsing.

 * Use configuration file to configure auth for test-http-server rather than
   command-line arguments. Add ability to specify arbitrary extra headers
   that is useful for testing 'malformed' server responses.

 * Use st_mult over unchecked multiplication in http.c curl callback
   functions.

 * Fix some documentation line break issues.

 * Reorder some commits to bring in the tests and test-http-server helper
   first and, then the WWW-Authentication changes, alongside tests to cover.

 * Expose previously static strvec_push_nodup function.

 * Merge the two timeout args for test-http-server (--timeout and
   --init-timeout) that were a hang-over from the original daemon.c but are
   no longer required here.

 * Be more careful around continuation headers where they may be empty
   strings. Add more tests to cover these header types.

 * Include standard trace2 tracing calls at start of test-http-server
   helper.


Updates in v6
=============

 * Clarify the change to make logging optional in the check_dead_children()
   function during libification of daemon.c.

 * Fix missing pointer dereference bugs identified in libification of child
   process handling functions for daemon.c.

 * Add doc comments to child process handling function declarations in the
   daemon-utils.h header.

 * Align function parameter names with variable names at callsites for
   libified daemon functions.

 * Re-split out the test-http-server test helper commits in to smaller
   patches: error response handling, request parsing, http-backend
   pass-through, simple authentication, arbitrary header support.

 * Call out auth configuration file format for test-http-server test helper
   and supported options in commit messages, as well as a test to exercise
   and demonstrate these options.

 * Permit auth.token and auth.challenge to appear in any order; create the
   struct auth_module just-in-time as options for that scheme are read. This
   simplifies the configuration authoring of the test-http-server test
   helper.

 * Update tests to use auth.allowAnoymous in the patch that introduces the
   new test helper option.

 * Drop the strvec_push_nodup() commit and update the implementation of HTTP
   request header line folding to use xstrdup and strvec_pop and _pushf.

 * Use size_t instead of int in credential.c when iterating over the struct
   strvec credential members. Also drop the not required const and cast from
   the full_key definition and free.

 * Replace in-tree test-credential-helper-reply.sh test cred helper script
   with the lib-credential-helper.sh reusable 'lib' test script and shell
   functions to configure the helper behaviour.

 * Leverage sed over the while read $line loop in the test credential helper
   script.


Updates in v7
=============

 * Address several whitespace and arg/param list alignment issues.

 * Rethink the test-http-helper worker-mode error and result enum to be more
   simple and more informative to the nature of the error.

 * Use uintmax_t to store the Content-Length of a request in the helper
   test-http-server. Maintain a bit flag to store if we received such a
   header.

 * Return a "400 Bad Request" HTTP response if we fail to parse the request
   in the test-http-server.

 * Add test case to cover request message parsing in test-http-server.

 * Use size_t and ALLOC_ARRAY over int and CALLOC_ARRAY respectively in
   get_auth_module.

 * Correctly free the split strbufs created in the header parsing loop in
   test-http-server.

 * Avoid needless comparison > 0 for unsigned types.

 * Always set optional outputs to NULL if not present in test helper config
   value handling.

 * Remove an accidentally commented-out test cleanup line for one test case
   in t5556.


Updates in v8
=============

 * Drop custom HTTP test helper tool in favour of using a CGI shell script
   and Apache; avoiding the need to implement an HTTP server.

 * Avoid allocations in header reading callback unless we have a header we
   care about; act on the char* from libcurl directly rather than create a
   strbuf for each header.

 * Drop st_mult overflow guarding function in curl callback functions; we're
   not allocating memory based on the resulting value and just adds to
   potential confusion in the future.


Updates in v9
=============

 * Drop anoynmous auth tests as these cases are already covered by all other
   tests that perform HTTP interactions with a remote today.

 * In the custom auth CGI script, avoid the empty-substitution in favour of
   testing explicitly for an empty string. Also simplify some other
   conditional expressions.

 * Avoid an allocation on each wwwauth[] credential helper key-value pair
   write.

 * Various style fixups.


Updates in v10
==============

 * Style fixups.

 * Only consider space (SP ' ') and horizontal tab (HTAB '\t') when
   detecting a header continuation line, as per the latest RFC on the
   matter.

 * Update references to old HTTP specs and formal grammars of header fields
   in comments.

 * Rewording of commit messages to remove confusing comment about the case
   sensitivity of header field names - this is not relevant with the current
   iteration of the header parsing code. Also update the message around
   libcurl header support to clarify that physical header lines are
   returned, but not 'logical' header lines.

 * Reword struct credential member doc comment to clarify the purpose of
   header_is_last_match is for re-folding lines of the WWW-Authenticate
   header.

 * Reintroduce helpful comments in tests to show the origin of the 'magic'
   base64 basic auth value.

 * Use grep -F to ensure we don't do regex matching; avoid interpreting
   special characters. Remove erronous insensitive comparison flag.

Matthew John Cheetham (3):
  t5563: add tests for basic and anoymous HTTP access
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests

 Documentation/git-credential.txt |  19 +-
 credential.c                     |   4 +
 credential.h                     |  16 ++
 git-compat-util.h                |  23 +++
 http.c                           | 111 +++++++++++
 t/lib-httpd.sh                   |   1 +
 t/lib-httpd/apache.conf          |   6 +
 t/lib-httpd/nph-custom-auth.sh   |  39 ++++
 t/t5563-simple-http-auth.sh      | 324 +++++++++++++++++++++++++++++++
 9 files changed, 542 insertions(+), 1 deletion(-)
 create mode 100755 t/lib-httpd/nph-custom-auth.sh
 create mode 100755 t/t5563-simple-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v10
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v9:

 1:  05449ec892b ! 1:  f3ccc53055a t5563: add tests for basic and anoymous HTTP access
     @@ t/lib-httpd/nph-custom-auth.sh (new)
      +#
      +
      +if test -n "$HTTP_AUTHORIZATION" && \
     -+	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE"
     ++	grep -Fqsx "${HTTP_AUTHORIZATION}" "$VALID_CREDS_FILE"
      +then
      +	# Note that although git-http-backend returns a status line, it
      +	# does so using a CGI 'Status' header. Because this script is an
     @@ t/t5563-simple-http-auth.sh (new)
      +	EOF
      +'
      +
     -+set_credential_reply() {
     ++set_credential_reply () {
      +	cat >"$TRASH_DIRECTORY/$1-reply.cred"
      +}
      +
     -+expect_credential_query() {
     ++expect_credential_query () {
      +	cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
      +	test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
      +		 "$TRASH_DIRECTORY/$1-query.cred"
     @@ t/t5563-simple-http-auth.sh (new)
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
 2:  f3f28e508c1 ! 2:  703ac15222f http: read HTTP WWW-Authenticate response headers
     @@ Commit message
          information to credential helpers or others that would otherwise have
          been lost.
      
     -    According to RFC2616 Section 4.2 [1], header field names are not
     -    case-sensitive meaning when collecting multiple values for the same
     -    field name, we can just use the case of the first observed instance of
     -    each field name and no normalisation is required.
     -
          libcurl only provides us with the ability to read all headers recieved
          for a particular request, including any intermediate redirect requests
          or proxies. The lines returned by libcurl include HTTP status lines
     @@ Commit message
      
          The collection of all header values matching the WWW-Authenticate
          header is complicated by the fact that it is legal for header fields to
     -    be continued over multiple lines, but libcurl only gives us one line at
     -    a time.
     +    be continued over multiple lines, but libcurl only gives us each
     +    physical line a time, not each logical header. This line folding feature
     +    is deprecated in RFC 7230 [1] but older servers may still emit them, so
     +    we need to handle them.
      
          In the future [2] we may be able to leverage functions to read headers
          from libcurl itself, but as of today we must do this ourselves.
      
     -    [1] https://datatracker.ietf.org/doc/html/rfc2616#section-4.2
     +    [1] https://www.rfc-editor.org/rfc/rfc7230#section-3.2
          [2] https://daniel.haxx.se/blog/2022/03/22/a-headers-api-for-libcurl/
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
     @@ credential.h: struct credential {
      +	struct strvec wwwauth_headers;
      +
      +	/**
     -+	 * Internal use only. Used to keep track of split header fields
     -+	 * in order to fold multiple lines into one value.
     ++	 * Internal use only. Keeps track of if we previously matched against a
     ++	 * WWW-Authenticate header line in order to re-fold future continuation
     ++	 * lines into one value.
      +	 */
      +	unsigned header_is_last_match:1;
      +
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
       }
       
      +/*
     -+ * A folded header continuation line starts with at least one single whitespace
     -+ * character. It is not a continuation line if the line is *just* a newline.
     -+ * The RFC for HTTP states that CRLF is the header field line ending, but some
     -+ * servers may use LF only; we accept both.
     ++ * A folded header continuation line starts with any number of spaces or
     ++ * horizontal tab characters (SP or HTAB) as per RFC 7230 section 3.2.
     ++ * It is not a continuation line if the line starts with any other character.
      + */
      +static inline int is_hdr_continuation(const char *ptr, const size_t size)
      +{
     -+	/* totally empty line or normal header */
     -+	if (!size || !isspace(*ptr))
     -+		return 0;
     -+
     -+	/* empty line with LF line ending */
     -+	if (size == 1 && ptr[0] == '\n')
     -+		return 0;
     -+
     -+	/* empty line with CRLF line ending */
     -+	if (size == 2 && ptr[0] == '\r' && ptr[1] == '\n')
     -+		return 0;
     -+
     -+	return 1;
     ++	return size && (*ptr == ' ' || *ptr == '\t');
      +}
      +
      +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 * strbufs for all operations.
      +	 *
      +	 * In addition, it is possible that header values can be split over
     -+	 * multiple lines as per RFC 2616 (even though this has since been
     -+	 * deprecated in RFC 7230). A continuation header field value is
     -+	 * identified as starting with a space or horizontal tab.
     ++	 * multiple lines as per RFC 7230. 'Line folding' has been deprecated
     ++	 * but older servers may still emit them. A continuation header field
     ++	 * value is identified as starting with a space or horizontal tab.
     ++	 *
     ++	 * The formal definition of a header field as given in RFC 7230 is:
     ++	 *
     ++	 * header-field   = field-name ":" OWS field-value OWS
      +	 *
     -+	 * The formal definition of a header field as given in RFC 2616 is:
     ++	 * field-name     = token
     ++	 * field-value    = *( field-content / obs-fold )
     ++	 * field-content  = field-vchar [ 1*( SP / HTAB ) field-vchar ]
     ++	 * field-vchar    = VCHAR / obs-text
      +	 *
     -+	 *   message-header = field-name ":" [ field-value ]
     -+	 *   field-name     = token
     -+	 *   field-value    = *( field-content | LWS )
     -+	 *   field-content  = <the OCTETs making up the field-value
     -+	 *                    and consisting of either *TEXT or combinations
     -+	 *                    of token, separators, and quoted-string>
     ++	 * obs-fold       = CRLF 1*( SP / HTAB )
     ++	 *                ; obsolete line folding
     ++	 *                ; see Section 3.2.4
      +	 */
      +
      +	/* Start of a new WWW-Authenticate header */
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +		goto exit;
      +	}
      +
     -+	/* This is the start of a new header we don't care about */
     ++	/* Not a continuation of a previously matched auth header line. */
      +	http_auth.header_is_last_match = 0;
      +
      +	/*
 3:  eba58c0d08d ! 3:  186da54fd3b credential: add WWW-Authenticate header to cred requests
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=wrong-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF
     @@ t/t5563-simple-http-auth.sh: test_expect_success 'access using basic auth' '
      +	password=secret-passwd
      +	EOF
      +
     ++	# Basic base64(alice:secret-passwd)
      +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
      +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
      +	EOF

-- 
gitgitgadget
