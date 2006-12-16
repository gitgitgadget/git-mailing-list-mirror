X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git-add fails after file type change
Date: Sat, 16 Dec 2006 10:35:06 -0800
Message-ID: <45843C5A.8020501@gmail.com>
References: <458437E0.1050501@midwinter.com>
Reply-To: Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 18:35:34 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=kz+1Av7KJdUa3Z+d5g7EtG/rw+gdP/ZSTly287k8ei9PoVnTDJUqKQvhk0OBqnLA7PuNbVpFcI/A4lm2Ylm3LG1t9gt8wifJ6k0TXtlPcDvtumiZ/bQBoC5SUmVlDabPSUNmG8KwWbmHp6hnA7Y7yDLXdt5+Nm9Mw7G1vLry4sc=
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
In-Reply-To: <458437E0.1050501@midwinter.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34632>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GveNQ-0007st-QV for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932504AbWLPSfM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 13:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWLPSfM
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:35:12 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:26660 "EHLO
 an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932504AbWLPSfK (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 13:35:10 -0500
Received: by an-out-0708.google.com with SMTP id b33so345345ana for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 10:35:09 -0800 (PST)
Received: by 10.100.7.18 with SMTP id 18mr1563529ang.1166294109639; Sat, 16
 Dec 2006 10:35:09 -0800 (PST)
Received: from ?10.0.0.6? ( [76.167.71.78]) by mx.google.com with ESMTP id
 c2sm6647189ana.2006.12.16.10.35.08; Sat, 16 Dec 2006 10:35:09 -0800 (PST)
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm wrote:
> In the course of experimenting with using git for my snapshot backups, I 
> ran into what looks like a bug in git-add: it croaks when it tries to 
> add a file whose type has changed, specifically when a directory gets 
> moved and a symbolic link is put in the old location pointing to the new 
> one. Here's a simple test case:
> 
> $ git init-db
> defaulting to local storage area
> $ mkdir dir
> $ echo foo > dir/file
> $ git add .
> $ git commit -m "initial commit" -a
> Committing initial tree f4bc9c50d08b041f5e096fa68e243c34170f1cd8
> create mode 100644 dir/file
> $ mv dir dir.real
> $ ln -s dir.real dir
> $ git add .
> fatal: unable to add dir to index
> 
> Is "git add ." the wrong thing to do here? I have been using it as a 
> generic "pick up all the files I haven't added yet" command. Or is this 
> a bug?
> 
> For what it's worth, "git update-index dir" and "git update-index --add 
> dir" both fail too.

