Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C007520281
	for <e@80x24.org>; Fri, 29 Sep 2017 21:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbdI2VUX (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 17:20:23 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:57126 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdI2VUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 17:20:22 -0400
Received: by mail-pg0-f44.google.com with SMTP id 7so412852pgd.13
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 14:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tcp5Os88dIn89qKfocuCXx73GxZ1moAafHZG2ejXpHg=;
        b=AH3+wOPYmH6h5KuHb8hAza4GYd07EICome+Yb2WjUV36sP1ak1nUy6euEc2GfEofg3
         z5Ye1zPUsoHMQpkrHNwZ3nfxVWYN1v2C7jVNIQx3IJXuUihSRyxXdkQuvKbUyYi5zJut
         M+z89vcQqbcTuKACVxg+fXmjYaI0jBUDgIOO+UUvE4gBwculhNiFm/ak4KrebU965GPW
         5lfKqMbjZQBYLUU3fThP1Gxiry1HezKbeqBeTKHVFnf8UM/Z3FBde/8RatAaMRcjSyMP
         CRp2td+RBLywLXQvmkHVmQVlZjnANWSRfmh7ijaaMZu9uVyt6nXAm1FT7xN5IMQC7+XC
         xLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tcp5Os88dIn89qKfocuCXx73GxZ1moAafHZG2ejXpHg=;
        b=ikAVZP+RN7DqBhHGawcWU+C3RMrqaJkEzkzbcwJ2qr+a8bsKTuBGFwsOxwi3UdJp7C
         wJyClYeCGIGcriLyIL/Sj3yfo05gA3E4gN+KiHRPVgc2xyS5pg02GVnqxTjoxDUe+z3p
         JB8C2wiPQZt+1Phkt8kXuY+TUYAJY6mIcoJJcq/FXC4vzVMq14o39uI9AIoyXI+uo5xu
         l+YMHL0CpReDjQccBYhsnXdqc3Qd008YseQRuu7naVmQOsufTtHu0kBJQNxQN5t8ckrJ
         7SncKYmqwssHOAPjFIl1KrBLXRHme+p7s1mLfFGjL2AmC82HyJWT1yJbShvAf5eUTfvk
         PiFw==
X-Gm-Message-State: AHPjjUgqq8Vh9mVSFNSS+nN5bY5SzAssNuljhsmQxGmb008F11yIM9AJ
        pvrKeoBtCLJBlktF/rFHxXj3eg==
X-Google-Smtp-Source: AOwi7QBu8o1oPfzFAtXzAAjwWGS4gM2Qj/hm3aIxfjlLHB2MA9+s7hFBQcHwNkz5C7SQdKbxkQdxUg==
X-Received: by 10.159.234.3 with SMTP id be3mr8382125plb.5.1506720021657;
        Fri, 29 Sep 2017 14:20:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:41cf:d592:f95a:46b2])
        by smtp.gmail.com with ESMTPSA id u27sm8276183pfl.76.2017.09.29.14.20.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Sep 2017 14:20:20 -0700 (PDT)
Date:   Fri, 29 Sep 2017 14:20:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 3/9] protocol: introduce protocol extention mechanisms
Message-ID: <20170929212018.GA92120@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
 <20170926235627.79606-4-bmwill@google.com>
 <xmqq4lro7mab.fsf@gitster.mtv.corp.google.com>
 <xmqqvak42xn3.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvak42xn3.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> +enum protocol_version determine_protocol_version_server(void)
> >> +{
> >> +	const char *git_protocol = getenv(GIT_PROTOCOL_ENVIRONMENT);
> >> +	enum protocol_version version = protocol_v0;
> >> +
> >> +	if (git_protocol) {
> >> +		struct string_list list = STRING_LIST_INIT_DUP;
> >> +		const struct string_list_item *item;
> >> +		string_list_split(&list, git_protocol, ':', -1);
> >> +
> >> +		for_each_string_list_item(item, &list) {
> >> +			const char *value;
> >> +			enum protocol_version v;
> >> +
> >> +			if (skip_prefix(item->string, "version=", &value)) {
> >> +				v = parse_protocol_version(value);
> >> +				if (v > version)
> >> +					version = v;
> >> +			}
> >> +		}
> >> +
> >> +		string_list_clear(&list, 0);
> >> +	}
> >> +
> >> +	return version;
> >> +}
> >
> > This implements "the largest one wins", not "the last one wins".  Is
> > there a particular reason why the former is chosen?
> 
> Let me give my version of why the usual "the last one wins" would
> not necessarily a good idea.  I would imagine that a client
> contacting the server may want to say "I understand v3, v2 (but not
> v1 nor v0)" and in order to influence the server's choice between
> the available two, it may want to somehow say it prefers v3 over v2
> (or v2 over v3).  
> 
> One way to implement such a behaviour would be "the first one that
> is understood is used", i.e. something along this line:
> 
>         enum protocol_version version = protocol_unknown;
> 
> 	for_each_string_list_item(item, &list) {
> 		const char *value;
> 		enum protocol_version v;
> 		if (skip_prefix(item->string, "version=", &value)) {
>                 	if (version == protocol_unknown) {
>                         	v = parse_protocol_version(value);
> 			        if (v != protocol_unknown)
> 					version = v;
> 			}
> 		}
> 	}
> 
> 	if (version == protocol_unknown)
> 		version = protocol_v0;
> 
> and not "the largest one wins" nor "the last one wins".
> 
> I am not saying your code or the choice of "the largest one wins" is
> necessarily wrong.  I am just illlustrating the way to explain
> "because I want to support a usecase like _this_, I define the way
> in which multiple values to the version variable is parsed like so,
> hence this code".  IOW, I think this commit should mention how the
> "largest one wins" rule would be useful to the clients and the
> servers when they want to achieve X---and that X is left unexplained.

I believe I mentioned this elsewhere but I think that at some point this
logic will probably have to be tweaked again at some point so that a
server may be able to prefer one version to another.

That being said I can definitely add a comment indicating how this code
selects the version and that it can be used to ensure that the latest
and greatest protocol version is used.

-- 
Brandon Williams
