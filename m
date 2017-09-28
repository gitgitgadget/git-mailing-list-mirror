Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C0E220A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdI1VEC (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:04:02 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35000 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbdI1VEB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:04:01 -0400
Received: by mail-pg0-f68.google.com with SMTP id j16so3145935pga.2
        for <git@vger.kernel.org>; Thu, 28 Sep 2017 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iOsk/cg3ShN1LCdyOyPls1O4HUQPGlNtBPTqNDdWkvc=;
        b=a6haoQ6QBYnN36DTEgmY7OYJ3ZI1VYh/HSyFbmPvkZpdfAFkkLrAgMdVucT0YLeFyL
         7rCzZeam+7rs+zriXGGLG4BbO4+2/iKDCfH8xpdIjmq4enyZCYMGvgkTYj2iE1g4gGPY
         z/d06zxjMc4fRQx1p2p+knfL0o3KdLuYJJpFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iOsk/cg3ShN1LCdyOyPls1O4HUQPGlNtBPTqNDdWkvc=;
        b=QGDtdnbzVi0vtOFVX/Et7TCuZa4h4NWMFJgy+5ahz3QC78sU7ChP7W4+aCMUbzfZIf
         2LoPt2/0mUwU+N8ZX0GsEBM9Ot3HyEk/JPFFbP5Slv+zw3JS6vBBgXZVkzKj5YCSyUWx
         6yxT3Q4CnG+k5tzBEPgxpu0a+cNDIRqaZNIyw09KwaWlo6s8St7rSX8r678aXfqa3piN
         zrW+Bjx36gnMvMEUts+WK9fUap7eKyP2ct4jKpqm1eFx1Y4i9WaF7oGGOBrYFT58y0H+
         8q19PDSQPIz/Itpnk9d8YFPRv/TAUbobeTWWSNyyb1KJ3DqnostNIDJsYC8nxSRw/EGi
         JyrA==
X-Gm-Message-State: AHPjjUgNnf/RPvKldYRdcJMAWuurc5phoHo8CpCL796mrJdEpPUeURsY
        0dbAlXQZBXRiOkRLIKZoxEGpR9JFJ6Q=
X-Google-Smtp-Source: AOwi7QC37++lGPTy6NSXAG1hlNmxVXaGnqdxmG4+Pt+vcD5FUIKA66bpQGygKlsyON6+MQIol1GiyA==
X-Received: by 10.84.133.66 with SMTP id 60mr4985569plf.386.1506632640732;
        Thu, 28 Sep 2017 14:04:00 -0700 (PDT)
Received: from localhost (node-1w7jr9qprg76wahmznhtpeq14.ipv6.telus.net. [2001:569:78e4:8500:bae8:56ff:fe42:9848])
        by smtp.gmail.com with ESMTPSA id e76sm4354716pfd.149.2017.09.28.14.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Sep 2017 14:03:59 -0700 (PDT)
Received: by localhost (sSMTP sendmail emulation); Thu, 28 Sep 2017 14:03:58 -0700
From:   "Eric Rannaud" <e@nanocritical.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
Date:   Thu, 28 Sep 2017 14:03:58 -0700
Message-Id: <20170928210358.11596-1-e@nanocritical.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170928125916.GB9439@dinwoodie.org>
References: <20170928125916.GB9439@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 5:59 AM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> On Wed, Sep 27, 2017 at 10:07:41PM -0700, Eric Rannaud wrote:
>>
>> Also adding the necessary PIPE prereq, as pointed out by Ramsay Jones.
>
> Cygwin doesn't have the PIPE prereq; I've just confirmed that the
> previous version of this patch has t9300 failing on Cygwin, but this
> version passes.

What's the preferred solution here? I can avoid using named pipes entirely:

	read_checkpoint () {
		if read output
		then
			if ! test "$output" = "progress checkpoint"
			then
				echo >&2 "no progress checkpoint received: $output"
				echo 1 > V.result
			else
				echo 0 > V.result
			fi
		else
			echo >&2 "failed to read fast-import output"
			echo 1 > V.result
		fi
	}
	
	# The commands in input_file should not produce any output on the file
	# descriptor set with --cat-blob-fd (or stdout if unspecified).
	#
	# To make sure you're observing the side effects of checkpoint *before*
	# fast-import terminates (and thus writes out its state), check that the
	# fast-import process is still running using background_import_still_running
	# *after* evaluating the test conditions.
	background_import_then_checkpoint () {
		options=$1
		input_file=$2
	
		rm -f V.result
	
		( cat "$input_file"
		echo "checkpoint"
		echo "progress checkpoint"
		sleep 3600 &
		echo $! >V.pid
		wait ) | git fast-import $options | read_checkpoint &
	
		# We don't mind if the pipeline has already died by the time the test
		# ends.
		test_when_finished "kill $(cat V.pid) || true"
	
		while ! test -f V.result
		do
			# Try to sleep less than a second, if supported.
			sleep .1 2>/dev/null || sleep 1
		done
		return $(cat V.result)
	}

Do we like this better?
