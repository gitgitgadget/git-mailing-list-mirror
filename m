From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 12/14] Fix pointer -> integer casts on IL32P64 systems
Date: Mon, 29 Sep 2014 22:43:41 +0200
Message-ID: <5429C47D.3050903@kdbg.org>
References: <1411910670-31285-1-git-send-email-marat@slonopotamus.org> <1411910670-31285-13-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>, 
 Erik Faye-Lund <kusmabite@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCJYV6HBKQIP5CFHUECRUBD2UHXZM@googlegroups.com Mon Sep 29 22:43:47 2014
Return-path: <msysgit+bncBCJYV6HBKQIP5CFHUECRUBD2UHXZM@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f184.google.com ([209.85.217.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIP5CFHUECRUBD2UHXZM@googlegroups.com>)
	id 1XYhnM-0007BH-6W
	for gcvm-msysgit@m.gmane.org; Mon, 29 Sep 2014 22:43:44 +0200
Received: by mail-lb0-f184.google.com with SMTP id p9sf292686lbv.11
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Sep 2014 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=wsi8lZvEofM5TMjRoMGUYa8JiOf/eWyf6L7pcJQrH9M=;
        b=ZKcI/+7ZUEKnkB5kF3jsNJI1DF97QcUo2G/WJ9WuXvDm3OvzlpwrqZ58In+oxnKVQ8
         jlcxcdAp066ce7F/DKwAcr3w97c1i2r8yxlxSfJWCkJhEVHm86yBJt6TmHgiQ7kXi5sW
         6NFHJlVPQkLHO0eKKpT0jT0qmLmrRdxOoUiNFjqKIeV6pzUQoFQpXv+ru43EuPepwWVY
         52S3uz9TWuCo1PZZNU3UOLUTdijyQ67E3OaRIpYWNvMT4oJ9ZQ+U4PZjCY3VaxK5Cpb5
         JgYa7qPDOpiZuIHcGxUpMLeKb76Hqc8Dwv1UKt4t5lJAEAjL0cl+IwHyD4G7JNcISMOS
         ByEA==
X-Received: by 10.152.36.193 with SMTP id s1mr91100laj.0.1412023423940;
        Mon, 29 Sep 2014 13:43:43 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.133 with SMTP id q5ls669016laj.80.gmail; Mon, 29 Sep
 2014 13:43:42 -0700 (PDT)
X-Received: by 10.152.26.225 with SMTP id o1mr1564133lag.4.1412023422441;
        Mon, 29 Sep 2014 13:43:42 -0700 (PDT)
Received: from bsmtp.bon.at (bsmtp3.bon.at. [213.33.87.17])
        by gmr-mx.google.com with ESMTPS id h1si674936wib.0.2014.09.29.13.43.42
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2014 13:43:42 -0700 (PDT)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.17;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3j6G0Q4rhkz5tlF;
	Mon, 29 Sep 2014 22:43:34 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 479C019F5C3;
	Mon, 29 Sep 2014 22:43:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1411910670-31285-13-git-send-email-marat@slonopotamus.org>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257639>

Am 28.09.2014 um 15:24 schrieb Marat Radchenko:
> This commit touches regcomp.c and poll.c from Gnulib,
> both were fixed upstream in 2012 the same way.
> 
> Wrt ShellExecute, see [1].
> 
> [1]: http://blogs.msdn.com/b/oldnewthing/archive/2006/11/08/1035971.aspx

Please do not force readers to visit a web site; provide at least a summary.

> 
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---

> diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
> index 06f3088..d8bde06 100644
> --- a/compat/regex/regcomp.c
> +++ b/compat/regex/regcomp.c
> @@ -2577,7 +2577,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
>      old_tree = NULL;
>  
>    if (elem->token.type == SUBEXP)
> -    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
> +    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
>  
>    tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
>    if (BE (tree == NULL, 0))
> @@ -3806,7 +3806,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
>  static reg_errcode_t
>  mark_opt_subexp (void *extra, bin_tree_t *node)
>  {
> -  int idx = (int) (long) extra;
> +  int idx = (int) (intptr_t) extra;
>    if (node->token.type == SUBEXP && node->token.opr.idx == idx)
>      node->token.opt_subexp = 1;
>  

This breaks with

In file included from compat/regex/regex.c:77:
compat/regex/regcomp.c: In function 'parse_dup_op':
compat/regex/regcomp.c:2580: error: 'intptr_t' undeclared (first use in
this function)

when compiled using the msysgit environment.

-- Hannes

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
