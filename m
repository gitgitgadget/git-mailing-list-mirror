X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Handling of branches in stgit
Date: Fri, 1 Dec 2006 12:42:19 +0000
Message-ID: <b0943d9e0612010442gf7bf2ccr8995967403788fe7@mail.gmail.com>
References: <20061130000038.GA13324@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:42:36 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BJSBfHR0F57XIXANgnrcIZ0+qijwIWmzIrWL13ou5Q+/627NBqIRA0zJHzznjvrFzyyewHpETXvo+rcpN/ucpdQgKWQ5v0qQQCMEl+Pq3L9d+4mu8/LQpIeLsE/Lzs6GvmT1Q8JHJG7znJ989igS6L1299/FwoA68OWcJ8fBC3I=
In-Reply-To: <20061130000038.GA13324@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32916>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq7ij-0001Y0-G2 for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:42:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031267AbWLAMmW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031279AbWLAMmW
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:42:22 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:15894 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1031267AbWLAMmV
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:42:21 -0500
Received: by nz-out-0102.google.com with SMTP id s1so1525454nze for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 04:42:21 -0800 (PST)
Received: by 10.64.156.3 with SMTP id d3mr7586221qbe.1164976939130; Fri, 01
 Dec 2006 04:42:19 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Fri, 1 Dec 2006 04:42:19 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
Sender: git-owner@vger.kernel.org

On 30/11/06, Yann Dirson <ydirson@altern.org> wrote:
> I have started to work on recording parent information for stgit
> branches, so we don't need to give the same info on every "git pull".

Isn't this what the branch.<name>.remote configuration option is for?
I think we should leave GIT handle this and StGIT only invoke "git
pull" without any arguments.

> I'm facing a problem, in that we have several kind of stgit branches:
>
> * those created against a cogito branch (eg. by "cg clone" and "stg
>   init").  They work pretty much intuitively (and it happens I mostly
>   used this flavour before those tests).  All we need is the name of
>   the local branch, and "stg pull <branch>" relies on "git fetch" to
>   find the repository information in .git/branches/<branch>.

But I think .git/branches got deprecated or it is a cogito-only feature.

>   In this case, it is easy to request pulling from any branch, but
>   usually only one of them is what you want, and the results of using
>   another one (or forgetting to specify the one you want) can be
>   annoying [ISSUE 1].  Hence this work of mine: being able to store
>   this info in .git/patches/<stack>/parent (my initial implementation)
>   was sufficient in theory.

I would leave this to GIT and its configuration files. Do you see any
problems with this approach?

I plan to merge the stgit config with the git one (and have a [stgit]
section) so that it is more maintainable.

-- 
