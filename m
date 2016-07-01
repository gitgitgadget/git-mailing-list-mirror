Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914EF2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 12:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbcGAMqN (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 08:46:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:61504 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbcGAMqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 08:46:10 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MSZ6u-1arMIy0m6m-00RWOy; Fri, 01 Jul 2016 14:46:04
 +0200
Date:	Fri, 1 Jul 2016 14:46:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH 9/9] am: make a direct call to merge_recursive
In-Reply-To: <xmqq37nv3d19.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607011442510.12947@virtualbox>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <dc58115e23c8d942b3ff6270b43719bc841becbb.1467199553.git.johannes.schindelin@gmx.de> <xmqq37nv3d19.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fhyt49JwKq37paPE5JF9LfCSwufv137yb71Ykjda6IYSUBhhBEq
 PNUTZBjVtH/QHOYbOU11nFh/GSOiVfXUlC0R2LM02J+V2eUrUSyIzppFWRSWl0fVDG30p5i
 QQfzE92+gHX19jlNeqrznP3aa7TLzOcKj25iAnga+T7fxxyTpO+hEcMe7EZEJaaCxxL2Q9n
 Bf2RUrBkiewF0pAf+GtfA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:pr23jg4Uxok=:vXGaKZ/WFcaH8Y4h1yTLjS
 RNlxUx4IeTC80cX+HQiVBLAVFST8NmBQEqK56EF83WWqaJOPAfzl2RKmJ/tGxR9IYbFBH/alz
 aO6Z1wAJ7H4pUIGHmbuLnPLy63vBK2I4x5PquI0pVhCZmHsxonBG9V7F8TRKLy53oS8BuNkE3
 I/1eDMklkjwBCk5nC72MqvpFp1gA9rrUujJxxj5ioNVITRzrmTxr2O2QuKXhmrRCPq4b0Mgrx
 j01I0RpRXb6qwreZggZ0Uj5XpdhaJMXAIQTZDgszExhLTBlTVLdnpOKHJ7BO6ueUF59Kvma6H
 QlxeJQiopJf4qtAqUV4iicysCmfH9ZorYS/NDE0aI/UDbtA2VhvhKXEUnLOm+G8fdJO0pyj9G
 nKtqDFk2kCYh9aiViJR/991xlM0D1JQo7HiCHhgYPGcdYzKSYCTvuEmWLR8s45dPgifUOtgh2
 WnSga1hzrUI/ZJ0UzQY4RKl7Wwew4t1KYFgT9evJLtTij6EJaenVEtF8jWeRHmZ/PTbPpAfab
 NgAesmnAWntG4nSPaRMUsXUWm8WU2+02C+r1jMv6ku7DByfi6+yAQ5NoxkW4FMq32nfU0Lmyw
 GRNt91YUQmn7VMvkoeuuUsFgzcrevH5DrbxEzSDL3s/ucspyLr1q0ABMK9xucMuwDB5Mu4zHl
 UT/90zbQYlZKhWdXRhUKiK25eFEQX1O9zvxXOdBuJV3uTJ9jRZ/pU27V2PLgahsiUM44sYJXp
 kxShZySLWs/zYiT73Kbwo0yUoXMHsvFRDoALfLSzbUcA8SKgylf8wVQ6MbDsYO9x6WVDo7vwT
 NPKapRM
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 29 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > -	cp.git_cmd = 1;
> > +	init_merge_options(&o);
> > +
> > +	o.branch1 = "HEAD";
> > +	his_tree_name = xstrfmt("%.*s", linelen(state->msg), state->msg);
> > +	o.branch2 = his_tree_name;
> >  
> > -	argv_array_pushf(&cp.env_array, "GITHEAD_%s=%.*s",
> > -			 sha1_to_hex(his_tree), linelen(state->msg), state->msg);
> >  	if (state->quiet)
> > -		argv_array_push(&cp.env_array, "GIT_MERGE_VERBOSITY=0");
> > +		o.verbosity = 0;
> >  
> > -	argv_array_push(&cp.args, "merge-recursive");
> > -	argv_array_push(&cp.args, sha1_to_hex(orig_tree));
> > -	argv_array_push(&cp.args, "--");
> > -	argv_array_push(&cp.args, sha1_to_hex(our_tree));
> > -	argv_array_push(&cp.args, sha1_to_hex(his_tree));
> > +	status = merge_recursive_generic(&o, our_tree, his_tree, 1, bases, &result);
> > +	if (status < 0)
> > +		exit(128);
> > +	free(his_tree_name);
> >  
> > -	status = run_command(&cp) ? (-1) : 0;
> > -	discard_cache();
> > -	read_cache();
> >  	return status;
> >  }
> 
> Is this a correct conversion?
> 
> We used to prepare the command line and called run_command() and
> without dying returned status with the error status from the
> merge-recursive that was spawned by run_command().
> 
> The new code does not report failure to the caller and instead dies.

True, this is incorrect.

I took a step back and realized that the most appropriate course of
action would be to revert the commit that calls run_command() to begin
with. This also solves the authorship issue.

And while at it, I also noticed another sore to my eye that I had noticed
repeatedly and now fix as part of this patch series.

Thanks,
Dscho
