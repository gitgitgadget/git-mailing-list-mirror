X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Fri, 8 Dec 2006 08:40:42 +0100
Message-ID: <81b0412b0612072340w6af9df37y25a1d15773a3f8d8@mail.gmail.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
	 <81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
	 <86ejrbihnr.fsf@blue.stonehenge.com>
	 <7vmz5zqqo7.fsf@assigned-by-dhcp.cox.net>
	 <7virgnqpt5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 07:40:55 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Pazu <pazu@pazu.com.br>, "Andreas Ericsson" <ae@op5.se>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mFXrFlDVxHWCl8kx6d44h702ZUbvcwKItcdN0SreZr31K8GcH4rt7qiZ2XAiONp43enVU+0AzINZtt4bopFjaRabtgAG0/K/5Oe6tmqYivfzVUHeYWfBeBWC1uWuAQj/k1KuJakSijgh1OR61DV9g+AoE0JlHPUrsmwR1mxiQTY=
In-Reply-To: <7virgnqpt5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33669>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsaLh-0000Ff-01 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 08:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425092AbWLHHkp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 02:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425095AbWLHHkp
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 02:40:45 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:6068 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1425093AbWLHHko (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 02:40:44 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1068162nfa for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 23:40:43 -0800 (PST)
Received: by 10.78.157.8 with SMTP id f8mr239669hue.1165563642481; Thu, 07
 Dec 2006 23:40:42 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 7 Dec 2006 23:40:42 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 12/7/06, Junio C Hamano <junkio@cox.net> wrote:
> >> Definitely something went weird when Makefile was removed
> >> from .gitignore.
> >
> > Yes, perl/Makefile is getting overwritten by what Makefile.PL
> > generates.  I thought the point of Alex's patch was to have it
> > muck with perl.mak and leave the tracked Makefile alone?
>
> Now, I am CLUELESS about what MakeMaker does, but would this
> help?
>

Much better.
Works here. Others?

> diff --git a/perl/Makefile.PL b/perl/Makefile.PL
> index de73235..4168775 100644
> --- a/perl/Makefile.PL
> +++ b/perl/Makefile.PL
> @@ -24,5 +24,6 @@ WriteMakefile(
>  	NAME            => 'Git',
>  	VERSION_FROM    => 'Git.pm',
>  	PM		=> \%pm,
> +	MAKEFILE	=> 'perl.mak',
>  	%extra
>  );

I should have read the FS of that MakeMaker.pm,
