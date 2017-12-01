Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA50920C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbdLADD5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:03:57 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:41112 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdLADCh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:02:37 -0500
Received: by mail-it0-f66.google.com with SMTP id x28so955262ita.0
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djqFmBIPJs0urYyGgXMRJn8KCOCr2I8sFW5UFzGtlkI=;
        b=K4mhm678ld+O/P/xj+9ElOkZJfcozamZZhXGWPO/qeCHgdQDl6CfPBqqh+7oP9vQUl
         b5+xRF1gsogtBXK1SIIpY8755+C6p4GNRPad/xzCjN+WPU3+InHeNXViK808wcD6+9VZ
         xV3fOcgoNqvcuReSGvF30jmWnhailk514x8kHz9ATf8ygpHIk+5qZiz5U6Y2slUJNQeG
         1CGBDU255ii8Xl+7qOXNS88anIDyKMKJ8JWNKizXjHZKrO0Y4hBJgTFMLEgv3HhxUvDo
         O3LfHvxpdlNCGL8N2ZeMSQIkvZoD8KyrrgTiDzwLIXPseTd9ribnM9/o3N5k86bjyOqa
         tP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djqFmBIPJs0urYyGgXMRJn8KCOCr2I8sFW5UFzGtlkI=;
        b=We/87zWa07P1foLuC1JSvS6zcfk4VGr3UomxvlBC3lGGwqU/kTuskWIU6iNofcACrM
         0UI5vq7OIZyf2IvSbK6E61kyLzo9iA2m81Taj8IP2wNFswnWy1QApSAdpnmbFpL0Fh83
         RQ2B6qqgXNrzfB0BbOhWcBQZ2WE7d2pe4Nbo5ifIe6UEaNTRuu9kZzGhb+AYahN8IwIk
         jVjFCPNVkPzKg04LIBUhJ4T7lOIJU9n/wtRM5TYJ9tXxgbCAuij85TZCx0CY9WYwn23c
         6Bx7QzPbpMpfYc0SNn+PXV12yvohovyUXCH5KeDF8oByLzwwmOqBXJ22BKYQhefp3jVA
         P2Tg==
X-Gm-Message-State: AJaThX7/LAELHwEoBj8mPaMzeS3x1bUJXWg1JkuhdwdeldlTO+HpqdQX
        B318OF6FUux8OVhYW/yW6qc=
X-Google-Smtp-Source: AGs4zMZ77hAz8SQwjaJ0J7z8fH8hmNLaEZms2x+paniePQj9E2ReFO5soW89cuFK7Q+WJTLweOBbgg==
X-Received: by 10.36.214.132 with SMTP id o126mr73501itg.80.1512097356199;
        Thu, 30 Nov 2017 19:02:36 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j193sm2801968ita.36.2017.11.30.19.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:02:35 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:02:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] t/lib-git-svn.sh: improve svnserve tests with
 parallel make test
Message-ID: <20171201030234.GF20640@aiede.mtv.corp.google.com>
References: <20171201023239.26153-1-tmz@pobox.com>
 <20171201023239.26153-3-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171201023239.26153-3-tmz@pobox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Todd Zullinger wrote:

> Previously, setting SVNSERVE_PORT enabled several tests which require a
> local svnserve daemon to be run (in t9113 & t9126).  The tests share the
> setup of the local svnserve via `start_svnserve()`.  The function uses
> the svnserve option `--listen-once` which causes svnserve to accept one
> connection on the port, serve it, and exit.  When running the tests in
> parallel this fails if one test tries to start svnserve while the other
> is still running.

I had trouble reading this because I didn't know what previous time it
was referring to.  Is it about how the option currently behaves?

(Git's commit messages tend to use the present tense to describe the
behavior before the patch, like a bug report, and the imperative to
describe the change the patch proposes to make, like an impolite bug
report. :))

> Use the test number as the svnserve port (similar to httpd tests) to
> avoid port conflicts.  Set GIT_TEST_SVNSERVE to any value other than
> 'false' or 'auto' to enable these tests.

This uses imperative in two ways and also ended up confusing me.  The
second one is a direction to me, not Git, right?  How about:

	Use the test number instead of $SVNSERVE_PORT as the svnserve
	port (similar to httpd tests) to avoid port conflicts.
	Developers can set GIT_TEST_SVNSERVE to any value other than
	'false' or 'auto' to enable these tests.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  t/lib-git-svn.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

The patch looks good.  Thanks.

> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 84366b2624..4c1f81f167 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -110,14 +110,16 @@ EOF
>  }
>  
>  require_svnserve () {
> -	if test -z "$SVNSERVE_PORT"
> +	test_tristate GIT_TEST_SVNSERVE
> +	if ! test "$GIT_TEST_SVNSERVE" = true
>  	then
> -		skip_all='skipping svnserve test. (set $SVNSERVE_PORT to enable)'
> +		skip_all='skipping svnserve test. (set $GIT_TEST_SVNSERVE to enable)'
>  		test_done
>  	fi
>  }
>  
>  start_svnserve () {
> +	SVNSERVE_PORT=${SVNSERVE_PORT-${this_test#t}}
>  	svnserve --listen-port $SVNSERVE_PORT \
>  		 --root "$rawsvnrepo" \
>  		 --listen-once \
> -- 
> 2.15.1
> 
