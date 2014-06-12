From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/11] add performance tracing facility
Date: Thu, 12 Jun 2014 11:30:13 -0700
Message-ID: <xmqqvbs656bu.fsf@gitster.dls.corp.google.com>
References: <53980B83.9050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBPHD46OAKGQEI7SGKAY@googlegroups.com Thu Jun 12 20:30:22 2014
Return-path: <msysgit+bncBCG77UMM3EJRBPHD46OAKGQEI7SGKAY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f186.google.com ([209.85.160.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBPHD46OAKGQEI7SGKAY@googlegroups.com>)
	id 1Wv9lV-0001dj-Ei
	for gcvm-msysgit@m.gmane.org; Thu, 12 Jun 2014 20:30:21 +0200
Received: by mail-yk0-f186.google.com with SMTP id 131sf116239ykp.3
        for <gcvm-msysgit@m.gmane.org>; Thu, 12 Jun 2014 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=uXKB4ALQsDdce0gcQoBDUNrhQw8RwCb7t0t2ztbfMLI=;
        b=FYHnX7syNXnDxwC3WEaC/CYCwa6WEulC7CTjXUyp+mUo5DTRZLW5OLuU58DhMgBXbX
         Mnuo7Uwq3X28jm1sCVo4F69bb4U7KNN9lU56AAzrxnzIkfs63VNd1ZRx08M5xvNo4Rbp
         bF/T1aub9PCzQwWi3dJx/v3IgDxjtw6lVeHR4DebUJJA4Ji0v/0Q9Xqq45LzRfwDxWfB
         FiLJyE1eV0FFyhWKN06pV7r8gllfzMPnHkMHo+99NuPiENAbEsUvy7apWwzvCO1PokPG
         oyYlTMPymPlUl6+uWKizNjrXTn5AwYWYmTvrVqgkIOhCuTJRXpufybPgrPwA7xPtdZrT
         LnOQ==
X-Received: by 10.50.70.100 with SMTP id l4mr100311igu.1.1402597820576;
        Thu, 12 Jun 2014 11:30:20 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.88.42 with SMTP id bd10ls1932849igb.5.gmail; Thu, 12 Jun
 2014 11:30:19 -0700 (PDT)
X-Received: by 10.42.49.138 with SMTP id w10mr3717524icf.13.1402597819837;
        Thu, 12 Jun 2014 11:30:19 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id l6si407231qco.2.2014.06.12.11.30.19
        for <msysgit@googlegroups.com>;
        Thu, 12 Jun 2014 11:30:19 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 892151DFAD;
	Thu, 12 Jun 2014 14:30:19 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BFD91DFAC;
	Thu, 12 Jun 2014 14:30:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DCBC1DFA8;
	Thu, 12 Jun 2014 14:30:15 -0400 (EDT)
In-Reply-To: <53980B83.9050409@gmail.com> (Karsten Blees's message of "Wed, 11
	Jun 2014 09:55:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 991387E4-F25F-11E3-B08C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251474>

Karsten Blees <karsten.blees@gmail.com> writes:

> Here's v5 of the performance tracing patch series, now including a bunch of cleanups and adding timestamp, file and line to all trace output.
>
> I'm particularly interested in feedback for the output format. As file names have different lengths, printing file:line as prefix results in unaligned output:
>
>  > GIT_TRACE=1 git stash list
>  00:12:10.544266 git.c:512 trace: exec: 'git-stash' 'list'
>  00:12:10.544266 run-command.c:337 trace: run_command: 'git-stash' 'list'
>  00:12:10.649779 git.c:312 trace: built-in: git 'rev-parse' '--git-dir'
>
> We could add separators to make it easier to parse, e.g.:
>
>  > GIT_TRACE=1 git stash list
>  [00:12:10.544266 git.c:512] trace: exec: 'git-stash' 'list'
>  [00:12:10.544266 run-command.c:337] trace: run_command: 'git-stash' 'list'
>  [00:12:10.649779 git.c:312] trace: built-in: git 'rev-parse' '--git-dir'

This is easier to parse if " " and ":" are found in the names of
_our_ source files and "]" isn't, but is that really the case?

> Or print file:line at the end (but what about multi-line messages, such as packet-trace?):
>
>  > GIT_TRACE=1 git stash list
>  00:12:10.544266 trace: exec: 'git-stash' 'list' (git.c:512)

Somehow I find this a lot harder to read than the other two.

I am not commenting on the usefulness of the patch series (yet),
though.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
