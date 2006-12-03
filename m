X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether it needs -a automatically
Date: Sun, 3 Dec 2006 09:57:02 +0000
Message-ID: <200612030957.03592.andyparkins@gmail.com>
References: <200612011106.42272.andyparkins@gmail.com> <7vbqmmzplm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 10:00:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rb0kfWYfXBMMKOWUfRqGAbGSZdDuW1QRcSOd8DadxQZuGC7+sfie+m/KzwasAd6QaLwsWNbff6rs0TA1qE+aborPMISCZObHNJi2uBOy/Yb5hozyEhV05r52LVlGz3iwZgkLDO8cJm3yjqZ6JOd5Xk+qN5YYqZ3f+iGzL2bwk3Q=
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqmmzplm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33103>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqo8f-0001UK-Kx for gcvg-git@gmane.org; Sun, 03 Dec
 2006 11:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757289AbWLCJ7u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 04:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758600AbWLCJ7u
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 04:59:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:44761 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757289AbWLCJ7t
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 04:59:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so4056059nfa for
 <git@vger.kernel.org>; Sun, 03 Dec 2006 01:59:48 -0800 (PST)
Received: by 10.49.57.1 with SMTP id j1mr6475890nfk.1165139988628; Sun, 03
 Dec 2006 01:59:48 -0800 (PST)
Received: from ?192.168.7.102? ( [82.0.29.64]) by mx.google.com with ESMTP id
 l27sm44457934nfa.2006.12.03.01.59.47; Sun, 03 Dec 2006 01:59:47 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Saturday 2006, December 02 08:09, Junio C Hamano wrote:

> Aside from the "working tree not matching index" safety valve I
> asked for, there is a more important case that "when the index
> matches HEAD" is not a safe enough check for this 'cleverness'.

As I pointed out, that safety valve made the whole thing a no-op.

> So that is _another_ exception you must handle.
>
> But I think the problem with this 'cleverer' commit runs
> deeper.
>
> Notice that you needed to say "The main idea is this cleverness,
> but foo pointed out this special case, and bar pointed out
> another, and we fixed all of these known ones and now this is
> good, let's apply it." in your proposed commit log message?  You
> should smell fishiness in that kind of reasoning.

I don't believe so.  In deep parts of a program cleverness is always a bad 
idea.  It just obfuscates functionality.  However, this "cleverness" is about 
making things easier for a human.  Humans have a notoriously illogical set of 
requirements for doing the right thing.  As an example I'd hold up git's 
clever date specification code; a computer would be perfectly happy to accept 
epoch time, but instead humans like to be able to say "three weeks ago this 
Thursday at five to four".

This patch is merely to make git-commit do something sensible when it would 
normally do nothing.  I was sure there would be more exceptions to when it 
should activate; as git-commit is already a mess of "useful" extra switches.  
To blame this patch for the fact that git-commit does a lot of things in 
slightly different ways hardly seems fair.

As usual though: I don't mind, I'm not some huge proponent of this 
functionality - /I/ get along fine with git-commit

> I really think the users would be much better off with
> consistent behaviour that is easy and simple to describe than a
> complex magic that does the right thing 99.9% of the time,
> because you either understand the complex magic or constantly in
> fear of the tool that can work against you 0.01% of the time.

I suspect that this patch is the least of git-commit's problems in that 
department.  "Easy to describe" is certainly not the case already, otherwise 
none of this discussion (or patch) would ever have started.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
