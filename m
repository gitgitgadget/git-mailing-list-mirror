From: Alexander 'z33ky' Hirsch <1zeeky@gmail.com>
Subject: Re: [PATCH] pull: warn on --verify-signatures with --rebase
Date: Thu, 19 May 2016 12:02:21 +0200
Message-ID: <20160519100221.GB22257@netblarch>
References: <20160518101827.GA14475@netblarch>
 <xmqq37pftks7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 11:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Kd0-00011G-PE
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 11:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbcESJvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 05:51:52 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36214 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbcESJvv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 05:51:51 -0400
Received: by mail-wm0-f50.google.com with SMTP id n129so222302816wmn.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fy5cD3ODOfGQ8UwdG2lf6fsvMWD6IfQTk7NmycllYjs=;
        b=rba9G478ufsq6HdMcqnHRADP062U1m9nXuIkmDmvK+Jwn82exhAOH4KtY/AFC4melr
         qXJAYeMah3DoNMGSR+cdwSYNj1bKZJ9FwLV8BRDFk8vDogu5GcCCwBfrmyMgoQvOj2DH
         VjpP1Z9pok+ewBFhLmgqAw0yHaWew6EMGVh888ZAH1Fx881g/BdcdPF/h79+CHUUGWdQ
         d9MKhm8YBkFXbQ6sfYA7ZUtoX++rg1VXe823V8KaUn+eNFGJ7/iSXgtUg+ztavDNC7wn
         Mur2g8uHKA3ZdW3qTFK2mSjpCElNnejsPCHxmwGen+L6rp32UikLD8tVmuHAkzf8D0lk
         uGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fy5cD3ODOfGQ8UwdG2lf6fsvMWD6IfQTk7NmycllYjs=;
        b=EPiDDA3cuEq9i4J3tlqY3WF8EllG+7/rwWN0n9k1hw6bk7DpiIUaa61Hq/+10UrWJ7
         tttg1pGeOoUNHHQpNgkX4gAR4PWVXniq04spGAJT6NfSukplOkl05hIVaDul9ZEwms5c
         o6T3W2DhVLl2VZBxRyCCMi+34E/H+rh1PIqKUWDjC9hhN1g1Wf+enjeELElmEnRi6nAj
         PT7juDXaA+0eJoV/OEygbh2QCec0KxLPC3FopyyUMall6LM4r5eUrnTIndSAgB8frk/e
         uZz9WSA7QRHO7FyaeYsMW2sdqld45bJYO8BMG7lwLwW5NZuHyofM4MoMBI2g06Wq+t//
         CcoA==
X-Gm-Message-State: AOPr4FU604AlezaU8JiySJvxbAPQUG224id1khYD22NKNTVViYBkdkKtmgdbrRjgrRPUvQ==
X-Received: by 10.28.47.75 with SMTP id v72mr2358470wmv.87.1463651509468;
        Thu, 19 May 2016 02:51:49 -0700 (PDT)
Received: from netblarch (s5144.dyn.hrz.tu-darmstadt.de. [130.83.220.120])
        by smtp.gmail.com with ESMTPSA id e8sm13442138wjm.23.2016.05.19.02.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 02:51:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq37pftks7.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295051>

On Wed, May 18, 2016 at 09:04:24AM -0700, Junio C Hamano wrote:
> > Previously git-pull silently ignored the --verify-signatures option for
> > --rebase.
> 
> Missing pieces information that would have made the patch more
> complete are answers to these questions:
> 
>  - Is that a bad thing?  Why?
> 
>  - Assuming it is a bad thing, what is the solution this patch
>    presents us?  Teach rebase about the option?  Error out the
>    request?  What is the reason why "warn" was chosen as the best
>    way forward?
> 

Is the warning a solution "for now" and might this become an error
should a valid usecase not be found after a while?

> >  builtin/pull.c  |  2 ++
> >  t/t5520-pull.sh | 16 ++++++++++++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 1d7333c..0eafae7 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -815,6 +815,8 @@ static int run_rebase(const unsigned char *curr_head,
> >  		argv_array_push(&args, "--no-autostash");
> >  	else if (opt_autostash == 1)
> >  		argv_array_push(&args, "--autostash");
> > +	if (opt_verify_signatures && strcmp(opt_verify_signatures, "--verify-signatures") == 0)
> 
> The logic looks OK.  I would have written that long line as two
> lines, e.g.
> 
> 	if (opt_verify_signatures &&
>             !strcmp(opt_verify_signatures, "--verify-signatures")
> 
> though.
> 

I shall format it as per your suggestion in the next submission.

> > +		warning(_("git-rebase does not support --verify-signatures"));
> 
> Is this a good warning message?
> 
> As a casual reader, my reaction to this warning would be "Does not
> support?  Then what did it do instead?  Did it refuse to integrate
> my changes on top of what happened on the remote?"
> 

Indeed.

> Something like
> 
>     warning(_("ignored --verify-signatures as it is meaningless in rebase"));
> 
> may convey what is going on better, in that it makes it clear that
> we are not failing "rebase" and instead we are ignoring "verify".
> 
> It is way too long for the final version, though.  A more concise
> way to say the same thing needs to be found.
> 

Would "ignoring --verify-signatures for rebase" be sufficient? It does
not describe why it is ignored though.


With Regards,
Alexander Hirsch
