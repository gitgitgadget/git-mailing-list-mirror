Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A1C43461
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F329206D4
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 13:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgIQNWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 09:22:03 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57059 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIQNVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 09:21:08 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbizQ-1kuzkc38xy-00dFNo; Thu, 17 Sep 2020 15:20:48 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 0EC851E01E7;
        Thu, 17 Sep 2020 13:20:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u9LQLzRqhFzm; Thu, 17 Sep 2020 15:20:47 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id AC2381E01E6;
        Thu, 17 Sep 2020 15:20:47 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 7E4CB8051A; Thu, 17 Sep 2020 15:20:47 +0200 (CEST)
Date:   Thu, 17 Sep 2020 15:20:47 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] Config option to set the transport protocol version for
 network fetches
Message-ID: <20200917132047.GA14771@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916200203.GA37225@coredump.intra.peff.net>
X-Provags-ID: V03:K1:NKNNdR2ynt94Mh5McqRLi8ycwWg+6Ks7koGqjym+FVaD/Acil6E
 HTYWUn7BRvwzlrvM2NkIPPS7qY1CFqrEAx+Xqq69KNXC0US52b+HREBhAjbLluEjhB8uxxF
 2CzzLGLawiD8lEshVIJyQLnSwWtqicjXVcZZ1Xd2M5bwGLoUvma7mvzcINQjXMsXFF4kTEM
 xIFEERLjqAQxOZR+cQorw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1T5Z3ARaAK0=:fE/Asb9ZdcQEfpmbpeE+9D
 RJ97Qj7iri1/FqYgN88VW/oqpIOhFBGiQPVrcPcusoCBtAlKXCHvIdhd/TL03w8U2W3hl+zVp
 SKgM6uAPhRGSNWMuqsXoYgpuutgqAUX9MlVCpn2NxKCSNF6pFUfKmyhdqwFu3mWMXVWF48C6v
 UkGNOZtVb7CPDfmdzI53EMbI+5A7nbJllcWSHpbBqhlrGjhXe3C0ZgG8dOtAGbYOF1kwIjzOz
 V9MJ6xVHdSQGGImrIpkG8s1K8NpPz0pE0PU1g7kLTOV6Y0M+QsybV9ZSLLeyonHNDTtOSmFbV
 sdyf43hBwIQFERsundHvrjVT+vMdNZ5Qu9n9wrfJ3FiJLe1m4qJwAVhMOtkW2zSpG7Rrmxk5p
 fXpxzKQbDwaYtYyNXRXafeD0VulLEauMgPa4Qcg/P44Kmi4trHRhGMBKVPbTTEzaU3Ra9CQvx
 +v1LamI21UUi5jm4sNXSM2aQo9d/XQexP9jRSF0eBGyMRLv5HDRnWyzned2e56iV/UjqZmyB1
 NzwJJN2kYNzPGWVHCsoI+FyQmh4su6Dj+cldybOjrVZj/71lDZPzYxd6l3W4yqG+Bmg6tfJ+V
 p5AfLpigFN0vDInr6Ka3/hzDYu2cX2V+R1IA2l9Ludna0TXbZ3nxfHsZcyx9aePHD1yVAYRah
 zsvchooOUrcW0cA3rFiZwBy8p2WQJUu74JS5kiwS8DfARH9OsSe4qVDC72KFqOAe0W4UIXXCq
 pmXQb+SDhICRgh3+6NStBNkJl7BWvDSb37L5YBXqX91p64niARTH4WjTS6NiF5EYS/vJ80aW6
 OvnFfddGDGTuTkaikrgiWfpDjlNn9g24Ws6OXQeMNkbU+vhmCkcvMlvsStfSz7mI3gpKedxEd
 uPhOGaxvWL0fAAOHtOZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Affecting the transfers initiated by fetch and push,
the option allows to control network operations similar
to --ipv4 and --ipv6 options.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Alex Riesen <alexander.riesen@cetitec.com>
---

Jeff King, Wed, Sep 16, 2020 22:02:03 +0200:
> On Tue, Sep 15, 2020 at 03:54:28PM +0200, Alex Riesen wrote:
> 
> > Jeff King, Tue, Sep 15, 2020 15:05:06 +0200:
> > > On Tue, Sep 15, 2020 at 01:50:25PM +0200, Alex Riesen wrote:
> > > > Sure! Thinking about it, I actually would have preferred to have both: a
> > > > config option and a command-line option. So that I can set --ipv4 in, say,
> > > > ~/.config/git/config file, but still have the option to try --ipv6 from time
> > > > to time to check if the network setup magically fixed itself.
> > > > 
> > > > What would the preferred name for that config option be? fetch.ipv?
> > > 
> > > It looks like we've got similar options for clone/pull (which are really
> > > fetch under the hood of course) and push. We have the "transfer.*"
> > > namespace which applies to both already. So maybe "transfer.ipversion"
> > > or something?
> > 
> > Something like this?
> 
> That's the right direction, but I think we'd want to make sure it
> impacted all of the spots that allow switching. "clone" on the fetching
> side, but probably also "push".
> 
> Each of those commands could learn the same config, but it might be
> easier to just enforce it in the transport layer. Something like this
> maybe (compiled but not tested):

I have merged the patches.

> A few notes:
> 
>   - it cheats a little by noting that command-line options can't get it
>     to "ALL". It might be a bit cleaner if we have an explicit
>     TRANSPORT_FAMILY_UNSET, and then resolve the default at look-up
>     time.
> 
>   - it probably needs more "if (family)" spots in each command, which is
>     unfortunate (which again might go away if "UNSET" is 0).

As this is still being discussed, and because I still imagine the
transport protocol family as a list of allowed protocols, this part
is not in the patch below.

>   - I waffled on the name. transfer.* is where we put things that apply
>     to both push/fetch, but it's usually more related to the git layer.
>     This is more of a core networking decision, and if we added other
>     network programs, I'd expect them to respect it. So maybe "core." is
>     a better namespace.

I agree.

 Documentation/config/core.txt |  7 +++++++
 builtin/fetch.c               |  3 ++-
 builtin/push.c                |  3 ++-
 transport.c                   | 19 +++++++++++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 74619a9c03..dcb7db9799 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -626,3 +626,10 @@ core.abbrev::
 	in your repository, which hopefully is enough for
 	abbreviated object names to stay unique for some time.
 	The minimum length is 4.
+
+core.ipversion::
+	Limit the network operations to the specified version of the transport
+	protocol. Can be specified as `4` to allow IPv4 only, `6` for IPv6, or
+	`all` to allow all protocols.
+	See also linkgit:git-fetch[1] options `--ipv4` and `--ipv6`.
+	The default value is `all` to allow all protocols.
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 447d28ac29..41f82d61d7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1248,7 +1248,8 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
-	transport->family = family;
+	if (family)
+		transport->family = family;
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/builtin/push.c b/builtin/push.c
index bc94078e72..f7a40b65cd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -343,7 +343,8 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 	char *anon_url = transport_anonymize_url(transport->url);
 
 	transport_set_verbosity(transport, verbosity, progress);
-	transport->family = family;
+	if (family)
+		transport->family = family;
 
 	if (receivepack)
 		transport_set_option(transport,
diff --git a/transport.c b/transport.c
index b41386eccb..e16c339f3e 100644
--- a/transport.c
+++ b/transport.c
@@ -922,6 +922,23 @@ static struct transport_vtable builtin_smart_vtable = {
 	disconnect_git
 };
 
+static enum transport_family default_transport_family(void)
+{
+	static const char key[] = "core.ipversion";
+	const char *v;
+
+	if (git_config_get_string_const(key, &v))
+		return TRANSPORT_FAMILY_ALL;
+	if (!strcmp(v, "all"))
+		return TRANSPORT_FAMILY_ALL;
+	if (!strcmp(v, "ipv4"))
+		return TRANSPORT_FAMILY_IPV4;
+	if (!strcmp(v, "ipv6"))
+		return TRANSPORT_FAMILY_IPV6;
+
+	die(_("%s: unknown value '%s'"), key, v);
+}
+
 struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
@@ -951,6 +968,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
 			helper = xstrndup(url, p - url);
 	}
 
+	ret->family = default_transport_family();
+
 	if (helper) {
 		transport_helper_init(ret, helper);
 	} else if (starts_with(url, "rsync:")) {
-- 
2.28.0.22.gfab0d4627e
