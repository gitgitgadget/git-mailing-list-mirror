From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-credential-netrc: fix uninitialized warning
Date: Tue, 08 Oct 2013 16:12:56 -0400
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <8761t7v7w7.fsf@flea.lifelogs.com>
References: <87zjqjx25g.fsf@flea.lifelogs.com>
	<20131008194147.GF9464@google.com> <87li23v8p5.fsf@flea.lifelogs.com>
	<20131008200235.GG9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 22:12:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTdeF-0000OY-78
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 22:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab3JHUMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 16:12:47 -0400
Received: from mail-qe0-f44.google.com ([209.85.128.44]:55710 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037Ab3JHUMq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 16:12:46 -0400
Received: by mail-qe0-f44.google.com with SMTP id 6so4192524qeb.17
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lifelogs.com; s=google;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=WymxpfdvGpcB7PVqFfim+GTzA36Lmi7GIfgk0PZlF1Y=;
        b=uVurzxB3pGdf4QVWZ/IDGEETQguFwbr7OHR2RprS90oOesxQkuMloVuwP2d8AO+FTx
         DV5YxizMbPc1jnWdALMa0U+aBAf0J11FradlZyYpuDcyQxp5fNrCN5h+WP7N5c/0BBJk
         7YjPxFWDF7/5W29XDJV+wQMB6arfiDSEtdU4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=WymxpfdvGpcB7PVqFfim+GTzA36Lmi7GIfgk0PZlF1Y=;
        b=Cx+M4Ur0yWzBRbHgwbIk9uug5LCTAXAnmd0pvbV2uhoL2ycmKBAxqWmjwHhlXTZ5hG
         9sG4BlZ6In/V5oWCkKFJ1NbArfyFbWGTdjM10Tj8FBMrB0W2kCTHPz4Jig8rU3RoRaLq
         oTBAOQn10Ucab2rm6HfUpTAJm/Zh56dnF5hOnXlWouiIw04B/fsFJZXTjb1b4aPrTh/B
         zkU8NpV6BlUkw/q8AUx5XK7pWJ3ukPGvxuw31UOdPbQgR2dwFYJL0a0+UAUJuzKuTjtP
         8yBTB7bj3NmaN3HbqxK42NjFvARaExWb53Ia3IqgWcBlcoxa8If45jf7PJQOO1+NTNSI
         mB2A==
X-Gm-Message-State: ALoCoQkIn/OCxToyghTmRARRzCPbDgldQCVsxxLiefROQYnUxPPWf+I3W66bHsweKB0Hm9BPi5Jv
X-Received: by 10.224.76.10 with SMTP id a10mr6572356qak.9.1381263165939;
        Tue, 08 Oct 2013 13:12:45 -0700 (PDT)
Received: from flea.lifelogs.com (c-98-229-61-72.hsd1.ma.comcast.net. [98.229.61.72])
        by mx.google.com with ESMTPSA id n9sm77576023qag.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 13:12:45 -0700 (PDT)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20131008200235.GG9464@google.com> (Jonathan Nieder's message of
	"Tue, 8 Oct 2013 13:02:35 -0700")
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235791>

On Tue, 8 Oct 2013 13:02:35 -0700 Jonathan Nieder <jrnieder@gmail.com> wrote: 

JN> Ted Zlatanov wrote:
>> On Tue, 8 Oct 2013 12:41:47 -0700 Jonathan Nieder <jrnieder@gmail.com> wrote: 
JN> Ted Zlatanov wrote:

>>>> Simple patch to avoid unitialized warning and log what we'll do.
JN> Sign-off?
>> 
>> I didn't realize it was a requirement, must I?

JN> See Documentation/SubmittingPatches, section '(5) Sign your work'
JN> for what this means.

JN> If you just forgot to sign off, that's fine and I can forge it or go
JN> without.  If you are unable to sign off because you don't have the
JN> right to submit the change under an open source license, I'd be a bit
JN> worried going forward.

Right, I got it.  Sorry, I didn't know that applied to trivial patches.

JN> After this patch, the code looks like

JN> 	if (!defined $entry->{$check}) {
JN> 		log_debug(...);
JN> 	} elsif (defined $query->{$check}) {
JN> 		...
JN> 	} else {
JN> 		log_debug(...);
JN> 	}

JN> As a small nit, wouldn't it be more readable with the two !defined()
JN> cases together?

JN> 	if (!defined $entry->{$check}) {
JN> 		...
JN> 	} elsif (!defined $query->{$check}) {
JN> 		...
JN> 	} else {
JN> 		...
JN> 	}

Because of way the "next ENTRY" line comes out, I like my way slightly
better, but honestly it's fine either way :)  If you like, go ahead and
commit the rewrite the way it works for you, I have no objections at all.

Ted
