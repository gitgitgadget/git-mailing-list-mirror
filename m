Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8151F9AF
	for <e@80x24.org>; Mon, 30 Jan 2017 21:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754477AbdA3VML (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 16:12:11 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35806 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754251AbdA3VMK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 16:12:10 -0500
Received: by mail-yb0-f195.google.com with SMTP id j82so21704799ybg.2
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 13:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=RuuTJnuKTM2QvJlu0Gh1nEFiwIWBQRC3IqzvbOmwmX4=;
        b=AxMy+bzOZtYerl9M7H2nMlOh3VT7PGzujNEoK+m/h8TQiu8frTfVIwqfqyp5acjOBD
         iuCmQ01Q8XxhLsJMq8TksAQuqZQaqTP98b887FriAnKGPJBmYGrobdqKqLU+Xd80qZoR
         AbkaTFch4MD8zG3Ee0UWI9gYlXfIqGChRQojpr6pE11b0nXtnQPJ5M3gLzVH6AGeUrvU
         kRdLd/Y6ivlRgF0t3ccfAkd6QZ72S1rUK2wa55wwWeLjrbEAtX+EkrDVNpvz577p6KO5
         O4R8i+paLqay+ACe5mhJ5f7GAtnMkJAqtc6I9toMwGe3vCbDm1K/pKdSAJfRReBnjad6
         dJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=RuuTJnuKTM2QvJlu0Gh1nEFiwIWBQRC3IqzvbOmwmX4=;
        b=FhdZ8DWhjzjutvvtor4OcFQtZeYv1BCIlwolTcde4JMaK2/7Nh4NQWFlKpUVYWBJ89
         jRAE6E71YqhsYF7MYEkrVCXjVRUZLh9L4cCfkqt3ArDSMF+NS4nWmec3pTxAvhklAoE6
         vYHYqJoDHEqNsx8Z9h4zmdxchj7wzzWRK0OatAEW1mEJUE4PpIRdydBiQAsgdtpd2+Bw
         +USbnYQdiedICQ4H3HUs8rR0gjK26b9WI0HqcFygiQWhvsjhHiU/qPfIqHnDOzPQsfWq
         c6TajmVmgUOMbu43S+qJlT8J9lWIB7m+2lpcPbJHgp4ZqWoKO424cpiu1DsDtFENjYkx
         m0+A==
X-Gm-Message-State: AIkVDXLsgkJDajmyvcFIv56c2jd93Tetg1llJI10GdRyKiJ4AgDeIW0qhB7kfaZirLCV9A==
X-Received: by 10.37.177.15 with SMTP id g15mr13289347ybj.120.1485810724655;
        Mon, 30 Jan 2017 13:12:04 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id g18sm7847327ywb.37.2017.01.30.13.12.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 13:12:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/4] stash: introduce push verb
In-Reply-To: <20170129201604.30445-3-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 29 Jan 2017 20:16:02 +0000")
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170129201604.30445-1-t.gummerer@gmail.com>
        <20170129201604.30445-3-t.gummerer@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
Date:   Mon, 30 Jan 2017 13:12:02 -0800
Message-ID: <xmqq8tpsuual.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Introduce a new git stash push verb in addition to git stash save.  The
> push verb is used to transition from the current command line arguments
> to a more conventional way, in which the message is specified after a -m
> parameter instead of being a positional argument.

I think the canonical way to express that is "... the message is
given as an argument to the -m option" (i.e. some options take an
argument, some others do not, and the "-m" takes one).

> This allows introducing a new filename argument to stash single files.

I do not want them to be "a filename argument", and I do not think
you meant them as such, either.  

    This allows us to have pathspecs at the end of the command line
    arguments like other Git commands do, so that the user can say
    which subset of paths to stash (and leave others behind).

> +save_stash () {
> +	push_options=
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		-k|--keep-index)
> +...
> +		esac
> +		shift
> +	done

It is a bit unfortunate that we need to duplicate the above
case/esac here.  I do not know if doing it this way:

	case "$1" in
	--)
		shift
		break 
		;;
	--help)
		show_help
		;;
	-*)
		# pass all options through to push_stash
		push_options="$push_options $1"
		;;
	*)
		break
                ;;
	esac

and letting push_stash complain for an unknown option is easier to
maintain.

You are reversing the order of the options in the loop.  Don't.
