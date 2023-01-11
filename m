Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E61EC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236111AbjAKWN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjAKWNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 17:13:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A23E0E8
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so13740592wms.2
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 14:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Bo+YGQcjKIg5qAh6NGQriFuadWCH3wMJT8tLnO8kF0=;
        b=O+FC0wGU4OOIUVZ28tx/auHqki97KKVQaHYZFYF7GRMkt805BvvqEUURlkEZU1svno
         FcSALTWQyCCwA7XuB4j5h1TolkBvM+GP4qceXIkQcMAHTJWwq6gHRZiNh/T00f1eBT7n
         s87uwZ7i7w6h/YVWCh5risJZjGerOfMC7fw7T79uhJp5SCJOVzmGIgfHy+fYbCeooLux
         G5duYZeCHkZp1Biiu6TPsO/sTkKuVftKGS/zTBSfXi9O8Bix+GC2t9G9GMJhACp0KjMV
         VRAn0jOrOLzkKARmxbs2/jS60FAPlsSomDhZO0pRmE2pRhkZKtQtowlWmvu0lmk6YQ4Q
         TznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Bo+YGQcjKIg5qAh6NGQriFuadWCH3wMJT8tLnO8kF0=;
        b=RU4Pm1yq71zduTVI0moMLZkQwgmFKOtLzcDCnSZsE5NiXqP/7XQ05WMafYJN1TvCau
         BmND8Zn1AhusM0aaHFeKd+tWtzfi3uhHmytfs59/qJNE8Tv9HOE6e7mcB7+QneuC6Y2u
         JsL0wcx4Y2eCMG0GRJlJmu0rqWJos0mQ0Y5VFEE68/fwFex+KztMXfv81RigNkB1DQ08
         HXdvPTFEz4YBe5+j6Zuo4DpuMes2bt9C3TcWKsrHbSE94+HMQiFgdyfTUORNF4IgOfTn
         MwqDUOjBxM1MBuAKbyhGewUiIb5aqpBA3XKT1RQY5CbBS5VSzMYmEaIRjVYu213LpTfb
         zI4w==
X-Gm-Message-State: AFqh2kp9NBrAUnnTUeLqe4Y3R4um4elintk+2UIzRkSZkJRbXXJN9Ukv
        n0XcDs0YwxDxMevc4lDPXd997vJ3R7k=
X-Google-Smtp-Source: AMrXdXt6E8hW3am8m+CR6JyASUYfIqBiuohT6o28xN8/HwUxyyo4dPRoTyOk9rUwa/USp4vCNP6JZg==
X-Received: by 2002:a05:600c:3b1c:b0:3d9:f0da:542c with SMTP id m28-20020a05600c3b1c00b003d9f0da542cmr9691328wms.28.1673475192711;
        Wed, 11 Jan 2023 14:13:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003da0b75de94sm3271331wmq.8.2023.01.11.14.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 14:13:12 -0800 (PST)
Message-Id: <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Jan 2023 22:13:00 +0000
Subject: [PATCH v5 00/10] Enhance credential helper protocol to include auth headers
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
        Matthew John Cheetham <mjcheetham@github.com>
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

Testing these new additions, I introduce a new test helper test-http-server
that acts as a frontend to git-http-backend; a mini HTTP server sharing code
with git-daemon, with simple authentication configurable by a config file.


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

Matthew John Cheetham (10):
  daemon: libify socket setup and option functions
  daemon: libify child process handling functions
  daemon: rename some esoteric/laboured terminology
  test-http-server: add stub HTTP server test helper
  test-http-server: add HTTP error response function
  test-http-server: add simple authentication
  http: replace unsafe size_t multiplication with st_mult
  strvec: expose strvec_push_nodup for external use
  http: read HTTP WWW-Authenticate response headers
  credential: add WWW-Authenticate header to cred requests

 Documentation/git-credential.txt          |  19 +-
 Makefile                                  |   2 +
 contrib/buildsystems/CMakeLists.txt       |  11 +-
 credential.c                              |  13 +
 credential.h                              |  15 +
 daemon-utils.c                            | 286 +++++++
 daemon-utils.h                            |  38 +
 daemon.c                                  | 306 +------
 http.c                                    | 102 ++-
 strvec.c                                  |   2 +-
 strvec.h                                  |   3 +
 t/helper/.gitignore                       |   1 +
 t/helper/test-credential-helper-replay.sh |  14 +
 t/helper/test-http-server.c               | 920 ++++++++++++++++++++++
 t/t5556-http-auth.sh                      | 372 +++++++++
 15 files changed, 1801 insertions(+), 303 deletions(-)
 create mode 100644 daemon-utils.c
 create mode 100644 daemon-utils.h
 create mode 100755 t/helper/test-credential-helper-replay.sh
 create mode 100644 t/helper/test-http-server.c
 create mode 100755 t/t5556-http-auth.sh


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1352%2Fmjcheetham%2Femu-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1352/mjcheetham/emu-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1352

Range-diff vs v4:

  -:  ----------- >  1:  74b0de14185 daemon: libify socket setup and option functions
  -:  ----------- >  2:  bc972fc8d3d daemon: libify child process handling functions
  -:  ----------- >  3:  8f176d5955d daemon: rename some esoteric/laboured terminology
  3:  07a1845ea56 !  4:  706fb3781bd test-http-server: add stub HTTP server test helper
     @@ Commit message
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Makefile ##
     -@@ Makefile: else
     - 	endif
     - 	BASIC_CFLAGS += $(CURL_CFLAGS)
     +@@ Makefile: TEST_BUILTINS_OBJS += test-xml-encode.o
     + # Do not add more tests here unless they have extra dependencies. Add
     + # them in TEST_BUILTINS_OBJS above.
     + TEST_PROGRAMS_NEED_X += test-fake-ssh
     ++TEST_PROGRAMS_NEED_X += test-http-server
     + TEST_PROGRAMS_NEED_X += test-tool
       
     -+	TEST_PROGRAMS_NEED_X += test-http-server
     -+
     - 	REMOTE_CURL_PRIMARY = git-remote-http$X
     - 	REMOTE_CURL_ALIASES = git-remote-https$X git-remote-ftp$X git-remote-ftps$X
     - 	REMOTE_CURL_NAMES = $(REMOTE_CURL_PRIMARY) $(REMOTE_CURL_ALIASES)
     + TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
      
       ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: if(BUILD_TESTING)
     + add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
     + target_link_libraries(test-fake-ssh common-main)
     + 
     ++add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
     ++target_link_libraries(test-http-server common-main)
     ++
     + #reftable-tests
     + parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
     + list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     +@@ contrib/buildsystems/CMakeLists.txt: if(MSVC)
     + 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
     + 	set_target_properties(test-fake-ssh test-tool
     + 				PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
     ++
     ++	set_target_properties(test-http-server
     ++			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
     ++	set_target_properties(test-http-server
     ++			PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
     + endif()
     + 
     + #wrapper scripts
      @@ contrib/buildsystems/CMakeLists.txt: set(wrapper_scripts
     - set(wrapper_test_scripts
     - 	test-fake-ssh test-tool)
     + 	git git-upload-pack git-receive-pack git-upload-archive git-shell git-remote-ext scalar)
       
     -+if(CURL_FOUND)
     -+       list(APPEND wrapper_test_scripts test-http-server)
     -+
     -+       add_executable(test-http-server ${CMAKE_SOURCE_DIR}/t/helper/test-http-server.c)
     -+       target_link_libraries(test-http-server common-main)
     -+
     -+       if(MSVC)
     -+               set_target_properties(test-http-server
     -+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/t/helper)
     -+               set_target_properties(test-http-server
     -+                                       PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/t/helper)
     -+       endif()
     -+endif()
     + set(wrapper_test_scripts
     +-	test-fake-ssh test-tool)
     +-
     ++	test-http-server test-fake-ssh test-tool)
       
       foreach(script ${wrapper_scripts})
       	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
     @@ t/helper/.gitignore
      
       ## t/helper/test-http-server.c (new) ##
      @@
     ++#include "daemon-utils.h"
      +#include "config.h"
      +#include "run-command.h"
      +#include "strbuf.h"
     @@ t/helper/test-http-server.c (new)
      +
      +static const char test_http_auth_usage[] =
      +"http-server [--verbose]\n"
     -+"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
     ++"           [--timeout=<n>] [--max-connections=<n>]\n"
      +"           [--reuseaddr] [--pid-file=<file>]\n"
      +"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
      +;
      +
     -+/* Timeout, and initial timeout */
      +static unsigned int timeout;
     -+static unsigned int init_timeout;
      +
      +static void logreport(const char *label, const char *err, va_list params)
      +{
     @@ t/helper/test-http-server.c (new)
      +	va_end(params);
      +}
      +
     -+static void set_keep_alive(int sockfd)
     -+{
     -+	int ka = 1;
     -+
     -+	if (setsockopt(sockfd, SOL_SOCKET, SO_KEEPALIVE, &ka, sizeof(ka)) < 0) {
     -+		if (errno != ENOTSOCK)
     -+			logerror("unable to set SO_KEEPALIVE on socket: %s",
     -+				strerror(errno));
     -+	}
     -+}
     -+
      +/*
      + * The code in this section is used by "worker" instances to service
      + * a single connection from a client.  The worker talks to the client
     @@ t/helper/test-http-server.c (new)
      +	 * Close the socket and clean up.  Does not imply an error.
      +	 */
      +	WR_HANGUP   = 1<<1,
     -+
     -+	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
      +};
      +
      +static enum worker_result worker(void)
     @@ t/helper/test-http-server.c (new)
      +	if (client_addr)
      +		loginfo("Connection from %s:%s", client_addr, client_port);
      +
     -+	set_keep_alive(0);
     ++	set_keep_alive(0, logerror);
      +
      +	while (1) {
     -+		if (write_in_full(1, response, strlen(response)) < 0) {
     ++		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
      +			logerror("unable to write response");
      +			wr = WR_IO_ERROR;
      +		}
      +
     -+		if (wr & WR_STOP_THE_MUSIC)
     ++		if (wr != WR_OK)
      +			break;
      +	}
      +
     -+	close(0);
     -+	close(1);
     ++	close(STDIN_FILENO);
     ++	close(STDOUT_FILENO);
      +
      +	return !!(wr & WR_IO_ERROR);
      +}
      +
     -+/*
     -+ * This section contains the listener and child-process management
     -+ * code used by the primary instance to accept incoming connections
     -+ * and dispatch them to async child process "worker" instances.
     -+ */
     -+
     -+static int addrcmp(const struct sockaddr_storage *s1,
     -+		   const struct sockaddr_storage *s2)
     -+{
     -+	const struct sockaddr *sa1 = (const struct sockaddr*) s1;
     -+	const struct sockaddr *sa2 = (const struct sockaddr*) s2;
     -+
     -+	if (sa1->sa_family != sa2->sa_family)
     -+		return sa1->sa_family - sa2->sa_family;
     -+	if (sa1->sa_family == AF_INET)
     -+		return memcmp(&((struct sockaddr_in *)s1)->sin_addr,
     -+		    &((struct sockaddr_in *)s2)->sin_addr,
     -+		    sizeof(struct in_addr));
     -+#ifndef NO_IPV6
     -+	if (sa1->sa_family == AF_INET6)
     -+		return memcmp(&((struct sockaddr_in6 *)s1)->sin6_addr,
     -+		    &((struct sockaddr_in6 *)s2)->sin6_addr,
     -+		    sizeof(struct in6_addr));
     -+#endif
     -+	return 0;
     -+}
     -+
      +static int max_connections = 32;
      +
      +static unsigned int live_children;
      +
     -+static struct child {
     -+	struct child *next;
     -+	struct child_process cld;
     -+	struct sockaddr_storage address;
     -+} *firstborn;
     -+
     -+static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
     -+{
     -+	struct child *newborn, **cradle;
     -+
     -+	newborn = xcalloc(1, sizeof(*newborn));
     -+	live_children++;
     -+	memcpy(&newborn->cld, cld, sizeof(*cld));
     -+	memcpy(&newborn->address, addr, addrlen);
     -+	for (cradle = &firstborn; *cradle; cradle = &(*cradle)->next)
     -+		if (!addrcmp(&(*cradle)->address, &newborn->address))
     -+			break;
     -+	newborn->next = *cradle;
     -+	*cradle = newborn;
     -+}
     -+
     -+/*
     -+ * This gets called if the number of connections grows
     -+ * past "max_connections".
     -+ *
     -+ * We kill the newest connection from a duplicate IP.
     -+ */
     -+static void kill_some_child(void)
     -+{
     -+	const struct child *blanket, *next;
     -+
     -+	if (!(blanket = firstborn))
     -+		return;
     -+
     -+	for (; (next = blanket->next); blanket = next)
     -+		if (!addrcmp(&blanket->address, &next->address)) {
     -+			kill(blanket->cld.pid, SIGTERM);
     -+			break;
     -+		}
     -+}
     -+
     -+static void check_dead_children(void)
     -+{
     -+	int status;
     -+	pid_t pid;
     -+
     -+	struct child **cradle, *blanket;
     -+	for (cradle = &firstborn; (blanket = *cradle);)
     -+		if ((pid = waitpid(blanket->cld.pid, &status, WNOHANG)) > 1) {
     -+			const char *dead = "";
     -+			if (status)
     -+				dead = " (with error)";
     -+			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
     -+
     -+			/* remove the child */
     -+			*cradle = blanket->next;
     -+			live_children--;
     -+			child_process_clear(&blanket->cld);
     -+			free(blanket);
     -+		} else
     -+			cradle = &blanket->next;
     -+}
     ++static struct child *first_child;
      +
      +static struct strvec cld_argv = STRVEC_INIT;
      +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
     @@ t/helper/test-http-server.c (new)
      +	struct child_process cld = CHILD_PROCESS_INIT;
      +
      +	if (max_connections && live_children >= max_connections) {
     -+		kill_some_child();
     ++		kill_some_child(first_child);
      +		sleep(1);  /* give it some time to die */
     -+		check_dead_children();
     ++		check_dead_children(first_child, &live_children, loginfo);
      +		if (live_children >= max_connections) {
      +			close(incoming);
      +			logerror("Too many children, dropping connection");
     @@ t/helper/test-http-server.c (new)
      +	else if (start_command(&cld))
      +		logerror("unable to fork");
      +	else
     -+		add_child(&cld, addr, addrlen);
     ++		add_child(&cld, addr, addrlen, first_child, &live_children);
      +}
      +
      +static void child_handler(int signo)
     @@ t/helper/test-http-server.c (new)
      +	signal(SIGCHLD, child_handler);
      +}
      +
     -+static int set_reuse_addr(int sockfd)
     -+{
     -+	int on = 1;
     -+
     -+	if (!reuseaddr)
     -+		return 0;
     -+	return setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
     -+			  &on, sizeof(on));
     -+}
     -+
     -+struct socketlist {
     -+	int *list;
     -+	size_t nr;
     -+	size_t alloc;
     -+};
     -+
     -+static const char *ip2str(int family, struct sockaddr *sin, socklen_t len)
     -+{
     -+#ifdef NO_IPV6
     -+	static char ip[INET_ADDRSTRLEN];
     -+#else
     -+	static char ip[INET6_ADDRSTRLEN];
     -+#endif
     -+
     -+	switch (family) {
     -+#ifndef NO_IPV6
     -+	case AF_INET6:
     -+		inet_ntop(family, &((struct sockaddr_in6*)sin)->sin6_addr, ip, len);
     -+		break;
     -+#endif
     -+	case AF_INET:
     -+		inet_ntop(family, &((struct sockaddr_in*)sin)->sin_addr, ip, len);
     -+		break;
     -+	default:
     -+		xsnprintf(ip, sizeof(ip), "<unknown>");
     -+	}
     -+	return ip;
     -+}
     -+
     -+#ifndef NO_IPV6
     -+
     -+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
     -+{
     -+	int socknum = 0;
     -+	char pbuf[NI_MAXSERV];
     -+	struct addrinfo hints, *ai0, *ai;
     -+	int gai;
     -+	long flags;
     -+
     -+	xsnprintf(pbuf, sizeof(pbuf), "%d", listen_port);
     -+	memset(&hints, 0, sizeof(hints));
     -+	hints.ai_family = AF_UNSPEC;
     -+	hints.ai_socktype = SOCK_STREAM;
     -+	hints.ai_protocol = IPPROTO_TCP;
     -+	hints.ai_flags = AI_PASSIVE;
     -+
     -+	gai = getaddrinfo(listen_addr, pbuf, &hints, &ai0);
     -+	if (gai) {
     -+		logerror("getaddrinfo() for %s failed: %s", listen_addr, gai_strerror(gai));
     -+		return 0;
     -+	}
     -+
     -+	for (ai = ai0; ai; ai = ai->ai_next) {
     -+		int sockfd;
     -+
     -+		sockfd = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
     -+		if (sockfd < 0)
     -+			continue;
     -+		if (sockfd >= FD_SETSIZE) {
     -+			logerror("Socket descriptor too large");
     -+			close(sockfd);
     -+			continue;
     -+		}
     -+
     -+#ifdef IPV6_V6ONLY
     -+		if (ai->ai_family == AF_INET6) {
     -+			int on = 1;
     -+			setsockopt(sockfd, IPPROTO_IPV6, IPV6_V6ONLY,
     -+				   &on, sizeof(on));
     -+			/* Note: error is not fatal */
     -+		}
     -+#endif
     -+
     -+		if (set_reuse_addr(sockfd)) {
     -+			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
     -+			close(sockfd);
     -+			continue;
     -+		}
     -+
     -+		set_keep_alive(sockfd);
     -+
     -+		if (bind(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
     -+			logerror("Could not bind to %s: %s",
     -+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
     -+				 strerror(errno));
     -+			close(sockfd);
     -+			continue;	/* not fatal */
     -+		}
     -+		if (listen(sockfd, 5) < 0) {
     -+			logerror("Could not listen to %s: %s",
     -+				 ip2str(ai->ai_family, ai->ai_addr, ai->ai_addrlen),
     -+				 strerror(errno));
     -+			close(sockfd);
     -+			continue;	/* not fatal */
     -+		}
     -+
     -+		flags = fcntl(sockfd, F_GETFD, 0);
     -+		if (flags >= 0)
     -+			fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
     -+
     -+		ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
     -+		socklist->list[socklist->nr++] = sockfd;
     -+		socknum++;
     -+	}
     -+
     -+	freeaddrinfo(ai0);
     -+
     -+	return socknum;
     -+}
     -+
     -+#else /* NO_IPV6 */
     -+
     -+static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
     -+{
     -+	struct sockaddr_in sin;
     -+	int sockfd;
     -+	long flags;
     -+
     -+	memset(&sin, 0, sizeof sin);
     -+	sin.sin_family = AF_INET;
     -+	sin.sin_port = htons(listen_port);
     -+
     -+	if (listen_addr) {
     -+		/* Well, host better be an IP address here. */
     -+		if (inet_pton(AF_INET, listen_addr, &sin.sin_addr.s_addr) <= 0)
     -+			return 0;
     -+	} else {
     -+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
     -+	}
     -+
     -+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
     -+	if (sockfd < 0)
     -+		return 0;
     -+
     -+	if (set_reuse_addr(sockfd)) {
     -+		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
     -+		close(sockfd);
     -+		return 0;
     -+	}
     -+
     -+	set_keep_alive(sockfd);
     -+
     -+	if (bind(sockfd, (struct sockaddr *)&sin, sizeof sin) < 0) {
     -+		logerror("Could not bind to %s: %s",
     -+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
     -+			 strerror(errno));
     -+		close(sockfd);
     -+		return 0;
     -+	}
     -+
     -+	if (listen(sockfd, 5) < 0) {
     -+		logerror("Could not listen to %s: %s",
     -+			 ip2str(AF_INET, (struct sockaddr *)&sin, sizeof(sin)),
     -+			 strerror(errno));
     -+		close(sockfd);
     -+		return 0;
     -+	}
     -+
     -+	flags = fcntl(sockfd, F_GETFD, 0);
     -+	if (flags >= 0)
     -+		fcntl(sockfd, F_SETFD, flags | FD_CLOEXEC);
     -+
     -+	ALLOC_GROW(socklist->list, socklist->nr + 1, socklist->alloc);
     -+	socklist->list[socklist->nr++] = sockfd;
     -+	return 1;
     -+}
     -+
     -+#endif
     -+
     -+static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
     -+{
     -+	if (!listen_addr->nr)
     -+		setup_named_sock("127.0.0.1", listen_port, socklist);
     -+	else {
     -+		int i, socknum;
     -+		for (i = 0; i < listen_addr->nr; i++) {
     -+			socknum = setup_named_sock(listen_addr->items[i].string,
     -+						   listen_port, socklist);
     -+
     -+			if (socknum == 0)
     -+				logerror("unable to allocate any listen sockets for host %s on port %u",
     -+					 listen_addr->items[i].string, listen_port);
     -+		}
     -+	}
     -+}
     -+
      +static int service_loop(struct socketlist *socklist)
      +{
      +	struct pollfd *pfd;
     @@ t/helper/test-http-server.c (new)
      +		int nr_ready;
      +		int timeout = (pid_file ? 100 : -1);
      +
     -+		check_dead_children();
     ++		check_dead_children(first_child, &live_children, loginfo);
      +
      +		nr_ready = poll(pfd, socklist->nr, timeout);
      +		if (nr_ready < 0) {
     @@ t/helper/test-http-server.c (new)
      +{
      +	struct socketlist socklist = { NULL, 0, 0 };
      +
     -+	socksetup(listen_addr, listen_port, &socklist);
     ++	socksetup(listen_addr, listen_port, &socklist, reuseaddr, logerror);
      +	if (socklist.nr == 0)
      +		die("unable to allocate any listen sockets on port %u",
      +		    listen_port);
     @@ t/helper/test-http-server.c (new)
      +	int i;
      +
      +	trace2_cmd_name("test-http-server");
     ++	trace2_cmd_list_config();
     ++	trace2_cmd_list_env_vars();
      +	setup_git_directory_gently(NULL);
      +
      +	for (i = 1; i < argc; i++) {
     @@ t/helper/test-http-server.c (new)
      +			timeout = atoi(v);
      +			continue;
      +		}
     -+		if (skip_prefix(arg, "--init-timeout=", &v)) {
     -+			init_timeout = atoi(v);
     -+			continue;
     -+		}
      +		if (skip_prefix(arg, "--max-connections=", &v)) {
      +			max_connections = atoi(v);
      +			if (max_connections < 0)
  5:  5c4e36e23ee !  5:  6f66bf146b4 test-http-server: add HTTP request parsing
     @@ Metadata
      Author: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Commit message ##
     -    test-http-server: add HTTP request parsing
     +    test-http-server: add HTTP error response function
      
     -    Add ability to parse HTTP requests to the test-http-server test helper.
     +    Introduce a function to the test-http-server test helper to write more
     +    full and valid HTTP error responses, including all the standard response
     +    headers like `Server` and `Date`.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## t/helper/test-http-server.c ##
      @@ t/helper/test-http-server.c: enum worker_result {
     - 	WR_STOP_THE_MUSIC = (WR_IO_ERROR | WR_HANGUP),
     + 	WR_HANGUP   = 1<<1,
       };
       
      +/*
     @@ t/helper/test-http-server.c: enum worker_result {
      +	string_list_clear(&req->header_list, 0);
      +}
      +
     - static enum worker_result send_http_error(
     - 	int fd,
     - 	int http_code, const char *http_code_name,
     -@@ t/helper/test-http-server.c: done:
     - 	return wr;
     - }
     - 
     ++static enum worker_result send_http_error(
     ++	int fd,
     ++	int http_code, const char *http_code_name,
     ++	int retry_after_seconds, struct string_list *response_headers,
     ++	enum worker_result wr_in)
     ++{
     ++	struct strbuf response_header = STRBUF_INIT;
     ++	struct strbuf response_content = STRBUF_INIT;
     ++	struct string_list_item *h;
     ++	enum worker_result wr;
     ++
     ++	strbuf_addf(&response_content, "Error: %d %s\r\n",
     ++		    http_code, http_code_name);
     ++	if (retry_after_seconds > 0)
     ++		strbuf_addf(&response_content, "Retry-After: %d\r\n",
     ++			    retry_after_seconds);
     ++
     ++	strbuf_addf  (&response_header, "HTTP/1.1 %d %s\r\n", http_code, http_code_name);
     ++	strbuf_addstr(&response_header, "Cache-Control: private\r\n");
     ++	strbuf_addstr(&response_header,	"Content-Type: text/plain\r\n");
     ++	strbuf_addf  (&response_header,	"Content-Length: %d\r\n", (int)response_content.len);
     ++	if (retry_after_seconds > 0)
     ++		strbuf_addf(&response_header, "Retry-After: %d\r\n", retry_after_seconds);
     ++	strbuf_addf(  &response_header,	"Server: test-http-server/%s\r\n", git_version_string);
     ++	strbuf_addf(  &response_header, "Date: %s\r\n", show_date(time(NULL), 0, DATE_MODE(RFC2822)));
     ++	if (response_headers)
     ++		for_each_string_list_item(h, response_headers)
     ++			strbuf_addf(&response_header, "%s\r\n", h->string);
     ++	strbuf_addstr(&response_header, "\r\n");
     ++
     ++	if (write_in_full(fd, response_header.buf, response_header.len) < 0) {
     ++		logerror("unable to write response header");
     ++		wr = WR_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	if (write_in_full(fd, response_content.buf, response_content.len) < 0) {
     ++		logerror("unable to write response content body");
     ++		wr = WR_IO_ERROR;
     ++		goto done;
     ++	}
     ++
     ++	wr = wr_in;
     ++
     ++done:
     ++	strbuf_release(&response_header);
     ++	strbuf_release(&response_content);
     ++
     ++	return wr;
     ++}
     ++
      +/*
      + * Read the HTTP request up to the start of the optional message-body.
      + * We do this byte-by-byte because we have keep-alive turned on and
     @@ t/helper/test-http-server.c: done:
      +		hp = strbuf_detach(&h, NULL);
      +		string_list_append(&req->header_list, hp);
      +
     -+		/* store common request headers separately */
     ++		/* also store common request headers as struct req members */
      +		if (skip_prefix(hp, "Content-Type: ", &hv)) {
      +			req->content_type = hv;
      +		} else if (skip_prefix(hp, "Content-Length: ", &hv)) {
     @@ t/helper/test-http-server.c: done:
      +	return result;
      +}
      +
     ++static int is_git_request(struct req *req)
     ++{
     ++	static regex_t *smart_http_regex;
     ++	static int initialized;
     ++
     ++	if (!initialized) {
     ++		smart_http_regex = xmalloc(sizeof(*smart_http_regex));
     ++		/*
     ++		 * This regular expression matches all dumb and smart HTTP
     ++		 * requests that are currently in use, and defined in
     ++		 * Documentation/gitprotocol-http.txt.
     ++		 *
     ++		 */
     ++		if (regcomp(smart_http_regex, "^/(HEAD|info/refs|"
     ++			    "objects/info/[^/]+|git-(upload|receive)-pack)$",
     ++			    REG_EXTENDED)) {
     ++			warning("could not compile smart HTTP regex");
     ++			smart_http_regex = NULL;
     ++		}
     ++		initialized = 1;
     ++	}
     ++
     ++	return smart_http_regex &&
     ++		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
     ++}
     ++
     ++static enum worker_result do__git(struct req *req)
     ++{
     ++	const char *ok = "HTTP/1.1 200 OK\r\n";
     ++	struct child_process cp = CHILD_PROCESS_INIT;
     ++	int res;
     ++
     ++	/*
     ++	 * Note that we always respond with a 200 OK response even if the
     ++	 * http-backend process exits with an error. This helper is intended
     ++	 * only to be used to exercise the HTTP auth handling in the Git client,
     ++	 * and specifically around authentication (not handled by http-backend).
     ++	 *
     ++	 * If we wanted to respond with a more 'valid' HTTP response status then
     ++	 * we'd need to buffer the output of http-backend, wait for and grok the
     ++	 * exit status of the process, then write the HTTP status line followed
     ++	 * by the http-backend output. This is outside of the scope of this test
     ++	 * helper's use at time of writing.
     ++	 *
     ++	 * The important auth responses (401) we are handling prior to getting
     ++	 * to this point.
     ++	 */
     ++	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
     ++		return error(_("could not send '%s'"), ok);
     ++
     ++	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     ++	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     ++			req->uri_path.buf);
     ++	strvec_push(&cp.env, "SERVER_PROTOCOL=HTTP/1.1");
     ++	if (req->query_args.len)
     ++		strvec_pushf(&cp.env, "QUERY_STRING=%s",
     ++				req->query_args.buf);
     ++	if (req->content_type)
     ++		strvec_pushf(&cp.env, "CONTENT_TYPE=%s",
     ++				req->content_type);
     ++	if (req->content_length >= 0)
     ++		strvec_pushf(&cp.env, "CONTENT_LENGTH=%" PRIdMAX,
     ++				(intmax_t)req->content_length);
     ++	cp.git_cmd = 1;
     ++	strvec_push(&cp.args, "http-backend");
     ++	res = run_command(&cp);
     ++	close(STDOUT_FILENO);
     ++	close(STDIN_FILENO);
     ++	return !!res;
     ++}
     ++
      +static enum worker_result dispatch(struct req *req)
      +{
     -+	return send_http_error(1, 501, "Not Implemented", -1, NULL,
     ++	if (is_git_request(req))
     ++		return do__git(req);
     ++
     ++	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
      +			       WR_OK | WR_HANGUP);
      +}
      +
       static enum worker_result worker(void)
       {
     +-	const char *response = "HTTP/1.1 501 Not Implemented\r\n";
      +	struct req req = REQ__INIT;
       	char *client_addr = getenv("REMOTE_ADDR");
       	char *client_port = getenv("REMOTE_PORT");
       	enum worker_result wr = WR_OK;
      @@ t/helper/test-http-server.c: static enum worker_result worker(void)
     - 	set_keep_alive(0);
     + 	set_keep_alive(0, logerror);
       
       	while (1) {
     --		wr = send_http_error(1, 501, "Not Implemented", -1, NULL,
     --			WR_OK | WR_HANGUP);
     +-		if (write_in_full(STDOUT_FILENO, response, strlen(response)) < 0) {
     +-			logerror("unable to write response");
     +-			wr = WR_IO_ERROR;
     +-		}
      +		req__release(&req);
      +
     -+		alarm(init_timeout ? init_timeout : timeout);
     ++		alarm(timeout);
      +		wr = req__read(&req, 0);
      +		alarm(0);
      +
     -+		if (wr & WR_STOP_THE_MUSIC)
     ++		if (wr != WR_OK)
      +			break;
     -+
     + 
      +		wr = dispatch(&req);
     - 		if (wr & WR_STOP_THE_MUSIC)
     + 		if (wr != WR_OK)
       			break;
       	}
     +
     + ## t/t5556-http-auth.sh (new) ##
     +@@
     ++#!/bin/sh
     ++
     ++test_description='test http auth header and credential helper interop'
     ++
     ++TEST_NO_CREATE_REPO=1
     ++. ./test-lib.sh
     ++
     ++test_set_port GIT_TEST_HTTP_PROTOCOL_PORT
     ++
     ++# Setup a repository
     ++#
     ++REPO_DIR="$TRASH_DIRECTORY"/repo
     ++
     ++# Setup some lookback URLs where test-http-server will be listening.
     ++# We will spawn it directly inside the repo directory, so we avoid
     ++# any need to configure directory mappings etc - we only serve this
     ++# repository from the root '/' of the server.
     ++#
     ++HOST_PORT=127.0.0.1:$GIT_TEST_HTTP_PROTOCOL_PORT
     ++ORIGIN_URL=http://$HOST_PORT/
     ++
     ++# The pid-file is created by test-http-server when it starts.
     ++# The server will shutdown if/when we delete it (this is easier than
     ++# killing it by PID).
     ++#
     ++PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
     ++SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
     ++
     ++PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
     ++
     ++test_expect_success 'setup repos' '
     ++	test_create_repo "$REPO_DIR" &&
     ++	git -C "$REPO_DIR" branch -M main
     ++'
     ++
     ++stop_http_server () {
     ++	if ! test -f "$PID_FILE"
     ++	then
     ++		return 0
     ++	fi
     ++	#
     ++	# The server will shutdown automatically when we delete the pid-file.
     ++	#
     ++	rm -f "$PID_FILE"
     ++	#
     ++	# Give it a few seconds to shutdown (mainly to completely release the
     ++	# port before the next test start another instance and it attempts to
     ++	# bind to it).
     ++	#
     ++	for k in 0 1 2 3 4
     ++	do
     ++		if grep -q "Starting graceful shutdown" "$SERVER_LOG"
     ++		then
     ++			return 0
     ++		fi
     ++		sleep 1
     ++	done
     ++
     ++	echo "stop_http_server: timeout waiting for server shutdown"
     ++	return 1
     ++}
     ++
     ++start_http_server () {
     ++	#
     ++	# Launch our server into the background in repo_dir.
     ++	#
     ++	(
     ++		cd "$REPO_DIR"
     ++		test-http-server --verbose \
     ++			--listen=127.0.0.1 \
     ++			--port=$GIT_TEST_HTTP_PROTOCOL_PORT \
     ++			--reuseaddr \
     ++			--pid-file="$PID_FILE" \
     ++			"$@" \
     ++			2>"$SERVER_LOG" &
     ++	)
     ++	#
     ++	# Give it a few seconds to get started.
     ++	#
     ++	for k in 0 1 2 3 4
     ++	do
     ++		if test -f "$PID_FILE"
     ++		then
     ++			return 0
     ++		fi
     ++		sleep 1
     ++	done
     ++
     ++	echo "start_http_server: timeout waiting for server startup"
     ++	return 1
     ++}
     ++
     ++per_test_cleanup () {
     ++	stop_http_server &&
     ++	rm -f OUT.*
     ++}
     ++
     ++test_expect_success 'http auth anonymous no challenge' '
     ++	test_when_finished "per_test_cleanup" &&
     ++	start_http_server &&
     ++
     ++	# Attempt to read from a protected repository
     ++	git ls-remote $ORIGIN_URL
     ++'
     ++
     ++test_done
  7:  794256754c1 !  6:  c3c3d17a688 test-http-server: add simple authentication
     @@ Commit message
      
          Add simple authentication to the test-http-server test helper.
          Authentication schemes and sets of valid tokens can be specified via
     -    command-line arguments. Incoming requests are compared against the set
     -    of valid schemes and tokens and only approved if a matching token is
     -    found, or if no auth was provided and anonymous auth is enabled.
     +    a configuration file (in the normal gitconfig file format).
     +    Incoming requests are compared against the set of valid schemes and
     +    tokens and only approved if a matching token is found, or if no auth
     +    was provided and anonymous auth is enabled.
      
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## t/helper/test-http-server.c ##
     +@@
     + #include "version.h"
     + #include "dir.h"
     + #include "date.h"
     ++#include "config.h"
     + 
     + #define TR2_CAT "test-http-server"
     + 
      @@ t/helper/test-http-server.c: static const char test_http_auth_usage[] =
     - "           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
     + "           [--timeout=<n>] [--max-connections=<n>]\n"
       "           [--reuseaddr] [--pid-file=<file>]\n"
       "           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
     -+"           [--anonymous-allowed]\n"
     -+"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
     ++"           [--auth-config=<file>]\n"
       ;
       
     - /* Timeout, and initial timeout */
     -@@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req, const char *user)
     + static unsigned int timeout;
     +@@ t/helper/test-http-server.c: static int is_git_request(struct req *req)
     + 		!regexec(smart_http_regex, req->uri_path.buf, 0, NULL, 0);
     + }
     + 
     +-static enum worker_result do__git(struct req *req)
     ++static enum worker_result do__git(struct req *req, const char *user)
     + {
     + 	const char *ok = "HTTP/1.1 200 OK\r\n";
     + 	struct child_process cp = CHILD_PROCESS_INIT;
     +@@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
     + 	if (write(STDOUT_FILENO, ok, strlen(ok)) < 0)
     + 		return error(_("could not send '%s'"), ok);
     + 
     ++	if (user)
     ++		strvec_pushf(&cp.env, "REMOTE_USER=%s", user);
     ++
     + 	strvec_pushf(&cp.env, "REQUEST_METHOD=%s", req->method);
     + 	strvec_pushf(&cp.env, "PATH_TRANSLATED=%s",
     + 			req->uri_path.buf);
     +@@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req)
       	return !!res;
       }
       
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +static struct auth_module **auth_modules = NULL;
      +static size_t auth_modules_nr = 0;
      +static size_t auth_modules_alloc = 0;
     ++static struct strvec extra_headers = STRVEC_INIT;
     ++
     ++static struct auth_module *create_auth_module(const char *scheme,
     ++					      const char *challenge)
     ++{
     ++	struct auth_module *mod = xmalloc(sizeof(struct auth_module));
     ++	mod->scheme = xstrdup(scheme);
     ++	mod->challenge_params = challenge ? xstrdup(challenge) : NULL;
     ++	CALLOC_ARRAY(mod->tokens, 1);
     ++	string_list_init_dup(mod->tokens);
     ++	return mod;
     ++}
      +
      +static struct auth_module *get_auth_module(const char *scheme)
      +{
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +	return NULL;
      +}
      +
     -+static void add_auth_module(struct auth_module *mod)
     ++static int add_auth_module(struct auth_module *mod)
      +{
     ++	if (get_auth_module(mod->scheme))
     ++		return error("duplicate auth scheme '%s'\n", mod->scheme);
     ++
      +	ALLOC_GROW(auth_modules, auth_modules_nr + 1, auth_modules_alloc);
      +	auth_modules[auth_modules_nr++] = mod;
     ++
     ++	return 0;
      +}
      +
      +static int is_authed(struct req *req, const char **user, enum worker_result *wr)
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +
      +	/*
      +	 * Check all auth modules and try to validate the request.
     -+	 * The first module that matches a valid token approves the request.
     ++	 * The first Authorization header that matches a known auth module
     ++	 * scheme will be consulted to either approve or deny the request.
      +	 * If no module is found, or if there is no valid token, then 401 error.
      +	 * Otherwise, only permit the request if anonymous auth is enabled.
     ++	 * It's atypical for user agents/clients to send multiple Authorization
     ++	 * headers, but not explicitly forbidden or defined.
      +	 */
      +	for_each_string_list_item(hdr, &req->header_list) {
      +		if (skip_iprefix(hdr->string, "Authorization: ", &v)) {
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +	case AUTH_UNKNOWN:
      +		if (result != AUTH_DENY && allow_anonymous)
      +			break;
     ++
      +		for (i = 0; i < auth_modules_nr; i++) {
      +			mod = auth_modules[i];
      +			if (mod->challenge_params)
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +						    mod->scheme);
      +			string_list_append(&hdrs, challenge);
      +		}
     -+		*wr = send_http_error(1, 401, "Unauthorized", -1, &hdrs, *wr);
     ++
     ++		for (i = 0; i < extra_headers.nr; i++)
     ++			string_list_append(&hdrs, extra_headers.v[i]);
     ++
     ++		*wr = send_http_error(STDOUT_FILENO, 401, "Unauthorized", -1,
     ++				      &hdrs, *wr);
      +	}
      +
      +	strbuf_list_free(split);
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +	return result == AUTH_ALLOW ||
      +	      (result == AUTH_UNKNOWN && allow_anonymous);
      +}
     ++
     ++static int split_auth_param(const char *str, char **scheme, char **val, int required_val)
     ++{
     ++	struct strbuf **p = strbuf_split_str(str, ':', 2);
     ++
     ++	if (!p[0])
     ++		return -1;
     ++
     ++	/* trim trailing ':' */
     ++	if (p[1])
     ++		strbuf_setlen(p[0], p[0]->len - 1);
     ++
     ++	if (required_val && !p[1])
     ++		return -1;
     ++
     ++	*scheme = strbuf_detach(p[0], NULL);
     ++
     ++	if (p[1])
     ++		*val = strbuf_detach(p[1], NULL);
     ++
     ++	strbuf_list_free(p);
     ++	return 0;
     ++}
     ++
     ++static int read_auth_config(const char *name, const char *val, void *data)
     ++{
     ++	int ret = 0;
     ++	char *scheme = NULL;
     ++	char *token = NULL;
     ++	char *challenge = NULL;
     ++	struct auth_module *mod = NULL;
     ++
     ++	if (!strcmp(name, "auth.challenge")) {
     ++		if (split_auth_param(val, &scheme, &challenge, 0)) {
     ++			ret = error("invalid auth challenge '%s'", val);
     ++			goto cleanup;
     ++		}
     ++
     ++		mod = create_auth_module(scheme, challenge);
     ++		if (add_auth_module(mod)) {
     ++			ret = error("failed to add auth module '%s'", val);
     ++			goto cleanup;
     ++		}
     ++	}
     ++	if (!strcmp(name, "auth.token")) {
     ++		if (split_auth_param(val, &scheme, &token, 1)) {
     ++			ret = error("invalid auth token '%s'", val);
     ++			goto cleanup;
     ++		}
     ++
     ++		mod = get_auth_module(scheme);
     ++		if (!mod) {
     ++			ret = error("auth scheme not defined '%s'\n", scheme);
     ++			goto cleanup;
     ++		}
     ++
     ++		string_list_append(mod->tokens, token);
     ++	}
     ++	if (!strcmp(name, "auth.allowanonymous")) {
     ++		allow_anonymous = git_config_bool(name, val);
     ++	}
     ++	if (!strcmp(name, "auth.extraheader")) {
     ++		strvec_push(&extra_headers, val);
     ++	}
     ++
     ++cleanup:
     ++	free(scheme);
     ++	free(token);
     ++	free(challenge);
     ++
     ++	return ret;
     ++}
      +
       static enum worker_result dispatch(struct req *req)
       {
     @@ t/helper/test-http-server.c: static enum worker_result do__git(struct req *req,
      +		return wr;
      +
       	if (is_git_request(req))
     --		return do__git(req, NULL);
     +-		return do__git(req);
      +		return do__git(req, user);
       
     - 	return send_http_error(1, 501, "Not Implemented", -1, NULL,
     + 	return send_http_error(STDOUT_FILENO, 501, "Not Implemented", -1, NULL,
       			       WR_OK | WR_HANGUP);
     -@@ t/helper/test-http-server.c: int cmd_main(int argc, const char **argv)
     - 	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
     - 	int worker_mode = 0;
     - 	int i;
     -+	struct auth_module *mod = NULL;
     - 
     - 	trace2_cmd_name("test-http-server");
     - 	setup_git_directory_gently(NULL);
      @@ t/helper/test-http-server.c: int cmd_main(int argc, const char **argv)
       			pid_file = v;
       			continue;
       		}
     -+		if (skip_prefix(arg, "--allow-anonymous", &v)) {
     -+			allow_anonymous = 1;
     -+			continue;
     -+		}
     -+		if (skip_prefix(arg, "--auth=", &v)) {
     -+			struct strbuf **p = strbuf_split_str(v, ':', 2);
     -+
     -+			if (!p[0]) {
     -+				error("invalid argument '%s'", v);
     ++		if (skip_prefix(arg, "--auth-config=", &v)) {
     ++			if (!strlen(v)) {
     ++				error("invalid argument - missing file path");
      +				usage(test_http_auth_usage);
      +			}
      +
     -+			/* trim trailing ':' */
     -+			if (p[1])
     -+				strbuf_setlen(p[0], p[0]->len - 1);
     -+
     -+			if (get_auth_module(p[0]->buf)) {
     -+				error("duplicate auth scheme '%s'\n", p[0]->buf);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			mod = xmalloc(sizeof(struct auth_module));
     -+			mod->scheme = xstrdup(p[0]->buf);
     -+			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
     -+			CALLOC_ARRAY(mod->tokens, 1);
     -+			string_list_init_dup(mod->tokens);
     -+
     -+			add_auth_module(mod);
     -+
     -+			strbuf_list_free(p);
     -+			continue;
     -+		}
     -+		if (skip_prefix(arg, "--auth-token=", &v)) {
     -+			struct strbuf **p = strbuf_split_str(v, ':', 2);
     -+			if (!p[0]) {
     -+				error("invalid argument '%s'", v);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			if (!p[1]) {
     -+				error("missing token value '%s'\n", v);
     -+				usage(test_http_auth_usage);
     -+			}
     -+
     -+			/* trim trailing ':' */
     -+			strbuf_setlen(p[0], p[0]->len - 1);
     -+
     -+			mod = get_auth_module(p[0]->buf);
     -+			if (!mod) {
     -+				error("auth scheme not defined '%s'\n", p[0]->buf);
     ++			if (git_config_from_file(read_auth_config, v, NULL)) {
     ++				error("failed to read auth config file '%s'", v);
      +				usage(test_http_auth_usage);
      +			}
      +
     -+			string_list_append(mod->tokens, p[1]->buf);
     -+			strbuf_list_free(p);
      +			continue;
      +		}
       
  -:  ----------- >  7:  9c4d25945dd http: replace unsafe size_t multiplication with st_mult
  -:  ----------- >  8:  65a620b08ef strvec: expose strvec_push_nodup for external use
  1:  b5b56ccd941 !  9:  bcfec529d95 http: read HTTP WWW-Authenticate response headers
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
       
      +static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
      +{
     -+	size_t size = eltsize * nmemb;
     ++	size_t size = st_mult(eltsize, nmemb);
      +	struct strvec *values = &http_auth.wwwauth_headers;
      +	struct strbuf buf = STRBUF_INIT;
      +	const char *val;
     -+	const char *z = NULL;
      +
      +	/*
      +	 * Header lines may not come NULL-terminated from libcurl so we must
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 * This line could be a continuation of the previously matched header
      +	 * field. If this is the case then we should append this value to the
      +	 * end of the previously consumed value.
     ++	 * Continuation lines start with at least one whitespace, maybe more,
     ++	 * so we should collapse these down to a single SP (valid per the spec).
      +	 */
      +	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
     -+		const char **v = values->v + values->nr - 1;
     -+		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
     ++		/* Trim leading whitespace from this continuation hdr line. */
     ++		strbuf_ltrim(&buf);
      +
     -+		free((void*)*v);
     -+		*v = append;
     ++		/*
     ++		 * At this point we should always have at least one existing
     ++		 * value, even if it is empty. Do not bother appending the new
     ++		 * value if this continuation header is itself empty.
     ++		 */
     ++		if (!values->nr) {
     ++			BUG("should have at least one existing header value");
     ++		} else if (buf.len) {
     ++			const char *prev = values->v[values->nr - 1];
     ++			struct strbuf append = STRBUF_INIT;
     ++			strbuf_addstr(&append, prev);
     ++
     ++			/* Join two non-empty values with a single space. */
     ++			if (append.len)
     ++				strbuf_addch(&append, ' ');
     ++
     ++			strbuf_addbuf(&append, &buf);
     ++
     ++			strvec_pop(values);
     ++			strvec_push_nodup(values, strbuf_detach(&append, NULL));
     ++		}
      +
      +		goto exit;
      +	}
     @@ http.c: size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buff
      +	 * We only care about the last HTTP request response's headers so clear
      +	 * the existing array.
      +	 */
     -+	if (skip_iprefix(buf.buf, "http/", &z))
     ++	if (istarts_with(buf.buf, "http/"))
      +		strvec_clear(values);
      +
      +exit:
  2:  d02875dda7c <  -:  ----------- credential: add WWW-Authenticate header to cred requests
  4:  98dd286db7c <  -:  ----------- test-http-server: add HTTP error response function
  6:  0a0f4fd10c8 <  -:  ----------- test-http-server: pass Git requests to http-backend
  8:  8ecf6383522 ! 10:  af66d2d2ede t5556: add HTTP authentication tests
     @@ Metadata
      Author: Matthew John Cheetham <mjcheetham@outlook.com>
      
       ## Commit message ##
     -    t5556: add HTTP authentication tests
     +    credential: add WWW-Authenticate header to cred requests
      
     -    Add a series of tests to exercise the HTTP authentication header parsing
     +    Add the value of the WWW-Authenticate response header to credential
     +    requests. Credential helpers that understand and support HTTP
     +    authentication and authorization can use this standard header (RFC 2616
     +    Section 14.47 [1]) to generate valid credentials.
     +
     +    WWW-Authenticate headers can contain information pertaining to the
     +    authority, authentication mechanism, or extra parameters/scopes that are
     +    required.
     +
     +    The current I/O format for credential helpers only allows for unique
     +    names for properties/attributes, so in order to transmit multiple header
     +    values (with a specific order) we introduce a new convention whereby a
     +    C-style array syntax is used in the property name to denote multiple
     +    ordered values for the same property.
     +
     +    In this case we send multiple `wwwauth[]` properties where the order
     +    that the repeated attributes appear in the conversation reflects the
     +    order that the WWW-Authenticate headers appeared in the HTTP response.
     +
     +    Add a set of tests to exercise the HTTP authentication header parsing
          and the interop with credential helpers. Credential helpers will receive
          WWW-Authenticate information in credential requests.
      
     +    [1] https://datatracker.ietf.org/doc/html/rfc2616#section-14.47
     +
          Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
      
     + ## Documentation/git-credential.txt ##
     +@@ Documentation/git-credential.txt: separated by an `=` (equals) sign, followed by a newline.
     + The key may contain any bytes except `=`, newline, or NUL. The value may
     + contain any bytes except newline or NUL.
     + 
     +-In both cases, all bytes are treated as-is (i.e., there is no quoting,
     ++Attributes with keys that end with C-style array brackets `[]` can have
     ++multiple values. Each instance of a multi-valued attribute forms an
     ++ordered list of values - the order of the repeated attributes defines
     ++the order of the values. An empty multi-valued attribute (`key[]=\n`)
     ++acts to clear any previous entries and reset the list.
     ++
     ++In all cases, all bytes are treated as-is (i.e., there is no quoting,
     + and one cannot transmit a value with newline or NUL in it). The list of
     + attributes is terminated by a blank line or end-of-file.
     + 
     +@@ Documentation/git-credential.txt: empty string.
     + Components which are missing from the URL (e.g., there is no
     + username in the example above) will be left unset.
     + 
     ++`wwwauth[]`::
     ++
     ++	When an HTTP response is received by Git that includes one or more
     ++	'WWW-Authenticate' authentication headers, these will be passed by Git
     ++	to credential helpers.
     +++
     ++Each 'WWW-Authenticate' header value is passed as a multi-valued
     ++attribute 'wwwauth[]', where the order of the attributes is the same as
     ++they appear in the HTTP response. This attribute is 'one-way' from Git
     ++to pass additional information to credential helpers.
     ++
     + Unrecognised attributes are silently discarded.
     + 
     + GIT
     +
     + ## credential.c ##
     +@@ credential.c: static void credential_write_item(FILE *fp, const char *key, const char *value,
     + 	fprintf(fp, "%s=%s\n", key, value);
     + }
     + 
     ++static void credential_write_strvec(FILE *fp, const char *key,
     ++				    const struct strvec *vec)
     ++{
     ++	int i = 0;
     ++	const char *full_key = xstrfmt("%s[]", key);
     ++	for (; i < vec->nr; i++) {
     ++		credential_write_item(fp, full_key, vec->v[i], 0);
     ++	}
     ++	free((void*)full_key);
     ++}
     ++
     + void credential_write(const struct credential *c, FILE *fp)
     + {
     + 	credential_write_item(fp, "protocol", c->protocol, 1);
     +@@ credential.c: void credential_write(const struct credential *c, FILE *fp)
     + 	credential_write_item(fp, "path", c->path, 0);
     + 	credential_write_item(fp, "username", c->username, 0);
     + 	credential_write_item(fp, "password", c->password, 0);
     ++	credential_write_strvec(fp, "wwwauth", &c->wwwauth_headers);
     + }
     + 
     + static int run_credential_helper(struct credential *c,
     +
       ## t/helper/test-credential-helper-replay.sh (new) ##
      @@
      +cmd=$1
     @@ t/helper/test-credential-helper-replay.sh (new)
      +fi
      
       ## t/t5556-http-auth.sh ##
     -@@ t/t5556-http-auth.sh: PID_FILE="$(pwd)"/pid-file.pid
     - SERVER_LOG="$(pwd)"/OUT.server.log
     +@@ t/t5556-http-auth.sh: PID_FILE="$TRASH_DIRECTORY"/pid-file.pid
     + SERVER_LOG="$TRASH_DIRECTORY"/OUT.server.log
       
       PATH="$GIT_BUILD_DIR/t/helper/:$PATH" && export PATH
      +CREDENTIAL_HELPER="$GIT_BUILD_DIR/t/helper/test-credential-helper-replay.sh" \
     @@ t/t5556-http-auth.sh: start_http_server () {
       	stop_http_server &&
      -	rm -f OUT.*
      +	rm -f OUT.* &&
     -+	rm -f *.cred
     ++	rm -f *.cred &&
     ++	rm -f auth.config
       }
       
       test_expect_success 'http auth anonymous no challenge' '
     -@@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
     + 	test_when_finished "per_test_cleanup" &&
     +-	start_http_server &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    allowAnonymous = true
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     + 
     + 	# Attempt to read from a protected repository
       	git ls-remote $ORIGIN_URL
       '
       
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
      +	export USERPASS64 &&
      +
     -+	start_http_server \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=basic:$USERPASS64 &&
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	test_cmp store-expected.cred store-actual.cred
      +'
      +
     ++test_expect_success 'http auth www-auth headers to credential helper ignore case valid' '
     ++	test_when_finished "per_test_cleanup" &&
     ++	# base64("alice:secret-passwd")
     ++	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     ++	export USERPASS64 &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	    extraHeader = wWw-aUtHeNtIcAtE: bEaRer auThoRiTy=\"id.example.com\"
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     ++
     ++	cat >get-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	wwwauth[]=basic realm="example.com"
     ++	wwwauth[]=bEaRer auThoRiTy="id.example.com"
     ++	EOF
     ++
     ++	cat >store-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	cat >get-response.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     ++
     ++	test_cmp get-expected.cred get-actual.cred &&
     ++	test_cmp store-expected.cred store-actual.cred
     ++'
     ++
     ++test_expect_success 'http auth www-auth headers to credential helper continuation hdr' '
     ++	test_when_finished "per_test_cleanup" &&
     ++	# base64("alice:secret-passwd")
     ++	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     ++	export USERPASS64 &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = "bearer:authority=\"id.example.com\"\\n    q=1\\n \\t p=0"
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     ++
     ++	cat >get-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	wwwauth[]=bearer authority="id.example.com" q=1 p=0
     ++	wwwauth[]=basic realm="example.com"
     ++	EOF
     ++
     ++	cat >store-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	cat >get-response.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     ++
     ++	test_cmp get-expected.cred get-actual.cred &&
     ++	test_cmp store-expected.cred store-actual.cred
     ++'
     ++
     ++test_expect_success 'http auth www-auth headers to credential helper empty continuation hdrs' '
     ++	test_when_finished "per_test_cleanup" &&
     ++	# base64("alice:secret-passwd")
     ++	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
     ++	export USERPASS64 &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	    extraheader = "WWW-Authenticate:"
     ++	    extraheader = " "
     ++	    extraheader = " bearer authority=\"id.example.com\""
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
     ++
     ++	cat >get-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	wwwauth[]=basic realm="example.com"
     ++	wwwauth[]=bearer authority="id.example.com"
     ++	EOF
     ++
     ++	cat >store-expected.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	cat >get-response.cred <<-EOF &&
     ++	protocol=http
     ++	host=$HOST_PORT
     ++	username=alice
     ++	password=secret-passwd
     ++	EOF
     ++
     ++	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
     ++
     ++	test_cmp get-expected.cred get-actual.cred &&
     ++	test_cmp store-expected.cred store-actual.cred
     ++'
     ++
      +test_expect_success 'http auth www-auth headers to credential helper custom schemes' '
      +	test_when_finished "per_test_cleanup" &&
      +	# base64("alice:secret-passwd")
      +	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
      +	export USERPASS64 &&
      +
     -+	start_http_server \
     -+		--auth=foobar:alg=test\ widget=1 \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=basic:$USERPASS64 &&
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = "foobar:alg=test widget=1"
     ++	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http
     @@ t/t5556-http-auth.sh: test_expect_success 'http auth anonymous no challenge' '
      +	# base64("alice:secret-passwd")
      +	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
      +	export USERPASS64 &&
     -+	start_http_server \
     -+		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
     -+		--auth=basic:realm=\"example.com\" \
     -+		--auth-token=basic:$USERPASS64 &&
     ++
     ++	cat >auth.config <<-EOF &&
     ++	[auth]
     ++	    challenge = "bearer:authority=\"id.example.com\" q=1 p=0"
     ++	    challenge = basic:realm=\"example.com\"
     ++	    token = basic:$USERPASS64
     ++	EOF
     ++
     ++	start_http_server --auth-config="$TRASH_DIRECTORY/auth.config" &&
      +
      +	cat >get-expected.cred <<-EOF &&
      +	protocol=http

-- 
gitgitgadget
