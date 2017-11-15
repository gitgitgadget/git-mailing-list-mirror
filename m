Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5ED0201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 20:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbdKOU0J (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 15:26:09 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44802 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbdKOU0H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 15:26:07 -0500
Received: by mail-io0-f195.google.com with SMTP id w127so2885344iow.11
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 12:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SJuy+tOTMzFuymetRtKeEuvc0SQpmO4TYg4v/YkC1vc=;
        b=t84ujGB3Rz6I/j1z+mul6pMRoPVPYXgMfu0GFHDSH7/5Nx45sNGrbx30egeiJvg0EP
         5sT8UAMyEc3bASPtzU6CAMbTAJVtEMvDe7LhDAN/RU4aa0VWF3fFSmPr38PxFMo+GAPz
         A7J47NnD4wDVzixVTy59I+pwSr1oOyFBvrE3ZowbgE2sk2uVGSk2bUNt54k+v0vx+P3m
         NSffLg1DjGW8RcEoPYttinSzTg8c5cSGnHTsRNg9wFthjCWdJ858fa/R1OB0314rL/w6
         C/5LZB46G6zIbXAq59W/wgouWtEmAkNlFkOYgFrtKMkPdtJkrLNvshRg2qk2Lnq7eni4
         /Xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SJuy+tOTMzFuymetRtKeEuvc0SQpmO4TYg4v/YkC1vc=;
        b=R2qVJagQGYx2HgES+aaYfSVDd4aJo+aw1uR8khR7YCNdUDcnFSUJOVrT0iVFHzCsCu
         pKpceaVzlrGkuc+zCkGOnYgjgq+K6tkvf0+HwAOjcd7x0U5c/mxDIoB6njhUrD7P15zt
         c9oaQt4/b98pJrbQ88GSFnqfFHfx3ED7AHUsE199GK6syo56uxKPg/LOEhtjmH7HzskM
         ZP1x/o58il6TV/1KtTv5QVyi0E3+BvPWqHhBP+2FU+u7hEkClnh7Rvb39qUx/x5TbB3/
         Nnc3rYOCTElx40nuDyXeoBRemRo2pGJ7f5UecekyEq3kz7iQb4x+3VXOT2GKFnnSNHvc
         ZmZQ==
X-Gm-Message-State: AJaThX6nKQfk1L3I0+O1d8STEA30nN/Gl31hLhmVmoXoxmJrnYVIjYTu
        5evqwCMoVNFOQ5my8N64k9gOk0Ib
X-Google-Smtp-Source: AGs4zMZhOC6vs9f6xnegPrNaLiaLdqqUlG60H5evf54TvUPo6hj0g+T85Yy7CupLOHFOuCHOQ4+YDA==
X-Received: by 10.107.9.223 with SMTP id 92mr4998015ioj.16.1510777566981;
        Wed, 15 Nov 2017 12:26:06 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b102sm6912484itd.19.2017.11.15.12.26.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Nov 2017 12:26:06 -0800 (PST)
Date:   Wed, 15 Nov 2017 12:25:16 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 1/5] connect: split git:// setup into a separate function
Message-ID: <20171115202516.hduhzsgeoff5a22b@aiede.mtv.corp.google.com>
References: <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
 <20171023225106.GA73667@google.com>
 <20171023155713.5055125d7467d8daaee42e32@google.com>
 <20171023231625.6mhcyqti7vdg6yot@aiede.mtv.corp.google.com>
 <20171023231703.f457jp43dh7fddpv@aiede.mtv.corp.google.com>
 <xmqqpo9d9v5y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpo9d9v5y.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Oct 24, 2017, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +static struct child_process *git_connect_git(int fd[2], char *hostandport,
>> +					     const char *path, const char *prog,
>> +					     int flags)
>> +{
>> +	struct child_process *conn = &no_fork;
>> +	struct strbuf request = STRBUF_INIT;
>
> As this one decides what "conn" to return, including the fallback
> &no_fork instance,...
>
>> +	...
>> +	return conn;
>> +}
>> +
>>  /*
>>   * This returns a dummy child_process if the transport protocol does not
>>   * need fork(2), or a struct child_process object if it does.  Once done,
>> @@ -881,50 +939,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>
> Each of the if/elseif/ cascade, one of which calls the new helper,
> now makes an explicit assignment to "conn" declared in
> git_connect().
>
> Which means the defaulting of git_connect::conn to &no_fork is now
> unneeded.  One of the things that made the original cascade a bit
> harder to follow than necessary, aside from the physical length of
> the PROTO_GIT part, was that the case where conn remains to point at
> no_fork looked very special and it was buried in that long PROTO_GIT
> part.

Good idea.  Here's what I'll include in the reroll.

-- >8 --
Subject: connect: move no_fork fallback to git_tcp_connect

git_connect has the structure

	struct child_process *conn = &no_fork;

	...
	switch (protocol) {
	case PROTO_GIT:
		if (git_use_proxy(hostandport))
			conn = git_proxy_connect(fd, hostandport);
		else
			git_tcp_connect(fd, hostandport, flags);
		...
		break;
	case PROTO_SSH:
		conn = xmalloc(sizeof(*conn));
		child_process_init(conn);
		argv_array_push(&conn->args, ssh);
		...
		break;
	...
	return conn;

In all cases except the git_tcp_connect case, conn is explicitly
assigned a value. Make the code clearer by explicitly assigning
'conn = &no_fork' in the tcp case and eliminating the default so the
compiler can ensure conn is always correctly assigned.

Noticed-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 connect.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/connect.c b/connect.c
index 7fbd396b35..b6accf71cb 100644
--- a/connect.c
+++ b/connect.c
@@ -582,12 +582,21 @@ static int git_tcp_connect_sock(char *host, int flags)
 #endif /* NO_IPV6 */
 
 
-static void git_tcp_connect(int fd[2], char *host, int flags)
+static struct child_process no_fork = CHILD_PROCESS_INIT;
+
+int git_connection_is_socket(struct child_process *conn)
+{
+	return conn == &no_fork;
+}
+
+static struct child_process *git_tcp_connect(int fd[2], char *host, int flags)
 {
 	int sockfd = git_tcp_connect_sock(host, flags);
 
 	fd[0] = sockfd;
 	fd[1] = dup(sockfd);
+
+	return &no_fork;
 }
 
 
@@ -761,8 +770,6 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	return protocol;
 }
 
-static struct child_process no_fork = CHILD_PROCESS_INIT;
-
 static const char *get_ssh_command(void)
 {
 	const char *ssh;
@@ -865,7 +872,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 				  const char *prog, int flags)
 {
 	char *hostandport, *path;
-	struct child_process *conn = &no_fork;
+	struct child_process *conn;
 	enum protocol protocol;
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -901,7 +908,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 		if (git_use_proxy(hostandport))
 			conn = git_proxy_connect(fd, hostandport);
 		else
-			git_tcp_connect(fd, hostandport, flags);
+			conn = git_tcp_connect(fd, hostandport, flags);
 		/*
 		 * Separate original protocol components prog and path
 		 * from extended host header with a NUL byte.
@@ -1041,11 +1048,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 	return conn;
 }
 
-int git_connection_is_socket(struct child_process *conn)
-{
-	return conn == &no_fork;
-}
-
 int finish_connect(struct child_process *conn)
 {
 	int code;
-- 
2.15.0.448.gf294e3d99a

